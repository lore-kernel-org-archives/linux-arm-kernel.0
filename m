From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 21 Jun 2012 01:32:47 +0000
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <4FE1EF26.9080401@wwwdotorg.org>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-9-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com> <20120613152841.GA23590@richard-laptop>
 <4FD8C4DB.4020908@gmail.com>
 <20120614013343.GD29684@b20223-02.ap.freescale.net>
 <4FE1DE53.4070202@gmail.com> <4FE1EF26.9080401@wwwdotorg.org>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BE3E73@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> I haven't been following the thread, but just noticed it. Very similar
> things (DT nodes for probed devices) are coming up quite a bit recently,
> for example:
> 
> Re: Where to power on the wifi device before loading the driver.
> http://www.spinics.net/lists/arm-kernel/msg180368.html
> 
> dt: rfkill-gpio: add bindings documentation
> http://www.spinics.net/lists/linux-tegra/msg03977.html
> 
> I wonder if there's any kind of infra-structure or standardized bindings
> that would be useful here?

Hi Stephen,
For your suggestion: 

sdhci at 78000000 {
	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
	reg = <0x78000000 0x200>;
	interrupts = <0 14 0x04>;

	sdio-device {
		reset-gpios = <...>;
		enable-gpios = <...>;
	};
};

I have a question, if reset-gpio or enable-gpio is not set, how bus (sd or usb) know
it is a sdio device as the wifi is not powered on at the time, it will not response host's
command,  the hub at usb bus is the same.
