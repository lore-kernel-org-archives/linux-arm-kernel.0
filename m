Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A47C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:45:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5919320867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YNXE+kMr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iDhQfYA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5919320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1J8cCo6NTYeQKxAoNzfGj7loS6a8gJHPp8S8Cw6M6f0=; b=YNXE+kMry/V/Wi
	++U3lGzxtSiG/BPpVlzu+Ke5dwEKrd00tpGsZOovG7t8L4w2a0jp5Ad9c0TNRWr/Ej+rn9coW4iPy
	0iPYrgytcivd74bXD3i/NGU8VoHU226G0EQzCZfQ3/bhyhSgXWFqb8RhM+69ezdD+yh26RrRuwhcU
	R1eWPJtGBf0f8r4C9yNoAH9SWPm0UZ5CtQYOQJ5MJqKZBws1ou4tTPlYikQhXyzPfY8ojY9/cgEJ0
	hDTSM3JCAX2piE57INWNuvtlUY6KRokkMPzCn2lLqacni2KhbKxVi0133bn31tJG1k3sTNHfsUEuU
	jJUHrWKrxSLkCaI2wfCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gStPS-0000Gi-JG; Sat, 01 Dec 2018 00:45:26 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gStPA-0007AO-J9
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:45:10 +0000
Received: by mail-lj1-x244.google.com with SMTP id u6-v6so6558248ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UD6TIdHtwPYHyPraYlY6EfBE20VicGPgtEp08k6yp8w=;
 b=iDhQfYA+ZnBx5PEjUC1WPtrfI7Xjt5/Ys66e89tiREQIk1TBgFoQuc7SATPeGb6odr
 UrgtnNpTpCTL6QTKKU5BWmwe3T6jiNL6s3OP5FUeELJ6wfrDSBx9ZKKrztvM05hnMZyw
 OqdpH7bwLsm10N9sG8UUmnsDBj9QAwlT9pquM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UD6TIdHtwPYHyPraYlY6EfBE20VicGPgtEp08k6yp8w=;
 b=lSMOjTRRnTc3+LpkalpSztNehSS0nFsyeJtMaM1aAjqB1h2Et5xA4+AB7VjaWObHjG
 c34qyfJwgJIA1vQZmS9zRUHU0sRFtwvPI+e3QNz5SmZbCN4eGes0v2mg6R2I0VgkEQTP
 1QdgFYg+7xJX3J5442yRWhT84y9csN+ES7s0u1Uoji4u0Vni3xQuPA3ft9RmCUCbxvcw
 siNcYJHD9CrKO5mjROHcwKI1LmvhoCOWwDmErpcjpiREv2Pl4P5RzeBHc5vVBtWQrB0u
 No+0pGcYCvNa1wEbnGeP0Q/X8R5ebr+buXVqhRoCDuCz2xnSxwyZH16/fhyuhZgFbko9
 DYXg==
X-Gm-Message-State: AA+aEWZMRYhKr4MGZiwdkwhZ6YMxap6M2vGvyiADVuM7X+KJusfYlLIo
 OEcnwYnclSAn9B37jA6hwWAr4KtDwt0=
X-Google-Smtp-Source: AFSGD/WNjuG8d90jdiM2+PbIyXsLVcA/q6Bhic0yBR4MtGutD5xpbfc7kur7Y6RZPYkyZDVje6W2yQ==
X-Received: by 2002:a2e:97d7:: with SMTP id
 m23-v6mr2544656ljj.18.1543625095924; 
 Fri, 30 Nov 2018 16:44:55 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id j76-v6sm1062924ljb.12.2018.11.30.16.44.55
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 16:44:55 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id t9-v6so6531990ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:44:55 -0800 (PST)
X-Received: by 2002:a2e:5152:: with SMTP id
 b18-v6mr4451636lje.88.1543624736801; 
 Fri, 30 Nov 2018 16:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-4-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-4-georgi.djakov@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 30 Nov 2018 16:38:20 -0800
