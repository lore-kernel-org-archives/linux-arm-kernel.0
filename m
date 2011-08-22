From: b32955@freescale.com (Huang Shijie)
Date: Mon, 22 Aug 2011 12:34:31 +0800
Subject: [PATCH v9 1/3] MTD : add the common code for GPMI-NAND controller
	driver
In-Reply-To: <1313818550.31216.9.camel@koala>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>	
	<1313581828-16625-2-git-send-email-b32955@freescale.com>
	<1313818550.31216.9.camel@koala>
Message-ID: <4E51DC57.8060608@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> 1. You do not need to call parse_mtd_partitions() anymore - we re-worked
> the partitions registration in l2-mtd-2.6.git:
>
> http://git.infradead.org/users/dedekind/l2-mtd-2.6.git
>
thanks.
>> +static void show_bch_geometry(struct bch_geometry *geo)
>> +{
>> +	pr_info("---------------------------------------\n");
>> +	pr_info("	BCH Geometry\n");
>> +	pr_info("---------------------------------------\n");
> I think these "---" only consume memory in .data. This is the kernel and
> I think nice separators like this should be avoided.
>
ok. got it.
>> +	pr_info("ECC Algorithm          : %s\n", geo->ecc_algorithm);
>> +	pr_info("ECC Strength           : %u\n", geo->ecc_strength);
>> +	pr_info("Page Size in Bytes     : %u\n", geo->page_size_in_bytes);
>> +	pr_info("Metadata Size in Bytes : %u\n", geo->metadata_size_in_bytes);
>> +	pr_info("ECC Chunk Size in Bytes: %u\n", geo->ecc_chunk_size_in_bytes);
>> +	pr_info("ECC Chunk Count        : %u\n", geo->ecc_chunk_count);
>> +	pr_info("Payload Size in Bytes  : %u\n", geo->payload_size_in_bytes);
>> +	pr_info("Auxiliary Size in Bytes: %u\n", geo->auxiliary_size_in_bytes);
>> +	pr_info("Auxiliary Status Offset: %u\n", geo->auxiliary_status_offset);
>> +	pr_info("Block Mark Byte Offset : %u\n", geo->block_mark_byte_offset);
>> +	pr_info("Block Mark Bit Offset  : %u\n", geo->block_mark_bit_offset);
>> +}
> Isn't it too much info for normal users? Should this be pr_debug()
the log is only printed out when the bug occurs.
so it's not for normal users.
> instead? There is another similar place in your code.
>
ok, I will change to pr_debug().

thanks
Huang Shijie
> Artem.
>
>
