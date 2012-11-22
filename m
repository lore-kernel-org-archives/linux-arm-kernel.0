From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 Nov 2012 09:44:07 -0200
Subject: [RFC] ARM: mx27: Replace clk_register_clkdev with clock DT lookup
In-Reply-To: <20121122075727.GX10369@pengutronix.de>
References: <1353532526-12897-1-git-send-email-festevam@gmail.com>
 <20121122075727.GX10369@pengutronix.de>
Message-ID: <CAOMZO5BWhXSJSP_FFw69hOhcT7pt5JMqWMBZe3H7r1Yk105NEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Nov 22, 2012 at 5:57 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

>> +     Clock                   ID
>> +     ---------------------------
>> +     dummy                   0
>> +     ckih                    1
>> +     ckil                    2
>> +     mpll                    3
>> +     spll                    4
>> +     mpll_main2              5
>> +     ahb ipg                 6
>         ^^^^^^^
>
> You could add the following to the clock code, this makes
> generating the lists less error prone:
>
>         for (i = 0; i < ARRAY_SIZE(clk); i++)
>                 pr_err("%-20s %d\n", IS_ERR(clk[i]) ? "-----" : __clk_get_name(clk[i]), i);

Thanks, this was the issue. It boots fine now.

Will rebase against imx/soc and re-submit.

Thanks,

Fabio Estevam
