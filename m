From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Mon, 27 Nov 2017 11:28:03 -0200
Subject: [PATCH v2] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
In-Reply-To: <20171127101739.qs6ws3232hd5qwgv@t450s.lan>
References: <20171124170004.31133-1-otavio@ossystems.com.br>
 <CAP9ODKoefNEcQtrCCLEa7hzx2D_2vJTit0t8ooQGTx7Uyds1mQ@mail.gmail.com>
 <20171127101739.qs6ws3232hd5qwgv@t450s.lan>
Message-ID: <CAP9ODKr-5Q3TgZQHFPNHQcjNfm9NZM0a-C8f-MuFQtRCj1FiAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 8:17 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> Hi Otavio,
>
> On Sat, Nov 25, 2017 at 07:55:53AM -0200, Otavio Salvador wrote:
>> On Fri, Nov 24, 2017 at 3:00 PM, Otavio Salvador
>> <otavio@ossystems.com.br> wrote:
>> > This adds the partitions definition for the SPI NOR to provide
>> > backward compatibility with the documented[1] layout used with
>> > Boundary Devices BSP.
>> >
>> > 1. https://boundarydevices.com/boot-flash-access-linux/
>> >
>> > It exports to Linux:
>> >
>> >  mtd0: bootloader
>> >  mtd1: env
>> >  mtd2: splash
>> >
>> > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
>>
>> After thinking a bit about Fabio's recommendation to use 'read-only'
>> to protect the partitions, I think it'd be better to use 'lock' so it
>> is still possible to write them on Linux but it requires a unlock
>> prior changing it.
>>
>> In my case, I am interested in being capable of upgrading the
>> bootloader from Linux.
>>
>> What people think?
>
> Agreed, I would rather have the lock option, especially for the splash
> and environment.

I will prepare a new patch using the lock option on the three
partitions so we allow the user to change them but knowing it may
break the system.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
