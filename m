From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 4 Jun 2014 01:18:07 +0200
Subject: HSI: fix omap ssi driver dependency
In-Reply-To: <5261510.XDu5DxNnFl@wuerfel>
References: <5261510.XDu5DxNnFl@wuerfel>
Message-ID: <20140603231807.GA13171@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jun 03, 2014 at 05:14:01PM +0200, Arnd Bergmann wrote:
> The SSI protocol implementation has an incorrect dependency on the OMAP_SSI
> driver, which allows SSI to be built-in while the underlying OMAP_SSI
> implementation is a loadable module, causing a link error.
> 
> This changes the dependency to the simpler 'depends on OMAP_SSI' that also
> ensures that SSI-protocol can only be a module if OMAP_SSI is not built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=for-next&id=518e1624f56615a88c91bc79c7b4b4d9eb2419e5

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/d46a40df/attachment.sig>
