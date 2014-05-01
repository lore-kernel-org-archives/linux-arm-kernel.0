From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Thu, 1 May 2014 20:37:43 +0200
Subject: [RFC PATCH 0/3] mtd: nand: add randomizer support
In-Reply-To: <1398906592-24677-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1398906592-24677-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140501183743.GA17618@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thu, May 01, 2014 at 03:09:49AM +0200, Boris BREZILLON wrote:
> Hello,
> 
> This series is a proposal to add support for randomizers (either software
> or hardware) to NAND flash controller drivers.

Thanks for providing this! I'll need these features soon and I'm happy
to see them coming into the nand controller framework.


Antoine

> The last patch is the sunxi HW randomizer implementation and is just given
> as an example (it won't apply on the MTD tree, because it depends on other
> stuff not yet posted on the MTD ML, but if you want a full overview of the
> NAND Flash controller driver you can take a look at this series [2]).
> 
> I can also provide a software implementation based on LFSR (Left Feedback
> Shift Register) algorithm, thought I haven't tested it yet, hence why it's
> not part of this series. Let me know if you're interested in this
> implementation.
> 
> This series depends on the "per-partition ECC" series [1], because I need
> the randomizer seed to be different depending on the partition (for the
> same reason I needed ECC config to be different for each partition: the
> bootrom config might not fit the NAND chip requirements).
> 
> I'd like to have feedback from both MTD maintainers and driver
> developers who might need to implement (or use) a randomizer in their
> system, so feel free to comment on this series.
> 
> Best Regards,
> 
> Boris
> 
> [1] https://lkml.org/lkml/2014/2/12/627
> [2] https://groups.google.com/forum/#!msg/linux-sunxi/s3lBb01I0Js/z2NoCFJ83g4J 
> 
> 
> Boris BREZILLON (3):
>   mtd: nand: introduce a randomizer layer in the NAND framework
>   of: mtd: add NAND randomizer mode retrieval
>   mtd: nand: add sunxi randomizer support
> 
>  drivers/mtd/nand/nand_base.c  | 278 ++++++++++++++++++-----
>  drivers/mtd/nand/sunxi_nand.c | 507 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/of/of_mtd.c           |  35 +++
>  include/linux/mtd/nand.h      |  98 ++++++++
>  include/linux/of_mtd.h        |   6 +
>  5 files changed, 858 insertions(+), 66 deletions(-)
> 
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
