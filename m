From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jan 2014 11:50:21 +0000
Subject: [PATCH v2 4/7] mfd: ssbi: Add regmap read/write helpers
In-Reply-To: <20131226194133.GJ31766@codeaurora.org>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-5-git-send-email-sboyd@codeaurora.org>
 <20131224125443.GC30815@sirena.org.uk>
 <20131226194133.GJ31766@codeaurora.org>
Message-ID: <20140106115021.GC30156@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Dec 2013, Stephen Boyd wrote:

> On 12/24, Mark Brown wrote:
> > On Mon, Dec 23, 2013 at 12:46:00PM -0800, Stephen Boyd wrote:
> > 
> > > +int ssbi_reg_read(void *context, unsigned int reg, unsigned int *val)
> > > +{
> > > +	*val = 0;
> > > +	return ssbi_read(context, reg, (u8 *)val, 1);
> > > +}
> > > +EXPORT_SYMBOL_GPL(ssbi_reg_read);
> > > +
> > > +int ssbi_reg_write(void *context, unsigned int reg, unsigned int val)
> > > +{
> > > +	return ssbi_write(context, reg, (u8 *)&val, 1);
> > > +}
> > > +EXPORT_SYMBOL_GPL(ssbi_reg_write);
> > 
> > Not a big deal but could these just be inlined in the headers?
> 
> Sure, I can do that if I need to resend? The only benefit I see
> is two less symbols exported.

Yes please. After this review.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
