From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Wed, 9 Dec 2009 03:42:43 -0800
Subject: GPIO support for HTC Dream
In-Reply-To: <20091209113739.GC22752@elf.ucw.cz>
References: <20091208102842.GH12264@elf.ucw.cz>
	<20091208224550.GA26915@n2100.arm.linux.org.uk>
	<d6200be20912081639mdd853bg4080f415116d018c@mail.gmail.com>
	<20091209113739.GC22752@elf.ucw.cz>
Message-ID: <d6200be20912090342n15f69a7cy1579cb47caca535b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2009 at 3:37 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2009-12-08 16:39:09, Arve Hj?nnev?g wrote:
>> On Tue, Dec 8, 2009 at 2:45 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Dec 08, 2009 at 11:28:43AM +0100, Pavel Machek wrote:
>> >> Add GPIO support for HTC Dream.
>> >>
>> >> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>> >>
>> >> diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
>> >> index f780086..774c50e 100644
>> >> --- a/arch/arm/mach-msm/Kconfig
>> >> +++ b/arch/arm/mach-msm/Kconfig
>> >> @@ -40,4 +40,8 @@ config MACH_TROUT
>> >> ? ? ? help
>> >> ? ? ? ? Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
>> >>
>> >> +config GENERIC_GPIO
>> >> + ? ? bool
>> >> + ? ? default y
>> >
>> > Please arrange for this to be handled just like every other ARM
>> > platform via a 'select' statement - eg:
>> >
>> > config ARCH_AT91
>> > ? ? ? ?bool "Atmel AT91"
>> > ? ? ? ?select GENERIC_GPIO
>> > ? ? ? ?select ARCH_REQUIRE_GPIOLIB
>> > ? ? ? ?select HAVE_CLK
>> >
>> > It is not nice to have multiple definitions of the same symbol scattered
>> > throughout the Kconfig files.
>> >
>>
>> Why did this code get pulled into the dream gpio code? The original
>> change that adds msm gpio support already selects GENERIC_GPIO
>> (http://android.git.kernel.org/?p=kernel/msm.git;a=commit;h=5ae9f4403530a5782478c35d29753081750c4188).
>> Since you copied half of the files from that change anyway, it would
>> be better to just include that change in you patch set.
>
> I'm not sure how to do that with git without pulling all the changes
> before that one, too :-(.

git cherry-pick

-- 
Arve Hj?nnev?g
