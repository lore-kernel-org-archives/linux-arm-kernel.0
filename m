From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Aug 2012 11:00:31 +0200
Subject: [PATCH 07/14] arm: at91: dt: at91sam9 add serial pinctrl support
In-Reply-To: <1344603731-32667-7-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-7-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdbknWyukz3k3VCTySe=7igvB5EsYaEim=hcNV0QHcTznw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 3:02 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> Set the dbgu pinctrl config by default as we have only one possible config
> For other uart set the rxd/txd by default.
>
> For at91sam9x5ek create soc based dts as we need to include specific soc dtsi.

Some things I understand, like this:

> @@ -145,6 +240,8 @@
>                                 compatible = "atmel,at91sam9260-usart";
>                                 reg = <0xfffff200 0x200>;
>                                 interrupts = <1 4 7>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_dbgu>;
>                                 status = "disabled";
>                         };

And that looks good ...

But the magic hex values I have no clue about so prefer to leave this
to Nicolas.

Yours,
Linus Walleij
