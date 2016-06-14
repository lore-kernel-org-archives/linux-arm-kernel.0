From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jun 2016 23:51:07 +0100
Subject: [PATCH 3/5] ARM: dts: add L2CC and RPM with regulators for MSM8660
In-Reply-To: <20160614194853.GL28218@codeaurora.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
 <20160614185517.GG28218@codeaurora.org>
 <20160614190217.GU1256@tuxbot>
 <20160614194853.GL28218@codeaurora.org>
Message-ID: <20160614225106.GF1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 12:48:53PM -0700, Stephen Boyd wrote:
> On 06/14, Bjorn Andersson wrote:
> > On Tue 14 Jun 11:55 PDT 2016, Stephen Boyd wrote:
> > 
> > > On 06/14, Linus Walleij wrote:
> > > > diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> > [..]
> > > > +
> > > > +			pm8901-regulators {
> > > 
> > > I'd rather have regulators at 8901 and regulators at 8058. That way the
> > > node name is generic per ePAPR suggestions.
> > > 
> > 
> > I agree, but unfortunately we're not allowed to do that without a
> > matching "reg = <>" anymore.
> 
> Oh does dtc blow up now?

I think latest dtc complains, maybe with some additional warning enables.
However, the requirement has been there for a long time in ePAPR:

"The unit-address must match the first address specified in the reg
 property of the node. If the node has no reg property, the @ and
 unit-address must be omitted and the node-name alone differentiates
 the node from other nodes at the same level in the tree."

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
