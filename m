From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 20 Oct 2014 16:10:31 +0300
Subject: [PATCHv8 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <20141020102939.GB10616@piout.net>
References: <1413743305-1979-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413743305-1979-2-git-send-email-alexandre.belloni@free-electrons.com>
 <54442BB1.1080403@mleia.com> <20141020102939.GB10616@piout.net>
Message-ID: <544509C7.9010309@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 20.10.2014 13:29, Alexandre Belloni wrote:
> Hi,
> 
> On 20/10/2014 at 00:22:57 +0300, Vladimir Zapolskiy wrote :
>>> +struct sun4i_pwm_chip {
>>> +	struct pwm_chip chip;
>>> +	struct clk *clk;
>>> +	void __iomem *base;
>>> +	struct mutex ctrl_lock;
>>
>> why do you use mutex? I haven't found any blocking subcalls under
>> protection, a spinlock seems to fit better here.
>>
> 
> A mutex here will do the right thing. The lock is never taken in
> interrupt context and a mutex is spinning for a few cycles before
> putting the thread to sleep.

and why do you want to put a thread to sleep in context of the driver?

> I'm not sure why you feel a spinlock would be better here.
> 

Only because a spinlock is lighter than a mutex.

With best wishes,
Vladimir
