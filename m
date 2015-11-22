From: Yuval.Mintz@qlogic.com (Yuval Mintz)
Date: Sun, 22 Nov 2015 09:30:30 +0000
Subject: [PATCH V3 net-next 2/5] net:hns: Add Hip06 "RSS(Receive Side
 Scaling)" support to HNS Driver
In-Reply-To: <1447966706-16219-3-git-send-email-salil.mehta@huawei.com>
References: <1447966706-16219-1-git-send-email-salil.mehta@huawei.com>
 <1447966706-16219-3-git-send-email-salil.mehta@huawei.com>
Message-ID: <CO2PR11MB0088B852596B9F86F7BDCF6F97180@CO2PR11MB0088.namprd11.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  static void hns_ppe_init_hw(struct hns_ppe_cb *ppe_cb)  {
...
> +	/* Set default RSS key and indrection table*/
> +	const u32 rss_key[HNS_PPEV2_RSS_KEY_NUM] = {
> +		0x6d5a56da, 0x255b0ec2,
> +		0x4167253d, 0x43a38fb0,
> +		0xd0ca2bcb, 0xae7b30b4,
> +		0x77cb2da3, 0x8030f20c,
> +		0x6a42b73b, 0xbeac01fa,
> +	};
> +
> +	/* set default RSS key and remember it */
> +	for (i = 0; i < HNS_PPEV2_RSS_KEY_NUM; i++)
> +		ppe_cb->rss_key[i]  = rss_key[i];
> 

Is there any reason for the special default key?
Why not use netdev_rss_key_fill()?
