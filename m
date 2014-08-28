From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Aug 2014 15:24:42 +0200
Subject: [PATCH] ARM: shmobile: Enable Armadillo 800 EVA board in
 multiplatform defconfig
In-Reply-To: <CAMuHMdVQLny1u7SxNvN+jNHSGNfFUPL=fvx8oDgO1EkhZBp8pA@mail.gmail.com>
References: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
 <3285079.8x1UeyRQTp@wuerfel>
 <CAMuHMdVQLny1u7SxNvN+jNHSGNfFUPL=fvx8oDgO1EkhZBp8pA@mail.gmail.com>
Message-ID: <2961349.mXGyF0dyBP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 August 2014 15:06:31 Geert Uytterhoeven wrote:
> On Thu, Aug 28, 2014 at 2:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 28 August 2014 14:40:22 Geert Uytterhoeven wrote:
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >>  arch/arm/configs/shmobile_defconfig | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >
> > No objections to the patch, but I wonder if you could send another
> > patch to enable all the machines working in ARCH_SHMOBILE_MULTI
> > as part of multi_v7_defconfig as well.
> 
> Sure. I actually have such a patch lying around 
> 
> I've just added armadillo support there, too, but it hangs during boot
> on Armadillo. May be that the image is just too big for the Hermit boot
> loader.
> It does work on Koelsch. Haven't tried it yet on BeagleBone Black, though.
> 
> Do you want it? Or do you want the version without armadillo support?
> 

Good question. Ideally I'd like them all to be enabled, but I guess there
is little value in adding Armadillo if it doesn't actually work.

Maybe you have run into the same u-boot problem that a few other people
had before? When mach-qcom is enabled, the kernel entry point changes
and you have to adapt any script that tries to build a uImage manually.

	Arnd
