From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Thu, 9 May 2013 20:12:40 +0200
Subject: [PATCH 1/2] atmel_nand: at91/avr32/: Replace
 cpu_is_at32ap7000() with a nand platform data
In-Reply-To: <1368084895-18266-2-git-send-email-josh.wu@atmel.com>
References: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
 <1368084895-18266-2-git-send-email-josh.wu@atmel.com>
Message-ID: <20130509181240.GA4260@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Thu 09 May 2013 15:34:54 +0800 or thereabout, Josh Wu wrote:
> The nand driver use cpu_is_at32ap7000() macro for a workaround. For the
> multi-platform support, we will remove this cpu_is_xxx() macro.
> 
> This patch adds a boolean variable need_reset_workaround in structure
> atmel_nand_data. Using this variable we can remove cpu_is_at32ap7000() macro.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/mach-at32ap/at32ap700x.c |    3 +++
>  drivers/mtd/nand/atmel_nand.c       |   13 ++++++-------
>  include/linux/platform_data/atmel.h |    3 +++
>  3 files changed, 12 insertions(+), 7 deletions(-)

Feel free to push this through the mtd tree, if they won't accept it I'm
working on getting my workflow up on the linux-avr32.git tree.

<snipp diff>

-- 
HcE
