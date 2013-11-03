From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 3 Nov 2013 17:36:50 -0500
Subject: [PATCH v2 09/27] mtd: nand: pxa3xx: Split FIFO size from
 to-be-read FIFO count
In-Reply-To: <1382137374-21251-10-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-10-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131103223646.GC5896@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 08:02:36PM -0300, Ezequiel Garcia wrote:
>  
> -	switch (host->page_size) {
> +	switch (info->fifo_size) {
>  	case 2048:
	
there is a item in the builtin_flash_types:
{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1] },

The original host->page_size could be 4096, how can the old code support
this nand with page-size is 4096?

thanks
Huang Shijie
