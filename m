From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Nov 2013 16:49:07 -0300
Subject: [PATCH v4 06/31] mtd: nand: pxa3xx: Add documentation about the
 controller
In-Reply-To: <20131114190004.GP9468@ld-irv-0074.broadcom.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383837455-30721-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131114190004.GP9468@ld-irv-0074.broadcom.com>
Message-ID: <20131114194906.GD9912@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 11:00:04AM -0800, Brian Norris wrote:
> On Thu, Nov 07, 2013 at 12:17:10PM -0300, Ezequiel Garcia wrote:
> > Given there's no public specification to this date, and in order
> > to capture some important details and singularities about the
> > controller let's document them once and for good.
> 
> Made a few small tweaks for spelling and such (see the following diff)
> and pushed patches 5 through 14 to l2-mtd.git/next.
> 

The below diff looks ok. I had to rework a few patches after the
completion patch rework, and I'm running some tests.

I'll submit the series as soon as the tests are done.

> Thanks,
> Brian
> 
> diff --git a/Documentation/mtd/nand/pxa3xx-nand.txt b/Documentation/mtd/nand/pxa3xx-nand.txt
> index 00e601c..840fd41 100644
> --- a/Documentation/mtd/nand/pxa3xx-nand.txt
> +++ b/Documentation/mtd/nand/pxa3xx-nand.txt
> @@ -36,7 +36,7 @@ OOB, one per chunk read.
>  So, in order to achieve reading (for instance), we issue several READ0 commands
>  (with some additional controller-specific magic) and read two chunks of 2080B
>  (2048 data + 32 spare) each.
> -The driver accomodates this data to expose the NAND core a contiguous buffer
> +The driver accommodates this data to expose the NAND core a contiguous buffer
>  (4096 data + spare) or (4096 + spare + ECC + spare + ECC).
>  
>  ECC
> @@ -81,7 +81,7 @@ an *entire* page.
>  Factory bad blocks handling
>  ===========================
>  
> -Given the ECC BCH requires to layout the device's pages in a splitted
> +Given the ECC BCH requires to layout the device's pages in a split
>  data/OOB/data/OOB way, the controller has a view of the flash page that's
>  different from the specified (aka the manufacturer's) view. In other words,
>  
> @@ -109,5 +109,5 @@ disabled by using the NAND_BBT_NO_OOB_BBM option in the driver. The rationale
>  for this is that there's no point in marking a block as bad, because good
>  blocks are also 'marked as bad' (in the OOB BBM sense) under normal usage.
>  
> -Instead, the drive relies in the bad block table alone, and should only perform
> +Instead, the driver relies on the bad block table alone, and should only perform
>  the bad block scan on the very first time (when the device hasn't been used).

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
