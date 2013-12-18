From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 18 Dec 2013 08:27:48 -0300
Subject: [PATCH v2 01/11] clk: sunxi: register factors clocks behind
 composite
In-Reply-To: <20131218025527.23538.28216@quantum>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-2-git-send-email-emilio@elopez.com.ar>
 <20131218025527.23538.28216@quantum>
Message-ID: <52B186B4.6050706@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Thanks for the prompt review! It's much appreciated.

El 17/12/13 23:55, Mike Turquette escribi?:
> Quoting Emilio L?pez (2013-12-17 16:44:53)
>> This commit reworks factors clock registration to be done behind a
>> composite clock. This allows us to additionally add a gate, mux or
>> divisors, as it will be needed by some future PLLs.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
(...)
> Seems like 5 is a magic number? I guess this type of clock always has
> the same number of parents? Might be good to use a preprocessor macro
> here.

Indeed, these clocks always have less than 5 parents. I'll use a macro 
to make it clearer.

Cheers,

Emilio
