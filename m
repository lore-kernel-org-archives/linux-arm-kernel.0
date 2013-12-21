From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Fri, 20 Dec 2013 23:26:28 -0300
Subject: [PATCH v2 05/11] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <20131219045905.23538.99955@quantum>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-6-git-send-email-emilio@elopez.com.ar>
 <20131219045905.23538.99955@quantum>
Message-ID: <52B4FC54.7070909@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 19/12/13 01:59, Mike Turquette escribi?:
> Quoting Emilio L?pez (2013-12-17 16:44:57)
>> +
>> +       /* It's not a good idea to have automatic reparenting changing
>> +        * our RAM clock! */
>> +       clkflags = !strcmp("pll5", parent) ? 0 : CLK_SET_RATE_PARENT;
>
> Just out of curiosity, did you hit this problem in testing?

Yes, I believe it was the case that, with automatic reparenting 
implemented, reconfiguring the mmc or similar clock ended up choosing 
pll5_other as ideal parent, and was trying to tune its frequency.

> Acked-by: Mike Turquette <mturquette@linaro.org>

Thanks!

Emilio
