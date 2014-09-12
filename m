From: shijie.huang@intel.com (Huang Shijie)
Date: Fri, 12 Sep 2014 08:40:47 +0800
Subject: [PATCH] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <20140911164536.796f1012@bbrezillon>
References: <1410339339-25561-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140911142930.GB2543@localhost.localdomain>
 <20140911164536.796f1012@bbrezillon>
Message-ID: <20140912004047.GA26904@shldeISGChi005.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 04:45:36PM +0200, Boris BREZILLON wrote:
> On Thu, 11 Sep 2014 22:29:32 +0800
> Huang Shijie <shijie8@gmail.com> wrote:
> 
> > On Wed, Sep 10, 2014 at 10:55:39AM +0200, Boris BREZILLON wrote:
> >  +static int gpmi_ecc_read_page_raw(struct mtd_info *mtd,
> > > +				  struct nand_chip *chip, uint8_t *buf,
> > > +				  int oob_required, int page)
> > > +{
> > > +	struct gpmi_nand_data *this = chip->priv;
> > > +	struct bch_geometry *nfc_geo = &this->bch_geometry;
> > > +	int eccsize = nfc_geo->ecc_chunk_size;
> > > +	int eccbytes = DIV_ROUND_UP(nfc_geo->ecc_strength * nfc_geo->gf_len,
> > > +				    8);
> > 
> > In actually, the ECC can be _NOT_ bytes aligned.
> > you should not round up to byte.
> 
> You mean, on the NAND storage ? That would be weird, but I'll check.

yes. it is weird. 

thanks
Huang Shijie
