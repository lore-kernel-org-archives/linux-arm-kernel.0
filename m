From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 3 Jul 2011 23:38:28 -0600
Subject: [PATCH 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
In-Reply-To: <20110704021923.GA10245@S2100-06.ap.freescale.net>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
	<1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
	<20110703211007.GB13742@ponder.secretlab.ca>
	<20110704021923.GA10245@S2100-06.ap.freescale.net>
Message-ID: <20110704053828.GB15152@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 10:19:25AM +0800, Shawn Guo wrote:
> > > @@ -689,7 +728,7 @@ static int imx_startup(struct uart_port *port)
> > >  		}
> > >  	}
> > >  
> > > -	if (!cpu_is_mx1()) {
> > > +	if (IS_IMX2_UART()) {
> > 
> > The logic is getting reversed here, is this really what you want to
> > do?  I would think you'd want to preserve the !IS_IMX1_UART() logic.
> > 
> Maybe not.  I actually made a small improvement here.  The body of
> the 'if' is really IMX2 specific code, so it makes more sense to use
> IS_IMX2_UART() than !IS_IMX1_UART().

Okay, it would probably be worth mentioning this change in the commit text.
