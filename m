From: ek9852@gmail.com (Mok Keith)
Date: Sat, 26 Sep 2009 01:04:47 +0800
Subject: [PATCH 1/5] pxa3xx_nand: enable PXA3xx bad block management
In-Reply-To: <771cded00909250457w19686a53obdc178488368dd43@mail.gmail.com>
References: <771cded00909250457w19686a53obdc178488368dd43@mail.gmail.com>
Message-ID: <69f617130909251004y2a17cdetb45f6022a37b4249@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Any reason to limit the max slot to 40 (PXA_MAX_SLOT). It seems the
bad block management scheme is not scalable and have a limitation of
up to 256M bytes flash size only. (256M, 128kB per block = 2048 blocks
= 40 bad blocks)

Also for the calibration of the 2% bad block area, according to most
NAND specifications (checked Samsung, Hynix, Micron), nand flash
vendor guarantee no more than 20 bad block per 1024 blocks and this
rule is apply linearly.

Would it be better to use the following otherwise when nand size is
greater than 256M the no of bad block entries is not matched to
specification:
instead of:
> +    entries = (entries * 2) / 100;

use:
+    entries = (entries * 10) / 512;

May I know what is the use of PXA_BEGIN_SLOT ?

Keith
