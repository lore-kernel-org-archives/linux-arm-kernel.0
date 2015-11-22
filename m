From: Yuval.Mintz@qlogic.com (Yuval Mintz)
Date: Sun, 22 Nov 2015 11:17:13 +0000
Subject: [PATCH V4 net-next 4/5] net:hns: Add support of ethtool TSO set
 option for Hip06 in HNS
In-Reply-To: <1448048952-146714-5-git-send-email-salil.mehta@huawei.com>
References: <1448048952-146714-1-git-send-email-salil.mehta@huawei.com>
 <1448048952-146714-5-git-send-email-salil.mehta@huawei.com>
Message-ID: <CO2PR11MB00885531F54375191E6F015597180@CO2PR11MB0088.namprd11.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static netdev_features_t hns_nic_fix_features(
> +		struct net_device *netdev, netdev_features_t features) {
> +	struct hns_nic_priv *priv = netdev_priv(netdev);
> +
> +	switch (priv->enet_ver) {
> +	case AE_VERSION_1:
> +		features &= ~(NETIF_F_TSO | NETIF_F_TSO6 |
> +				NETIF_F_HW_VLAN_CTAG_FILTER);
> +		break;
> +	default:
> +		break;
> +	}
> +	return features;
> +}
> +

Isn't AE_VERSION_1 something fixed once you publish your features?
If it can't be changed, why not simply remove the features from
`hw_features' instead of having to implement this ndo?
