From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Mar 2011 08:54:43 +0000
Subject: [PATCH 2/8] macb: detect hclk presence from platform data
In-Reply-To: <20110311014400.GJ9351@game.jcrosoft.org>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-3-git-send-email-jamie@jamieiles.com>
	<20110311014400.GJ9351@game.jcrosoft.org>
Message-ID: <20110311085443.GJ6198@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 02:44:00AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:10 Thu 10 Mar     , Jamie Iles wrote:
> > +#ifdef CONFIG_ARCH_AT91
> > +#define PCLK_NAME	"macb_clk"
> > +#else /* CONFIG_ARCH_AT91 */
> > +#define PCLK_NAME	"pclk"
> > +#endif
> 
> we need change the clock name and avoid the ifdef
> so this will be generic
> 
> nb I work on the switch to clkdev currently for avr32 and at91

This should be gone now.  Russell made the suggestion to have a fake clk 
for hclk on AT91 so I think I've solved that now.  There's an updated 
patch in my reply to Russell's message but essentially I'm using 
at91_clock_associate() to turn "macb_pclk" into "hclk" and "pclk".  Does 
this seem reasonable?

Jamie
