From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 30 Apr 2014 09:39:54 +0530
Subject: [PATCH Resend] ARM: EXYNOS: Map SYSRAM address through DT
In-Reply-To: <1493367.CDjMd4ghZP@phil>
References: <1397649051-3288-1-git-send-email-sachin.kamat@linaro.org>
 <5721231.s2ATyWsK21@wuerfel> <1493367.CDjMd4ghZP@phil>
Message-ID: <CAK9yfHxBh3x7coj1FtLOrYvRv9viN_1tS3irL5+inarwuHZWYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 16 April 2014 22:55, Heiko St?bner <heiko@sntech.de> wrote:
> Hi,
>
> Am Mittwoch, 16. April 2014, 16:35:36 schrieb Arnd Bergmann:
>> On Wednesday 16 April 2014 17:20:51 Sachin Kamat wrote:
>> > Instead of hardcoding the SYSRAM details for each SoC,
>> > pass this information through device tree (DT) and make
>> > the code SoC agnostic.
>> >
>> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> > ---
>> > Rebased on latest linux-next.
>>
>> Thanks for sending this again. I'd like Heiko to have a look
>> and provide an Ack if he's happy with it.
>>
>> It seems similar to what he did with the SRAM for mach-rockchip,
>> and if it is we should use the same binding that he introduced,
>> which would be a minor variation of this.
>
> The sram binding is derived from the generic reserved-memory bindings to
> enable the sram in general to be used generically through the sram driver,
> while still retaining some areas for special purposes, like the smp-trampoline
> in my case.
>
> From my reading of platsmp.c, it looks like offset+0x4 starts the so called
> boot-registesr, which get the smp-start-address written to.
>
> So I guess it all depends on what is contained in the rest of the sysram. If
> it is all covered with such special registers or other special uses, the code
> below is fine. But if the most of the area is just general purpose sram, a
> solution like on rockchip might be nicer - i.e. handling the sysram via the
> sram driver and declaring a reserved section for the boot registers.

Thanks for your inputs. In our case, we use sram for secondary boot
addresses but could not find any other general purpose use.

> So, depending on the above:
> Acked-by: Heiko Stuebner <heiko@sntech.de>

So I believe your ack applies to our case :). Thanks again.

-- 
With warm regards,
Sachin
