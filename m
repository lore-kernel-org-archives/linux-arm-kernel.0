From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 09 Feb 2012 14:11:27 +0200
Subject: [PATCH 2/2] mtd: ixp4xx: oops in ixp4xx_flash_probe
In-Reply-To: <1328729069-21308-3-git-send-email-mkl@blackshift.org>
References: <1328729069-21308-1-git-send-email-mkl@blackshift.org>
 <1328729069-21308-3-git-send-email-mkl@blackshift.org>
Message-ID: <1328789487.22240.84.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-08 at 20:24 +0100, Marc Kleine-Budde wrote:
> In commit "c797533 mtd: abstract last MTD partition parser argument" the
> third argument of "mtd_device_parse_register()" changed from start address
> of the MTD device to a pointer to a struct.

Hi, thanks for the fix. Several comments:

1. I've removed the huge oops from the description - it is not very
helpful and not worth having.
2. It is usually a good idea to CC the author of the commit causing the
regression.
3. For regressions like this it is a good idea put the stable tree tag.

I've added

Cc: stable at kernel.org [3.2+]

(git tag --contains c797533 gives the version)

and pushed to the l2-mtd.git tree, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/971916af/attachment.sig>
