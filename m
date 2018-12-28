Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998BB20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EUTSLAF7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJJtLhYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998BB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lb3gSP0XScXBXINej+wDYq8gSKwJT3IuZh0pJ0LBK2M=; b=EUTSLAF7hizXAZ
	dOVNopIJp38UBK7Reamljp9AeQXiALZRpXUolNHkjwLQbsQh0eMsHStPiPK3qxw1qt863BPf/fTSS
	MWF872+uhHp4Q35TMjfVQCdhDis9jugkLkDIVkLEdyo3lWBAXjnNjaa4nVH2uaD1UrpP8Pq9XEDRn
	MowWHxcNufqSS9VpVRaEsRhyqmLkdRUEhj2B7QAAMvWrWcP5CMGHoSuXiLn0LIwa85zDACjCyj9Ta
	eF86wbDBzkmq4HXYG1wgGzXVdnX+c6iZ8VmzeoKYPYKQuknCgKZsz44VUlziDvfMUQn7/dBnM4jAR
	V73VnI3neSAuh90IT/oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcuCm-0007MS-13; Fri, 28 Dec 2018 15:37:44 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuCh-0007LB-QM
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 15:37:41 +0000
Received: by mail-vs1-xe44.google.com with SMTP id p74so13189260vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YeoCcLIO6TBLl7FrMpKnuYcluO173e+MPWd9CDhxy/Y=;
 b=CJJtLhYnwGPturDSXtLn+1tZsCwTm8uY2tgJfviLACaoCGAsFFKazaWsqTziOZBi0Y
 7AuPxLEEDfBdOZPHdcgaVFajfIM0Gqn8c9ACU8wdy3lCD7dzK9XzboBjfeJF15+WJcD0
 /AgQcNMov2LQxMufo/0xdG5+lK++oARnlvV6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YeoCcLIO6TBLl7FrMpKnuYcluO173e+MPWd9CDhxy/Y=;
 b=MNiyfWkl/usXzwkKWa4HMRBbk0cG3GqINPm1oYCQ8RxyZp8yuFilVW2EG2V5PDF0W4
 40ypo0j+W39EEKWzWki9/rAsKwZ6kiQ/RhftETXIyvm3MCzKpXzaIuyJy8A8WyTzSubq
 cccSW3PDf3s0KPzA/VsSSC6ghj1CRIXvkigOKXSEEXN5Hb0lQnpHdA3seR8cQJXrgnUo
 uvLDcziKIrb/YtlW1Y5Q2igLxcS/htY1aiZv4YaltJZUs7EsGAx9Tn2WnL/XxFGwf0RN
 HenaUtkuHXQPq8wvKxJNzrD6e5a/f/n2AzSQlpg9VAkGOzeh3WSSwRjL1jPfljYxDhGU
 XxjQ==
X-Gm-Message-State: AA+aEWZwxG9J3DmJuHWQcNR95mo8/aEY0FkGL5IfbtJGt9JHRwoV/xDT
 Ul4r47/J9uuOnG13+cqvq+518WtFz5W/guDYCUpOznZwWiA=
X-Google-Smtp-Source: AFSGD/UjQAa2h1RvbXMs7pyY62Lh+9nGDi3adnyLAAg/kB3UCIAXowF7RuELRup3Nv5wZ/Yij/SjtWYerB16zOPDNjI=
X-Received: by 2002:a67:7685:: with SMTP id r127mr11255532vsc.35.1546011448292; 
 Fri, 28 Dec 2018 07:37:28 -0800 (PST)
