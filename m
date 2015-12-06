From: Yuval.Mintz@qlogic.com (Yuval Mintz)
Date: Sun, 6 Dec 2015 06:43:12 +0000
Subject: [PATCH V4 net-next 4/5] net:hns: Add support of ethtool TSO set
 option for Hip06 in HNS
In-Reply-To: <565DA6F5.7040804@gmail.com>
References: <1448048952-146714-1-git-send-email-salil.mehta@huawei.com>
 <1448048952-146714-5-git-send-email-salil.mehta@huawei.com>
 <CO2PR11MB00885531F54375191E6F015597180@CO2PR11MB0088.namprd11.prod.outlook.com>
 <565DA6F5.7040804@gmail.com>
Message-ID: <CO2PR11MB008864AFF3D819EFE7A7622B970A0@CO2PR11MB0088.namprd11.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Isn't AE_VERSION_1 something fixed once you publish your features?
> > If it can't be changed, why not simply remove the features from
> > `hw_features' instead of having to implement this ndo?
> There could be a case where the feature is supported by the SoC
> and therefore it is already part of the 'hw_features' but it has been
> say DISABLED or ENABLED by ethtool. In such a case, we need to
> make sure we strike off that feature from the 'features' flag.
> 
> Therefore, we need this leg I suppose. Let me know If I am missing
> something here or there is a gap in my understanding.

Look at ethtool_set_features() - if something isn't listed in hw_features,
you're not support to be able to change it.

If you can make a one-time decision when registering the netdevice
whether this feature is supported by HW or not [assuming AE_VERSION_1
is available at that point and can't later change] than it's the better alternative.

Cheers,
Yuval 
