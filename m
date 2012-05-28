From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 28 May 2012 08:39:58 +0200
Subject: [PATCH v9 0/3] MTD: at91: Add PMECC support for at91 nand
 flash driver
In-Reply-To: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
References: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20120528063958.GK3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:24 Sat 26 May     , Josh Wu wrote:
> Code is based on 3.4-rc2
> 
> Changes since v8,
> 	use _relaxed read/write in most place. use writel in operations of Control Register since it needs memory barrier.
> 	allocate the data for PMECC computation.
> 	add pmecc prefix for related variable/functions.
> 	modify code according to J.C's suggestion. except:
> 		>> +	for (i = 2; i <= 2 * host->cap; i += 2) {
> 		> manage the j in the for loop
> 		since that will change to: 
> 		+	for (i = 2, j = 1; i <= 2 * host->cap; i += 2, j = i / 2) {
		why you insist on doing j = i / 2

		you can simplify it by j++

		or loop on j and do i = j << 1;

		it's more simple and faster

Best Regards,
J.
