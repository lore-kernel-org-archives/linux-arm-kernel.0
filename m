From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Sep 2013 09:39:21 +0100
Subject: [patch] iio: mxs-lradc: use helper functions to simplify the code
In-Reply-To: <CAOMZO5BmeG3X+cyNcwg0B7hsaqTY5hxjfNiWbxMivinhcZZp7g@mail.gmail.com>
References: <201309051216.18305.jbe@pengutronix.de>
 <20130905181639.GA19090@elgon.mountain>
 <CAOMZO5BmeG3X+cyNcwg0B7hsaqTY5hxjfNiWbxMivinhcZZp7g@mail.gmail.com>
Message-ID: <20130906083920.GO6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 05:15:02PM -0300, Fabio Estevam wrote:
> Looks good, just one minor suggestion:
> 
> On Thu, Sep 5, 2013 at 3:16 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > +static void lradc_reg_set(struct mxs_lradc *lradc, u32 val, size_t chan)
> > +{
> > +       writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
> > +}
> > +
> > +static void lradc_reg_clear(struct mxs_lradc *lradc, u32 val, size_t chan)
> > +{
> > +       writel(val, lradc->base + chan + STMP_OFFSET_REG_CLR);
> > +}
> 
> Maybe 'static inline' ?

GCC will already inline these if it thinks they're appropriate for that
treatment.
