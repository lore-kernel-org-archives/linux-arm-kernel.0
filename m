From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 7 Mar 2014 00:02:51 -0800
Subject: [PATCH] Disable Subpage nand write when using Atmel PMECC
In-Reply-To: <53194432.50104@atmel.com>
References: <1393845329-18175-1-git-send-email-Herve.CODINA@celad.com>
 <53194432.50104@atmel.com>
Message-ID: <20140307080251.GI31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 11:59:46AM +0800, Josh Wu wrote:
> On 3/3/2014 7:15 PM, Herve Codina wrote:
> >Crash detected on sam5d35 and its pmecc nand ecc controller.
> >
> >The problem was a call to chip->ecc.hwctl from nand_write_subpage_hwecc
> >(nand_base.c) when we write a sub page.
> >chip->ecc.hwctl function is not set when we are using PMECC controller.
> >As a workaround, set NAND_NO_SUBPAGE_WRITE for PMECC controller in
> >order to disable sub page access in nand_write_page.
> >
> >
> >Signed-off-by: Herve Codina <Herve.CODINA@celad.com>
> 
> Acked-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git. Thanks!

Brian
