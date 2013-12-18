From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 18 Dec 2013 08:34:43 -0300
Subject: [PATCH v2 04/11] clk: sunxi: make factors_clk_setup return the
 clock it registers
In-Reply-To: <20131218030140.23538.40290@quantum>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-5-git-send-email-emilio@elopez.com.ar>
 <20131218030140.23538.40290@quantum>
Message-ID: <52B18853.1000301@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 18/12/13 00:01, Mike Turquette escribi?:
> Quoting Emilio L?pez (2013-12-17 16:44:56)
>> We will be needing this to register a factor clock as parent with leaf
>> divisors on a single call. While at it, also prepare the function to set
>> the ignore flag on pll5, so our RAM keeps working.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> ---
(...)
>>
>> +       /* We should not disable pll5, it powers the RAM */
>> +       flags = !strcmp("pll5", clk_name) ? CLK_IGNORE_UNUSED : 0;
>
> For hardware-agnostic flags like CLK_IGNORE_UNUSED I think that we can
> add a property to the binding description instead of hard-coding a
> string name in here.

Hm, I don't know if something like that would really belong to the DT. 
In any case, I should be able to drop this from here now that the clock 
protection stuff is in place, so it should be a non-issue.

> Rest of the patch looks good to me. Ack.

Thanks for reviewing this!

Emilio
