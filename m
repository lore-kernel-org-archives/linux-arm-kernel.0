From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 25 Sep 2018 22:33:36 +0200 (CEST)
Subject: [PATCH] arm64: dts: broadcom: Use the .dtb name in the rule,
 rather than .dts
In-Reply-To: <20180925185133.jdom5tvs6zklntr7@localhost>
References: <b42d2e57-8bcd-0d6a-7a4d-aeefedcdd5f3@i2se.com>
 <20180924102228.19656-1-liviu@dudau.co.uk>
 <539eb374-9122-6c09-4c64-80bfa6b7bf89@i2se.com>
 <1c0db58a-5bc2-8de3-f70d-725a29376513@gmail.com>
 <20180925185133.jdom5tvs6zklntr7@localhost>
Message-ID: <1480797531.286958.1537907616382@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Olof Johansson <olof@lixom.net> hat am 25. September 2018 um 20:51 geschrieben:
> 
> 
> On Tue, Sep 25, 2018 at 11:17:52AM -0700, Florian Fainelli wrote:
> > On 09/24/2018 04:03 AM, Stefan Wahren wrote:
> > > Am 24.09.2018 um 12:22 schrieb Liviu Dudau:
> > >> Commit a7eb26392b893 ("arm64: dts: broadcom: Add reference to Compute
> > >> Module IO Board V3") adds the bcm2837-rpi-cm3-io3.dts file as a target
> > >> in the Makefile, rather than the .dtb name. This will skip the
> > >> generation of the .dtb file at compile time and will fail the dtbs_install
> > >> target.
> > >>
> > >> Fixes: a7eb26392b893 ("arm64: dts: broadcom: Add reference to Compute
> > >> Module IO Board V3")
> > >>
> > >> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> > > 
> > > Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > 
> > > Thanks, i will add a dtbs_install step to my test jobs.
> > 
> > Same here.
> 
> I do but I don't seem to catch any errors from it. :-/

Strange, i'm get getting this:

scripts/Makefile.dtbinst:31: Target ?bcm2837-rpi-cm3-io3.dts? passt nicht zum Ziel-Muster
  INSTALL arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dtb
  INSTALL arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
  INSTALL 
cp: Fehlender Zieldatei?Operand hinter '/tmp/broadcom'
?cp --help? liefert weitere Informationen.
scripts/Makefile.dtbinst:32: die Regel f?r Ziel ?bcm2837-rpi-cm3-io3.dts? scheiterte
make[2]: *** [bcm2837-rpi-cm3-io3.dts] Fehler 1
scripts/Makefile.dtbinst:35: die Regel f?r Ziel ?broadcom? scheiterte
make[1]: *** [broadcom] Fehler 2
arch/arm64/Makefile:139: die Regel f?r Ziel ?dtbs_install? scheiterte
make: *** [dtbs_install] Fehler 2

> 
> > > @Arnd @Olof Should this fix for 4.20 go via pull request or can you
> > > apply it directly to your tree?
> > 
> > That would be my preference here as well.
> 
> Applied to next/dt now. Thanks!

Thanks

> 
> 
> -Olof
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
