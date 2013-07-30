From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 30 Jul 2013 12:35:47 -0500
Subject: [PATCH v2 00/13] Remove platform callbacks from mmc_spi,
 sh_mmcif and sh_mobile_sdhi drivers
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC5C24E0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 30, 2013 3:37 AM, Laurent Pinchart wrote:
>
> This patch set replaces callbacks to board code with regulators and GPIOs in
> the mmc_spi, sh_mmcif and sh_mobile_sdhi MMC drivers.

Just tested this series on the vision_ep93xx board. Everything looks ok.

For patches 01/13, 02/13 and 07/13 you can add:

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

For patch 03/13:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

> This will be a bit messy to merge, as the series interleaves patches for
> drivers and board files. Given that the mmc_spi driver is marked as orphan in
> MAINTAINERS and that the vision_ep9307 hasn't seen any board-specific
> modification in the last couple of kernel versions one option would be to
> merge all patches (or at least patches 01/13 to 07/13) through Simon's tree if
> all involved maintainers agree.
>
> If patch 01/13 should better be merged through the MMC tree (in which case
> 02/13 should go through that tree as well), the two patches should be applied
> first to the MMC tree, and a stable branch will be needed for Simon to base
> the rest of the series on.

I'm fine with whatever merge path you end up using. I don't currently have
any changes planned to vision_ep93xx.

Thanks,
Hartley
