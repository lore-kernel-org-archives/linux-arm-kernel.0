From: German.Rivera@freescale.com (Jose Rivera)
Date: Fri, 6 Nov 2015 22:45:45 +0000
Subject: [PATCH] arm64: dts: Added syscon-reboot node for FSL's LS2080A SoC
In-Reply-To: <CABxcv=n6UTcdskBv8fqRzfes+nCjPaFbCTDGRRDt=MStdepwWA@mail.gmail.com>
References: <1446846529-10613-1-git-send-email-German.Rivera@freescale.com>
 <CABxcv=n6UTcdskBv8fqRzfes+nCjPaFbCTDGRRDt=MStdepwWA@mail.gmail.com>
Message-ID: <DM2PR0301MB1309536CB3D9024A42ED02C9FE280@DM2PR0301MB1309.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Javier Martinez Canillas [mailto:javier at dowhile0.org]
> Sent: Friday, November 06, 2015 4:13 PM
> To: Rivera Jose-B46482
> Cc: Rob Herring; Mark Rutland; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Linux Kernel; Sharma Bhupesh-B45370; Li Yang-
> Leo-R58472; Yoder Stuart-B08248
> Subject: Re: [PATCH] arm64: dts: Added syscon-reboot node for FSL's
> LS2080A SoC
> 
> Hello J. German,
> 
> On Fri, Nov 6, 2015 at 6:48 PM, J. German Rivera
> <German.Rivera@freescale.com> wrote:
> > Added sys-reboot node to the FSL's LS2080A SoC DT to leverage the
> > ARM-generic reboot mechanism for this SoC. This mechanism is enabled
> > through CONFIG_POWER_RESET_SYSCON.
> >
> 
> What's in the changelog ends as a part of the commit message and usually
> the change history is not added there...
> 
You are right, thanks. I forgot to move the CHANGE HISTORY to be below the "---"
Marker. I'll repost the patch.

> > CHANGE HISTORY:
> >
> > Changes in v3:
> > - Addressed comment from Stuart Yoder
> >   * Fixed commit message to refer to LS2080A instead of LS2085A.
> >
> > Changes in v2:
> > - Addressed comment form Stuart Yoder:
> >   * Removed "@<address>" from reboot node
> >
> > Changes in v3:
> > - Addressed comment form Stuart Yoder:
> >   * Expose only the reset register
> >
> > Changes in v4:
> > - Addressed comment from Arnd Bergmann:
> >   * Changed compatible string to be more specific
> >   * Changed node name to 'syscon' instead of 'rstcr'
> >   * Changed address to lower case hex
> > - Addressed comment form Stuart Yoder:
> >   * Rebase on top of branch arm-soc/for-next
> >
> > Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
> > ---
> 
> ...so the change history should be added here, between the '---'
> marker line and the patch diff since that section is omitted by tools
> like git-am when applying patches.
> 
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > index e81cd48..a790a90 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > @@ -153,6 +153,18 @@
> >                 };
> >         };
> >
> > +       rstcr: syscon at 1e60000 {
> > +               compatible = "fsl,ls2085a-rstcr", "syscon";
> > +               reg = <0x0 0x1e60000 0x0 0x4>;
> > +       };
> > +
> > +       reboot {
> > +               compatible ="syscon-reboot";
> > +               regmap = <&rstcr>;
> > +               offset = <0x0>;
> > +               mask = <0x2>;
> > +       };
> > +
> >         timer {
> >                 compatible = "arm,armv8-timer";
> >                 interrupts = <1 13 0x8>, /* Physical Secure PPI,
> > active-low */
> > --
> 
> The patch looks good to me though.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
> Javier
