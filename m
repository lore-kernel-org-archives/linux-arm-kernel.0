From: mehta.salil.lnk@gmail.com (Salil Mehta)
Date: Tue, 1 Dec 2015 13:56:05 +0000
Subject: [PATCH V4 net-next 4/5] net:hns: Add support of ethtool TSO set
 option for Hip06 in HNS
In-Reply-To: <CO2PR11MB00885531F54375191E6F015597180@CO2PR11MB0088.namprd11.prod.outlook.com>
References: <1448048952-146714-1-git-send-email-salil.mehta@huawei.com>
 <1448048952-146714-5-git-send-email-salil.mehta@huawei.com>
 <CO2PR11MB00885531F54375191E6F015597180@CO2PR11MB0088.namprd11.prod.outlook.com>
Message-ID: <565DA6F5.7040804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/11/15 11:17, Yuval Mintz wrote:
>> +static netdev_features_t hns_nic_fix_features(
>> +		struct net_device *netdev, netdev_features_t features) {
>> +	struct hns_nic_priv *priv = netdev_priv(netdev);
>> +
>> +	switch (priv->enet_ver) {
>> +	case AE_VERSION_1:
>> +		features &= ~(NETIF_F_TSO | NETIF_F_TSO6 |
>> +				NETIF_F_HW_VLAN_CTAG_FILTER);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return features;
>> +}
>> +
> Isn't AE_VERSION_1 something fixed once you publish your features?
> If it can't be changed, why not simply remove the features from
> `hw_features' instead of having to implement this ndo?
Hi Yuval,
I some how missed to reply this, though I worked on your suggestions
in the already floated V5 patch earlier. Sorry for this!
There could be a case where the feature is supported by the SoC
and therefore it is already part of the 'hw_features' but it has been
say DISABLED or ENABLED by ethtool. In such a case, we need to
make sure we strike off that feature from the 'features' flag.

Therefore, we need this leg I suppose. Let me know If I am missing
something here or there is a gap in my understanding.

Thanks
Salil
