From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 5 Feb 2014 14:47:27 +0530
Subject: [PATCH v5] ARM: davinci: aemif: get rid of davinci-nand driver
 dependency on aemif
In-Reply-To: <1391079820-13018-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1391079820-13018-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52F201A7.2040401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Thursday 30 January 2014 04:33 PM, Ivan Khoronzhuk wrote:
> The problem that the set timings code contains the call of Davinci
> platform function davinci_aemif_setup_timing() which is not
> accessible if kernel is built for another platform like Keystone.
> 
> The Keysone platform is going to use TI AEMIF driver.
> If TI AEMIF is used we don't need to set timings and bus width.
> It is done by AEMIF driver.
> 
> To get rid of davinci-nand driver dependency on aemif platform code
> we moved aemif code to davinci platform.
> 
> The platform AEMIF code (aemif.c) has to be removed once Davinci
> will be converted to DT and use ti-aemif.c driver.
> 
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> [nsekhar at ti.com: fixed checkpatch error and a build breakage due to
> 		 missing include, rebased onto l2-mtd/master]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Hope this patch looks good to you now. I would like to take it for v3.15
via DaVinci tree.

Thanks,
Sekhar
