Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA19C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788FD21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YmFV4LUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788FD21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gt8s6PYupOD5zwPb+ojvzqOdASvfGz/ECtEu9GYAXF8=; b=YmFV4LUyeTldXl
	uT3dAoEZjMq7T8hO5iohkNN9IdyDRHhJ03Qb+XmghWLaj7ne4BODy+/lK8CPlHpxJZIE9rZMhIV2l
	0iK41n1mM1P+YxoAgrLcQHaOXCBGYY1Ujb3M6ALwr1vaFxh/41T3D1ZJ6PF7d44lzUjDyNt9IWoiN
	YzpwsO2Vk3FJZcozqYSoz3ISUxzp0oeHXkrqBulByxxtTTq2Pv8qsZ7FiV74a7YaGzihLM1vib7Dp
	L4+LZ+0Jn8eGZl7GDI74u9h9yqv6frZzF6BoYPLt0whe5+MWPMzWvxKr7jEkKZVqskN16NLC1rf60
	/vrFl/TxL6c6V5M60Qxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMR8-0004rK-2F; Fri, 04 Jan 2019 10:10:42 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMR4-0004qA-6J
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 10:10:39 +0000
Received: by mail-oi1-f194.google.com with SMTP id t204so29981492oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 02:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yt4HNDl09ieCjuS/nsDwyzqPPyZth8+B5W1jjboCKV0=;
 b=nCIaHZ1+OHAuOxGzq+o4R6m5x/+CKV7AORG8JEdLVVYQGdGPpzZiVM1YJMs7QSZLzT
 0XL0PoeMw3ahOm5FFRKAviuLxoB5s+ErDW190UEgxHm+2MG64mIKD8LWxRZnQzlueW4E
 7SyTxRnZ/Qs5SEbdDId6OSUKPByVrjukSjaGAne9hgC/fZPVfNELCvjJNMFvsHKLTbES
 USYWFpmPDiXGdbmcxgobQAcX8HzqDI4aoAIVq+mlNt6VYNB6l8As+pb9ydDhsDI2vwYc
 pEYMAjYb69fvZq+aWKHqCJL3qDWvyzIwzwzBcdLJ762kzkqf0B/YSma1ixppYv82b06I
 yP9w==
X-Gm-Message-State: AA+aEWbJYM+rFAo5eBIzxn0dX4AmQ9Z9xgKPDbXIgboEAakBZmVLnKWL
 NA1khX88QxCFz6R+Lh/xG3fkLzm8fLWAAv6laEc=
X-Google-Smtp-Source: AFSGD/XFImHUJZ1/VGSZTFmgKvxWWynKWrJPNOCA19FJ2eCGHpS28SoW0F6f/SfKWUm/vUaZ1jF5XWbypNAFa5ipNpA=
X-Received: by 2002:aca:b642:: with SMTP id g63mr32191553oif.195.1546596636553; 
 Fri, 04 Jan 2019 02:10:36 -0800 (PST)
MIME-Version: 1.0
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
In-Reply-To: <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Jan 2019 11:10:25 +0100
Message-ID: <CAJZ5v0g4ABiPGGeLuzLN=1cT+7ejUP5hCgoN3_nhvr=Foaxa6Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_021038_274088_1E9C6445 
X-CRM114-Status: GOOD (  23.55  )
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
Cc: Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "4 . 20" <stable@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Quentin Perret <quentin.perret@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Douglas.Raillard@arm.com, Valentin Schneider <valentin.schneider@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 10:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> failures or on invocations of the policy->exit() callback.
>
> Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> called from these drivers instead of dev_pm_opp_cpumask_remove_table().
>
> In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> opp_list isn't getting accessed simultaneously from other parts of the
> OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> the opp_table->lock while traversing through the OPP list. And to
> accomplish that, this patch also creates _opp_kref_release_unlocked()
> which can be called from this new helper with the opp_table lock already
> held.
>
> Cc: 4.20 <stable@vger.kernel.org> # v4.20
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I guess I'll pick it up by hand.

I'm assuming that you have tested it, have you?

