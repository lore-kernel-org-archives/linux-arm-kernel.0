From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jul 2014 13:25:55 +0100
Subject: [PATCH v3 3/8] component: add support for component match array
In-Reply-To: <CAK5sBcFof_QvDouNOUD1SVqPucMQ+wW4u_jxguCqDgO=zD7_Og@mail.gmail.com>
References: <CAK5sBcEupbnzpxskD8D7wXbFRfU+4gh5oDE9X-SvkZEQ2+dQ_w@mail.gmail.com>
 <20140704105258.GF21766@n2100.arm.linux.org.uk>
 <CAK5sBcFof_QvDouNOUD1SVqPucMQ+wW4u_jxguCqDgO=zD7_Og@mail.gmail.com>
Message-ID: <20140704122554.GG21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 05:00:36PM +0530, Sachin Kamat wrote:
> On Fri, Jul 4, 2014 at 4:22 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jul 04, 2014 at 04:17:35PM +0530, Sachin Kamat wrote:
> >> Hi Russell
> >>
> >> > +int component_master_add_with_match(struct device *dev,
> >> > +       const struct component_master_ops *ops,
> >> > +       struct component_match *match)
> >> >  {
> >> >         struct master *master;
> >> >         int ret;
> >> >
> >> > +       if (ops->add_components && match)
> >> > +               return -EINVAL;
> >> > +
> >> > +       /* Reallocate the match array for its true size */
> >> > +       match = component_match_realloc(dev, match, match->num);
> >>
> >>            ^^^^^^^^^^^^^
> >> This gives a NULL pointer dereference error when match is NULL (as passed
> >> by component_master_add() below). Observed this while testing linux-next
> >> kernel (next-20140704) on Exynos based board with DRM enabled.
> >
> > Thanks for your report.  Please verify that the patch below resolves it
> > for you.  Thanks.
> 
> Yes, the below patch fixes the crash. Thanks for the fix.

Thanks.  I'll add a tested-by and reported-by for your address when
committing this patch.  Let me know if you want something different.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
