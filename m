From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 23 Aug 2011 12:34:16 +0200
Subject: [PATCH v9 1/3] MTD : add the common code for GPMI-NAND controller
	driver
In-Reply-To: <4E53807B.10100@freescale.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<201108221509.49721.marek.vasut@gmail.com>
	<4E53807B.10100@freescale.com>
Message-ID: <201108231234.16258.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 23, 2011 12:27:07 PM Huang Shijie wrote:
> Hi,
> 
> >>>> +}
> >>>> +
> >>>> +int common_nfc_set_geometry(struct gpmi_nand_data *this)
> >>>> +{
> >>>> +	struct bch_geometry *geo =&this->bch_geometry;
> >>>> +	struct mtd_info *mtd =&this->mil.mtd;
> >>>> +	unsigned int metadata_size;
> >>>> +	unsigned int status_size;
> >>>> +	unsigned int chunk_data_size_in_bits;
> >>>> +	unsigned int chunk_ecc_size_in_bits;
> >>>> +	unsigned int chunk_total_size_in_bits;
> >>>> +	unsigned int block_mark_chunk_number;
> >>>> +	unsigned int block_mark_chunk_bit_offset;
> >>>> +	unsigned int block_mark_bit_offset;
> >>>> +	int gf_len = 13;/* use GP13 by default */
> >>>> +
> >>>> +	/* We only support BCH now. */
> >>>> +	geo->ecc_algorithm = "BCH";
> >>>> +
> >>>> +	/*
> >>>> +	 * We always choose a metadata size of 10. Don't try to make sense
> >>>> of +	 * it -- this is really only for historical compatibility.
> >>>> +	 */
> >>> 
> >>> Historical compat or you mean "the chip was designed this way, see
> >>> datasheet section x.y.z"? ;-)
> >> 
> >> Just for historical compatibility.
> >> it's better to keep it as now, there is no need to change it.
> > 
> > I'm just trying to make sense of it ... from the docs, it seems like a
> > chip design thing. So this is compat with STMP37xx and 36xx ? Or even
> > something older and more obscure ?
> 
> The size of metadata can be changed, though it's set to 10 bytes now.
> 
> But it can't be too large, because we have to save enough space for BCH.

I saw the algo in the MX28 manual. Then just sum this up in the comment and it's 
good :)

Thanks!

Cheers
> 
> 
> thanks
> Huang Shijie
