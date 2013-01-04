From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 4 Jan 2013 11:47:53 +0200
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
In-Reply-To: <50E6A378.90503@ti.com>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch>
 <1355482986-885-2-git-send-email-andrew@lunn.ch> <50E6A378.90503@ti.com>
Message-ID: <50E6A549.5050407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello again,

On 04-01-2013 11:40, Eduardo Valentin wrote:
> Hey Andrew,
>
> On 14-12-2012 13:03, Andrew Lunn wrote:
>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

<cut>

>
> I believe you forgot to request this memory. I suggest you do:
> +    thermal_dev->base_addr = devm_request_and_ioremap(&pdev->dev,
> res->start,
> +                          res);
>

small fix:

+    thermal_dev->base_addr = devm_request_and_ioremap(&pdev->dev,
+                                                      res);
