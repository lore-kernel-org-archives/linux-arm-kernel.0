From: robh@kernel.org (Rob Herring)
Date: Wed, 4 Feb 2015 07:58:32 -0600
Subject: [PATCH 0/4] SA1100 RTC clean-up for ARM64
In-Reply-To: <20150204104453.GE8656@n2100.arm.linux.org.uk>
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <20150204104453.GE8656@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqLChx1ZP_tYPoHydgbnfaELYiBnDHkmGPyjY5ULej0yjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 4:44 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 03, 2015 at 05:22:51PM -0600, Rob Herring wrote:
>> This series enables building the SA1100 RTC driver for ARM64 in
>> preparation for enabling CONFIG_ARCH_MMP on ARM64. This is needed for
>> supporting the PXA1928 SOC.
>>
>> It's a bit late for 3.20, so targeting 3.21 is fine. Probably this
>> should go through the arm-soc tree.
>
> This seems weird.  Surely it's using the PXA version of this IP, so
> shouldn't you be using drivers/rtc/rtc-pxa.c instead?

Nope. It is the early PXA version, but with some extra "backup"
registers. I'm not sure how those are intended to be used, but the
vendor kernel doesn't use them either.

Rob
