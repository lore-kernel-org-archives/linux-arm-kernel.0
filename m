From: jgross@suse.com (Juergen Gross)
Date: Thu, 17 May 2018 08:42:00 +0200
Subject: [PATCH v5] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
In-Reply-To: <20180509131612.21107-1-paul.durrant@citrix.com>
References: <20180509131612.21107-1-paul.durrant@citrix.com>
Message-ID: <69c96876-e5b7-dd6e-8ebe-3493d736e578@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/18 15:16, Paul Durrant wrote:
> My recent Xen patch series introduces a new HYPERVISOR_memory_op to
> support direct priv-mapping of certain guest resources (such as ioreq
> pages, used by emulators) by a tools domain, rather than having to access
> such resources via the guest P2M.
> 
> This patch adds the necessary infrastructure to the privcmd driver and
> Xen MMU code to support direct resource mapping.
> 
> NOTE: The adjustment in the MMU code is partially cosmetic. Xen will now
>       allow a PV tools domain to map guest pages either by GFN or MFN, thus
>       the term 'mfn' has been swapped for 'pfn' in the lower layers of the
>       remap code.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Pushed to xen/tip.git for-linus-4.18


Juergen
