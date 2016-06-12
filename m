From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 12 Jun 2016 20:24:25 +0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <alpine.DEB.2.11.1606092204590.28031@nanos>
References: <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
 <alpine.DEB.2.11.1604271212290.3941@nanos>
 <20160602145915.GA31124@shlinux2>
 <alpine.DEB.2.11.1606061448010.28031@nanos>
 <20160607070440.GA32573@shlinux2>
 <alpine.DEB.2.11.1606092204590.28031@nanos>
Message-ID: <20160612122425.GG32690@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 10:08:01PM +0200, Thomas Gleixner wrote:
> On Tue, 7 Jun 2016, Dong Aisheng wrote:
> > Then it may need introduce a lot changes and increase many new core APIs.
> > Is that a problem?
> 
> No. That's all better than each driver having broken workarounds. It's a
> common problem so it wants to be addressed at the core level. There you have a
> central point to do this and you can still catch abusers which call stuff from
> the wrong context. The hacks in the drivers don't allow that because they look
> at the context, i.e. irq disabled, instead of checking the system state.
> 

Okay, thanks.
If you wouldn't mind i could send out a patch based on your
suggestion for further discussion.

Thanks

Regards
Dong Aisheng

> Thanks,
> 
> 	tglx
