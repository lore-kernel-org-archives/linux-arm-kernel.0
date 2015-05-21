From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 20 May 2015 21:40:54 -0700
Subject: [PATCH v3 4/4] mtd: mxc_nand: generate nand_ecclayout for 8 bit
 ECC
In-Reply-To: <20150521041128.GI2586@tarshish>
References: <cover.1431504091.git.baruch@tkos.co.il>
 <95e2a17d74da5a0415ab93e060f6efc681216313.1431504091.git.baruch@tkos.co.il>
 <20150520224120.GS11598@ld-irv-0074>
 <20150521041128.GI2586@tarshish>
Message-ID: <20150521044054.GC23718@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 07:11:28AM +0300, Baruch Siach wrote:
> On Wed, May 20, 2015 at 03:41:20PM -0700, Brian Norris wrote:
> > On Wed, May 13, 2015 at 11:17:39AM +0300, Baruch Siach wrote:
> > > +		if (get_eccsize(mtd) == 8)
> > > +			ecc_8bit_layout_4k(this->ecc.layout);
> > 
> > So you're overwriting an existing layout (e.g., nandv2_hw_eccoob_4k).
> > What if you have more than one NAND chip? You might do better by
> > dynamically allocating the memory.
> 
> It would take a quite a bit more code changes then that to have the mxc_nand 
> driver support more than one NAND chip, not to mention the DT binding. As Uwe 

Right. I guess there's also the case that you have more than one
instance of this controller / driver. But I assume that's pretty
unlikely?

> has indicated on a previous version of this series, ecclayout handling in this 
> driver could use some cleanup. This patch just fixes bug, trying to break 
> anything else while doing so.

Yeah, OK. Then I'll apply this patch anyway, and the rest could be
worked out later if this driver ever supports more cases.

> Thanks for reviewing, and for applying the rest of this series.

Applied, thanks.

Brian
