Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C557C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:10:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4402145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g34HQZPt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwiIy9+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4402145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bBW3p79EUPup7vKE36ZCSwZGgJRrpV7WEfvLFoJlVXQ=; b=g34HQZPtn9324M
	CzF/r0jtLf+qMQRtKu2X3YjHMoRih7/uJTPmIcZFnwKrgech9HmmS+CVeAHQBaqJAdLJDqXMkJ5mV
	VkNUgZDi6dq+J6KsYpp5Lkaugqm0DKVXHyXaI9alMboMrGt+xgKC6Y5TagHhhtpXNTTrinyXGVkxS
	p2Q9JzZCEPs9pfna/lUVgT2rVRwZ4rMqOjO+OH7w5dQqg9wMNq/XkaGssNsQODTMGGFQn9jS0jjA5
	MVyRZ0sdbUmomnqYYHwpTr50PciPmFL8A97UvC0xzbOjbKptau5Ot89gtGklq3eYC/7ZtneTQbsd4
	ReApb2cYotFGWQdACBeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqvoQ-0007Dm-Ar; Tue, 05 Feb 2019 08:10:34 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqvoM-0007Cg-Ce
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:10:31 +0000
Received: by mail-ua1-x943.google.com with SMTP id u19so851901uae.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gxoEnVe+Vjte4GPkatgNUZFr6HlYZiQ/Ql2mHZyW+BE=;
 b=CwiIy9+8bQhetX3jE/IloHLl00yjggv0xrVSzfSfNonBSIkyGmMy0siLmglUFGH1CU
 1xZT8ehXbPTXlUminWUjuW/XJ/zsClZXDVbci8oSax9EhVyBmVqUF9UmR6n0XgLFcPz+
 QOGm/q7UgiaZ9vzfQE9OUz7QLsJ0rIdKJwfzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gxoEnVe+Vjte4GPkatgNUZFr6HlYZiQ/Ql2mHZyW+BE=;
 b=jBML5CoBF55oYI9wcrqHkZxVSSwoIdRmvY70UKVFCdU7gMRlGLovasoebCa6d1FPRC
 9KtJ4fVR2CP1OMXuo4jvPGtvhjX17LbvcwYg/5mQ+V3XGb/T60XDqf0KNpgjsIQex7ux
 y+4E0JchAkJAieIHhk9aAyPfNDSER1VA3VANC45rWR0oUzew5gRNs45Jj7nqkHXX1cey
 PfvpAnkzuVtj5xNgybaaH0SLIvCS4g3tj/4hdAn6IsOuPtf8z9bH0DTFbhHdhoBSsgz/
 i9Vw6IKXnXrHXUcaQFS5Nm41zpuUmE9O5O251pd7tQBTOT+1aoMiEdWfZEJvikY0Jaad
 FtgQ==
X-Gm-Message-State: AHQUAuY3JZep86Lrv8wSjdJc1ycaZuCcAgS70usTbgVZj3lHVcXeygng
 zE56fh15q0i1QGVDXyAPqPjzKdlXB0QSXKd5YJZtRP4v
X-Google-Smtp-Source: AHgI3IYdcq4Qsyb1csuGEXT3J5FqsCuk81iMJIjnMeZ3ljIufq8VriCbdiW+TQeYNOMH0TKiv0PmLU3SlDnHXCnWRrs=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr1387608uan.107.1549354227865; 
 Tue, 05 Feb 2019 00:10:27 -0800 (PST)
MIME-Version: 1.0
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
 <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Feb 2019 09:09:50 +0100
Message-ID: <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: move runtime accounting on
 ktime_get_mono_fast_ns()
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_001030_451651_F622E43D 
X-CRM114-Status: GOOD (  18.80  )
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

On Mon, 4 Feb 2019 at 17:25, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> Similarly to what happened whith autosuspend, a deadlock has been raised
> with runtime accounting in the sequence:
>
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume
>                 update_pm_runtime_accounting
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Move runtime accounting on ktime_get_mono_fast_ns()
> With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> monotonic across an update of timekeeping and as a result time can goes
> backward. Add a test to skip accounting for such situation which should
> stay exceptional.
>
> Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 1caa394..50740da 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
>   */
>  void update_pm_runtime_accounting(struct device *dev)
>  {
> -       u64 now = ktime_to_ns(ktime_get());
> +       u64 now = ktime_get_mono_fast_ns();
> +       u64 last = dev->power.accounting_timestamp;
>         u64 delta;
>
> -       delta = now - dev->power.accounting_timestamp;
> -
>         dev->power.accounting_timestamp = now;
>
> +       /*
> +        * Because ktime_get_mono_fast_ns() is not monotonic during
> +        * timekeeping update, we must ensure that now is after the last saved
> +        * timesptamp
> +        */
> +       if (now < last)
> +               return;
> +
> +       delta = now - last;
> +
>         if (dev->power.disable_depth > 0)
>                 return;
>
> @@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
>
>                 /* About to enable runtime pm, set accounting_timestamp to now */
>                 if (!dev->power.disable_depth)
> -                       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
>         } else {
>                 dev_warn(dev, "Unbalanced %s!\n", __func__);
>         }
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
