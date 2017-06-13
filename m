From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jun 2017 14:28:00 +0200
Subject: [PATCH v2] clockevents/tcb_clksrc: implement suspend/resume
In-Reply-To: <926f790a-3041-69fb-1501-2c8137f1ba65@linaro.org>
References: <20170512182251.23948-1-alexandre.belloni@free-electrons.com>
 <926f790a-3041-69fb-1501-2c8137f1ba65@linaro.org>
Message-ID: <20170613122800.tic2c5c2p7nqz6dq@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2017 at 14:21:10 +0200, Daniel Lezcano wrote:
> On 12/05/2017 20:22, Alexandre Belloni wrote:
> > On sama5d2, power to the core may be cut while entering suspend mode. It is
> > necessary to save and restore the TCB registers.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> The context will be saved/restored on all the platforms (other than
> sama5d2) using this timer even if the clock is not powered down. Is that ok?
> 

Yes, that is fine. There is not much we can do here until we can
determine what is the target suspend state from the drivers.

> Should it be tagged for stable@?
> 

No because support for this suspend mode is not yet upstream.

> Side note: the config option is in drivers/misc, any particular reason
> to have it there and not in the clocksource's Kconfig?
> 

Mostly historical, this is changed in the other series.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
