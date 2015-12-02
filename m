From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 2 Dec 2015 05:32:14 +0000
Subject: [PATCH v2 1/3] serial: xuartps: Spliting the ISR into smaller
 routines.
In-Reply-To: <20151120144348.GS32017@xsjsorenbubuntu>
References: <1448026478-22131-1-git-send-email-navam@xilinx.com>
 <20151120144348.GS32017@xsjsorenbubuntu>
Message-ID: <C89496FEAE474D468F30D558A9468D9F25949EBB@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Friday, November 20, 2015 8:14 PM
> To: Nava kishore Manne
> Cc: jslaby at suse.com; Michal Simek; Anirudha Sarangi; linux-
> serial at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Nava kishore Manne
> Subject: Re: [PATCH v2 1/3] serial: xuartps: Spliting the ISR into smaller
> routines.
> 
> On Fri, 2015-11-20 at 07:04PM +0530, Nava kishore Manne wrote:
> > Breaking the single big ISR that has both Rx and Tx in a single
> > function into smaller ones
> >
> > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > ---
> > Changes for v2:
> > 	--Splits up the ISR without any functional changes as suggested
> > 	by Peter Hurley
> >
> >  drivers/tty/serial/xilinx_uartps.c | 247
> > ++++++++++++++++++++-----------------
> >  1 file changed, 135 insertions(+), 112 deletions(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 009e0db..2e1b0a8 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -172,6 +172,9 @@ struct cdns_uart {  #define to_cdns_uart(_nb)
> > container_of(_nb, struct cdns_uart, \
> >  		clk_rate_change_nb);
> >
> > +static void cdns_uart_handle_tx(void *dev_id); static void
> > +cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus);
> 
> Can't you just move these functions here instead of adding prototypes here?

Initially I created the patch without adding prototypes but that patch was unreadable
Due to the common lines of code b/w the functions so created the prototypes to make the 
Patch more readable as suggested by Peter.

Will add one more patch in the next series to get rid of the prototypes.

> Also, this is likely to conflict with
> https://lkml.org/lkml/2015/11/19/622

Yes I agree l see that no comments for your series of patches as of now...
Let me know whether I should wait until your patches got applied or you want me to send the next version 
Of my patches...

Regards,
Navakishore.

> 
> 	S?ren
