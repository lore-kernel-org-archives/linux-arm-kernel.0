From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 11:48:05 +0200
Subject: [PATCH 2/4] pinctrl: imx: add gpio pinmux support for vf610
In-Reply-To: <4cf96e22ce2c7646513b64260c7bb1a2279e232d.1410020459.git.stefan@agner.ch>
References: <cover.1410020458.git.stefan@agner.ch>
 <4cf96e22ce2c7646513b64260c7bb1a2279e232d.1410020459.git.stefan@agner.ch>
Message-ID: <CACRpkdYk0zW12qNXgOstTLmdVDYacu0Un+8quTN+J_azOic7AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 6, 2014 at 6:25 PM, Stefan Agner <stefan@agner.ch> wrote:

> Add pinmux support for GPIO for Vybrid (vf610) IOMUX controller.
> This is needed since direction configuration is not part of the
> GPIO module in Vybrid.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
(...)

> -arch_initcall(vf610_pinctrl_init);
> +postcore_initcall(vf610_pinctrl_init);

Why is this necessary? You should be able to rely on deferred
probing to do its work here. I think this should be module_init()
or driver_initcall() really.

Yours,
Linus Walleij
