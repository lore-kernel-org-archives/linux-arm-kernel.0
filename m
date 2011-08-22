From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 22 Aug 2011 15:11:59 +0200
Subject: [PATCH v9 1/3] MTD : add the common code for GPMI-NAND controller
	driver
In-Reply-To: <201108221511.16251.marek.vasut@gmail.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<4E51FAED.7030403@freescale.com>
	<201108221511.16251.marek.vasut@gmail.com>
Message-ID: <201108221511.59316.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2011 03:11:16 PM Marek Vasut wrote:
> On Monday, August 22, 2011 08:45:01 AM Huang Shijie wrote:
> > Hi Artem:
> > > On Mon, 2011-08-22 at 12:34 +0800, Huang Shijie wrote:
> > >>>> +	pr_info("ECC Algorithm          : %s\n", geo->ecc_algorithm);
> > >>>> +	pr_info("ECC Strength           : %u\n", geo->ecc_strength);
> > >>>> +	pr_info("Page Size in Bytes     : %u\n", geo->page_size_in_bytes);
> > >>>> +	pr_info("Metadata Size in Bytes : %u\n",
> > >>>> geo->metadata_size_in_bytes); +	pr_info("ECC Chunk Size in Bytes:
> > >>>> %u\n", geo->ecc_chunk_size_in_bytes); +	pr_info("ECC Chunk Count
> > >>>> 
> > >>>>   : %u\n", geo->ecc_chunk_count); +	pr_info("Payload Size in Bytes  
:
> > >>>> %u\n", geo->payload_size_in_bytes); +	pr_info("Auxiliary Size in
> > >>>> Bytes: %u\n", geo->auxiliary_size_in_bytes); +	pr_info("Auxiliary
> > >>>> Status Offset: %u\n", geo->auxiliary_status_offset);
> > >>>> +	pr_info("Block Mark Byte Offset : %u\n",
> > >>>> geo->block_mark_byte_offset);
> > >>>> +	pr_info("Block Mark Bit Offset  : %u\n",
> > >>>> geo->block_mark_bit_offset); +}
> > >>> 
> > >>> Isn't it too much info for normal users? Should this be pr_debug()
> > >> 
> > >> the log is only printed out when the bug occurs.
> > >> so it's not for normal users.
> > >> 
> > >>> instead? There is another similar place in your code.
> > >> 
> > >> ok, I will change to pr_debug().
> > > 
> > > I did not read the driver code carefully, so did not realize this is
> > > printed only in case of a bug - I thought this is printed on every boot
> > > up. For the bug case it may be OK to use pr_info as well, so I take
> > > back by comment about using pr_debug(), apologies.
> > 
> > thank you all the same :)
> 
> If this is printed only in case of bug, I agree with Artem.

Maybe though, dev_err() would be more suitable.

> 
> Sorry Huang, cheers!
> 
> > Huang Shijie
> > 
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
