From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Sat, 8 Mar 2014 21:57:48 +0000
Subject: [PATCH RFC v2 04/11] tty: xuartps: Remove bogus comment and
 register write
In-Reply-To: <e074f376-9565-422e-abee-fdaa031239a1@TX2EHSMHS043.ehs.local>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-5-git-send-email-soren.brinkmann@xilinx.com>
 <20140307212816.715e5e19@alan.etchedpixels.co.uk>
 <e074f376-9565-422e-abee-fdaa031239a1@TX2EHSMHS043.ehs.local>
Message-ID: <20140308215748.4889aed8@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Mar 2014 15:08:00 -0800
S?ren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> On Fri, 2014-03-07 at 09:28PM +0000, One Thousand Gnomes wrote:
> > On Fri,  7 Mar 2014 11:13:27 -0800
> > Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> > 
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > ---
> > >  drivers/tty/serial/xilinx_uartps.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > > index a4bd6242e72d..a39c2d290902 100644
> > > --- a/drivers/tty/serial/xilinx_uartps.c
> > > +++ b/drivers/tty/serial/xilinx_uartps.c
> > > @@ -1082,11 +1082,7 @@ static void xuartps_console_write(struct console *co, const char *s,
> > >  
> > >  	xuartps_writel(ctrl, XUARTPS_CR_OFFSET);
> > >  
> > > -	/* restore interrupt state, it seems like there may be a h/w bug
> > > -	 * in that the interrupt enable register should not need to be
> > > -	 * written based on the data sheet
> > > -	 */
> > > -	xuartps_writel(~imr, XUARTPS_IDR_OFFSET);
> > > +	/* restore interrupt state */
> > 
> > It would be appropriate for the changelog at least to explain why the
> > note about the data sheet differing is going away !
> 
> I don't know why anybody ever thought things are broken. IMHO, the
> comment does not make any sense. Why would it not be required to write
> the enable register when you enable interrupts?
> I think someone read the data sheet wrong.

The comment reads very much like John Linn added it after trying to debug
a problem in real hardware. As such I think it warrants a bit more
calling out than a silent removal. That way if someone does find there is
a hardware bug (or some software race we don't understand) they will be
able to find the regression easily in the git log.

Alan
