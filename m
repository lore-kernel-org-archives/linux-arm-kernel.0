From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Oct 2014 12:29:39 +0200
Subject: [PATCHv8 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <54442BB1.1080403@mleia.com>
References: <1413743305-1979-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413743305-1979-2-git-send-email-alexandre.belloni@free-electrons.com>
 <54442BB1.1080403@mleia.com>
Message-ID: <20141020102939.GB10616@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/10/2014 at 00:22:57 +0300, Vladimir Zapolskiy wrote :
> > +struct sun4i_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	void __iomem *base;
> > +	struct mutex ctrl_lock;
> 
> why do you use mutex? I haven't found any blocking subcalls under
> protection, a spinlock seems to fit better here.
> 

A mutex here will do the right thing. The lock is never taken in
interrupt context and a mutex is spinning for a few cycles before
putting the thread to sleep. I'm not sure why you feel a spinlock would
be better here.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
