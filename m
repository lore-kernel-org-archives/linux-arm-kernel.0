From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 31 May 2015 12:23:53 +0900
Subject: [PATCH] char:xilinx_hwicap:buffer_icap - change 1/0 to
 true/false for bool type variable in function
 buffer_icap_set_configuration().
In-Reply-To: <5565B9B7.8080506@xilinx.com>
References: <1432582863-5012-1-git-send-email-shailendra.capricorn@gmail.com>
 <5565B9B7.8080506@xilinx.com>
Message-ID: <20150531032353.GB1603@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 02:33:59PM +0200, Michal Simek wrote:
> +Greg
> 
> On 05/25/2015 09:41 PM, Shailendra Verma wrote:
> > The variable dirty is bool type. Hence assign the variable with
> > bool value true/false instead of 1/0.
> > 
> > Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> > ---
> >  drivers/char/xilinx_hwicap/buffer_icap.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/xilinx_hwicap/buffer_icap.c b/drivers/char/xilinx_hwicap/buffer_icap.c
> > index 05d8977..53c3882 100644
> > --- a/drivers/char/xilinx_hwicap/buffer_icap.c
> > +++ b/drivers/char/xilinx_hwicap/buffer_icap.c
> > @@ -270,7 +270,7 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
> >  	int status;
> >  	s32 buffer_count = 0;
> >  	s32 num_writes = 0;
> > -	bool dirty = 0;
> > +	bool dirty = false;
> >  	u32 i;
> >  	void __iomem *base_address = drvdata->base_address;
> >  
> > @@ -279,7 +279,7 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
> >  
> >  		/* Copy data to bram */
> >  		buffer_icap_set_bram(base_address, buffer_count, data[i]);
> > -		dirty = 1;
> > +		dirty = true;
> >  
> >  		if (buffer_count < XHI_MAX_BUFFER_INTS - 1) {
> >  			buffer_count++;
> > @@ -299,7 +299,7 @@ int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
> >  
> >  		buffer_count = 0;
> >  		num_writes++;
> > -		dirty = 0;
> > +		dirty = false;
> >  	}
> >  
> >  	/* Write unwritten data to ICAP */
> > 
> 
> Tested-by: Michal Simek <michal.simek@xilinx.com>

Hm, I don't have the original, can you resend it with your tested-by?

thanks,

greg k-h
