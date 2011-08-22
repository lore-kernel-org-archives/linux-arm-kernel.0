From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 22 Aug 2011 09:26:58 +0300
Subject: [PATCH v9 1/3] MTD : add the common code for GPMI-NAND
	controller driver
In-Reply-To: <4E51DC57.8060608@freescale.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<1313581828-16625-2-git-send-email-b32955@freescale.com>
	<1313818550.31216.9.camel@koala> <4E51DC57.8060608@freescale.com>
Message-ID: <1313994423.2644.3.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-08-22 at 12:34 +0800, Huang Shijie wrote:
> >> +	pr_info("ECC Algorithm          : %s\n", geo->ecc_algorithm);
> >> +	pr_info("ECC Strength           : %u\n", geo->ecc_strength);
> >> +	pr_info("Page Size in Bytes     : %u\n", geo->page_size_in_bytes);
> >> +	pr_info("Metadata Size in Bytes : %u\n", geo->metadata_size_in_bytes);
> >> +	pr_info("ECC Chunk Size in Bytes: %u\n", geo->ecc_chunk_size_in_bytes);
> >> +	pr_info("ECC Chunk Count        : %u\n", geo->ecc_chunk_count);
> >> +	pr_info("Payload Size in Bytes  : %u\n", geo->payload_size_in_bytes);
> >> +	pr_info("Auxiliary Size in Bytes: %u\n", geo->auxiliary_size_in_bytes);
> >> +	pr_info("Auxiliary Status Offset: %u\n", geo->auxiliary_status_offset);
> >> +	pr_info("Block Mark Byte Offset : %u\n", geo->block_mark_byte_offset);
> >> +	pr_info("Block Mark Bit Offset  : %u\n", geo->block_mark_bit_offset);
> >> +}
> > Isn't it too much info for normal users? Should this be pr_debug()
> the log is only printed out when the bug occurs.
> so it's not for normal users.
> > instead? There is another similar place in your code.
> >
> ok, I will change to pr_debug().

I did not read the driver code carefully, so did not realize this is
printed only in case of a bug - I thought this is printed on every boot
up. For the bug case it may be OK to use pr_info as well, so I take back
by comment about using pr_debug(), apologies.

-- 
Best Regards,
Artem Bityutskiy
