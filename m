From: camhirundo@gmail.com (Hirundo Cam)
Date: Wed, 4 May 2011 10:36:04 +0800
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <20110503205056.GA13075@gentoodev.compulab.local>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<20110503205056.GA13075@gentoodev.compulab.local>
Message-ID: <BANLkTimQM_J2ZbDjAewUsp+XSEP+x+eniA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

2011/5/4  <mike@compulab.co.il>:
> Hello Hirundo Cam,
>
> I'm not Kirkwood expert, so my comments are quite general.

That's O.K.. It still helped other thing

> On Thu, Apr 28, 2011 at 12:34:46AM +0800, Hirundo Cam wrote:
>> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
>> LEDs, GPIO, Buttons remains unknown.
>>
>> To use this patch, u-boot must also be modified.
>>
>> Signed-off-by: Hirundo Cam <camhirundo@gmail.com>
>> ---
>> ?arch/arm/mach-kirkwood/Kconfig ? ? ? ? ? ?| ? ?6 ++
>> ?arch/arm/mach-kirkwood/Makefile ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-kirkwood/mv88f6281_dir665.c | ?107 +++++++++++++++++++++++++++++
>> ?arch/arm/tools/mach-types ? ? ? ? ? ? ? ? | ? ?1 +
>> ?4 files changed, 115 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-kirkwood/mv88f6281_dir665.c
>>
>> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
>> index 7fc603b..296d97f 100644
>> --- a/arch/arm/mach-kirkwood/Kconfig
>> +++ b/arch/arm/mach-kirkwood/Kconfig
>> @@ -26,6 +26,12 @@ config MACH_MV88F6281GTW_GE
>> ? ? ? ? Say 'Y' here if you want your kernel to support the
>> ? ? ? ? Marvell 88F6281 GTW GE Board.
>>
>> +config MACH_MV88F6281_DIR665
>> + ? ? bool "Marvell 88F6281 DIR665 Board"
>> + ? ? help
>
> Citing checkpatch.pl:
> "WARNIING: please write a paragraph that describes the config symbol fully"

I've used checkpatch. and get this WARNING too.
But I didn't understand how the paragraph is wrong.
This section just as other sections. Should I add
this line "Say 'Y' here if you want your kernel to support the" into
th paragraph?

> Please check what headers are actually needed. I belieive that
> linux/input.h, linux/leds.h, linux/gpio.h and most probably many others
> can be safely removed.

Shouldn't I keep these stuff for future discovered LED and GPIOs?


> You should add the dir665 machine into the machine registry at
> http://www.arm.linux.org.uk/developer/machines/ rather than modify the
> mach-types file.

Thanks for your information.

Regards,
Hirundo Cam.
