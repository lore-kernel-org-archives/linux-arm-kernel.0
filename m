From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 27 Apr 2014 20:23:06 +0200
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <1398584283-22846-12-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <1398584283-22846-12-git-send-email-shaik.ameer@samsung.com>
Message-ID: <4447051.OnJtcFSqFV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 April 2014 13:07:43 Shaik Ameer Basha wrote:
> +- mmu-masters: A phandle to device nodes representing the master for which
> +               the System MMU can provide a translation. Any additional values
> +              after the phandle will be ignored because a System MMU never
> +              have two or more masters. "#stream-id-cells" specified in the
> +              master's node will be also ignored.
> +              If more than one phandle is specified, only the first phandle
> +              will be treated.

This seems completely backwards: Why would you list the masters for an IOMMU
in the IOMMU node?

The master should have a standard property pointing to the IOMMU instead.

We don't have a generic binding for IOMMUs yet it seems, but the time is
overdue to make one.

Consider this NAKed until there is a generic binding for IOMMUs that all
relevant developers have agreed to.

	Arnd
