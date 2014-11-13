From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 13 Nov 2014 12:20:02 -0800 (PST)
Subject: [PATCH v11 2/3] power-domain: rockchip: add power doamin driver
In-Reply-To: <CAGS+omCxtvk7VNr7_tJkDCwZpbW-ocFm2VL4ngujxbS5remmVA@mail.gmail.com>
References: <1415829690-20236-1-git-send-email-caesar.wang@rock-chips.com>
 <1415829690-20236-3-git-send-email-caesar.wang@rock-chips.com>
 <CAGS+omCxtvk7VNr7_tJkDCwZpbW-ocFm2VL4ngujxbS5remmVA@mail.gmail.com>
Message-ID: <2914846.96jvVdAmYN@dtor-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 14, 2014 03:35:44 AM Daniel Kurtz wrote:
> On Thu, Nov 13, 2014 at 6:01 AM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> > +
> > +       error = -ENXIO;
> > +
> > +       for_each_available_child_of_node(np, node) {
> > +               error = rockchip_pm_add_one_domain(pmu, node);
> > +               if (error) {
> > +                       dev_err(dev, "failed to handle node %s: %d\n",
> > +                               node->name, error);
> > +                       goto err_out;
> > +               }
> > +       }
> > +
> > +       if (error) {
> > +               dev_dbg(dev, "no power domains defined\n");
> 
> Perhaps dev_err() or dev_warn(), to ensure this message is seen.
> But, not have defined power domains doesn't seem like a fatal error.
> Perhaps just return 0?

As far as the driver concerned it is a fatal error - the driver can't do
anything when no domain is defined.

Thanks.

-- 
Dmitry
