From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 20 Dec 2017 12:06:41 +0100
Subject: [PATCH v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <5A3A4103.6050502@nxp.com>
References: <20171129100844.19874-1-laurentiu.tudor@nxp.com>
 <20171219144802.GA4534@kroah.com> <5A392E3A.6040303@nxp.com>
 <20171219152916.GA11279@kroah.com> <5A3932BF.80106@nxp.com>
 <20171219161045.GA18839@kroah.com> <5A3A3AE6.6080905@nxp.com>
 <20171220104203.GA29824@kroah.com> <5A3A4103.6050502@nxp.com>
Message-ID: <20171220110641.GB7001@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 10:52:52AM +0000, Laurentiu Tudor wrote:
> 
> 
> On 12/20/2017 12:42 PM, Greg KH wrote:
> > On Wed, Dec 20, 2017 at 10:26:49AM +0000, Laurentiu Tudor wrote:
> >> On 12/19/2017 06:10 PM, Greg KH wrote:
> >>>>> But all of these .h files are only used by the code in this specific
> >>>>> directory, no where else.
> >>>>
> >>>> They are also used by our ethernet driver, see:
> >>>>      drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> >>>
> >>> Ick, really?  Then they should not be buried in a bus-specific
> >>> location, but rather be in include/linux/SOMEWHERE, right?
> >>
> >> Right. The goal is that in the end, all headers be moved to the already
> >> existing include/linux/fsl/. For now I've left these in staging because
> >> they are not part of the bus "core" infrastructure.
> >
> > Then shouldn't they be in the drivers/staging/fsl-mc/include/ directory
> > now to show this?
> 
> Not sure i get your comment. Aren't we talking about the headers in there?
> 
> This was your original comment:
> 
>  > Also, what's up with the .h files in drivers/staging/fsl-bus/include?
>  > You didn't touch those with this movement, right?  Why?

Ok, yeah, I'm getting confused now.  Let's just see what you do with
your next set of patches and we can go from there :)

thanks,

greg k-h
