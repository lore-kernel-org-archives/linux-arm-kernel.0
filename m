From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Jun 2017 12:35:49 +0200
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
In-Reply-To: <20170627091006.GN4902@n2100.armlinux.org.uk>
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623152227.GA21989@leverpostej>
 <DB6PR04MB2999E8FFBE0FE708A003637986D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
 <CAK8P3a0mhWTRriGYB6aHS28dm842d-0OeGRmRYzMS4ZYY9=YCQ@mail.gmail.com>
 <20170627081717.GM4902@n2100.armlinux.org.uk>
 <CAK8P3a0N5tiP7RPMg=Q8fsROuYabJjQ5Awd2ekrn686nDqdNwA@mail.gmail.com>
 <20170627091006.GN4902@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a0EXGfkijeQG6OKGHeS8LZsO4YFmRhN9WXTei51rj6G1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 11:10 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Jun 27, 2017 at 11:05:38AM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 27, 2017 at 10:17 AM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>>
>> I wonder if doing memcpy_toio on the write-combining mapping
>> will do what Roy wants and and up sending a single bus transaction
>> for one descriptor most of the time, while fitting in with the ioremap_wc()
>> interface and its __iomem pointers.
>
> Either the CE region needs __iomem pointers and proper accessors, or
> it needs to be using memremap(offset, size, MEMREMAP_WC) and not use
> the iomem accessors.

Right, memremap() would work here as well. If there are no other constraints,
using ioremap_wc and __iomem pointers would have the advantage of giving
us a little more type safety, but it depends on what operations we actually
need to do on the data.

        Arnd
