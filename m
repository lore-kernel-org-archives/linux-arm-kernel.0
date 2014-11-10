From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 10 Nov 2014 14:13:28 +0300
Subject: [PATCH v4] i2c/at91: adopt pinctrl support
In-Reply-To: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
References: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <54609DD8.8030903@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/10/2014 4:55 AM, Wenyou Yang wrote:

> Amend the at91 i2c pin controller

    You're amending the hardware itself, really? :-)

> to optionally take a pin controlhandle

    I don't see the code that does this.

> and set the state of the pins to:
> - "default" on boot and resume.

    I don't see where you are changing anything for the probe() method. 
Perhaps you meant the driver core code which selects the dafault profile 
automatically?

> - "sleep" on suspend().

> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> Hi Wolfram,
>
> Thanks a lot.
>
> The change of this version is to remove
> 	pinctrl_pm_select_default_state(&pdev->dev) from the _probe function.

    Aha, you've specifically removed this...

WBR, Sergei
