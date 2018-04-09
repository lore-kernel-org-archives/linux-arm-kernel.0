From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Mon, 9 Apr 2018 12:36:25 -0400
Subject: [PATCH v3] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
In-Reply-To: <20180409093629.9621-1-paul.durrant@citrix.com>
References: <20180409093629.9621-1-paul.durrant@citrix.com>
Message-ID: <bd84cd4b-1834-b631-303c-3e190ad7676d@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2018 05:36 AM, Paul Durrant wrote:
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

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

I think this will have to wait until 4.18 though, it's somewhat late for
current merge window right now.

-boris
