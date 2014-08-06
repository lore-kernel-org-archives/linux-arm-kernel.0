From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 6 Aug 2014 11:44:40 +0100
Subject: [PATCH] mtd: nand: stm_nand_bch: add new driver
In-Reply-To: <20140731164709.GK9030@lee--X1>
References: <1401268805-26043-1-git-send-email-lee.jones@linaro.org>
 <20140703002237.GM3599@ld-irv-0074> <20140731164709.GK9030@lee--X1>
Message-ID: <20140806104440.GC10136@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jul 2014, Lee Jones wrote:
> On Wed, 02 Jul 2014, Brian Norris wrote:
> > On Wed, May 28, 2014 at 10:20:05AM +0100, Lee Jones wrote:

[...]

> > > +	if (IS_ERR(pdata))
> > > +		return PTR_ERR(pdata);
> > > +
> > > +	ppdata.of_node = stm_of_get_partitions_node(np, 0);
> > 
> > So you only support a single bank, at chip-select 0? Is this a
> > hardware limitation, or simply software? You might consider whether this
> > needs to be noted in the DT binding too -- it currently suggests that
> > this can be plural.
> 
> Yes, only one bank.  Chip select is not possible.

Sorry, not only one bank.

We can have multiple banks, but only one chip.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
