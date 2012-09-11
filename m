From: cjb@laptop.org (Chris Ball)
Date: Tue, 11 Sep 2012 13:11:55 -0400
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <201209111705.37490.arnd@arndb.de> (Arnd Bergmann's message of
 "Tue, 11 Sep 2012 17:05:37 +0000")
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-9-git-send-email-arnd@arndb.de>
 <871ui8y3at.fsf@octavius.laptop.org>
 <201209111705.37490.arnd@arndb.de>
Message-ID: <87sjaowkkk.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 11 2012, Arnd Bergmann wrote:
>> Looks like you aren't renaming the idempotency guards, so e.g.
>> include/linux/platform_data/mmc-sdhci-tegra.h will contain:
>> 
>> #ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
>> #define __ASM_ARM_ARCH_TEGRA_SDHCI_H
>> 
>> Is that intentional?  Thanks,
>
> No, it's not intentional. We actually have a lot of instances that
> are already wrong. Do we care enough to change the ones I'm moving here?

It's clearly not a big deal.  I did fix it in Stephen's previous version
of this change, though.

Maybe just add a note to the commit message explaining that you aren't
changing the guards and driver maintainers might want to fix them up if
it's something they care about?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
