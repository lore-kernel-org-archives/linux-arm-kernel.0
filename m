From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 14:02:45 +0100
Subject: [PATCH 09/18] dmaengine/amba-pl08x: Schedule tasklet in case
	of error interrupt
In-Reply-To: <1311941799.1536.532.camel@vkoul-udesk3>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
	<1311941799.1536.532.camel@vkoul-udesk3>
Message-ID: <20110729130245.GM25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 05:46:39PM +0530, Koul, Vinod wrote:
> On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
> > +	/* check & clear - ERR & TC interrupts */
> > +	err = readl(pl08x->base + PL080_ERR_STATUS);
> > +	if (err) {
> > +		dev_err(&pl08x->adev->dev, "%s error interrupt, register value"
> > +				"0x%08x\n", __func__, err);
> again this looks convoluted, and the stuff is quotes can be in single
> line :)

And it shows the danger of wrapping quoted strings.  This will print
the following message:

...: pl08x_irq error interrupt, register value0xNNNNNNNN

So it may want a space between 'value' and '0x%08x' - and it may want a
':' after '%s' too.
