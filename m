From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 15 Dec 2014 19:05:18 +0100
Subject: [PATCHv0 5/5] dt-bindings: fix isl vs isil prefix issue for
 Intersil
In-Reply-To: <20141215135545.GC967@titan.lakedaemon.net> (Jason Cooper's
 message of "Mon, 15 Dec 2014 08:55:45 -0500")
References: <cover.1418519430.git.arno@natisbad.org>
 <b2c34bea6fc7bd42d636c9cadfe1b7e5ec523aeb.1418519430.git.arno@natisbad.org>
 <20141215135545.GC967@titan.lakedaemon.net>
Message-ID: <87388gkcv5.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Cooper <jason@lakedaemon.net> writes:

>> AFAICT, it seems it makes sense to *definitively* settle for isil as the
>> vendor prefix for Intersil, as Philip did in 7a6540ca856a: it's the NASDAQ
>> symbol and this choice requires less changes than opting for isl.
>> 
>> So, this patch changes compatible strings in .dts files to use isil where
>> isl was found before, and modify drivers w/ compatible strings using isl
>> to add one using isil. In those cases, a comment is made that the old
>> compatible string is kept for backward compatibility (w/ out-fo-tree users
>> of those drivers). Additionally, it leaves only isil as prefix in
>> vendor-prefixes.txt. Those changes should prevent any new inclusion of
>> isl compatible strings for Intersil devices due to copy-and-paste.
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++---
>>  Documentation/devicetree/bindings/regulator/isl9305.txt   | 4 ++--
>>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 3 +--
>
>>  arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
>>  arch/arm/boot/dts/zynq-parallella.dts                     | 2 +-
>
>>  drivers/regulator/isl9305.c                               | 6 ++++--
>>  drivers/rtc/rtc-isl12022.c                                | 3 ++-
>>  drivers/rtc/rtc-isl12057.c                                | 3 ++-
>>  drivers/staging/iio/light/isl29028.c                      | 4 ++--
>>  9 files changed, 17 insertions(+), 15 deletions(-)
>
> Please split the dts{i} changes out into a separate patch.  The
> different maintainers under drivers/ may want separate patches as well.

I will prepare that, and then let get_maintainer.pl decide who should
be added to the CC: list. But before doing that work, I would like to
at least get some feedback that there will not be a big NAK on the
whole approach in the end.

Cheers,

a+
