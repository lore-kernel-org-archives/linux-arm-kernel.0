From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 28 May 2014 13:48:18 +0800
Subject: [PATCH v2 2/2] net: hisilicon: add hix5hd2 mac driver
In-Reply-To: <20140527130236.GA26163@distanz.ch>
References: <1401194667-14445-1-git-send-email-zhangfei.gao@linaro.org>
 <1401194667-14445-3-git-send-email-zhangfei.gao@linaro.org>
 <20140527130236.GA26163@distanz.ch>
Message-ID: <538578A2.7060600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/27/2014 09:02 PM, Tobias Klauser wrote:
> On 2014-05-27 at 14:44:27 +0200, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
>> +static struct net_device_stats *hix5hd2_net_get_stats(struct net_device *dev)
>> +{
>> +	return &dev->stats;
>> +}
>
> This function can be omitted, since it corresponds to the default
> behavior if neither .ndo_get_stats or .ndo_get_stats64 is set.
>
>> +
>> +static const struct net_device_ops hix5hd2_netdev_ops = {
>> +	.ndo_open		= hix5hd2_net_open,
>> +	.ndo_stop		= hix5hd2_net_close,
>> +	.ndo_start_xmit		= hix5hd2_net_xmit,
>> +	.ndo_tx_timeout		= hix5hd2_net_timeout,
>> +	.ndo_set_mac_address	= hix5hd2_net_set_mac_address,
>> +	.ndo_get_stats		= hix5hd2_net_get_stats,
>
> Thus the line above can then be omitted as well.

Thanks Tobias.

Have double checked dev_get_stats, the .ndo_get_stats can be removed here.
Thanks for the remainder.
