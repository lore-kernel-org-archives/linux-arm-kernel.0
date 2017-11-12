From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 12 Nov 2017 01:14:12 +0100
Subject: [PATCH V3 2/4] ACPI / bus: introduce acpi_device_get_match_data()
 function
In-Reply-To: <31ef1ea5-ddb6-1a24-980b-7986627cfeca@codeaurora.org>
References: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
 <1510281175-27173-2-git-send-email-okaya@codeaurora.org>
 <31ef1ea5-ddb6-1a24-980b-7986627cfeca@codeaurora.org>
Message-ID: <1605519.pfaIp4IsxJ@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 10, 2017 3:35:41 AM CET Sinan Kaya wrote:
> +linux-acpi at vger.kernel.org, +Rafael

Thanks!

> On 11/9/2017 9:32 PM, Sinan Kaya wrote:
> > OF has of_device_get_match_data() function to extract driver specific data
> > structure. Add a similar function for ACPI.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > ---
> >  drivers/acpi/bus.c   | 12 ++++++++++++
> >  include/linux/acpi.h |  6 ++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 4d0979e..da29c10 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -785,6 +785,18 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_match_device);
> >  
> > +void *acpi_device_get_match_data(const struct device *dev)
> > +{
> > +	const struct acpi_device_id *match;
> > +
> > +	match = acpi_match_device(dev->driver->acpi_match_table, dev);
> > +	if (!match)
> > +		return NULL;
> > +
> > +	return (void *)match->driver_data;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_device_get_match_data);

While I understand that the name follows the OF convention, I have some
doubts on whether it is the best one.

Apart from this the change is fine by me.

Thanks,
Rafael
