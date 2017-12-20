From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 20 Dec 2017 11:42:03 +0100
Subject: [PATCH v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <5A3A3AE6.6080905@nxp.com>
References: <20171129100844.19874-1-laurentiu.tudor@nxp.com>
 <20171219144802.GA4534@kroah.com> <5A392E3A.6040303@nxp.com>
 <20171219152916.GA11279@kroah.com> <5A3932BF.80106@nxp.com>
 <20171219161045.GA18839@kroah.com> <5A3A3AE6.6080905@nxp.com>
Message-ID: <20171220104203.GA29824@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 10:26:49AM +0000, Laurentiu Tudor wrote:
> On 12/19/2017 06:10 PM, Greg KH wrote:
> >>> But all of these .h files are only used by the code in this specific
> >>> directory, no where else.
> >>
> >> They are also used by our ethernet driver, see:
> >>     drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> >
> > Ick, really?  Then they should not be buried in a bus-specific
> > location, but rather be in include/linux/SOMEWHERE, right?
> 
> Right. The goal is that in the end, all headers be moved to the already 
> existing include/linux/fsl/. For now I've left these in staging because 
> they are not part of the bus "core" infrastructure.

Then shouldn't they be in the drivers/staging/fsl-mc/include/ directory
now to show this?

thanks,

greg k-h
