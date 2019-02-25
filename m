Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C5AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A4D21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CxZnIcMz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UT+ZbmKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A4D21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=snlPKdLc9Z4bmsauxaS2LtZWby4PqF5gOPTBhe2V9rI=; b=CxZnIcMzbs06Y9
	daK9g9bRmbuOD7ZOy28TVvIyFrxtvYAc0GQRktD1SAm5QZBvvTyKwEH5NpEzT0cBcL4FZkONoZtqW
	TV2FwaGQ9IEEiQUatkVnOIiusCB93fKK76W9uYNjDYBcf6v4dN8zqGVngqpKQuoEh1awnD4HyTCoB
	BSGHeZXqQMIsU0TsOUs9HDeMKpZQ6llO9ImoJuj0Fj0ebvor+WX0iU9NtI7l30EZzq+9JJ/0gPZ1X
	S0uFedQ0w68lcycm0v/CHsOIRPW9BQJFOTurKAe9sj5rcHtSZOKzp9mGHHi97Ivmufebws+ns7jrc
	dUZg3+prkg7Sjgsn1bXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQ67-00021e-Ju; Mon, 25 Feb 2019 23:55:47 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQ5q-0001l2-EZ
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 23:55:38 +0000
Received: by mail-lj1-x242.google.com with SMTP id t13so4731103lji.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dYbJU7KLt5fEwcgGrnxctZm7wSA32fxgxnmdAdViJBo=;
 b=UT+ZbmKg075BMaoRB3dhU31fxp6X1Tf7UHYXVQYaK8UAfVWUk/ZwXVhmbxnTcYJ81q
 c676Cv+YcqLBgfy8NFHZHV58ZwllODWoGj4WqRxk9FvCasx3FU0WjRhsuLmOREqVmxJI
 dtA4oDX3k8kRvxo3hDxECsOCT2ad3sKa6QnL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dYbJU7KLt5fEwcgGrnxctZm7wSA32fxgxnmdAdViJBo=;
 b=JZcS3MDfChpxmOjjo4BD2eXWs8l8wS/UyxD81O9UPpTPJQO8RF2BmJSFMX7f1vygbx
 QEP4Gb+4XQVWEIS6IPQ70Fv2K6ZUJq453qDZUf64SEFbwHrhcKGgkf+80onQktF9ZG/T
 rSI0S7W0c7vEyXXAYu32ctvreMPez2CwCp1qLorTe1OwwtvY71WrkOhZ1ejMHKYhgwDR
 AzkwXp8N1QKnmRXpyC0AX4EFN3tsMej8nw6e0W13AkMU09I3eJ5zhyl24Re5KfasbBqR
 cQVvERuRSuQqIh0retbM5FB5Vw7LvK8NYvwof2ouYYRxryyf1JdjliIhvtrbtBdGpgKN
 8VoA==
X-Gm-Message-State: AHQUAuYSZSF/TyBRdTj1Sn8zi0nj9NNT02IORD49545qncPRBGU3GARA
 J9U8q9Xh5BZqOuwhnChh79pQ2wkwxgI=
X-Google-Smtp-Source: AHgI3IYqPQFDSdRYksnG6BTN5u/uvOolW3GZ2OhyCIDD5zXf5Ls/66rqnFJcH2PyIdaV6WDiyeKVZw==
X-Received: by 2002:a2e:5d54:: with SMTP id r81mr11672612ljb.183.1551138928348; 
 Mon, 25 Feb 2019 15:55:28 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id y15sm2587038lje.23.2019.02.25.15.55.26
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 15:55:26 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id g80so9088035ljg.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:55:26 -0800 (PST)
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr11481483ljj.60.1551138926072; 
 Mon, 25 Feb 2019 15:55:26 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-6-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-6-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:54:50 -0800
X-Gmail-Original-Message-ID: <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
Message-ID: <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
Subject: Re: [PATCH 05/13] memory: mtk-smi: Add device-link between smi-larb
 and smi-common
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_155531_093388_D3141FBC 
X-CRM114-Status: GOOD (  20.00  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Normally, If the smi-larb HW need work, we should enable the smi-common
> HW power and clock firstly.
> This patch adds device-link between the smi-larb dev and the smi-common
> dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
> (smi-common-dev) will be called automatically.
>
> Since smi is built-in driver like IOMMU and never unbound,
> DL_FLAG_AUTOREMOVE_* is not needed.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 9688341..30930e4 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -271,6 +271,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *smi_node;
>         struct platform_device *smi_pdev;
> +       struct device_link *link;
>
>         larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>         if (!larb)
> @@ -310,6 +311,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>                 if (!platform_get_drvdata(smi_pdev))
>                         return -EPROBE_DEFER;
>                 larb->smi_common_dev = &smi_pdev->dev;
> +               link = device_link_add(dev, larb->smi_common_dev,
> +                                      DL_FLAG_PM_RUNTIME);

Doesn't this need to be torn down in remove()? You mention that it's
built-in and never removed, but it does seem to have a remove()
function that tears down everything else, so it seemed a shame to
start leaking now. Maybe the AUTOREMOVE flag would do it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
