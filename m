From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Apr 2016 14:24:50 -0700
Subject: [PATCH] clk: sunxi: Add CSI (camera's Sensors Interface) module
 clock driver for sun[457]i
In-Reply-To: <20160402011436.GA18567@codeaurora.org>
References: <1458204222-31149-1-git-send-email-yassinjaffer@gmail.com>
 <1458204222-31149-2-git-send-email-yassinjaffer@gmail.com>
 <20160319235905.GA16539@rob-hp-laptop>
 <20160402011436.GA18567@codeaurora.org>
Message-ID: <20160404212450.GP4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen

On Fri, Apr 01, 2016 at 06:14:36PM -0700, Stephen Boyd wrote:
> On 03/19, Rob Herring wrote:
> > On Thu, Mar 17, 2016 at 07:43:42PM +1100, yassinjaffer at gmail.com wrote:
> > > From: Yassin Jaffer <yassinjaffer@gmail.com>
> > > 
> > > This patch adds a composite clock type consisting of
> > > a clock gate, mux, configurable dividers, and a reset control.
> > > 
> > > Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
> > 
> > I wish someone would just add all the sunxi clocks in one pass instead 
> > of one by one.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Me too!

I understand, but it's probably not going to happen. The clock tree is
massive, and obviously you have to multiply that by the number of SoCs
we have.

And to be honest, I don't really see the point of merging clock
drivers that have never been tested, and might be massively broken,
especially now that we have this ABI requirement for the DT, and we
can't adjust the binding when we actually start using that clock.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/8ab7147b/attachment.sig>
