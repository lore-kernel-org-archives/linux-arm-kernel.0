From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 23 Dec 2015 12:04:57 +0100
Subject: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions"
 node
In-Reply-To: <20151222212350.GF30172@localhost> (Olof Johansson's message of
 "Tue, 22 Dec 2015 13:23:50 -0800")
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <20151222212350.GF30172@localhost>
Message-ID: <87egedfmsm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 
 On mar., d?c. 22 2015, Olof Johansson <olof@lixom.net> wrote:

> Hi,
>
> On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
>> 	Hi,
>> 
>> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
>> subnode of an SPI FLASH device node must have a compatible property. The
>> partitions are no longer detected if it is not present.
>> 
>> However, several DTSes in -next have already been converted to the
>> "partitions" subnode without "compatible" property, introduced by
>> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
>> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
>> partitions in a special 'partitions' subnode"). Hence all of these are
>> now broken in -next, and will be broken in upstream during the merge
>> window.
>
> So, if I understand this correctly, the partitions format was added for v4.4,
> then this non-backwards compatible change was added in -rc6. But, there were
> also DT files that had the new-for-v4.4 partitions nodes in them that then
> stopped working in -rc6?

At least for the mvebu dts, the change was added for v4.5 not
v4.4. Currently it is only in the next branches (and also in your
arm-soc tree in next/dt).

>
> That sounds like a regression, so this should be picked up as fixes
> for v4.4.


It won't be a regression but a breakage of the bissectability between
the patch adding the partition subnode and the one using the compatible
"fixed-partitions".

If you really want avoiding this you could squash the patches, however
from my point of view it's not worth doing it.

>
> Please confirm that I've understood the setup correctly, and I'll apply the
> series directly to fixes.

I think it won't apply on v4.4 because the partition change was not made
at this moment.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
