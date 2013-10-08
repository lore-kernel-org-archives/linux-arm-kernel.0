From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Oct 2013 11:40:51 +0800
Subject: [PATCH RFC 1/2] ARM: imx6qdl: provide pinctrl configurations for
 DAT3 pull-down
In-Reply-To: <52537378.1020904@wwwdotorg.org>
References: <20131005112147.GX12758@n2100.arm.linux.org.uk>
 <E1VSPw9-0004Ug-BF@rmk-PC.arm.linux.org.uk>
 <20131007055340.GB3739@S2101-09.ap.freescale.net>
 <20131007180357.GS12758@n2100.arm.linux.org.uk>
 <20131008015426.GA7480@S2101-09.ap.freescale.net>
 <52537378.1020904@wwwdotorg.org>
Message-ID: <20131008034048.GB7480@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 08:52:40PM -0600, Stephen Warren wrote:
> >>> &usdhc1 {
> >>> 	pinctrl-names = "default";
> >>> 	pinctrl-0 = <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3cd>;
> >>> 	...
> >>> 	status = "okay";
> >>> };
> >>
> >> Are you sure that this will always be the case?  This would assume that
> >> the pinctrl entries are always processed sequentially.
> > 
> > That will always be the case per my understanding.  Otherwise, I would
> > be so surprised.  Are you seeing any case that the entries are not
> > processed sequentially?
> 
> Given the way the Linux code currently works, I think that will
> currently happen in practice. However, there's nothing in the pinctrl DT
> binding documentation that guarantees (or even mentions) such semantics.

Ah, that's Russell's point, I guess.  I think it makes perfect sense to
make this clear in the binding doc, as this "overwrite mechanism" can be
very helpful.  I will send a patch for it.

Shawn
