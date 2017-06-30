From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 29 Jun 2017 18:43:05 -0700
Subject: [PATCH V1 3/9] clk: sprd: add gate clock support
In-Reply-To: <CAAfSe-sbJxEA0OdC9u3A4p5Q7hrfqkiHscvsuT_irOHp98G+aQ@mail.gmail.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170618015855.27738-4-chunyan.zhang@spreadtrum.com>
 <20170620013130.GI4493@codeaurora.org>
 <CAAfSe-sbJxEA0OdC9u3A4p5Q7hrfqkiHscvsuT_irOHp98G+aQ@mail.gmail.com>
Message-ID: <20170630014305.GK22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22, Chunyan Zhang wrote:
> On 20 June 2017 at 09:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/18, Chunyan Zhang wrote:
> >> diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
> >> index 8f802b2..333e2b2 100644
> >> --- a/drivers/clk/sprd/Makefile
> >> +++ b/drivers/clk/sprd/Makefile
> >> @@ -1,3 +1,3 @@
> >>  ifneq ($(CONFIG_OF),)
> >> -obj-y        += ccu_common.o
> >> +obj-y        += ccu_common.o ccu_gate.o
> >
> > Can this be built as a module?
> 
> Since most of all Spreadtrum device drivers would depend on if clocks
> have been initialized, so we'd prefer to build this into the kernel
> image.

This isn't really a good reason, but OK. Hopefully nobody wants
to make a module for every driver on the system and jam the ones
needed to access the rootfs into a ramdisk. Don't worry, you
don't need to support modules here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
