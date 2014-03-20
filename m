From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 20 Mar 2014 20:19:27 +0100
Subject: [PATCH v2 0/3] ata: ahci_platform related cleanups
In-Reply-To: <1395340026-3969-1-git-send-email-b.zolnierkie@samsung.com>
References: <1395340026-3969-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <532B3F3F.1050508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/20/2014 07:27 PM, Bartlomiej Zolnierkiewicz wrote:
> [ v1 was named "ata: add remaining new-style AHCI platform drivers"
>   but we are down from 2 drivers to 1 driver so the title of the patch
>   series no longer was valid :) ]
> 
> Hi,
> 
> This patch series:
> - fixes ahci_platform_data->suspend() handling
> - moves library AHCI platform code to its own file
> - adds a new-style AHCI platform driver for DaVinci DA850 AHCI controller
> 
> Changes since v1:
> - dropped no longer needed patch #4 (ST SPEAr1340 AHCI controller driver)
> - adressed review comments for patch #3 from Sekhar Nori
> - updated patch descriptions

I assume that the spear patch has been dropped since the spear code has
already been converted now and thus is no longer using ahci_platform_data ?

In that case I think it would best to replace patch 1 with a patch just dropping
the suspend and resume callbacks from ahci_platform_data, as they then no
longer have any users.

Regards,

Hans
