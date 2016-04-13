From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 13 Apr 2016 14:20:37 +0100
Subject: [PATCH] arm64/sunxi: 4.6-rc1: Add dependency on generic irq chip
In-Reply-To: <CAL_Jsq+_2byE=Bd7cs_ULCnsWobKW3QQ+6XE8LVEqmu=R-ur8A@mail.gmail.com>
References: <1459245786-11905-1-git-send-email-suzuki.poulose@arm.com>
 <20160412191149.GC4174@localhost> <570E0BE4.2080007@arm.com>
 <CAL_Jsq+_2byE=Bd7cs_ULCnsWobKW3QQ+6XE8LVEqmu=R-ur8A@mail.gmail.com>
Message-ID: <570E47A5.3060807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/16 14:17, Rob Herring wrote:
> On Wed, Apr 13, 2016 at 4:05 AM, Suzuki K Poulose
> <Suzuki.Poulose@arm.com> wrote:
>> On 12/04/16 20:11, Olof Johansson wrote:
>>>
>>> On Tue, Mar 29, 2016 at 11:03:06AM +0100, Suzuki K Poulose wrote:

>> Do you mean something like :
>> config ARCH_SUNXI
>>          ...
>>          select SUNXI_PLATFORM
>>
>> And have
>>
>> config SUNXI_PLATFORM
>>          select SUNXI_DEPENDENCY_1
>>          select SUNXI_DEPENDENCY_2
>>
>> where SUNXI_PLATFORM drives the dependencies for both ARM and ARM64 ?
>
> No, I believe what Olof is saying is make the kconfig symbol for the
> irqchip (irq-sunxi-nmi) select it. If there is not a kconfig symbol
> already for it because you just use ARCH_SUNXI directly, then add it.

Ok, makes sense. Thanks, will respin it.

Suzuki
