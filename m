From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 6 Jun 2014 14:17:33 +0200
Subject: OMAP SSI build error
In-Reply-To: <20140606111323.GI23430@n2100.arm.linux.org.uk>
References: <20140606111323.GI23430@n2100.arm.linux.org.uk>
Message-ID: <20140606121733.GA29069@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jun 06, 2014 at 12:13:24PM +0100, Russell King - ARM Linux wrote:
> I recently spotted this build error (via a randconfig build):
> 
> drivers/hsi/controllers/omap_ssi_port.c: In function 'ssi_port_probe':
> drivers/hsi/controllers/omap_ssi_port.c:1119:2: error: implicit declaration of function 'ref_module'
> 
> Looks like it's missing out on including linux/module.h which provides
> the prototype for this function.

I have a fix for that in my for-next branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=for-next&id=b357d7b58f379ebe8038cd97b6204f2f5c52220d

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/68edb4fb/attachment-0001.sig>
