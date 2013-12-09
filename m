From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 09 Dec 2013 17:44:48 +0400
Subject: [PATCH 04/10] net: stmmac: sunxi platfrom extensions for GMAC
 in Allwinner A20 SoC's
In-Reply-To: <52A5A7B2.4000509@st.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org> <52A5A7B2.4000509@st.com>
Message-ID: <52A5C950.7070903@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-12-2013 15:21, srinivas kandagatla wrote:

>> +static int sun7i_gmac_init(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *addr = NULL;
>> +	struct plat_stmmacenet_data *plat_dat = NULL;

    No need to initialize it since you're assigning to it right below.

>> +	u32 priv_clk_reg;
>> +
>> +	plat_dat = dev_get_platdata(&pdev->dev);
>> +	if (!plat_dat)
>> +		return -EINVAL;

> dev_get_platdata will return NULL for DT, So this function will fail all
> the time.

    Indeed, unless the probe() method assigns it from the 'data' field of
'struct of_device_id'.

> How is it supposed to work?
> Am I missing some thing?

    Look at stmmac_pltfr_probe().

> --srini

WBR, Sergei
