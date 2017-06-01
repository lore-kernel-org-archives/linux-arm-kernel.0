From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 01 Jun 2017 13:30:49 +0100
Subject: [RFC,20/30] iommu/arm-smmu-v3: Enable PCI PASID in masters
In-Reply-To: <a5428875-6ff9-820a-498d-ae2602e8cc53@arm.com>
References: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
 <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
 <a5428875-6ff9-820a-498d-ae2602e8cc53@arm.com>
Message-ID: <1496320249.6254.35.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-06-01 at 13:30 +0100, Jean-Philippe Brucker wrote:
> 
> Yes, the current plan is to create a PASID (SSID) allocator that could be
> used by AMD, Intel, ARM, and other IOMMUs. Currently the kfd driver
> allocates PASIDs, but this will be done by the IOMMU subsystem in the
> future. Writing the generic allocator isn't on my schedule for the next
> few months, though.
> 
> I'm trying to implement the next version of SMMU SVM with the following
> principles in mind, and Intel are reworking their PASID allocator similarly.

Note that the Intel allocator is designed to work that way and to be
easily made generic (that is, easily used from elsewhere).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170601/1cffb17d/attachment.bin>
