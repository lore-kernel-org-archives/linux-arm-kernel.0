From: eric@anholt.net (Eric Anholt)
Date: Mon, 23 May 2016 19:14:09 -0700
Subject: [PATCH 2/4] hwrng: bcm2835: Support Broadcom NSP SoC rng
In-Reply-To: <1464020451-16520-3-git-send-email-yendapally.reddy@broadcom.com>
References: <1464020451-16520-1-git-send-email-yendapally.reddy@broadcom.com>
 <1464020451-16520-3-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <87oa7w2oem.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
writes:

> This supports the random number generator available in NSP SoC.
> Masks the rng interrupt for NSP.

The interrupt reg is also present on the 2835.  I would prefer for
simplicity if you also initialized the register to the same value on the
Pi, even though the firmware has presumably been setting it for us
already.

However, this patch is still correct and I'm fine with it, so it's:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160523/b46b26ff/attachment-0001.sig>
