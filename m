Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CDEC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D39E2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dct+2i7w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXC0ehae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D39E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r8UznRoYosEiDDs41gTKl56utV8PZFf/2/ieqGVC2SI=; b=dct+2i7w0vrktq
	K8+iB4UccK1Q8XETOvPAwDjsGWoCfIq5/lGWs6L4bflxxwTuiRlkHD6QR6lBIT7WS8zyRQ39akNb+
	DLpnU5SYPH2nhHyOSydNI5/wm2uvc0tayJuZQMA4YoZKhpnzsfvU5rbj8VpY5zTgx9tQCSZc7l4QM
	WdmYSfISVwFm+OLW61cTjGovlGHGiVSmaUyFo9u6EYKh+G5IbGOBza5J8ysDptqbZcvEpzRNWz/Ab
	D/n6dpDCOCA1cq1wA9mAl8BIGKr0wCBYoyC7ivwkQg3B6HrAYPsJJ56uEX6N4917OHc/ZWeA8y6ES
	CPg2KShjqO87OuoEFE/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqvob-0007Of-QX; Tue, 05 Feb 2019 08:10:45 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqvoO-0007Cy-6G
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:10:33 +0000
Received: by mail-ua1-x941.google.com with SMTP id z24so841437ual.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i0j1f/7ELLhI89wgaZXD9QSuujo2YuCpG10Bl7Mn71Y=;
 b=eXC0ehaeA5Xz0wOqIgKHsZV4s3GVAREioJmEUCemm9BTlCyF2DzpzrR8201tipR1+q
 7jMYoR+O4W8Bpymd/ypX3S8dO8Lv/nDQeb40omhPIMaqf1xLw32q1y9IbwIuWbl2gfGV
 JEcBbjd7AqnT+AKHdWT5WvupQUVcSWFnfX0Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i0j1f/7ELLhI89wgaZXD9QSuujo2YuCpG10Bl7Mn71Y=;
 b=UHpxTqAx3xz9PyvbU4d3nQfCKvoIZ116PJRyDRuy2B66XtZIrpGKcjrBlxy0HoEO8p
 CMM98ayqvYVWPTpnfMG12Rh0j/6ODOC8sASBMydrmfEwd/6xhPjvvd/hqx7QA8w0LQt8
 OkvwE+Pd/BvOE9e3gY92/OG4wB81sS+5NdiWH8E3pFMpoJQCF2siFaXVzXGLWvCD4c8V
 TvUI8hI1Uj1RV8eLtxcuM/hXARhjAVBgbCEo2unmda2PQxU7OjBfl3hdfo+LqJEtMYEu
 hWv0zwuDKeR/AGh+HvSFqjK0gpO3IU6deAaxXrCH/ymmiB7PhcDk1pXHfpkrY6xluNyK
 CO7g==
X-Gm-Message-State: AHQUAuaQWAO+Sonm+B7qfviV9eCr79+4K+CGLcc/x3jcjAUEy1/rb50X
 bkqmPG+iMfp3eAZxuaw3p69CRapOMrg++yacfG9Iuw==
X-Google-Smtp-Source: AHgI3IbVvZx/jLvXMDvjzGiW8jzC0rA+HNa8/r+YA/SdzydQDZftHCs6Qx0Ak5BKmzHgFg2Pyg2VcQ6C5WIqCJJmYgo=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr1331326uad.119.1549354230688; 
 Tue, 05 Feb 2019 00:10:30 -0800 (PST)
MIME-Version: 1.0
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
 <1549297553-17647-3-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1549297553-17647-3-git-send-email-vincent.guittot@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Feb 2019 09:09:54 +0100
Message-ID: <CAPDyKFqNgnvHM0hpgzy-oY+oj0_q72LDybgZJ5r8BugDM97Oqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM-runtime: update time accounting only when enabled
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_001032_228239_FD8841A3 
X-CRM114-Status: GOOD (  16.40  )
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
Cc: Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thara Gopinath <thara.gopinath@linaro.org>, Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019 at 17:26, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> Update accounting_timestamp field only when PM runtime is enable
> and don't forget to account the last state before disabling it.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 50740da..ed62cca 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -66,11 +66,14 @@ static int rpm_suspend(struct device *dev, int rpmflags);
>   */
>  void update_pm_runtime_accounting(struct device *dev)
>  {
> -       u64 now = ktime_get_mono_fast_ns();
> -       u64 last = dev->power.accounting_timestamp;
> -       u64 delta;
> +       u64 now, last, delta;
>
> -       dev->power.accounting_timestamp = now;
> +       if (dev->power.disable_depth > 0)
> +               return;
> +
> +       last = dev->power.accounting_timestamp;
> +
> +       dev->power.accounting_timestamp = now = ktime_get_mono_fast_ns();
>
>         /*
>          * Because ktime_get_mono_fast_ns() is not monotonic during
> @@ -82,9 +85,6 @@ void update_pm_runtime_accounting(struct device *dev)
>
>         delta = now - last;
>
> -       if (dev->power.disable_depth > 0)
> -               return;
> -
>         if (dev->power.runtime_status == RPM_SUSPENDED)
>                 dev->power.suspended_time += delta;
>         else
> @@ -1298,6 +1298,9 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
>                 pm_runtime_put_noidle(dev);
>         }
>
> +       /* Update time accounting before disabling pm runtime */
> +       update_pm_runtime_accounting(dev);
> +
>         if (!dev->power.disable_depth++)
>                 __pm_runtime_barrier(dev);
>
> @@ -1521,7 +1524,6 @@ void pm_runtime_init(struct device *dev)
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.accounting_timestamp = 0;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
