From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 20 Nov 2013 16:57:33 +0800
Subject: [PATCH v2 3/4] ata: add APM X-Gene SoC 6.0Gbps SATA PHY driver
In-Reply-To: <1384905197-3566-4-git-send-email-lho@apm.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <1384905197-3566-2-git-send-email-lho@apm.com>
 <1384905197-3566-3-git-send-email-lho@apm.com>
 <1384905197-3566-4-git-send-email-lho@apm.com>
Message-ID: <CACVXFVPnRCtaFULYf307gfu4jvYpV7cgFOjmq5fOgyfb0Gp+SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 7:53 AM, Loc Ho <lho@apm.com> wrote:
> +
> +       sprintf(name, "xgene-ahci-phy-%08X", (u32) ctx->csr_phys);
> +       ctx->phy = devm_phy_create(ctx->dev, (u32) ctx->csr_phys,
> +                                  &xgene_phy_ops, name);

The devm_phy_create() API has changed, so suggest you make your
patch against -next tree.

Thanks,
--
Ming Lei

-- 
Ming Lei
