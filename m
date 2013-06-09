From: b32955@freescale.com (Huang Shijie)
Date: Sun, 9 Jun 2013 10:17:51 +0800
Subject: [PATCH] serial: imx: enable the clocks for console
In-Reply-To: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
References: <20130608062307.GB22416@S2101-09.ap.freescale.net>	<1370678667-3514-1-git-send-email-b32955@freescale.com>
 <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
Message-ID: <51B3E5CF.4010202@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?06?08? 21:11, Fabio Estevam ??:
> Hi Huang,
>
> On Sat, Jun 8, 2013 at 5:04 AM, Huang Shijie<b32955@freescale.com>  wrote:
>
>> +       if (!uart_console(port)) {
>> +               retval = clk_prepare_enable(sport->clk_per);
>> +               if (retval)
>> +                       goto error_out1;
>> +               retval = clk_prepare_enable(sport->clk_ipg);
>> +               if (retval)
>> +                       goto error_out1;
> Here you should not jump to "error_out1".
>
> You should jump to a different label and disable the sport->clk_per clock.
yes. you are right.
I will fix it in the patch "serial: imx: enable the clocks for console"

thanks
Huang Shijie
> This was also wrong in your previous patch.
>
