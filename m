From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Apr 2016 09:58:36 +0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
Message-ID: <20160427015835.GE30692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 07:27:03PM +0800, Dong Aisheng wrote:
> Shawn,
> What's your suggestion?

I think this needs more discussion, and I just dropped Stefan's patch
from my tree.

We need to firstly understand why this is happening.  The .prepare hook
is defined to be non-atomic context, and so that we call sleep function
in there.  We did everything right.  Why are we getting the warning?  If
I'm correct, this warning only happens on i.MX7D.  Why is that?

Shawn
