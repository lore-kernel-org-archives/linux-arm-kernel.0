From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 10 Mar 2016 10:11:49 +0200
Subject: [patch net 1/2] net: hns: fix return value of the function
 about rss
In-Reply-To: <1457576189-22924-2-git-send-email-yankejian@huawei.com>
References: <1457576189-22924-1-git-send-email-yankejian@huawei.com>
 <1457576189-22924-2-git-send-email-yankejian@huawei.com>
Message-ID: <1457597509.1347.49.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-03-10 at 10:16 +0800, Kejian Yan wrote:
> Both .get_rxfh and .get_rxfh are always return 0, it should return
> result
> from hardware when getting or setting rss. And the rss function
> should
> return the correct data type.
> 

@@ -1213,7 +1213,7 @@ hns_get_rss(struct net_device *netdev, u32
> *indir, u8 *key, u8 *hfunc)
> ?
> 

> ?	ret = ops->get_rss(priv->ae_handle, indir, key, hfunc);
> ?
> -	return 0;
> +	return ret;

All three can be one line.

> @@ -1241,7 +1241,7 @@ hns_set_rss(struct net_device *netdev, const
> u32 *indir, const u8 *key,
> ?
> ?	ret = ops->set_rss(priv->ae_handle, indir, key, hfunc);
> ?
> -	return 0;
> +	return ret;

Ditto.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