X-Gmail-Original-Message-ID: <CAE=gft5Z7-Ri07iZesq57bqLpsStvJF3y_TSm+Cz=h-pGqJzyw@mail.gmail.com>
Message-ID: <CAE=gft5Z7-Ri07iZesq57bqLpsStvJF3y_TSm+Cz=h-pGqJzyw@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] interconnect: Allow endpoints translation via DT
To: georgi.djakov@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_164508_658320_C0FF2B27 
X-CRM114-Status: GOOD (  31.50  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 thierry.reding@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may lead to complications when a single driver is used by multiple
> SoCs, which may have different interconnect topology.
> To avoid cluttering the consumer drivers, introduce a translation function
> to help us get the board specific interconnect data from device-tree.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c           | 156 ++++++++++++++++++++++++++
>  include/linux/interconnect-provider.h |  17 +++
>  include/linux/interconnect.h          |   7 ++
>  3 files changed, 180 insertions(+)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 3ae8e5a58969..ebc42ef9fa46 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <linux/overflow.h>
>
>  static DEFINE_IDR(icc_idr);
> @@ -193,6 +194,159 @@ static int apply_constraints(struct icc_path *path)
>         return ret;
>  }
>
> +/* of_icc_xlate_onecell() - Xlate function using a single index.

It would be nice if translate were spelled out instead of xlate in the
description portion (throughout).

> + * @spec: OF phandle args to map into an interconnect node.
> + * @data: private data (pointer to struct icc_onecell_data)
> + *
> + * This is a generic xlate function that can be used to model simple
> + * interconnect providers that have one device tree node and provide
> + * multiple interconnect nodes. A single cell is used as an index into
> + * an array of icc nodes specified in the icc_onecell_data struct when
> + * registering the provider.
> + */
> +struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
> +                                     void *data)
> +{
> +       struct icc_onecell_data *icc_data = data;
> +       unsigned int idx = spec->args[0];
> +
> +       if (idx >= icc_data->num_nodes) {
> +               pr_err("%s: invalid index %u\n", __func__, idx);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return icc_data->nodes[idx];
> +}
> +EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
> +
> +/**
> + * of_icc_get_from_provider() - Look-up interconnect node
> + * @spec: OF phandle args to use for look-up
> + *
> + * Looks for interconnect provider under the node specified by @spec and if
> + * found, uses xlate function of the provider to map phandle args to node.
> + *
> + * Returns a valid pointer to struct icc_node on success or ERR_PTR()
> + * on failure.
> + */
> +static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> +{
> +       struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
> +       struct icc_provider *provider;
> +
> +       if (!spec)
> +               return ERR_PTR(-EINVAL);
> +
> +       mutex_lock(&icc_lock);
> +       list_for_each_entry(provider, &icc_providers, provider_list) {
> +               if (provider->dev->of_node == spec->np)
> +                       node = provider->xlate(spec, provider->data);
> +               if (!IS_ERR(node))
> +                       break;
> +       }
> +       mutex_unlock(&icc_lock);
> +
> +       return node;
> +}
> +
> +/**
> + * of_icc_get() - get a path handle from a DT node based on name
> + * @dev: device pointer for the consumer device
> + * @name: interconnect path name
> + *
> + * This function will search for a path two endpoints and return an

path between two endpoints

> + * icc_path handle on success. Use icc_put() to release constraints when
> + * they are not needed anymore.
> + * If the interconnect API is disabled, NULL is returned and the consumer
> + * drivers will still build. Drivers are free to handle this specifically,
> + * but they don't have to. NULL is also returned when the "interconnects"

I'm not sure the sentence starting with "Drivers are free" adds much.
Also, you mention that null is returned when the interconnect API is
disabled both above and below. We probably only need it once.

> + * DT property is missing.
> + *
> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
> + * when the API is disabled or the "interconnects" DT property is missing.
> + */
> +struct icc_path *of_icc_get(struct device *dev, const char *name)
> +{
> +       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> +       struct icc_node *src_node, *dst_node;
> +       struct device_node *np = NULL;
> +       struct of_phandle_args src_args, dst_args;
> +       int idx = 0;
> +       int ret;
> +
> +       if (!dev || !dev->of_node)
> +               return ERR_PTR(-ENODEV);
> +
> +       np = dev->of_node;
> +
> +       /*
> +        * When the consumer DT node do not have "interconnects" property
> +        * return a NULL path to skip setting constraints.
> +        */
> +       if (!of_find_property(np, "interconnects", NULL))
> +               return NULL;
> +
> +       /*
> +        * We use a combination of phandle and specifier for endpoint. For now
> +        * lets support only global ids and extend this is the future if needed

s/is the future/in the future/

> +        * without breaking DT compatibility.
> +        */
> +       if (name) {
> +               idx = of_property_match_string(np, "interconnect-names", name);
> +               if (idx < 0)
> +                       return ERR_PTR(idx);
> +       }
> +
> +       ret = of_parse_phandle_with_args(np, "interconnects",
> +                                        "#interconnect-cells", idx * 2,
> +                                        &src_args);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       of_node_put(src_args.np);
> +
> +       if (!src_args.args_count || src_args.args_count > 1)

This could be src_args.argc_count != 1

> +               return ERR_PTR(-EINVAL);
> +
> +       ret = of_parse_phandle_with_args(np, "interconnects",
> +                                        "#interconnect-cells", idx * 2 + 1,
> +                                        &dst_args);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       of_node_put(dst_args.np);
> +
> +       if (!dst_args.args_count || dst_args.args_count > 1)

Similarly, this could be dst_args.args_count != 1

> +               return ERR_PTR(-EINVAL);
> +
> +       src_node = of_icc_get_from_provider(&src_args);
> +
> +       if (IS_ERR(src_node)) {
> +               if (PTR_ERR(src_node) != -EPROBE_DEFER)
> +                       dev_err(dev, "error finding src node: %ld\n",
> +                               PTR_ERR(src_node));
> +               return ERR_CAST(src_node);
> +       }
> +
> +       dst_node = of_icc_get_from_provider(&dst_args);
> +
> +       if (IS_ERR(dst_node)) {
> +               if (PTR_ERR(dst_node) != -EPROBE_DEFER)
> +                       dev_err(dev, "error finding dst node: %ld\n",
> +                               PTR_ERR(dst_node));
> +               return ERR_CAST(dst_node);
> +       }
> +
> +       mutex_lock(&icc_lock);
> +       path = path_find(dev, src_node, dst_node);
> +       if (IS_ERR(path))
> +               dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +       mutex_unlock(&icc_lock);
> +
> +       return path;
> +}
> +EXPORT_SYMBOL_GPL(of_icc_get);
> +
>  /**
>   * icc_set() - set constraints on an interconnect path between two endpoints
>   * @path: reference to the path returned by icc_get()
> @@ -521,6 +675,8 @@ int icc_provider_add(struct icc_provider *provider)
>  {
>         if (WARN_ON(!provider->set))
>                 return -EINVAL;
> +       if (WARN_ON(!provider->xlate))
> +               return -EINVAL;
>
>         mutex_lock(&icc_lock);
>
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 78208a754181..63caccadc2db 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -12,6 +12,21 @@
>  #define icc_units_to_bps(bw)  ((bw) * 1000ULL)
>
>  struct icc_node;
> +struct of_phandle_args;
> +
> +/**
> + * struct icc_onecell_data - driver data for onecell interconnect providers
> + *
> + * @num_nodes: number of nodes in this device
> + * @nodes: array of pointers to the nodes in this device
> + */
> +struct icc_onecell_data {
> +       unsigned int num_nodes;
> +       struct icc_node *nodes[];
> +};
> +
> +struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
> +                                     void *data);
>
>  /**
>   * struct icc_provider - interconnect provider (controller) entity that might
> @@ -21,6 +36,7 @@ struct icc_node;
>   * @nodes: internal list of the interconnect provider nodes
>   * @set: pointer to device specific set operation function
>   * @aggregate: pointer to device specific aggregate operation function
> + * @xlate: provider-specific callback for mapping nodes from phandle arguments
>   * @dev: the device this interconnect provider belongs to
>   * @users: count of active users
>   * @data: pointer to private data
> @@ -31,6 +47,7 @@ struct icc_provider {
>         int (*set)(struct icc_node *src, struct icc_node *dst);
>         int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
>                          u32 *agg_avg, u32 *agg_peak);
> +       struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
>         struct device           *dev;
>         int                     users;
>         void                    *data;
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 04b2966ded9f..41f7ecc2f20f 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -26,6 +26,7 @@ struct device;
>
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>                          const int dst_id);
> +struct icc_path *of_icc_get(struct device *dev, const char *name);
>  void icc_put(struct icc_path *path);
>  int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>
> @@ -37,6 +38,12 @@ static inline struct icc_path *icc_get(struct device *dev, const int src_id,
>         return NULL;
>  }
>
> +static inline struct icc_path *of_icc_get(struct device *dev,
> +                                         const char *name)
> +{
> +       return NULL;
> +}
> +
>  static inline void icc_put(struct icc_path *path)
>  {
>  }

With these nits fixed:

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
