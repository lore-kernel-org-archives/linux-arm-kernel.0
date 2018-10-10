From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Oct 2018 13:59:27 -0500
Subject: [Question] directory for SoC-related DT binding
In-Reply-To: <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
 <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
 <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
Message-ID: <CAL_JsqK_MDQvePhEGJsk5CRQuzkOo+s3QjF7hcNZp_dVsbc9zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 7:04 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi,
>
> Am 10.10.2018 um 13:19 schrieb Rob Herring:
> > On Wed, Oct 10, 2018 at 6:08 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> Hi,
> >>
> >>
> >> I see a bunch of vendor (or SoC) names in
> >> Documentation/device/bindings/arm/
> >>
> >> ./Documentation/devicetree/bindings/arm/altera
> >> ./Documentation/devicetree/bindings/arm/amlogic
> > Yeah, it's kind of a mixture of board/soc bindings mostly with some
> > ARM architecture, ARM, Ltd. IP, and SoC system reg bindings.
> >
> > Eventually, I'd like to not split board bindings by arch and maybe we
> > should move all the system/misc reg bindings out.
> >
> > [,,,]
> >
> >> I also see some vendor names in
> >> Documentation/device/bindings/soc/
> >>
> >> ./Documentation/devicetree/bindings/soc/bcm
> >> ./Documentation/devicetree/bindings/soc/dove
> >> ./Documentation/devicetree/bindings/soc/fsl
> >> ./Documentation/devicetree/bindings/soc/mediatek
> >> ./Documentation/devicetree/bindings/soc/qcom
> >> ./Documentation/devicetree/bindings/soc/rockchip
> >> ./Documentation/devicetree/bindings/soc/ti
> >> ./Documentation/devicetree/bindings/soc/xilinx
> >> ./Documentation/devicetree/bindings/soc/zte
> > This I believe is mostly SoC system reg bindings though there's
> > probably a few other things.
> >
> >> Confusingly, I see bcm, mediatek, rockchip
> >> in both locations.
> >>
> >> Is there any rule to choose one than the other?
> > Top-level SoC/board bindings in arm/ and anything else elsewhere ideally.
>
> in case of Documentation/devicetree/bindings/soc/bcm the directory
> contains SoC / board bindings, cpu-enable and a firmware binding.
>
> Is there any action required?

If there's a better location based on class/function, then moving them
would be nice.

> Btw the Broadcom SoC / boards from this directory has been left out for
> the yaml conversion [1] was this intended?

Yes, I'm not planning to convert all bindings for everyone myself.

Rob
