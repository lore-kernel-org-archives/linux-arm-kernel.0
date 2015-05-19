From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 19 May 2015 11:08:15 +0800
Subject: [RFC 4/7] ARM: dts: sun9i: Add PRCM device node for the A80 dtsi
In-Reply-To: <20150517145426.GL4004@lukather>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431583811-25780-5-git-send-email-wens@csie.org>
 <20150517145426.GL4004@lukather>
Message-ID: <CAGb2v64-H_eBm87R3RB659_6Dn+3UmbSjfp3M7+uKMCcvqs-mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 17, 2015 at 10:54 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, May 14, 2015 at 02:10:08PM +0800, Chen-Yu Tsai wrote:
>> The PRCM is a collection of clock controls, reset controls, and various
>> power switches/gates. Some of these can be independently listed and
>> supported, while a number of CPU related ones are used in tandem with
>> CPUCFG for SMP bringup and CPU hotplugging.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun9i-a80.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
>> index c45735398f6a..1507bd2a88f0 100644
>> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
>> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
>> @@ -797,6 +797,11 @@
>>                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>               };
>>
>> +             prcm at 01700000 {
>> +                     compatible = "allwinner,sun9i-a80-prcm";
>> +                     reg = <0x08001400 0x200>;
>> +             };
>> +
>
> The unit address doesn't match the content of the reg property.

Obvious copy-paste error (facepalm)

ChenYu
