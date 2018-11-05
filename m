From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 5 Nov 2018 15:24:09 +0100
Subject: linux-4.20-rc1/sound/soc/stm/stm32_sai_sub.c:343: Faulty error
 check
In-Reply-To: <VI1PR08MB3342060AF73044939F5273F59CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
References: <VI1PR08MB3342060AF73044939F5273F59CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
Message-ID: <ccd8a02d-13a0-432a-ecd0-94234a2cfd83@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello David,

On 11/5/18 2:33 PM, David Binderman wrote:
> Hello there,
> 
> linux-4.20-rc1/sound/soc/stm/stm32_sai_sub.c:343]: (style) Checking if
> unsigned variable 'div' is less than zero.
> 
> Source code is
> 
> ??????? div = stm32_sai_get_clk_div(sai, parent_rate, rate);
> ??????? if (div < 0)
> ??????????????? return div;
> 
> Suggest store return value from function in int local variable, test it
> and only then assign it into an unsigned variable.
> 
> Regards
> 
> David Binderman

Thanks for your feedback, a patch has already been sent and applied to
fix this warning: https://lkml.org/lkml/2018/11/5/510.

Regards,
Arnaud
