From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 29 Jun 2014 12:00:20 +0100
Subject: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
In-Reply-To: <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>	<1402672899-6995-1-git-send-email-denis@eukrea.com>	<1402672899-6995-3-git-send-email-denis@eukrea.com>	<53A55BD8.7030905@kernel.org>
 <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
Message-ID: <53AFF1C4.1010402@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/14 20:55, Fabio Estevam wrote:
> On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>
>> Could this not in theory fail?
>
> Yes, but devm_ioremap_resource will take care of it, so we don't need
> to check for error here.
Nothing like counter intuitive behaviour.  Ah well.

Thanks for explaining this!
>
>>
>>> +       mem = devm_ioremap_resource(dev, res);
>>> +       if (!mem)
>>> +               return -ENOMEM;
