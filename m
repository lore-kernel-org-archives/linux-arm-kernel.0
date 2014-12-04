From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 10:12:24 +0100
Subject: [PATCH v4 1/2] soc: samsung: add exynos chipid driver support
In-Reply-To: <547FEA74.1010900@samsung.com>
References: <1417594658-2931-1-git-send-email-pankaj.dubey@samsung.com>
 <19026872.NZqUJn3Abb@wuerfel> <547FEA74.1010900@samsung.com>
Message-ID: <4074205.TGQpWxTihh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 10:30:36 Pankaj Dubey wrote:
> >
> > On Wednesday 03 December 2014 13:47:37 Pankaj Dubey wrote:
> >
> >> +       soc_dev_attr->soc_id = exynos_product_id_to_name(soc_product_id);
> >> +
> >> +       soc_dev = soc_device_register(soc_dev_attr);
> >> +       if (IS_ERR(soc_dev))
> >> +               goto free_rev;
> >> +
> >> +       device_create_file(soc_device_to_device(soc_dev), &exynos_product_attr);
> >> +       device_create_file(soc_device_to_device(soc_dev),
> >> +                               &exynos_main_rev_attr);
> >> +       device_create_file(soc_device_to_device(soc_dev), &exynos_sub_rev_attr);
> >> +
> >
> > I don't like the idea of having three extra nonstandard properties here,
> > especially when you are not using the machine field for anything useful.
> >
> 
> I did not get you here. Any suggestions how we can use 'machine' field 
> more useful way.

For instance you could pass the exynos_product_id_to_name() result to
the machine field instead of the soc_id field, and use the soc_id
for a more fine-grained distinction.

> > Also, all three of these just come from the same register, why expose
> > them all as the machine and revision standard properties.
> >
> 
> Agreed. These properties are basically giving same information but with 
> small modification.
> As you said these are getting exposed via standard properties as well, 
> so I have no issue to drop them. Just waiting for more review from 
> Samsung folks, will take care of this in next version.

Ok.

	Arnd
