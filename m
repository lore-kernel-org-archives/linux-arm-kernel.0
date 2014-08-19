From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 19 Aug 2014 12:06:53 -0700
Subject: [PATCH 0/8] mtd: nand: Support for new DT NAND driver
In-Reply-To: <20140818083953.GA4266@lee--X1>
References: <1407921127-8590-1-git-send-email-lee.jones@linaro.org>
 <20140814224013.GE18411@ld-irv-0074>
 <20140818083953.GA4266@lee--X1>
Message-ID: <20140819190653.GV18411@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 09:39:53AM +0100, Lee Jones wrote:
> On Thu, 14 Aug 2014, Brian Norris wrote:
> > drivers/mtd/nand/stm_nand_bch.c: In function 'bch_calc_timing_registers':
> > drivers/mtd/nand/stm_nand_bch.c:1022:6: warning: variable 'ren_half_off' set but not used [-Wunused-but-set-variable]
> > drivers/mtd/nand/stm_nand_bch.c:1021:6: warning: variable 'ren_half_on' set but not used [-Wunused-but-set-variable]
> 
> This I have never seen.  I guess -Wunused-but-set-variable is normally
> off.  This issue has been present since the beginning of this endeavour
> and exists in the original (internal) code.

BTW, you can get extra warnings by building with the W=[123] option to
the Makefile (e.g., 'make W=1').

$ make help
[...]
  make W=n   [targets] Enable extra gcc checks, n=1,2,3 where
		1: warnings which may be relevant and do not occur too often
		2: warnings which occur quite often but may still be relevant
		3: more obscure warnings, can most likely be ignored
		Multiple levels can be combined with W=12 or W=123

Brian
