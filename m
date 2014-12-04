From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 13:51:25 +0100
Subject: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
 drivers
In-Reply-To: <54805312.6000402@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <2579924.PPXuLn3o19@wuerfel> <54805312.6000402@arm.com>
Message-ID: <2542658.tyv3UdgsYi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 12:26:58 Robin Murphy wrote:
> 
> +struct of_iommu_node {
> +       struct hlist_node list;
> +       struct device_node *np;
> +       const struct iommu_ops *ops;
> +};
> +static HLIST_HEAD(of_iommu_list);
> +static DEFINE_SPINLOCK(of_iommu_lock);

Looks good to me. For 3.20, I would hope to get consensus on renaming this
structure to 'struct iommmu' and adding additional members into it as needed,
but let's do that another day. Please address Grant's feedback and send
a new version.

	Arnd
