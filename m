From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 21 Jun 2014 16:55:52 -0300
Subject: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
In-Reply-To: <53A55BD8.7030905@kernel.org>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
 <1402672899-6995-3-git-send-email-denis@eukrea.com>
 <53A55BD8.7030905@kernel.org>
Message-ID: <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> Could this not in theory fail?

Yes, but devm_ioremap_resource will take care of it, so we don't need
to check for error here.

>
>> +       mem = devm_ioremap_resource(dev, res);
>> +       if (!mem)
>> +               return -ENOMEM;
