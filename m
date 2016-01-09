From: hzpeterchen@gmail.com (Peter Chen)
Date: Sat, 9 Jan 2016 16:57:56 +0800
Subject: [RFC PATCH 2/2] usb: Example for how to use device node at usb
 device driver
In-Reply-To: <4231421.FQCAATyWeB@wuerfel>
References: <1452231864-11171-1-git-send-email-peter.chen@freescale.com>
 <1452231864-11171-3-git-send-email-peter.chen@freescale.com>
 <4231421.FQCAATyWeB@wuerfel>
Message-ID: <20160109085756.GC27759@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 09:26:10AM +0100, Arnd Bergmann wrote:
> On Friday 08 January 2016 13:44:24 Peter Chen wrote:
> > +	  u32 duration_us = 0;
> 
> > +       of_property_read_u32(hdev->dev.of_node, "delay-duration-us", &duration_us);
> > +       if (duration_us > 0) {
> > +               usleep_range(duration_us, duration_us + 10);
> > +               dev_info(&hdev->dev, "The delay is %d us\n", duration_us);
> > +       }
> > +
> 
> I think especially for an example, it would be better to use error checking and
> not initialize the variable:
> 
> 	u32 duration_us;
> 	int ret;
> ...
> 	ret = of_property_read_u32(hdev->dev.of_node, "delay-duration-us", &duration_us);
> 	if (!ret && duration_us > 0) {
> 		...
> 	}
> 
> The effect is the same as the other one.
> 

Thanks, will change.

-- 

Best Regards,
Peter Chen
