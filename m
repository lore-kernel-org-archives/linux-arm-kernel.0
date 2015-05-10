From: tj@kernel.org (Tejun Heo)
Date: Sun, 10 May 2015 11:54:54 -0400
Subject: [PATCH v5 3/3] ata: ahci_xgene: Add AHCI Support for 2nd HW
 version of APM X-Gene SoC AHCI SATA Host controller.
In-Reply-To: <1430853672-6227-4-git-send-email-stripathi@apm.com>
References: <1430853672-6227-1-git-send-email-stripathi@apm.com>
 <1430853672-6227-4-git-send-email-stripathi@apm.com>
Message-ID: <20150510155454.GD5856@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 06, 2015 at 12:51:12AM +0530, Suman Tripathi wrote:
> +	switch (version) {
> +	case XGENE_AHCI_V1:
> +		hpriv->flags = AHCI_HFLAG_NO_NCQ;
> +		/*
> +		 * Override the callbacks for storm ERRATA
> +		 */
> +		xgene_ahci_ops.qc_issue = xgene_ahci_qc_issue;
> +		xgene_ahci_ops.softreset = xgene_ahci_softreset;
> +		xgene_ahci_ops.pmp_softreset = xgene_ahci_pmp_softreset;

Let's please create separate ops structs for v1 and v2.

Thanks.

-- 
tejun
