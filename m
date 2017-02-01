From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Feb 2017 18:39:18 +0000
Subject: [PATCH v3 18/24] media: imx: Add SMFC subdev driver
In-Reply-To: <1483755102-24785-19-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-19-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170201183918.GP27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Fri, Jan 06, 2017 at 06:11:36PM -0800, Steve Longerbeam wrote:
> +/*
> + * Min/Max supported width and heights.
> + *
> + * We allow planar output from the SMFC, so we have to align
> + * output width by 16 pixels to meet IDMAC alignment requirements,
> + * which also means input width must have the same alignment.
> + */
> +#define MIN_W       176
> +#define MIN_H       144
> +#define MAX_W      8192
> +#define MAX_H      4096
> +#define W_ALIGN    4 /* multiple of 16 pixels */

Does this only apply to planar formats?

I notice Philipp's driver allows 8 pixel alignment.  If it's only for
planar formats, it ought to determine the alignment based on the
requested format rather than hard-coding it to the maximum alignment
of all the supported formats.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
