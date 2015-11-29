From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 29 Nov 2015 15:35:48 +0100
Subject: [PATCH 4/4] ARM: dt: mvebu: ix4-300d: Add ECC properties to
 NAND flash
In-Reply-To: <1448709248-21177-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1448709248-21177-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20151129153548.304522af@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

Adding Ezequiel Garcia in Cc.

On Sat, 28 Nov 2015 12:14:08 +0100, Sebastian Hesselbarth wrote:
> The NAND device found on Lenovo ix4-300d uses 4-bit BCH ECC protection.
> Add the corresponding properties to the NAND node.

If the ONFI information from the NAND flash say that it requires 4 bits
per 512, then there should be no need to add this information to the
Device Tree as the pxa3xx_nand driver by default uses the ONFI
information.

Those properties are only needed when for some reason the vendor has
chosen to use a ECC strength that doesn't match with the one advertised
by the flash in its ONFI information (either stronger or weaker). But
in this case, your commit log is confusing, because it says that the
"NAND device ... uses 4-bit BCH ECC protection". If it really does,
then the patch is not needed :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
