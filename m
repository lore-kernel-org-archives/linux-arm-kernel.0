From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 11 Dec 2016 12:31:04 +0530
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <878trntrig.fsf@dell.be.48ers.dk>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
 <20161210181639.GA5660@afzalpc> <878trntrig.fsf@dell.be.48ers.dk>
Message-ID: <20161211070104.GB3035@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 10, 2016 at 10:15:35PM +0100, Peter Korsgaard wrote:
> >>>>> "Afzal" == Afzal Mohammed <afzal.mohd.ma@gmail.com> writes:

>  > Seems no !MMU A-class suitable toolchains are available, the existing
>  > !MMU toolchains available are for either M or R class. Looks like
>  > FDPIC one's also are so (cc'ing Maxime & Mickeal in case they have
>  > some input here).
> 
>  > And compiling a suitable compiler failed.
> 
>  > Let know if any signposts to travel the remaining distance.

> You can build a toolchain and initramfs with Buildroot. Have a look at
> the stm32f429 nommu config:
> 
> https://git.buildroot.net/buildroot/tree/configs/stm32f429_disco_defconfig

iiuc, it builds one for Cortex-M. i already had a file system w/
busybox compiled using a Cortex-M toolchain (stolen from
Pengutronix's OSELAS.Toolchain), which works on Cortex M4 (Vybrid
VF610 M4 core). But it does not work here, i.e. on Cortex A, seems the
above mentioned also would have the same effect. And in buildroot,
couldn't see Cortex R option in menuconfig, and selecting Cortex-A's
excludes flat binary target & presents only with ELF.

Here compiler was attempted to be built using crosstool-NG, target
selected was "arm-unknown-linux-gnueabi", and in crosstool-NG
menuconfig, MMU was deselected, upon building target got changed to
"arm-unknown-linux-uclibcgnueabi". After building binutils & pass 1
compiler, it failed while building multilib. Probably would have to
dive into toolchain details now.

Regards
afzal
