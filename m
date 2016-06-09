From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 9 Jun 2016 22:08:01 +0200 (CEST)
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <20160607070440.GA32573@shlinux2>
References: <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
 <alpine.DEB.2.11.1604271212290.3941@nanos> <20160602145915.GA31124@shlinux2>
 <alpine.DEB.2.11.1606061448010.28031@nanos> <20160607070440.GA32573@shlinux2>
Message-ID: <alpine.DEB.2.11.1606092204590.28031@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Jun 2016, Dong Aisheng wrote:
> Then it may need introduce a lot changes and increase many new core APIs.
> Is that a problem?

No. That's all better than each driver having broken workarounds. It's a
common problem so it wants to be addressed at the core level. There you have a
central point to do this and you can still catch abusers which call stuff from
the wrong context. The hacks in the drivers don't allow that because they look
at the context, i.e. irq disabled, instead of checking the system state.

Thanks,

	tglx
