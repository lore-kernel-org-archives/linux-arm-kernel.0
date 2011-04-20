From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 20 Apr 2011 17:27:06 +0800
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <20110420083258.GB1517@S2100-06.ap.freescale.net>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
Message-ID: <BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 4:32 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> Hi Eric,
>
> On Mon, Apr 18, 2011 at 01:19:36PM +0800, Eric Miao wrote:
>> If AUTO_ZRELADDR is selected and target is not uImage, the existence
>> of Makefile.boot could be optional.
>>
>> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> ---
>> ?arch/arm/boot/Makefile | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
>> index 9128fdd..277368f 100644
>> --- a/arch/arm/boot/Makefile
>> +++ b/arch/arm/boot/Makefile
>> @@ -14,7 +14,7 @@
>> ?MKIMAGE ? ? ? ? := $(srctree)/scripts/mkuboot.sh
>>
>> ?ifneq ($(MACHINE),)
>> -include $(srctree)/$(MACHINE)/Makefile.boot
>> +-include $(srctree)/$(MACHINE)/Makefile.boot
> ? ^ Makefile grammar?

Yes. GNU make will only include the file if it _exists_.

>> ?endif
>>
> I do not understand the patch. ?But looking at the patch below, the
> dtb rule uses Makefile.boot too.
>

Since originally there are only definitions like zreladdr defined in
Makefile.boot,
and with AUTO_ZRELADDR, some platforms do not need this definition any
more, which makes Makefile.boot useless on these platforms. Yet it does now
look like Makefile.boot is so far the best place for these DTB rules.

> [PATCH v2] arm/dt: Add a make rule to build dtb for enabled boards
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/047129.html
>
> --
> Regards,
> Shawn
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
