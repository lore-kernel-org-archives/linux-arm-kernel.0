From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 09:17:10 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071926.08810.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071509.55166.arnd@arndb.de>
 <20120507151744.GI17002@opensource.wolfsonmicro.com>
 <201205071926.08810.arnd@arndb.de>
Message-ID: <20120508081710.GC15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 07:26:08PM +0000, Arnd Bergmann wrote:

> Yes, it also does that, but have a look at how drivers/pci/pci.c uses
> devres to attach auxiliary attributes to a device. We can do the same
> thing for other devices to attach any data.

Actually, thinking about this further devres is definitely not what we
want here: when the device is unbound it'll free all the resources it
has for the device which is definitely not what we want for things like
this.  We need the data to persist for as long as the device exists.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/cc6b4ac2/attachment-0001.sig>
