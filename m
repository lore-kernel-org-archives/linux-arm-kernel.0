From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 25 Aug 2016 03:18:55 +0900
Subject: [PATCH 01/10] reset: ath79: add driver Kconfig option
In-Reply-To: <20643424.8eBLZWavEG@wuerfel>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <20643424.8eBLZWavEG@wuerfel>
Message-ID: <CAK7LNAT4rZoQJaPLiA_Hg=PJ9AD4Z-oLVadq5WDgQ2etCYUFFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2016-08-25 0:51 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday, August 24, 2016 3:28:53 PM CEST Philipp Zabel wrote:
>>  if RESET_CONTROLLER
>>
>> +config RESET_ATH79
>> +       bool "AR71xx Reset Driver" if COMPILE_TEST
>> +       default ATH79
>> +       help
>> +         This enables the ATH79 reset controller driver that supports the
>> +         AR71xx SoC reset controller.
>> +
>>
>
> Nice series!
>
> Just note that there is one possible problem with COMPILE_TEST
> when the platforms are enabled, as you can then disable a driver
> that is normally there, and that can in turn cause problems in
> rare cases, e.g. when the driver has a global function that is
> called from platform code. I don't know if any of the drivers
> do that, but if they do, you'd have to use
>
> config RESET_ATH79
>        bool "AR71xx Reset Driver" if COMPILE_TEST && !ATH79
>        default ATH79
>
> to ensure that it's impossible to disable the driver on platforms
> that require it.

Hmm,
Can we do this only when we really have to do so?
I think we should not care about such a rare case that may not happen.

Let's start with only "if COMPILE_TEST",
and take a look at it if a build error is detected.

Anyway, depending on platform code is a sign of weird implementation.

It might be better to find a potential issue rather than hide it.


-- 
Best Regards
Masahiro Yamada
