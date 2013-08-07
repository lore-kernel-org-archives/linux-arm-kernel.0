From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Aug 2013 17:54:17 +0200
Subject: [PATCH 04/20] ARM: pxa: ssp: add DT bindings
In-Reply-To: <1375889649-14638-5-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-5-git-send-email-zonque@gmail.com>
Message-ID: <201308071754.17741.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 August 2013, Daniel Mack wrote:
> +Device tree bindings for Marvell PXA SSP ports
> +
> +Required properties:
> +
> +       - compatible:   Must be one of
> +                               mrvl,pxa25x-ssp
> +                               mvrl,pxa25x-nssp
> +                               mrvl,pxa27x-ssp
> +                               mrvl,pxa3xx-ssp
> +                               mvrl,pxa168-ssp
> +                               mrvl,pxa910-ssp
> +                               mrvl,ce4100-ssp
> +                               mrvl,lpss-ssp
> +
> +       - reg:          The memory base
> +
> +

It seems you are missing the 'dmas' properties here and that two of them
("rx" and "tx") are required by the code.

	Arnd
