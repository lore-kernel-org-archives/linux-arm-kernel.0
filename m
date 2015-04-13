From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 01:27:27 +0200
Subject: [PATCH v5 00/11] ARM: vf610m4: Add Vybrid Cortex-M4 support
In-Reply-To: <1428609855-27657-1-git-send-email-stefan@agner.ch>
References: <1428609855-27657-1-git-send-email-stefan@agner.ch>
Message-ID: <201504140127.28066.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 April 2015, Stefan Agner wrote:
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

It's a shame we didn't manage to pull these in in time for 4.1,
but while the patches look ok to me, they came a little late,
and it's not clear to me how we should maintain that platform.

You have lots of people on 'To:' for the emails, which is always
confusing. My preferred way of merging these in 4.2 would be for
you to send the patches to the imx maintainers so they can
pick them up and send them to arm at kernel.org.

	Arnd
