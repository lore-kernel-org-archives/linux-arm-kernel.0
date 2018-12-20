Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D4CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4CF217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="plwxCDTI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nW4gTURC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4CF217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVuNk+sXgP8qWq4VMboIAgyqE6T++B44RedMtaB+uc8=; b=plwxCDTIXJAUv3
	uxAcU3TdRFSQqsz3036t8Jsfr6UqR9no68otC2AAmq+MDa8yFIhUEdTUdu393od8D1JDQ8OtFye5v
	4KfdKCRDZFwHDfGwKkMkFdJNY+fSrn/7tkwlhW89XH0Hxs1MkPQNmG6oN6fkg8j2nYSQdYxv/OJFv
	kz/zjvh2oW1/hEatfqciVXn37tub6gs7O2JLsLms9Lx/o4LGrma+UXi3+b9feg7N1O2wzybYQ1fNr
	aRqKj8MoCzD1W9zVAfeACC2AA39eZue7MWv/2TDf9iJPSzmkM5qShhGH6Z6GUdn1dPS79RWRv4M++
	2PVuuXOBJUxryBoh2WeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZws9-0007d8-6u; Thu, 20 Dec 2018 11:52:13 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZws5-0007c3-Uh
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 11:52:11 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181220115156euoutp0276c20e3e42443587aa6d5c0de3d29851~yCEWOQUT71225512255euoutp02M
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 11:51:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181220115156euoutp0276c20e3e42443587aa6d5c0de3d29851~yCEWOQUT71225512255euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1545306717;
 bh=XMiM3DmsMK0uFSxzcXJQU11KHsnWS6JqEHwvsWPRKNM=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=nW4gTURCAd4L9AkSupTG5vGT94r93JbkAAQpjcCKXKLNKBgkuHKhTagScG50HX1Pi
 7ySzezR6IaFjgnk7/jNNsG7HM9AhbV6821oJdH0xK34gQFHo4tEX5oLYx67lf7IyOA
 hnHvpbDbRCegwA8MxjWTJXkMlkhc6iWyHTKlB7Ww=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181220115155eucas1p2c4bda5e566f5251e1aa74d4cfc58ed52~yCEU9Vgci2780027800eucas1p28;
 Thu, 20 Dec 2018 11:51:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 67.98.04441.B528B1C5; Thu, 20
 Dec 2018 11:51:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181220115154eucas1p1c40cf8ec2ff9192dd06a5bef9133333c~yCEUEBej22888628886eucas1p1Q;
 Thu, 20 Dec 2018 11:51:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181220115154eusmtrp26fa016ad3368b24869c6afd3ced3ab90~yCET1OU4-1446314463eusmtrp2q;
 Thu, 20 Dec 2018 11:51:54 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-49-5c1b825ba5a5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2D.DA.04128.A528B1C5; Thu, 20
 Dec 2018 11:51:54 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181220115153eusmtip1e8d1fbb7bd7f2bb8454c00c44e3356d2~yCETNMGe-2012720127eusmtip1h;
 Thu, 20 Dec 2018 11:51:53 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] driver core: add deferring probe reason to
 devices_deferred property
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <bd1424e7-44a3-52e9-3b4e-7b1496beb42c@samsung.com>
Date: Thu, 20 Dec 2018 12:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220111220.GA10978@kroah.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH/e3e3V1Hk5/T2GH2wEF/aKWZRpdMqSgYFRn4T6lkUy9q6pQ7
 H5l/aCq6lqlJKx2KhdnKRz5bPtJiho/E0jStiZq4f9JE8JFJ9HBeJf/7nHO+h+/3wKEJaa9Q
 TkerE1lOrYpVUGLS1L324WBwpkvIoWoLZr4VdiGmobhOyOinrRSTVVFHMY/uGxHTODMqZIbb
 SinGrO9ATO3bCRFTtqwnToiVw6NDhLLVMCFSNlbdopSvy2pEyqbH6cqFzk+UMr+5CimXGvdc
 pIPExyPY2OhklvP0vyqOKljWChPeuF9/NVdDZqB6hQ7Z04B9oKp0VqRDYlqKnyLImugg+GIZ
 QctsmcimkuIlBLrxw1sb/Q11JC8yIsix1CO+mEeQO2wlbConHAY/595tsDP2hoIBw4YHgVcF
 YLIuCG0DCrvB76YvlI0l2B9y+6Y37Ei8D+ay9QIb78SXQDtVvalxhL4SK2lje+wJ39vHNpjA
 e+HlfCnBswws1nKBzQywRQTPCuYRn/s03OmfFfHsBLM9zZu8C/62lgt4TofMkhGCX9Yi6K0w
 UvzAF7p6htZT0+sOblDX5sm3T0L33QHC1gbsAJ/nHfkMDlBkerDZloA2R8qrXWFq4AXBswwq
 B1eoQqQwbLvMsO0aw7ZrDP99HyKyCsnYJE1cJKvxUrMpHhpVnCZJHekRHh/XiNb/q/9Pz2IL
 WvkYZkaYRoodkuIgeYhUqErWpMaZEdCEwlkyc80lRCqJUKXeYLn4UC4pltWYkQtNKmSSNLuv
 wVIcqUpkY1g2geW2pgLaXp6BtIPDlrV7R8JbrvSJ33vb5WUEFt08AAFFeQS4jZpllv3+u3Wm
 sZ6jkxfPFhzz8TvntxbhMVJmklWn9fku1p8/o24ad+8gVtNdYnoXZSYiOzSYHBu/PCSM6syf
 JJueyH+UmqyuQfGClKzu9l7jbXVt9iku8FdA1uDzyguc3MIqSE2Uysud4DSqf0N8TKtbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7pRTdIxBoeuc1q8nHCY0WLjjPWs
 FlMfPmGzaF68ns1i4bTljBabHl9jtbi8aw6bxaGpexkt1h65y24x98tUZgcuj8vXLjJ77Jx1
 l91j06pONo/9c9ewe2xeUu/xft9VNo++LasYPT5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIz
 tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL6P/SwVpwQKtiz+s1LA2MG5S6GDk5JARM
 JE5vXM/SxcjFISSwlFFi1bvDrBAJcYnd898yQ9jCEn+udbFBFL1mlDh+bAZYQlggSeLH61Ng
 toiAsUT/2VnsIDazwG8miSkbskBsIYF7jBLnfxaC2GwCmhJ/N99kA7F5Bewk2k8+BKtnEVCV
 eN0ylQnEFhWIkDj7ch0jRI2gxMmZT1hAbE4BfYk3u6+zQMxXl/gz7xIzhC0vsf3tHChbXOLW
 k/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNdtx35u
 2cHY9S74EKMAB6MSD++MKKkYIdbEsuLK3EOMEhzMSiK8j7OkY4R4UxIrq1KL8uOLSnNSiw8x
 mgI9N5FZSjQ5H5hK8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1
 MN64bb6UxYJBZr5r68yM7ykdT1Wcfaa03WitdJYp8/wYoxF46HKreWe1YGD9h8ioyUq85yxm
 rE3Nab28u7dCTEImIumj/SNGj5z6GOkrFmlLFcN7HnFONE8y1j1+Tfnez0Xi3BXP17upPTDm
 C/69YWVbxP0tW1XUBU6q3H6ibeVzzoXZ/VePEktxRqKhFnNRcSIAH4Fci+0CAAA=
