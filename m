From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Nov 2011 21:58:58 +0800
Subject: Error for machine_is_m28evk
In-Reply-To: <20111116084258.GF9581@n2100.arm.linux.org.uk>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
 <4EB8CC7B.5060503@denx.de> <20111108075349.GK2854@pengutronix.de>
 <CAB4PhKeKdGLa74W-n1DNbUcszWMf3nymqqhuzdZoj_oQG+YNsg@mail.gmail.com>
 <20111116084258.GF9581@n2100.arm.linux.org.uk>
Message-ID: <20111116135857.GA14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 08:42:58AM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 16, 2011 at 01:59:41PM +0800, Shawn Guo wrote:
> > Hi Russell,
> > 
> > On Tue, Nov 08, 2011 at 08:53:47PM +0800, Shawn Guo wrote:
> > > On Tue, Nov 08, 2011 at 08:53:50AM +0000, Russell King - ARM Linux wrote:
> > > [...]
> > > > 
> > > > Maybe the answer is to just update the file anyway, and ignore peoples
> > > > complaints that their entries aren't present until they come to their
> > > > senses and start COMMUNICATING properly about issues they have with
> > > > their fscked up entry in the database.
> > > > 
> > > So I assume that you will update mach-types for -rc2.  Otherwise,
> > > please let me know, and I will send a patch to disable m28evk build
> > > from mxs_defconfig for -rc2.
> > > 
> > May I know your plan of mach-types updating?  The -rc2 is out with no
> > update on mach-types.
> 
> There is *NO* bloody way I'm updating this *known* *build* *breaking*
> thing in an -rc series.  I've already stated my reasons, and I _know_
> it will break stuff.  I've pointed out what the changes are.  It's in
> linux-next.  No one has responded to that.
> 
Then, can I send the following patch for -rc3 to fix the mxs build
(I noticed the statement '# Please do not send patches to this file;
it is automatically generated!' in the file)?  Or do I have to disable
the m28evk from mxs build?

Regards,
Shawn

---8<----
commit acbff8107c90a4d2a436cca53535f2fd35d109e7
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Wed Nov 16 21:44:33 2011 +0800

    ARM: Update mach-types to fix mxs build breakage

    Add entry m28evk to fix the following mxs build breakage.

      CHK     include/generated/compile.h
      CC      arch/arm/mach-mxs/clock-mx28.o
    arch/arm/mach-mxs/clock-mx28.c: In function 'clk_misc_init':
    arch/arm/mach-mxs/clock-mx28.c:748: error: implicit declaration of
    function 'machine_is_m28evk'
    make[1]: *** [arch/arm/mach-mxs/clock-mx28.o] Error 1
    make: *** [arch/arm/mach-mxs] Error 2

    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 5bdeef9..ccbe16f 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -1123,5 +1123,6 @@ blissc                    MACH_BLISSC             BLISSC                  3491
 thales_adc             MACH_THALES_ADC         THALES_ADC              3492
 ubisys_p9d_evp         MACH_UBISYS_P9D_EVP     UBISYS_P9D_EVP          3493
 atdgp318               MACH_ATDGP318           ATDGP318                3494
+m28evk                 MACH_M28EVK             M28EVK                  3613
 smdk4212               MACH_SMDK4212           SMDK4212                3638
 smdk4412               MACH_SMDK4412           SMDK4412                3765
