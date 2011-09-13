From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 13 Sep 2011 22:32:59 +0100
Subject: [PATCH v2 5/6] iommu/intel: announce supported page sizes
In-Reply-To: <1315942288-17297-5-git-send-email-ohad@wizery.com>
References: <1315942288-17297-1-git-send-email-ohad@wizery.com>
	<1315942288-17297-5-git-send-email-ohad@wizery.com>
Message-ID: <1315949582.2687.204.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-09-13 at 22:31 +0300, Ohad Ben-Cohen wrote:
> + * Traditionally the IOMMU core just handed us the mappings directly,
> + * after making sure the size is an order of a 4KB page and that the
> + * mapping has natural alignment.
> + *
> + * To retain this behavior, we currently advertise that we support
> + * all page sizes that are an order of 4KB. 

This is wrong. We do not support 4000-byte pages. We only support
4096-byte pages. 4KiB, not 4kB.

Please fix.

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110913/9925b4a6/attachment.bin>
