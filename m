From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 26 Aug 2011 17:16:33 +0100
Subject: [PATCH v3 11/13] of: add property iteration helpers
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A40C8@HQMAIL01.nvidia.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
	<1314315824-9687-12-git-send-email-swarren@nvidia.com>
	<20110826092632.GB3926@pulham.picochip.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A40C8@HQMAIL01.nvidia.com>
Message-ID: <20110826161633.GB2802@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 08:59:44AM -0700, Stephen Warren wrote:
> Jamie Iles wrote at Friday, August 26, 2011 3:27 AM:
> > For the !CONFIG_OF case, I *think* that
> > of_iter_u32_prop and of_iter_string_prop can be empty struct's, but I
> > wouldn't want to bet money on that!
> 
> Empty structs themselves certainly did compile OK, but the code that
> uses these macros references iter.value directly, and isn't under #ifdef
> CONFIG_OF, so that field has to exist.
> 
> I suppose an alternative would be to add an accessor function:
> 
> struct of_iter_string_prop iter;
> for_each_string_property_value(iter, np, "pins")
>         printk("Got value %s\n", of_iter_string_value(iter));
> 
> which would return NULL/"" when !CONFIG_OF, and hence allow iter.value
> to be removed too. Do you think that's a good approach? It'd be easy to
> implement.

I think I prefer what you have now rather than a separate accessor, but 
I'm happy either way!

Jamie
