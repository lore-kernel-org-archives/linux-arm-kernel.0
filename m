From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Aug 2013 10:26:12 -0400
Subject: [PATCHv3 7/9] ARM: OMAP: omap_device: Add APIs to enable and
 idle hwmods
In-Reply-To: <1375811376-49985-8-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-8-git-send-email-d-gerlach@ti.com>
Message-ID: <5203AA84.4080404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Needed to let the AM335x PM handle the IPs which need forced
> standby transition during every suspend-resume cycle when
> the corresponding driver is not compiled into the kernel.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/omap_device.c |    8 ++++++++
>  arch/arm/mach-omap2/omap_device.h |    2 ++
>  2 files changed, 10 insertions(+)
> 
The interface might be sane but the need of force standby
is just non-sense. Why can't we take care of this in
firmware itself. Linux doesn't need to know about it.
More comments on this in other patch where it is being used.

Regards,
Santosh
