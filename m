From: coelho@ti.com (Luciano Coelho)
Date: Tue, 2 Jul 2013 23:19:54 +0300
Subject: [PATCH v2 8/9] wlcore: sdio: get clocks from device tree
In-Reply-To: <20130702153526.GI7013@arwen.pp.htv.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-9-git-send-email-coelho@ti.com>
 <20130702153526.GI7013@arwen.pp.htv.fi>
Message-ID: <1372796394.21065.89.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-02 at 18:35 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jul 02, 2013 at 05:55:47PM +0300, Luciano Coelho wrote:
> > @@ -294,6 +316,8 @@ static int wl1271_probe(struct sdio_func *func,
> >  	/* Use block mode for transferring over one block size of data */
> >  	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
> >  
> > +	sdio_set_drvdata(func, glue);
> 
> is this move really necessary ?

It is, because I use the glue in wlcore_get_pdata_from_of(), so I need
to call sdio_set_drvdata() earlier.  I reckoned it wouldn't hurt to move
this, so I wouldn't have to pass the glue in the
wlcore_get_pdata_from_of() call.

--
Luca.
