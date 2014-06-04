From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 5 Jun 2014 01:48:46 +0200
Subject: [PATCH v2] hsi: omap_ssi_port: use normal module refcounting
In-Reply-To: <4579153.ES6XlsZ43F@wuerfel>
References: <7426698.eEpYu3o0WK@wuerfel>
 <4579153.ES6XlsZ43F@wuerfel>
Message-ID: <20140604234846.GA16356@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 04, 2014 at 10:00:59AM +0200, Arnd Bergmann wrote:
> The ref_module() function is used for internal housekeeping of the
> module code, it's not normally used by subsystems or device drivers,
> and the use of ref_module in the omap_ssi_port driver causes a link
> build error when modules are disabled:
> 
> hsi/controllers/omap_ssi_port.c: In function 'ssi_port_probe':
> hsi/controllers/omap_ssi_port.c:1119:2: error: implicit declaration of function 'ref_module' [-Werror=implicit-function-declaration]
> 
> This changes the omap_ssi_port driver to use try_module_get()
> and module_put() instead, which is the normal way to ensure that
> the driver providing a device used in another module does not
> go away.

Thanks, applied:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=for-next&id=b357d7b58f379ebe8038cd97b6204f2f5c52220d

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140605/8de21a91/attachment.sig>
