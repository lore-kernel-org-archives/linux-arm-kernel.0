Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48294C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:42:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CA521473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Auqe6L3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CA521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qm6SGlfvKOt4au8GMTcwD0cjvikJ5gZQml48rEUGDcQ=; b=Auqe6L3Y+U4YEGX9S+UHw7c7H
	e3AGiKBb51NcepKAIrhTALHoY65/C8mFsRm7g7el7U70Et8QBFqhG5skfJ7FCZwgT0AozuUru3j8+
	+sPyXMfIjW/Ly3B+5GKXMBwXdhmK9BzzZ80aCO1eWvbqtQDDUM3fgxsoTn0AWeXvKGVFUMRzscE9x
	Vx4XcZvH44DgXjlmFi9oZ9SqzBe1LtVYjzyQLAhsG1vCyJh6O5SlCdUWMrXhyr0zoAxsTInjcmWCS
	MYk8fazvPZ0TOdYKyWcEg6WmHpg92sjJY3hIOBMmtmv3etrAhYKYqcVg61vcjWisKDtaoLY3vqh58
	LN7uvDWjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gott4-0000vE-61; Wed, 30 Jan 2019 17:42:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gott0-0000uP-GE
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:42:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF8E280D;
 Wed, 30 Jan 2019 09:42:53 -0800 (PST)
Received: from [10.37.12.221] (unknown [10.37.12.221])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71043F557;
 Wed, 30 Jan 2019 09:42:49 -0800 (PST)
Subject: Re: [PATCH v2 2/7] coresight: perf: Add "sinks" group to PMU directory
To: mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
 <20190122181144.26645-3-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <aed8011b-5487-a30a-559f-e0daf2867f67@arm.com>
Date: Wed, 30 Jan 2019 17:44:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190122181144.26645-3-mathieu.poirier@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_094254_551009_FB63944E 
X-CRM114-Status: GOOD (  29.66  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org,
 alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com,
 ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,


On 01/22/2019 06:11 PM, Mathieu Poirier wrote:
> Add a "sinks" directory entry so that users can see all the sinks
> available in the system in a single place.  Individual sink are added
> as they are registered with the coresight bus.

A couple of minor comments.

> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 76 +++++++++++++++++++
>   .../hwtracing/coresight/coresight-etm-perf.h  |  6 +-
>   drivers/hwtracing/coresight/coresight.c       | 18 +++++
>   include/linux/coresight.h                     |  7 +-
>   4 files changed, 104 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f21eb28b6782..c68a0036532c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -14,6 +14,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/percpu-defs.h>
>   #include <linux/slab.h>
> +#include <linux/stringhash.h>
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>   
> @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
>   	.attrs  = etm_config_formats_attr,
>   };
>   
> +static struct attribute *etm_config_sinks_attr[] = {
> +	NULL,
> +};
> +
> +static const struct attribute_group etm_pmu_sinks_group = {
> +	.name   = "sinks",
> +	.attrs  = etm_config_sinks_attr,
> +};
> +
>   static const struct attribute_group *etm_pmu_attr_groups[] = {
>   	&etm_pmu_format_group,
> +	&etm_pmu_sinks_group,
>   	NULL,
>   };

I was thinking if this could be the "events" directory for ETM pmu. We
don't have any other event codes. Even if we get in the future, we could
expose them here. But from a quick try it looks like the event names
cannot start with a number (e.g, 2007000.etr wouldn't parse as an event
name). So we could leave this as above and switch when we get generic
naming scheme.

>   
> @@ -479,6 +490,71 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>   	return 0;
>   }
>   
> +static ssize_t etm_perf_sink_name_show(struct device *dev,
> +				       struct device_attribute *dattr,
> +				       char *buf)
> +{
> +	/* See function coresight_get_sink_by_id() to know where this is used */
> +	u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> +
> +	return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> +}

You may need "0x%x" to avoid confusions interpreting the data.

> +
> +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +{
> +	int ret;
> +	struct device *pmu_dev = etm_pmu.dev;
> +	struct device *pdev = csdev->dev.parent;
> +	struct device_attribute *dattr;

If we make this a struct dev_ext_attribute(), you get a space to
store the "id" in the "var" field. This can be used for

1) name_show() above

we could do :
	struct dev_ext_attribute *eattr = container_of(attr,
					struct dev_ext_attribute, attr);

	return scnprintf(bu, PAGE_SIZE, "0x%x\n", (u32)eattr->var);

2) Matching the ID of a sink device in lookup by simply doing :
	(u32)csdev->dattr.var == (u32)(void *)data

and can avoid computing the hash all the time.

> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return -EINVAL;
> +
> +	if (csdev->dattr != NULL)
> +		return -EINVAL;
> +
> +	if (!etm_perf_up)
> +		return -EPROBE_DEFER;
> +
> +	dattr = kzalloc(sizeof(*dattr), GFP_KERNEL);

nit: Could we use devm_kzalloc(pdev, ...) ?

> +	dattr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);.


similarly here : devm_kstrdup()

> +	dattr->attr.mode = 0444;
> +	dattr->show = etm_perf_sink_name_show;
> +	csdev->dattr = dattr;
> +
> +	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> +				      &dattr->attr, "sinks");
> +
> +	if (!ret)
> +		return 0;
> +
> +	csdev->dattr = NULL;
> +	kfree(dattr->attr.name);
> +	kfree(dattr);

And we could get rid of these ^

> +
> +	return ret;
> +}
> +
> +void etm_perf_del_symlink_sink(struct coresight_device *csdev)
> +{
> +	struct device *pmu_dev = etm_pmu.dev;
> +	struct device_attribute *dattr = csdev->dattr;
> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return;
> +
> +	if (!dattr)
> +		return;
> +
> +	sysfs_remove_file_from_group(&pmu_dev->kobj,
> +				     &dattr->attr, "sinks");
> +	csdev->dattr = NULL;
> +	kfree(dattr->attr.name);
> +	kfree(dattr);ext

And these ^^

> +}


> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 46c67a764877..a42fac83eac9 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -154,8 +154,9 @@ struct coresight_connection {
>    * @orphan:	true if the component has connections that haven't been linked.
>    * @enable:	'true' if component is currently part of an active path.
>    * @activated:	'true' only if a _sink_ has been activated.  A sink can be
> -		activated but not yet enabled.  Enabling for a _sink_
> -		happens when a source has been selected for that it.
> + *		activated but not yet enabled.  Enabling for a _sink_
> + *		appens when a source has been selected for that it.
> + * @dattr:	Device attribute for sink representation under PMU directory.
>    */
>   struct coresight_device {
>   	struct coresight_connection *conns;
> @@ -168,7 +169,9 @@ struct coresight_device {
>   	atomic_t *refcnt;
>   	bool orphan;
>   	bool enable;	/* true only if configured as part of a path */
> +	/* sink specific fields */
>   	bool activated;	/* true only if a sink is part of a path */
> +	struct device_attribute *dattr;

See my comment above about switching to struct dev_ext_attribute *.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
