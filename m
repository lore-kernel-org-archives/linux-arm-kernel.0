From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Fri, 14 Jan 2011 12:43:52 +0100
Subject: [PATCH] MTD: atmel_nand: Add DMA support to access Nandflash
In-Reply-To: <1294997687-12515-1-git-send-email-hong.xu@atmel.com> (Hong Xu's
	message of "Fri, 14 Jan 2011 17:34:47 +0800")
References: <1294997687-12515-1-git-send-email-hong.xu@atmel.com>
Message-ID: <878vynww07.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Hong" == Hong Xu <hong.xu@atmel.com> writes:

 Hong> Some SAM9 chips have the ability to perform DMA between CPU and
 Hong> SMC controller.  This patch adds DMA support for SAM9RL, SAM9G45,
 Hong> SSAM9G46,AM9M10, SAM9M11.

 Hong> Signed-off-by: Hong Xu <hong.xu@atmel.com>

But mtd buffers are not guaranteed to be DMA safe (E.G. might come from
vmalloc), so you'll need to walk the page tables.

-- 
Bye, Peter Korsgaard
