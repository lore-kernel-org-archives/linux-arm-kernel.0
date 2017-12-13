From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 13 Dec 2017 16:36:38 +0200
Subject: [PATCH 4/4] [v4] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <88349f2e-5243-8061-cc72-d01fa70e6f2e@codeaurora.org>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
 <1512170904-4749-5-git-send-email-timur@codeaurora.org>
 <CACRpkdYer_Q5R4XhWTX3=jwshcKZRSDY9=gOvSeUPsQHbUw6vw@mail.gmail.com>
 <1513076836.25007.641.camel@linux.intel.com>
 <88349f2e-5243-8061-cc72-d01fa70e6f2e@codeaurora.org>
Message-ID: <1513175798.7000.15.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-12 at 14:27 -0600, Timur Tabi wrote:
> On 12/12/2017 05:07 AM, Andy Shevchenko wrote:
> 
> > Not ACPI standards as of my knowledge. ACPI standard defines a
> > common
> > scheme how to define properties, it doesn't tell anything about
> > property
> > names or any mappings between names to values or names to "OS
> > subsystem").
> 
> There was an attempt a while back to standardize this like we do for 
> device tree, but it fell apart.  Device-specific ACPI-only properties 
> are not standarized.  This driver is initialized only on ACPI
> systems. 
> It has no device tree binding.

It should follow DT *de facto* standard bindings like "ngpios" (though
it's not needed in ACPI case IIRC) and other properties.

> > As for GPIO we just follow *de facto* what DT has right now, i.e.
> > "xxx-
> > gpio" or "xxx-gpios" pattern is used to map ACPI standard resource
> > to a
> > GPIO name. That's how GPIO ACPI lib is being developed.
> 
> GPIOs in device tree are defined completely differently than in ACPI. 
> On DT, the kernel controls the pin muxing.  On ACPI, pins are muxed
> by 
> firmware and never re-muxed by the operating system.  So all this
> driver 
> does is expose a few pins as simple GPIOs.

Wait, runtime muxing is a matter of requesting another function (usually
GPIO) and putting it back afterwards. Do you really need anything like
this at *runtime*?

Pin control design is not compatible with hardware (too abstract), but
that is the problem of DT as well: I'm referring here to not carefully
designed so called "pin states". This is another story and has nothing
specific for ACPI.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
