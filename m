From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 09 Oct 2018 18:43:41 +0200
Subject: [PATCH 3/5] spi: pxa2xx: use an enum for type
In-Reply-To: <87d0t64mkk.fsf@belgarion.home>
References: <20180910115935.163121-1-lkundrak@v3.sk>
 <20180910115935.163121-4-lkundrak@v3.sk> <87d0t64mkk.fsf@belgarion.home>
Message-ID: <04b4e7779325de995371685f094f3762c30793a8.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-09-21 at 22:34 +0200, Robert Jarzmik wrote:
> Lubomir Rintel <lkundrak@v3.sk> writes:
> 
> > That seems to be the correct type.
> Okay, but what happens here when adev_id->driver_data is a value out
> of enum
> range ? Does the following assignment make sense ?
> > +		type = (enum pxa_ssp_type)adev_id->driver_data;

No change in behavior. In standard C the enum type is compatible with
an integer type (char or larger), thus type would just hold a value
outside the rank of an enum.

But why would that happen? What we can get here is just the constants
from pxa2xx_spi_acpi_match[], all of them of enum pxa_ssp_type type.

> As a side note, could you join for the next throw to the review :
>  - Jarkko Nikula <jarkko.nikula@linux.intel.com>
>  - Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Even if they are Intel, I think they have worked a lot on this driver
> for Intel
> platforms.

Will do.

> Cheers.

Thanks,
Lubo
