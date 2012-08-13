From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 13 Aug 2012 18:38:47 +0100
Subject: [PATCH] efikamx: reintroduce Genesi Efika MX Smarttop via device
 tree
In-Reply-To: <CAKGA1bkwMvDW7nMWxUbNm3_0ZTR2+uKs8UL_HuisJe7cd8POBA@mail.gmail.com>
References: <1344375978-29981-1-git-send-email-matt@genesi-usa.com>
 <20120809101947.GA8474@sirena.org.uk>
 <CAKGA1bkwMvDW7nMWxUbNm3_0ZTR2+uKs8UL_HuisJe7cd8POBA@mail.gmail.com>
Message-ID: <20120813173847.GH13446@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 10:42:58AM -0500, Matt Sealey wrote:
> On Thu, Aug 9, 2012 at 5:19 AM, Mark Brown

> > This and many of your other regulators have voltage ranges specified but
> > no consumers which doesn't make sense.  It looks awfully like you've
> > just typed in the maximum range supported by the regulator which is most
> > likely broken.

> Okay I have a question about this; some of the regulators (SW1
> especially) are obviously consumed by the CPU core complex so that
> when DVFS gives us a hint we can clock down and reduce voltage. How on
> earth do we implement that?

> We can drop the maximum range to be better for the CPU (1.3V is too
> high, I think this is legacy from when we may have had a sorted 1GHz
> MX51 coming out) but I can't find any source for where this is hooked
> in.

DVFS doesn't use the device model in Linux (yet!) so there's no device
node and it's all a bit messy.  Shawn Guo is working on some generic DT
bindings for it which should solve that problem but for now in the
specific case of CPU bindings it's OK to not have an consumer, it's
understandable what's going on there.
