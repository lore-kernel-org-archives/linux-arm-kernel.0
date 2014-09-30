From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 30 Sep 2014 10:02:25 +0200
Subject: [PATCH v2 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
In-Reply-To: <1412043352.9388.86.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043352.9388.86.camel@decadent.org.uk>
Message-ID: <CACna6ry3=+1GLRCvd_xOGBHjQmEGdYT-eM4YFfzO2Fkw9BHSTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2014 04:15, Ben Hutchings <ben@decadent.org.uk> wrote:
> Move the list of chip type information to a macro in spi-nor.h, but
> leave the definitions of INFO and CAT25_INFO in spi-nor.
>
> In m25p80, define the INFO and CAT25_INFO macros to initialise a
> struct spi_device_id with the name, ignoring the remaining parameters.

Anyone would consider my idea proposed in 1/5 thread?

We could simply follow the way Linux-specific platform data works. We
could always use
compatible = "m25p80";
and then for some rare cases (where JEDEC fails) add something like
model = "at25df321a";

Using above way we could use a one single "compatible" in m25p80.c and
avoid this messy share of id_table.
