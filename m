From: gerg@uclinux.org (Greg Ungerer)
Date: Wed, 23 Oct 2013 13:19:57 +1000
Subject: [PATCH 2/8] ARM: imx: add clocking support code for the IMX50 SoC
In-Reply-To: <20131022122708.GA31304@pengutronix.de>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-3-git-send-email-gerg@uclinux.org>
 <20131022122708.GA31304@pengutronix.de>
Message-ID: <5267405D.4010104@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 22/10/13 22:27, Sascha Hauer wrote:
> Hi Greg,
> 
> On Fri, Oct 18, 2013 at 04:04:14PM +1000, gerg at uclinux.org wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> Add code to support the specific clock tree of the Freescale IMX50 SoC.
>> It can use much of the common IMX51/IMX53 clocking code.
>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>> ---
>> +	clk_register_clkdev(clk[i2c3_gate], NULL, "imx21-i2c.2");
>> +	clk_register_clkdev(clk[fec_gate], NULL, "imx25-fec.0");
>> +	clk_register_clkdev(clk[usb_phy1_gate], "usb_phy1", "mxc-ehci.0");
>> +	clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg", "sdhci-esdhc-imx50.0");
>> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.0");
>> +	clk_register_clkdev(clk[esdhc1_per_gate], "per", "sdhci-esdhc-imx50.0");
>> +	clk_register_clkdev(clk[esdhc2_ipg_gate], "ipg", "sdhci-esdhc-imx50.1");
>> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.1");
>> +	clk_register_clkdev(clk[esdhc2_per_gate], "per", "sdhci-esdhc-imx50.1");
>> +	clk_register_clkdev(clk[esdhc3_ipg_gate], "ipg", "sdhci-esdhc-imx50.2");
>> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.2");
>> +	clk_register_clkdev(clk[esdhc3_per_gate], "per", "sdhci-esdhc-imx50.2");
>> +	clk_register_clkdev(clk[esdhc4_ipg_gate], "ipg", "sdhci-esdhc-imx50.3");
>> +	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx50.3");
>> +	clk_register_clkdev(clk[esdhc4_per_gate], "per", "sdhci-esdhc-imx50.3");
> 
> The above shouldn't be needed with dt-only support. On i.MX51/53 these
> are only needed for platform based support.

Ok, thanks. I'll remove them.

Regards
Greg
