Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:39:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B216F2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hnPoZ2Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B216F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4t9l12Kl4jSXPMIltbHOw2fHaC/k8PCOPpbLICatixc=; b=hnPoZ2Lwmps60Y
	11CaIjifUXcKsvrgpP4pY3h5AAxj8Q0iakHjbbFCZ/ugOhLZsoLVdgDkopXClCn9r/0/xgov4vI+A
	PLHhgalJCuR3EK4uXEmusOVyuQuHBtI20QuN321e9xHojMHlSqXFuRF0Hfa0lEAOdfiXzngUgXnvM
	Wr+vSHy6sqtKGaJoVUaHuZLQN2GXAACavWaaZYwV59T/IjzQuKDPoar0lTeaMWLECE/bUCNcSrQbx
	quu6C/CI0/q7lztD4tJMw9UO6GLV/T5YsNnZGWNluaUQAmRClRaWjl2u6ysWrRcRiPMD3pHKI7F7g
	BgcS0VLXgJBofQORtk+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt8G-0002CN-Rd; Mon, 03 Dec 2018 18:39:48 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt8C-0002BF-Qp
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:39:46 +0000
Received: by mail-ot1-f65.google.com with SMTP id i20so12614416otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 10:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6n/oxCL8XduT0iPyabgGeKYtciBEEj11+xCAlfZn8pA=;
 b=Ae8QDRnYZHKUClcGOCv8suOZdJQI4oUW1xs5UxEkGIsG65VVzRseSIuWQ01C6uZS6I
 1B8clxCwOGNHZlpPoFBG8lIaqEUdHUhiqMGcm7vJKjp8cb78I91ehy9MMgAttLY1eG1I
 aGpE4SyqKMQ0b0QPA3cMa+63QXxRb0g0wB9L0C+PqKO10ia6p3Dsq62xV1nUvCWLDAH1
 dJ431MzSpCmyj674l4ZDWCV8VY2xXgHLVVYpqM7bematec0EW1ym2VVgKmsSNwW6sjUT
 TKaZvnP08wri+BRmg1Lrvc1Ncz3SXIRN/egH1zeqYxrpM8C1ERMEQ3E7PUysGwaotzIW
 caww==
X-Gm-Message-State: AA+aEWZeAgv0LRcdafNuKBG5RrSe52Y7TQHZGjG5OisIthXOOJRhX/3K
 gymfaM42f/xEQFYhR3sjsarFNKsI
X-Google-Smtp-Source: AFSGD/X12YyrK2MrYNmPaMfJmPPfK9k0MDNz9qDGboCbtSKuj1twugOa1QpwXrWUtrSXoEnqOcI4eg==
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr996732oti.267.1543862373117; 
 Mon, 03 Dec 2018 10:39:33 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com.
 [209.85.167.179])
 by smtp.gmail.com with ESMTPSA id b124sm7024425oia.35.2018.12.03.10.39.32
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 10:39:32 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id i6so11859635oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 10:39:32 -0800 (PST)
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr11042322oia.154.1543862372213; 
 Mon, 03 Dec 2018 10:39:32 -0800 (PST)
MIME-Version: 1.0
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
 <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 3 Dec 2018 12:39:21 -0600
X-Gmail-Original-Message-ID: <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
Message-ID: <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus
 are unused
