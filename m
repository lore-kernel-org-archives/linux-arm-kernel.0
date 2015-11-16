From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 16 Nov 2015 10:28:27 -0800
Subject: [PATCH] pinctrl: fix qcom ssbi drivers for 64-bit compilation
In-Reply-To: <5235862.Gokjxf5QH1@wuerfel>
References: <5235862.Gokjxf5QH1@wuerfel>
Message-ID: <20151116182826.GD30882@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 16 Nov 08:41 PST 2015, Arnd Bergmann wrote:

> When building pinctrl-ssbi-gpio and pinctrl-ssbi-mpp for ARM64, we get
> a compile warning about invalid types:
> 
> drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c: In function 'pm8xxx_gpio_probe':
> drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c:675:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c: In function 'pm8xxx_mpp_probe':
> drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c:766:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> This changes the code so we cast the pointer to 'unsigned long', which
> is the right thing to do here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks Arnd,

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
