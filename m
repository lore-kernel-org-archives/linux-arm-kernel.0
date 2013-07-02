From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 00:32:08 +0300
Subject: [PATCH v2 8/9] wlcore: sdio: get clocks from device tree
In-Reply-To: <1372796394.21065.89.camel@cumari.coelho.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-9-git-send-email-coelho@ti.com>
 <20130702153526.GI7013@arwen.pp.htv.fi>
 <1372796394.21065.89.camel@cumari.coelho.fi>
Message-ID: <20130702213208.GC10388@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 11:19:54PM +0300, Luciano Coelho wrote:
> On Tue, 2013-07-02 at 18:35 +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Jul 02, 2013 at 05:55:47PM +0300, Luciano Coelho wrote:
> > > @@ -294,6 +316,8 @@ static int wl1271_probe(struct sdio_func *func,
> > >  	/* Use block mode for transferring over one block size of data */
> > >  	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
> > >  
> > > +	sdio_set_drvdata(func, glue);
> > 
> > is this move really necessary ?
> 
> It is, because I use the glue in wlcore_get_pdata_from_of(), so I need
> to call sdio_set_drvdata() earlier.  I reckoned it wouldn't hurt to move
> this, so I wouldn't have to pass the glue in the
> wlcore_get_pdata_from_of() call.

that's alright, it does look like it deserves a mention in changelog
though. Other than that:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/ec49d171/attachment.sig>
