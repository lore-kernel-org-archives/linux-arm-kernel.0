From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 7 Mar 2014 15:08:00 -0800
Subject: [PATCH RFC v2 04/11] tty: xuartps: Remove bogus comment and
 register write
In-Reply-To: <20140307212816.715e5e19@alan.etchedpixels.co.uk>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-5-git-send-email-soren.brinkmann@xilinx.com>
 <20140307212816.715e5e19@alan.etchedpixels.co.uk>
Message-ID: <e074f376-9565-422e-abee-fdaa031239a1@TX2EHSMHS043.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-03-07 at 09:28PM +0000, One Thousand Gnomes wrote:
> On Fri,  7 Mar 2014 11:13:27 -0800
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > index a4bd6242e72d..a39c2d290902 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -1082,11 +1082,7 @@ static void xuartps_console_write(struct console *co, const char *s,
> >  
> >  	xuartps_writel(ctrl, XUARTPS_CR_OFFSET);
> >  
> > -	/* restore interrupt state, it seems like there may be a h/w bug
> > -	 * in that the interrupt enable register should not need to be
> > -	 * written based on the data sheet
> > -	 */
> > -	xuartps_writel(~imr, XUARTPS_IDR_OFFSET);
> > +	/* restore interrupt state */
> 
> It would be appropriate for the changelog at least to explain why the
> note about the data sheet differing is going away !

I don't know why anybody ever thought things are broken. IMHO, the
comment does not make any sense. Why would it not be required to write
the enable register when you enable interrupts?
I think someone read the data sheet wrong.

	S?ren
