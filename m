From: dcb314@hotmail.com (David Binderman)
Date: Mon, 5 Nov 2018 13:33:41 +0000
Subject: linux-4.20-rc1/sound/soc/stm/stm32_sai_sub.c:343: Faulty error check
Message-ID: <VI1PR08MB3342060AF73044939F5273F59CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

linux-4.20-rc1/sound/soc/stm/stm32_sai_sub.c:343]: (style) Checking if unsigned variable 'div' is less than zero.

Source code is

        div = stm32_sai_get_clk_div(sai, parent_rate, rate);
        if (div < 0)
                return div;

Suggest store return value from function in int local variable, test it
and only then assign it into an unsigned variable.

Regards

David Binderman
