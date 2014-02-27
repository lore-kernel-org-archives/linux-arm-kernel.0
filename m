From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Feb 2014 13:02:59 -0600
Subject: [PATCH v12 3/4] PHY: add APM X-Gene SoC 15Gbps Multi-purpose PHY
 driver
In-Reply-To: <1393524848-8207-4-git-send-email-lho@apm.com>
References: <1393524848-8207-1-git-send-email-lho@apm.com>
 <1393524848-8207-2-git-send-email-lho@apm.com>
 <1393524848-8207-3-git-send-email-lho@apm.com>
 <1393524848-8207-4-git-send-email-lho@apm.com>
Message-ID: <20140227190259.GC4862@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 27, 2014 at 11:14:07AM -0700, Loc Ho wrote:
> +/*
> + * This function is used to configure the PHY to operation as either SATA Gen1
> + * or Gen2 speed.
> + */
> +static void xgene_phy_sata_force_gen(struct xgene_phy_ctx *ctx,
> +				     int lane, int gen)

why do you need to *force* the generation ? Is this because of some
silicon errata ? It almost seems like this should be done through link
negotiation between both link partners.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/d35f8bec/attachment.sig>
