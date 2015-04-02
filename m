From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Thu, 2 Apr 2015 11:45:14 +0200
Subject: [STLinux Kernel] [PATCH 0/4] clk: Provide support for always-on
 clocks
In-Reply-To: <20150402081210.GB3567@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
 <20150402081210.GB3567@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <CAG374jDc6HsJhL4HqTgvnMU3AG9pXNYXyxr6gjZQkTODR-BHyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter, Lee,

With these series as they are, we need  'clk_ignore_unused'  on
sthi407-b2120.dts and stih418-b2199.dts.

We have to modificate stih407-clock.dtsi and stih418-clock.dtsi in same way.

BR
Gabriel

On 2 April 2015 at 10:12, Peter Griffin <peter.griffin@linaro.org> wrote:
> Hi Lee,
>
> On Fri, 27 Feb 2015, Lee Jones wrote:
>
>> Some hardware contains bunches of clocks which must never be
>> turned off.  If drivers a) fail to obtain a reference to any
>> of these or b) give up a previously obtained reference
>> during suspend, the common clk framework will attempt to
>> disable them and a platform can fail irrecoverably as a
>> result.  Usually the only way to recover from these failures
>> is to reboot.
>>
>> To avoid either of these two scenarios from catastrophically
>> disabling an otherwise perfectly healthy running system,
>> clocks can be identified as always-on using this property
>> from inside a clocksource's node.  The CLK_IGNORE_UNUSED
>> flag will be applied to each clock instance named in this
>> property, thus preventing them from being shut down by the
>> framework.
>
> Great stuff.
>
> One minor comment is that assuming this works on stih407 and stih410
> to the extent that the platform can now boot without clk_ignore_unused
> kenel parameter then you should have an additional patch to remove
> clk_ignore_unused from the default bootargs in stih407-b2120.dts and
> stih410-b2120.dts files.
>
> Maxime - Is it possible for you to test this series on stih418-b2199 as
> a well? As it could most likely also be removed from stih418-b2199.dts file
> to, but neither Lee or myself have the hardware to test.
>
> Apart from that, for the series: -
>  Acked-by: Peter Griffin <peter.griffin@linaro.org>
>
> regards,
>
> Peter.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
