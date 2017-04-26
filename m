From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 26 Apr 2017 17:50:44 +0200
Subject: [PATCH] iommu: Print a message with the default domain type
 created
In-Reply-To: <20170426143813.21225-1-rrichter@cavium.com>
References: <20170426143813.21225-1-rrichter@cavium.com>
Message-ID: <20170426155044.GA1332@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Wed, Apr 26, 2017 at 04:38:13PM +0200, Robert Richter wrote:
> -	pr_info("Adding device %s to group %d\n", dev_name(dev), group->id);
> +	pr_info("Adding device %s to group %d, default domain type %d\n",
> +		dev_name(dev), group->id,
> +		group->default_domain ? group->default_domain->type : -1);

Printing just a number is not very user-friendly. We have only two
default domain-types right now, so it is sufficient to just print
additional information if a device is identity-mapped. Something like

	"Adding device %s to group %d - using identity mapping"


Regards,

	Joerg
