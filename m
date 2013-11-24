From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 24 Nov 2013 15:22:39 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87d2lp28pd.fsf@natisbad.org>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org>
Message-ID: <20131124152239.01777cf9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Sun, 24 Nov 2013 15:08:46 +0100, Arnaud Ebalard wrote:

> [   80.189852] pxa3xx-nand d00d0000.nand: This platform can't do DMA on this device
> [   80.197454] NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC)
> [   80.205308] NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
> [   80.211594] pxa3xx-nand d00d0000.nand: ECC strength 1 at page size 2048 is not supported
> [   80.219699] pxa3xx-nand d00d0000.nand: failed to scan nand at cs 0

[...]

> i.e. return 0 because it does not support page size and strength of the
> chip. I also guess this works fine on the Armada mirabox and XP GP
> boards you have which both include a 1GB NAND flash w/ higher page size
> and ECC strength.

Right, that's correct. Ezequiel will expand on this, but we
intentionally excluded the cases we couldn't test, such as 2048 bytes
page size.

> I wonder if you could extend your support support to lower page size and
> strength. I'd be happy to test it on a 370 and XP based platfom.

We were just waiting for people to have practical cases that we can
test, so I'm sure Ezequiel will provide patches to support 2048 bytes
page size.

Thanks for your testing, very useful!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