> ---
>  drivers/cpufreq/scmi-cpufreq.c |  4 +--
>  drivers/cpufreq/scpi-cpufreq.c |  4 +--
>  drivers/opp/core.c             | 63 +++++++++++++++++++++++++++++++---
>  include/linux/pm_opp.h         |  5 +++
>  4 files changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 50b1551ba894..c2e66528f5ee 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -176,7 +176,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  out_free_priv:
>         kfree(priv);
>  out_free_opp:
> -       dev_pm_opp_cpumask_remove_table(policy->cpus);
> +       dev_pm_opp_remove_all_dynamic(cpu_dev);
>
>         return ret;
>  }
> @@ -188,7 +188,7 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>         cpufreq_cooling_unregister(priv->cdev);
>         dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>         kfree(priv);
> -       dev_pm_opp_cpumask_remove_table(policy->related_cpus);
> +       dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
>
>         return 0;
>  }
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 87a98ec77773..99449738faa4 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -177,7 +177,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  out_free_priv:
>         kfree(priv);
>  out_free_opp:
> -       dev_pm_opp_cpumask_remove_table(policy->cpus);
> +       dev_pm_opp_remove_all_dynamic(cpu_dev);
>
>         return ret;
>  }
> @@ -190,7 +190,7 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
>         clk_put(priv->clk);
>         dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>         kfree(priv);
> -       dev_pm_opp_cpumask_remove_table(policy->related_cpus);
> +       dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
>
>         return 0;
>  }
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e5507add8f04..18f1639dbc4a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -988,11 +988,9 @@ void _opp_free(struct dev_pm_opp *opp)
>         kfree(opp);
>  }
>
> -static void _opp_kref_release(struct kref *kref)
> +static void _opp_kref_release(struct dev_pm_opp *opp,
> +                             struct opp_table *opp_table)
>  {
> -       struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
> -       struct opp_table *opp_table = opp->opp_table;
> -
>         /*
>          * Notify the changes in the availability of the operable
>          * frequency/voltage list.
> @@ -1002,7 +1000,22 @@ static void _opp_kref_release(struct kref *kref)
>         opp_debug_remove_one(opp);
>         list_del(&opp->node);
>         kfree(opp);
> +}
>
> +static void _opp_kref_release_unlocked(struct kref *kref)
> +{
> +       struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
> +       struct opp_table *opp_table = opp->opp_table;
> +
> +       _opp_kref_release(opp, opp_table);
> +}
> +
> +static void _opp_kref_release_locked(struct kref *kref)
> +{
> +       struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
> +       struct opp_table *opp_table = opp->opp_table;
> +
> +       _opp_kref_release(opp, opp_table);
>         mutex_unlock(&opp_table->lock);
>  }
>
> @@ -1013,10 +1026,16 @@ void dev_pm_opp_get(struct dev_pm_opp *opp)
>
>  void dev_pm_opp_put(struct dev_pm_opp *opp)
>  {
> -       kref_put_mutex(&opp->kref, _opp_kref_release, &opp->opp_table->lock);
> +       kref_put_mutex(&opp->kref, _opp_kref_release_locked,
> +                      &opp->opp_table->lock);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_put);
>
> +static void dev_pm_opp_put_unlocked(struct dev_pm_opp *opp)
> +{
> +       kref_put(&opp->kref, _opp_kref_release_unlocked);
> +}
> +
>  /**
>   * dev_pm_opp_remove()  - Remove an OPP from OPP table
>   * @dev:       device for which we do this operation
> @@ -1060,6 +1079,40 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
>
> +/**
> + * dev_pm_opp_remove_all_dynamic() - Remove all dynamically created OPPs
> + * @dev:       device for which we do this operation
> + *
> + * This function removes all dynamically created OPPs from the opp table.
> + */
> +void dev_pm_opp_remove_all_dynamic(struct device *dev)
> +{
> +       struct opp_table *opp_table;
> +       struct dev_pm_opp *opp, *temp;
> +       int count = 0;
> +
> +       opp_table = _find_opp_table(dev);
> +       if (IS_ERR(opp_table))
> +               return;
> +
> +       mutex_lock(&opp_table->lock);
> +       list_for_each_entry_safe(opp, temp, &opp_table->opp_list, node) {
> +               if (opp->dynamic) {
> +                       dev_pm_opp_put_unlocked(opp);
> +                       count++;
> +               }
> +       }
> +       mutex_unlock(&opp_table->lock);
> +
> +       /* Drop the references taken by dev_pm_opp_add() */
> +       while (count--)
> +               dev_pm_opp_put_opp_table(opp_table);
> +
> +       /* Drop the reference taken by _find_opp_table() */
> +       dev_pm_opp_put_opp_table(opp_table);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
> +
>  struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>  {
>         struct dev_pm_opp *opp;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0a2a88e5a383..b895f4e79868 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -108,6 +108,7 @@ void dev_pm_opp_put(struct dev_pm_opp *opp);
>  int dev_pm_opp_add(struct device *dev, unsigned long freq,
>                    unsigned long u_volt);
>  void dev_pm_opp_remove(struct device *dev, unsigned long freq);
> +void dev_pm_opp_remove_all_dynamic(struct device *dev);
>
>  int dev_pm_opp_enable(struct device *dev, unsigned long freq);
>
> @@ -217,6 +218,10 @@ static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
>  {
>  }
>
> +static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
> +{
> +}
> +
>  static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
>  {
>         return 0;
> --
> 2.19.1.568.g152ad8e3369a
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