To: ioana.ciornei@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_103944_865600_230C010C 
X-CRM114-Status: GOOD (  23.98  )
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
Cc: Horia Geanta <horia.geanta@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>, youri.querry_1@nxp.com,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 5, 2018 at 3:31 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> The current implementation of the dpio driver uses a static next_cpu
> variable to keep track of the index of the next cpu available. This
> approach does not handle well unbinding and binding dpio devices in a
> random order. For example, unbinding a dpio and then binding it again
> with the driver, will generate the below error:
>
> $ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/unbind
> $ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/bind
> [  103.946380] fsl_mc_dpio dpio.5: probe failed. Number of DPIOs exceeds
> NR_CPUS.
> [  103.955157] fsl_mc_dpio dpio.5: fsl_mc_driver_probe failed: -34
> -bash: echo: write error: No such device
>
> Fix this error by keeping a global cpumask of unused cpus that will be
> updated at every dpaa2_dpio_[probe,remove].
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
>  drivers/soc/fsl/dpio/dpio-service.c |  6 ++++++
>  include/soc/fsl/dpaa2-io.h          |  2 ++
>  3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index e58fcc9..832175c 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -30,6 +30,8 @@ struct dpio_priv {
>         struct dpaa2_io *io;
>  };
>
> +static cpumask_var_t cpus_unused_mask;
> +
>  static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
>  {
>         struct device *dev = (struct device *)arg;
> @@ -86,7 +88,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>         struct dpio_priv *priv;
>         int err = -ENOMEM;
>         struct device *dev = &dpio_dev->dev;
> -       static int next_cpu = -1;
> +       int possible_next_cpu;
>
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -128,17 +130,14 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>         desc.dpio_id = dpio_dev->obj_desc.id;
>
>         /* get the cpu to use for the affinity hint */
> -       if (next_cpu == -1)
> -               next_cpu = cpumask_first(cpu_online_mask);
> -       else
> -               next_cpu = cpumask_next(next_cpu, cpu_online_mask);
> -
> -       if (!cpu_possible(next_cpu)) {
> +       possible_next_cpu = cpumask_first(cpus_unused_mask);
> +       if (possible_next_cpu >= nr_cpu_ids) {
>                 dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
>                 err = -ERANGE;
>                 goto err_allocate_irqs;
>         }
> -       desc.cpu = next_cpu;
> +       desc.cpu = possible_next_cpu;
> +       cpumask_clear_cpu(possible_next_cpu, cpus_unused_mask);
>
>         /*
>          * Set the CENA regs to be the cache inhibited area of the portal to
> @@ -211,7 +210,7 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>  {
>         struct device *dev;
>         struct dpio_priv *priv;
> -       int err;
> +       int err = 0, cpu;
>
>         dev = &dpio_dev->dev;
>         priv = dev_get_drvdata(dev);
> @@ -220,6 +219,9 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>
>         dpio_teardown_irqs(dpio_dev);
>
> +       cpu = dpaa2_io_get_cpu(priv->io);
> +       cpumask_set_cpu(cpu, cpus_unused_mask);
> +
>         err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
>         if (err) {
>                 dev_err(dev, "MC portal allocation failed\n");
> @@ -267,11 +269,16 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>
>  static int dpio_driver_init(void)
>  {
> +       if (!zalloc_cpumask_var(&cpus_unused_mask, GFP_KERNEL))
> +               return -ENOMEM;
> +       cpumask_copy(cpus_unused_mask, cpu_online_mask);
> +
>         return fsl_mc_driver_register(&dpaa2_dpio_driver);
>  }
>
>  static void dpio_driver_exit(void)
>  {
> +       free_cpumask_var(cpus_unused_mask);
>         fsl_mc_driver_unregister(&dpaa2_dpio_driver);
>  }
>  module_init(dpio_driver_init);
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 21c3e32..3198265 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -214,6 +214,12 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
>         return IRQ_HANDLED;
>  }
>
> +int dpaa2_io_get_cpu(struct dpaa2_io *d)
> +{
> +       return d->dpio_desc.cpu;
> +}
> +EXPORT_SYMBOL(dpaa2_io_get_cpu);

Although this function is very simple function and probably
self-explanatory, it is required that exported APIs have a kernel-doc
comment just like other functions in the file.

> +
>  /**
>   * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
>   *                               notifications on the given DPIO service.
> diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
> index ab51e40..1c1764f 100644
> --- a/include/soc/fsl/dpaa2-io.h
> +++ b/include/soc/fsl/dpaa2-io.h
> @@ -90,6 +90,8 @@ struct dpaa2_io_notification_ctx {
>         void *dpio_private;
>  };
>
> +int dpaa2_io_get_cpu(struct dpaa2_io *d);
> +
>  int dpaa2_io_service_register(struct dpaa2_io *service,
>                               struct dpaa2_io_notification_ctx *ctx);
>  void dpaa2_io_service_deregister(struct dpaa2_io *service,
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
