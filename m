From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 9 Jan 2013 22:54:28 +0100
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <201301092119.57067.arnd@arndb.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-6-git-send-email-thierry.reding@avionic-design.de>
 <201301092119.57067.arnd@arndb.de>
Message-ID: <20130109215428.GA13648@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 09:19:56PM +0000, Arnd Bergmann wrote:
> On Wednesday 09 January 2013, Thierry Reding wrote:
> > The I/O map cache is used to map large regions of physical memory in
> > smaller chunks to avoid running out of vmalloc()/ioremap() space.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> Can you explain why this is necessary and which problem it solves?
> The implementation looks reasonable, but it's not clear to me if
> we really need this new interface.
> 
> In what cases does it actually save ioremap space?

I briefly described this in the cover letter of this series and didn't
realize I hadn't put more information in this patch's commit message.

What happens on Tegra is that we need to map 256 MiB of physical memory
to access all the PCIe extended configuration space. However, ioremap()
on such a large region fails if not enough vmalloc() space is available.

This was observed when somebody tested this on CardHu which has a 1 GiB
of RAM and therefore remapping the full 256 MiB fails.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130109/8dd00bcf/attachment-0001.sig>
