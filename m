From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 3 Feb 2014 15:15:59 -0700
Subject: [RFC PATCH V3 1/4] pci: APM X-Gene PCIe controller driver
In-Reply-To: <4985267.LnsktRmabM@wuerfel>
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
 <201401301516.27091.arnd@arndb.de>
 <CACoXjcnXoysMeBsGuOb3t5b10zdeJ8pOnuOOzR8AaZhsOOYVEw@mail.gmail.com>
 <4985267.LnsktRmabM@wuerfel>
Message-ID: <20140203221559.GG2519@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 09:12:32PM +0100, Arnd Bergmann wrote:

> Are you sure that is true for the root bridge as well? I don't
> remember the details, but I though that for the host bridge,
> we don't actually look at the BARs at all.

That is right, but this isn't a host bridge device, it is a PCI-PCI
bridge with root complex registers. The root complex bridge is not the
same as the host bridge.

Unfortunately the implementation is non-conforming. :(

Jason
