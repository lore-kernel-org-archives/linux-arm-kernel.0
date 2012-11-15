From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Nov 2012 09:04:53 +0100
Subject: [PATCH 1/3] OF: Add helper for matching against linux, stdout-path
In-Reply-To: <CACxGe6uW+XN6RDnP+8QFXaCYqqPZO4dZM_aynR6AVMYZT=KuMg@mail.gmail.com>
References: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
 <1351849734-9836-2-git-send-email-s.hauer@pengutronix.de>
 <CACxGe6uW+XN6RDnP+8QFXaCYqqPZO4dZM_aynR6AVMYZT=KuMg@mail.gmail.com>
Message-ID: <20121115080453.GW10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 08:49:54PM +0000, Grant Likely wrote:
> > +int of_device_is_stdout_path(struct device_node *dn)
> > +{
> > +       const char *name;
> > +
> > +       name = of_get_property(of_chosen, "linux,stdout-path", NULL);
> > +       if (name == NULL)
> > +               return 0;
> > +
> > +       if (dn == of_find_node_by_path(name))
> 
> need to of_node_put() the return value of of_find_node_by_path()
> 
> > +               return 1;
> > +
> > +       return 0;
> > +}
> 
> Hi Sascha,
> 
> I'm fine with the helper, but there really is no need for a completely
> separate .c file. Just put it in drivers/of/base.c.

Agreed.

Thanks,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
