From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 10 Apr 2015 10:50:34 +0200
Subject: [PATCH v5 00/11] ARM: vf610m4: Add Vybrid Cortex-M4 support
In-Reply-To: <1428609855-27657-1-git-send-email-stefan@agner.ch>
References: <1428609855-27657-1-git-send-email-stefan@agner.ch>
Message-ID: <CALszF6Cc_7g873cz-zr=k4dDqDu+aMRjT1o2RGEh-tpSjYyREA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

2015-04-09 22:04 GMT+02:00 Stefan Agner <stefan@agner.ch>:
> In this fifth revision the patchset moves away from the idea
> including ARMv7-M platforms into ARCH_MULTIPLATFORM, but
> instead adds a new top-level config symbol ARM_SINGLE_ARMV7M
> Patch 7 adds this new config symbol while patch 8 alters the
> existing ARMv7-M platform ARCH_EFM32 to use ARM_SINGLE_ARMV7M.
> I chose to move the config symbol of the ARMv7-M specific
> architectures (ARCH_EFM32 at that point) below the multiarch
> includes. I think it is a good idea to keep them together, but
> I'm not sure if this is an appropriate place. The architecture
> which Vybrid is depending on, ARCH_MXC, is not also selectable
> when ARM_SINGLE_ARMV7M is selected.
>
> Since v3, this patchset does not contain the interrupt router
> driver anymore (MSCM IR). The driver has been merged inbetween:
> https://lkml.org/lkml/2015/3/8/6
>
> This patchset extends the NVIC driver to support irq domain
> hierarchy and the MSCM IR driver to support NVIC as a parent
> irq controller.
>
> The patchset has proven to be working on the Cortex-M4 of the
> Vybrid SoC using a Colibri VF61 module.
>
> Note: This patchset has dependencies on "ARM: ARMv7-M: Enlarge
> vector table up to 256 entries" (Maxime Coquelin) and the

I just submitted the patch to Russell's patch tracking system:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8340/1

Kind regards,
Maxime
