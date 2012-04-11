From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Apr 2012 16:17:25 -0600 (MDT)
Subject: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE
 support
In-Reply-To: <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1204111615140.29473@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs only support PWRDM_POWER_ON
> and PWRDM_POWER_INACTIVE power states. This causes
> an issue in some areas of the OMAP3 power-related
> code because of assumptions that PWRDM_POWER_RET
> and/or PWRDM_POWER_OFF are always valid states.
> 
> To get am35x SoCs to work properly, add missing support
> for PWRDM_POWER_INACTIVE and remove assumptions that
> PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Same comments here as on "arm: omap3: am35x: Set proper powerdomain 
states" -- does it even make sense for us to separate out INACTIVE at all 
in this case?  Seems like AM3517/3505 supports powerdomains ON, and that's 
it.  Seems like we can't program INACTIVE to the POWERSTATE bits, nor can 
we read it from those bits?


- Paul
