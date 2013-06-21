From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 21 Jun 2013 18:09:22 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVNQLSg_hQ_h7S8uCTjTuKV6Q5gPSYFP0SLXiqdHOKGfsw@mail.gmail.com>
References: <CACVXFVPPF=DNp0dpypoZ=OifkfnCgWJKpQHMv4xE8PmBk8RiHQ@mail.gmail.com>
 <4558223.ViRy5S2mR9@linux-5eaq.site>
 <CACVXFVNNR-ZYsJpQXu0tUpCtEk-hhw0M8nmYMB4GcSkKyLopqw@mail.gmail.com>
 <4846131.y6OZcfhzIJ@linux-5eaq.site>
 <CACVXFVNQLSg_hQ_h7S8uCTjTuKV6Q5gPSYFP0SLXiqdHOKGfsw@mail.gmail.com>
Message-ID: <CACVXFVOBwzLzp+VEdFE1swY7qN1eOKaF5DWr=uDakrSzWZMnXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 5:43 PM, Ming Lei <ming.lei@canonical.com> wrote:
> On Fri, Jun 21, 2013 at 5:20 PM, Oliver Neukum <oneukum@suse.de> wrote:
>
> Drivers may let usbcore to do that by not setting driver->soft_unbind.
>
> I will fix the problem in v2, one solution I thought of is to flush
> the endpoint's URBs which have been added to tasklet list
> at the end of usb_hcd_flush_endpoint(). Any comments?

Or we can wait for completion of all URBs in the endpoint at the end
of usb_hcd_flush_endpoint(), I think this approach should be easier.

Thanks,
--
Ming Lei
