From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Tue, 28 Nov 2017 15:37:02 -0200
Subject: [PATCH v3] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
In-Reply-To: <CAOMZO5Dtf6mjWt1wg_5NDUNAe4XZ3jvxu0KC2CaUo0wE7gjaRQ@mail.gmail.com>
References: <20171127133127.16985-1-otavio@ossystems.com.br>
 <CAOMZO5Dtf6mjWt1wg_5NDUNAe4XZ3jvxu0KC2CaUo0wE7gjaRQ@mail.gmail.com>
Message-ID: <CAP9ODKrG=hsGSs=rfXumnLJwNeRe+njMOsK5Q=bYDm+gXnXUeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Mon, Nov 27, 2017 at 2:17 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Nov 27, 2017 at 11:31 AM, Otavio Salvador
> <otavio@ossystems.com.br> wrote:
>> This adds the partitions definition for the SPI NOR to provide
>> backward compatibility with the documented[1] layout used with
>> Boundary Devices BSP.
>>
>> 1. https://boundarydevices.com/boot-flash-access-linux/
>>
>> It exports to Linux:
>>
>>  mtd0: bootloader
>>  mtd1: env
>>  mtd2: splash
>>
>> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
>
> Has this been tested? I mean, have you tested the locking mechanism is
> really working in this SPI NOR flash?

Yes, we tested it here using Linux 4.14 but didn't notice this SPI NOR
does not support the lock.

> As far as I can see the SPI locking mechanism does not need device
> tree properties.

Humm it is confusing, at least for me that am not used to the this. In
any case, I think for now it is better to include the partitions
without read-only and lock as it is convenient to have access to it
from Linux so we adhere the same partition layout used in Boundary's
Linux fork.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