MIME-Version: 1.0
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 28 Dec 2018 16:36:52 +0100
Message-ID: <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_073739_855560_BC413125 
X-CRM114-Status: GOOD (  32.17  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 27 Dec 2018 at 18:14, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Currently attach_dev() in power domain infrastructure still does
> not support multi domains case as the struct device *dev passed
> down from genpd_dev_pm_attach_by_id() is a virtual PD device, it
> does not help for parsing the real device information from device
> tree, e.g. Device/Power IDs, Clocks and it's unware of which real
> power domain the device should attach.

Thanks for working on this!

I would appreciate if the changelog could clarify the problem a bit.
Perhaps something along the lines of the below.

"A genpd provider's ->attach_dev() callback may be invoked with a so
called virtual device, which is created by genpd, at the point when a
device is being attached to one of its corresponding multiple PM
domains.

In these cases, the genpd provider fails to look up any resource, by a
clk_get() for example, for the virtual device in question. This is
because, the virtual device that was created by genpd, does not have
the virt_dev->of_node assigned."

>
> Extend the framework a bit to store the multi PM domains information
> in per-device struct generic_pm_domain_data, then power domain driver
> could retrieve it for necessary operations during attach_dev().
>
> Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are also
> introduced to ease the driver operation.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> This patch is a follow-up work of the earlier discussion with Ulf Hansson
> about the multi PM domains support for the attach_dev() function [1].
> After a bit more thinking, this is a less intrusive implementation with
> the mininum impact on the exist function definitions and calling follows.
> One known little drawback is that we have to use the device driver private
> data (device.drvdata) to pass down the multi domains information in a
> earlier time. However, as multi PD devices are created by domain framework,
> this seems to be safe to use it in domain core code as device driver
> is not likely going to use it.
> Anyway, if any better ideas, please let me know.
>
> With the two new APIs, the using can be simply as:
> static int xxx_attach_dev(struct generic_pm_domain *domain,
>                           struct device *dev)
> {
>         ...
>         if (genpd_is_mpd_device(dev)) {
>                 mpd_data = dev_gpd_mpd_data(dev);
>                 np = mpd_data->parent->of_node;
>                 idx = mpd_data->index;
>                 //dts parsing
>                 ...
>         }
>         ...

I think we can make this a lot less complicated. Just assign
virt_dev->of_node = of_node_get(dev->of_node), somewhere in
genpd_dev_pm_attach_by_id() and before calling
__genpd_dev_pm_attach().

Doing that, would mean the genpd provider's ->attach_dev() callback,
don't have to distinguish between virtual and non-virtual devices.
Instead they should be able to look up resources in the same way as
they did before.

Kind regards
Uffe

> }
>
> [1] https://patchwork.kernel.org/patch/10658669/
> ---
>  drivers/base/power/domain.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 23 +++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7f38a92..1aa0918 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1343,6 +1343,9 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
>         gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
>
> +       if (genpd_is_mpd_device(dev))
> +               gpd_data->mpd_data = dev_get_drvdata(dev);
> +
>         spin_lock_irq(&dev->power.lock);
>
>         if (dev->power.subsys_data->domain_data) {
> @@ -2179,6 +2182,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_last);
>
>  static void genpd_release_dev(struct device *dev)
>  {
> +       kfree(dev->driver_data);
>         kfree(dev);
>  }
>
> @@ -2320,6 +2324,20 @@ int genpd_dev_pm_attach(struct device *dev)
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>
>  /**
> + * genpd_is_mpd_device - Check if a device is associated with multi PM domains
> + * @dev: Device to check.
> + */
> +
> +bool genpd_is_mpd_device(struct device *dev)
> +{
> +       if (!dev || (dev && !dev->bus))
> +               return false;
> +
> +       return dev->bus == &genpd_bus_type;
> +};
> +EXPORT_SYMBOL_GPL(genpd_is_mpd_device);
> +
> +/**
>   * genpd_dev_pm_attach_by_id - Associate a device with one of its PM domains.
>   * @dev: The device used to lookup the PM domain.
>   * @index: The index of the PM domain.
> @@ -2338,6 +2356,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                                          unsigned int index)
>  {
> +       struct pm_domain_mpd_data *mpd_data;
>         struct device *genpd_dev;
>         int num_domains;
>         int ret;
> @@ -2366,6 +2385,18 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                 return ERR_PTR(ret);
>         }
>
> +       /* Allocate multi power domains data */
> +       mpd_data = kzalloc(sizeof(*mpd_data), GFP_KERNEL);
> +       if (!mpd_data) {
> +               device_unregister(genpd_dev);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       mpd_data->parent = dev;
> +       mpd_data->index = index;
> +
> +       dev_set_drvdata(genpd_dev, mpd_data);
> +
>         /* Try to attach the device to the PM domain at the specified index. */
>         ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index, false);
>         if (ret < 1) {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3b5d728..106d4e7 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -144,6 +144,11 @@ struct gpd_timing_data {
>         bool cached_suspend_ok;
>  };
>
> +struct pm_domain_mpd_data {
> +       struct device *parent;
> +       unsigned int index;
> +};
> +
>  struct pm_domain_data {
>         struct list_head list_node;
>         struct device *dev;
> @@ -151,6 +156,7 @@ struct pm_domain_data {
>
>  struct generic_pm_domain_data {
>         struct pm_domain_data base;
> +       struct pm_domain_mpd_data *mpd_data;
>         struct gpd_timing_data td;
>         struct notifier_block nb;
>         unsigned int performance_state;
> @@ -262,10 +268,17 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>                                 struct device_node *np);
>
>  int genpd_dev_pm_attach(struct device *dev);
> +bool genpd_is_mpd_device(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                                          unsigned int index);
>  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>                                            char *name);
> +
> +static inline struct pm_domain_mpd_data *dev_gpd_mpd_data(struct device *dev)
> +{
> +       return dev_gpd_data(dev)->mpd_data;
> +}
> +
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>                                         struct generic_pm_domain *genpd)
> @@ -311,6 +324,11 @@ static inline int genpd_dev_pm_attach(struct device *dev)
>         return 0;
>  }
>
> +static bool genpd_is_mpd_device(struct device *dev)
> +{
> +       return false;
> +}
> +
>  static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                                                        unsigned int index)
>  {
> @@ -323,6 +341,11 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>         return NULL;
>  }
>
> +static inline struct pm_domain_mpd_data *dev_gpd_mpd_data(struct device *dev)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
>  static inline
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
