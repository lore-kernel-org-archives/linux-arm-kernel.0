From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 10 Feb 2014 10:17:10 -0800
Subject: [PATCH v5] ARM: davinci: aemif: get rid of davinci-nand driver
 dependency on aemif
In-Reply-To: <52F201A7.2040401@ti.com>
References: <1391079820-13018-1-git-send-email-ivan.khoronzhuk@ti.com>
 <52F201A7.2040401@ti.com>
Message-ID: <20140210181710.GB18440@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 02:47:27PM +0530, Sekhar Nori wrote:
> On Thursday 30 January 2014 04:33 PM, Ivan Khoronzhuk wrote:
> > The problem that the set timings code contains the call of Davinci
> > platform function davinci_aemif_setup_timing() which is not
> > accessible if kernel is built for another platform like Keystone.
> > 
> > The Keysone platform is going to use TI AEMIF driver.
> > If TI AEMIF is used we don't need to set timings and bus width.
> > It is done by AEMIF driver.
> > 
> > To get rid of davinci-nand driver dependency on aemif platform code
> > we moved aemif code to davinci platform.
> > 
> > The platform AEMIF code (aemif.c) has to be removed once Davinci
> > will be converted to DT and use ti-aemif.c driver.
> > 
> > Acked-by: Brian Norris <computersforpeace@gmail.com>
> > Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> > [nsekhar at ti.com: fixed checkpatch error and a build breakage due to
> > 		 missing include, rebased onto l2-mtd/master]
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Hope this patch looks good to you now. I would like to take it for v3.15
> via DaVinci tree.

Sure. Just don't send any conflicting patches to me in the meantime!
I'll try to leave it alone, or at least check linux-next first.

Brian
