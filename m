From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 03 Jun 2014 13:38:30 +0800
Subject: [PATCH v3 2/2] net: hisilicon: add hix5hd2 mac driver
In-Reply-To: <20140602.161131.783479189097234753.davem@davemloft.net>
References: <1401440528-7804-1-git-send-email-zhangfei.gao@linaro.org>	<1401440528-7804-3-git-send-email-zhangfei.gao@linaro.org>
 <20140602.161131.783479189097234753.davem@davemloft.net>
Message-ID: <538D5F56.1030106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/03/2014 07:11 AM, David Miller wrote:
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Date: Fri, 30 May 2014 17:02:08 +0800
>
>> +			skb = netdev_alloc_skb_ip_align(priv->netdev,
>> +				MAC_MAX_FRAME_SIZE);
>
> When a function call, declaration, or definition spans multiple lines,
> you must start the arguments on the second and subsequent lines exactly
> at the first column after the openning parenthesis.
>
> Please therefore reindent this properly.
Got it, not know this rule, will update accordingly.

>> +static int hix5hd2_mdio_wait_ready(struct mii_bus *bus)
>> +{
>> +	struct hix5hd2_priv *priv = bus->priv;
>> +	void __iomem *base = priv->base;
>> +	int i, timeout = 10000;
>> +
>> +	for (i = 0; readl_relaxed(base + MDIO_SINGLE_CMD) & MDIO_START; i++) {
>> +		if (i == timeout)
>> +			return -ETIMEDOUT;
>> +		udelay(1);
>> +	}
>> +
>> +	return 0;
>> +}
>
> 10,000 udelay(1)'s is a long time, consider changing to usleep() or
> similar.
>
Will use usleep_range(10, 20) instead.

Thanks
