From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Feb 2014 07:10:05 -0600
Subject: [PATCH 3/9] ARM: select MIGHT_HAVE_CACHE_L2X0 for V7
 multi-platform
In-Reply-To: <52FBDA63.6030303@wwwdotorg.org>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-4-git-send-email-robherring2@gmail.com>
 <52FBDA63.6030303@wwwdotorg.org>
Message-ID: <CAL_JsqKWWnwEb479vsgCJ6swqbE9ZVo30A4VLiMKjwuc=nfVFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 2:32 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/11/2014 02:11 PM, Rob Herring wrote:
>> Many V7 platforms have an L2x0 cache, so make CONFIG_MIGHT_HAVE_CACHE_L2X0
>> visible for V7 multi-platform builds.
>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>
>>  config ARCH_MULTI_V6_V7
>>       bool
>> +     select MIGHT_HAVE_CACHE_L2X0
>
> The commit description says "V7", whereas the select got added to
> "V6_V7" rather then "V7". Was that intentional?

I'll fix the commit text. Given that most ARM11 platforms have an
L2x0, we should enable for both.

Rob