X-CMS-MailID: 20181220115154eucas1p1c40cf8ec2ff9192dd06a5bef9133333c
X-Msg-Generator: CA
X-RootMTR: 20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a@eucas1p1.samsung.com>
 <20181220102247.4911-3-a.hajda@samsung.com>
 <20181220111220.GA10978@kroah.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_035210_122574_F6565F54 
X-CRM114-Status: GOOD (  26.35  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20.12.2018 12:12, Greg Kroah-Hartman wrote:
> On Thu, Dec 20, 2018 at 11:22:46AM +0100, Andrzej Hajda wrote:
>> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
>> This list does not contain reason why the driver deferred probe, the patch
>> improves it.
>> The natural place to set the reason is probe_err function introduced recently,
>> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
>> will be attached to deferred device and printed when user read devices_deferred
>> property.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>> v4:
>>   - removed NULL check before kfree,
>>   - coding style tweaking.
>> v3:
>>   - adjusted deferred_devs_show, to accept newline ended messages,
>>   - changed conditonal check to positive,
>>   - added R-b by Andy.
>> v2:
>>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>>   - use kasprintf instead of bunch of code,
>>   - keep consistent format of devices_deferred lines,
>>   - added R-Bs (again I hope changes above are not against it).
>> ---
>> ---
>>  drivers/base/base.h |  3 +++
>>  drivers/base/core.c |  9 +++++----
>>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>>  3 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>> index 7a419a7a6235..effbd5e7f9f1 100644
>> --- a/drivers/base/base.h
>> +++ b/drivers/base/base.h
>> @@ -75,6 +75,7 @@ struct device_private {
>>  	struct klist_node knode_driver;
>>  	struct klist_node knode_bus;
>>  	struct list_head deferred_probe;
>> +	char *deferred_probe_msg;
>>  	struct device *device;
>>  };
>>  #define to_device_private_parent(obj)	\
>> @@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
>>  extern void driver_detach(struct device_driver *drv);
>>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>>  extern void driver_deferred_probe_del(struct device *dev);
>> +extern void __deferred_probe_set_msg(const struct device *dev,
>> +				     struct va_format *vaf);
>>  static inline int driver_match_device(struct device_driver *drv,
>>  				      struct device *dev)
>>  {
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 7f644f3c41d3..d3eb5aeeaa28 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -3108,6 +3108,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>>   *
>>   * This helper implements common pattern present in probe functions for error
>>   * checking: print message if the error is not -EPROBE_DEFER and propagate it.
>> + * In case of -EPROBE_DEFER it sets defer probe reason.
>>   * It replaces code sequence:
>>   * 	if (err != -EPROBE_DEFER)
>>   * 		dev_err(dev, ...);
>> @@ -3123,14 +3124,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>>  	struct va_format vaf;
>>  	va_list args;
>>  
>> -	if (err == -EPROBE_DEFER)
>> -		return err;
>> -
>>  	va_start(args, fmt);
>>  	vaf.fmt = fmt;
>>  	vaf.va = &args;
>>  
>> -	dev_err(dev, "error %d: %pV", err, &vaf);
>> +	if (err == -EPROBE_DEFER)
>> +		__deferred_probe_set_msg(dev, &vaf);
>> +	else
>> +		dev_err(dev, "error %d: %pV", err, &vaf);
>>  
>>  	va_end(args);
>>  
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 88713f182086..857aa4d1d45d 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/async.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pinctrl/devinfo.h>
>> +#include <linux/slab.h>
>>  
>>  #include "base.h"
>>  #include "power/power.h"
>> @@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
>>  	if (!list_empty(&dev->p->deferred_probe)) {
>>  		dev_dbg(dev, "Removed from deferred list\n");
>>  		list_del_init(&dev->p->deferred_probe);
>> +		kfree(dev->p->deferred_probe_msg);
>> +		dev->p->deferred_probe_msg = NULL;
>>  	}
>>  	mutex_unlock(&deferred_probe_mutex);
>>  }
>> @@ -202,6 +205,21 @@ void device_unblock_probing(void)
>>  	driver_deferred_probe_trigger();
>>  }
>>  
>> +/*
>> + * __deferred_probe_set_msg() - Set defer probe reason message for device
>> + */
>> +void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
>> +{
>> +	const char *drv = dev_driver_string(dev);
>> +
>> +	mutex_lock(&deferred_probe_mutex);
>> +
>> +	kfree(dev->p->deferred_probe_msg);
>> +	dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> Why do you also need the dev driver string here?  Don't you get it
> automatically when you print out the list in deferred_devs_show()?


Deferred device is not bound to driver.


>
> How about we just wait on this patch, it seems very unneeded.  Or at
> least I can't see who would need this, what can a user do with this
> information?


It should be quite helpful in case of deferred probing, solving
mysteries why given device is not bound to the driver is very common in
mobile world.

And since deferal should not be treated as an error grepping dmesg often
does not help.


Regards

Andrzej



>
> thanks,
>
> greg k-h
>
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
