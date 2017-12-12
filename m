From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 12 Dec 2017 13:07:16 +0200
Subject: [PATCH 4/4] [v4] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <CACRpkdYer_Q5R4XhWTX3=jwshcKZRSDY9=gOvSeUPsQHbUw6vw@mail.gmail.com>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
 <1512170904-4749-5-git-send-email-timur@codeaurora.org>
 <CACRpkdYer_Q5R4XhWTX3=jwshcKZRSDY9=gOvSeUPsQHbUw6vw@mail.gmail.com>
Message-ID: <1513076836.25007.641.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-12 at 11:42 +0100, Linus Walleij wrote:
> On Sat, Dec 2, 2017 at 12:28 AM, Timur Tabi <timur@codeaurora.org>
> wrote:

> > +               /* The number of GPIOs in the approved list */
> > +               ret = device_property_read_u16_array(&pdev->dev,
> > "gpios",
> > +                                                    NULL, 0);
> > +               if (ret < 0) {
> > +                       dev_err(&pdev->dev, "missing 'gpios'
> > property\n");
> > +                       return ret;
> > +               }
> 
> This is in direct conflict with the existing "gpios" binding in device
> tree.
> 
> Where is this name coming from? ACPI standards?

Not ACPI standards as of my knowledge. ACPI standard defines a common
scheme how to define properties, it doesn't tell anything about property
names or any mappings between names to values or names to "OS
subsystem").

As for GPIO we just follow *de facto* what DT has right now, i.e. "xxx-
gpio" or "xxx-gpios" pattern is used to map ACPI standard resource to a
GPIO name. That's how GPIO ACPI lib is being developed.

> If device tree and ACPI start defining things which are in direct
> conflict
> we can just shut down this device_property() business altogether,
> it will never work that way.

This is fully understandable. Also it works in other direction, i.e. if
DT will break the established thing it will break also ACPI and built-in 
device properties.

We are keeping an eye on this not to happen as much as we can in any
direction.

So, summarize above, I don't see any impediments (except maybe very
broken ARM64 firmware that is already on devices on market) to make it
properly from the beginning.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
