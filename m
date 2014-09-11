From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 16:45:36 +0200
Subject: [PATCH] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <20140911142930.GB2543@localhost.localdomain>
References: <1410339339-25561-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140911142930.GB2543@localhost.localdomain>
Message-ID: <20140911164536.796f1012@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Sep 2014 22:29:32 +0800
Huang Shijie <shijie8@gmail.com> wrote:

> On Wed, Sep 10, 2014 at 10:55:39AM +0200, Boris BREZILLON wrote:
>  +static int gpmi_ecc_read_page_raw(struct mtd_info *mtd,
> > +				  struct nand_chip *chip, uint8_t *buf,
> > +				  int oob_required, int page)
> > +{
> > +	struct gpmi_nand_data *this = chip->priv;
> > +	struct bch_geometry *nfc_geo = &this->bch_geometry;
> > +	int eccsize = nfc_geo->ecc_chunk_size;
> > +	int eccbytes = DIV_ROUND_UP(nfc_geo->ecc_strength * nfc_geo->gf_len,
> > +				    8);
> 
> In actually, the ECC can be _NOT_ bytes aligned.
> you should not round up to byte.

You mean, on the NAND storage ? That would be weird, but I'll check.

When accessing in raw mode I'm not using the ECC engine (or at least
that's what I'm trying to achieve when using read_buf and not
gpmi_ecc_read_page).



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
