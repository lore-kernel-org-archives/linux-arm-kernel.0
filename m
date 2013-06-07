From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 15:56:08 +0200
Subject: [RFC][PATCH 7/7] USB: OHCI: make ohci-s3c2410 a separate driver
In-Reply-To: <1370585013-12809-8-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1370585013-12809-8-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <3472823.JjiFtr34DX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 11:33:33 Manjunath Goudar wrote:
> 
> +       ohci_setup(hcd);
>         s3c2410_start_hc(dev, hcd);
>  
> -       ohci_hcd_init(hcd_to_ohci(hcd));
> -

I'm not sure about this part: s3c2410_start_hc is where the clock gets
enabled, presumable we are not supposed to touch the ohci registers
before it gets called, so ohci_init() being called implicitly
by ohci_setup() seems like a bad idea.

	Arnd
