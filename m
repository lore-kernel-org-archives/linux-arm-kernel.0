From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Oct 2018 13:09:55 +0100
Subject: [Question] directory for SoC-related DT binding
In-Reply-To: <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
 <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
 <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
Message-ID: <20181010120955.GQ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 02:04:14PM +0200, Stefan Wahren wrote:
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

I think you're confused there...

$ ls -1 Documentation/devicetree/bindings/soc/bcm/
brcm,bcm2835-vchiq.txt
raspberrypi,bcm2835-power.txt

Doesn't look like SoC/board bindings to me...

whereas:

$ ls -1 Documentation/devicetree/bindings/arm/bcm/
brcm,bcm11351-cpu-method.txt
brcm,bcm11351.txt
brcm,bcm21664.txt
brcm,bcm23550-cpu-method.txt
brcm,bcm23550.txt
brcm,bcm2835.txt
brcm,bcm4708.txt
brcm,bcm63138.txt
brcm,brcmstb.txt
brcm,cygnus.txt
brcm,hr2.txt
brcm,ns2.txt
brcm,nsp-cpu-method.txt
brcm,nsp.txt
brcm,stingray.txt
brcm,vulcan-soc.txt
raspberrypi,bcm2835-firmware.txt

does fit with your description, except for the directory path...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
