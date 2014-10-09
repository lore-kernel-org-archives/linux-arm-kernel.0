From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 9 Oct 2014 10:46:59 +0200
Subject: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa
 board
In-Reply-To: <1819182.VPTrtc9d2P@wuerfel>
References: <2750153.I3nVqzmXTP@amdc1032> <1998495.eXa2FjeVGo@wuerfel>
 <CAD=FV=VB_eK9pSmmTBRHoQmkORweHzT-OFaMWA6haFYnQuQaUQ@mail.gmail.com>
 <1819182.VPTrtc9d2P@wuerfel>
Message-ID: <CAPDyKFoPBep287uAVDQWSXdFz-aoV4VmV7xgP_PEZ-c1q9Oz0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2014 20:28, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 08 October 2014 08:29:16 Doug Anderson wrote:
>>
>> On Wed, Oct 8, 2014 at 8:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Why does it cause a regression though? Does this mean you are breaking
>> > any boot with an old DT file and a new kernel? That would be very
>> > bad, the driver is supposed to keep working with an existing dtb.
>>
>> The old dts file specified completely the wrong regulator.  It
>> happened that the old code didn't really care, but when the code was
>> fixed to care then things broke.  If we need to keep old dts files
>> working then the most sensible place to do it would be in a "fixup old
>> broken device trees" stage somewhere in kernel boot.
>
> Ok, got it. I guess it's better to apply this one first then.
>
>         Arnd

Thanks for your comments Arnd! I have applied this once to my mmc tree
now. Please tell me soon if you want to carry this through arm-soc
instead, thus I can drop it.

Kind regards
Uffe
