Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C6C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:21:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81652081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WlR4Eiw3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNjgOlg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81652081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cQvT6WYYpRRbJa5K89INEOMLPhaLC7xQv0aAzgZ2RnA=; b=WlR4Eiw32YjDBF
	ZXNlWgiv0qgxFcTihdSnP0kr3u/QtMBlkMZ+tq23YhClo8aceD3pczBq19MMb0lWNH0HHldK6Qbpc
	EQNWL/XnmZGVDJqN84pj/vsn0JvAs0sXIuj2NHW+nOs7kmXYpskn9adU80Nx/aHc1pimq8StddXIq
	xlynGSgaQdM4IQT5V3esZ98xaeDDJGerArR2NGvHnE6wKypAjQ4zFtFoPMe95lwh3c37LM9msUMQP
	+bm4AMMrOYagqZRyZJhIoNJOfDBSRA7WHMZ7k6TnaKWF49LyfhxJYkw3LGrsJd7kQq87S1F44LusJ
	FagqrmMI/f6qbl3UpW3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVsSd-0004hO-Pm; Sun, 09 Dec 2018 06:21:03 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVsSa-0004gW-Cv
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 06:21:01 +0000
Received: by mail-it1-x142.google.com with SMTP id o19so12881776itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ib5jvwf9cWIXq05xPudwRJmlDR7yz2Tfrst7V1mjPLQ=;
 b=KNjgOlg6nHQEf4M5a/fsheYoESoLhVa8TKCwZeU+ohn4KIaAy7t2tVVT88NodlG2lc
 ZTnzjDn9cLUzpWpYOimdJNHGwoIjCmq0eM1rPWGGncI4hCca8gRrgdtQb5+09nDQb80I
 IlyQ9vFsncqVck0IfIlsR+1sjuPk58CQmZnU0UqOerYXEgBYla3yh7Mb0v12vcIj/MqO
 YwIsN9NDI3gygTKlw2ovRIIePVaiprB8QDiApzb+hlC/j+er/77LPTRklDnkVeXbx5BQ
 fmrOqpxIa1CcHw6qIsk4T75u2UrUOU6SIyjw6qYDncIG3LQPBM2qkXReTVsPKPSiV6EK
 b3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ib5jvwf9cWIXq05xPudwRJmlDR7yz2Tfrst7V1mjPLQ=;
 b=n+++pdESPVIliaT6yd2R2UYitutVIm7Q0s5ThIUg7jtujFQEK/GNx2vvGYqs0rSBRP
 eppmtLsDYAQqS9PcxybyeCbUiyNjSRE7SneOTqGJupK5PHdFgNDDj8z3tPA8Lw/kFtvZ
 XxbNRqOOJE8jzgfCeQUXOk8fxkwdGmUbVzueVPtlPra/hhgMkw5AUrw0h2cnh2UGyFzo
 KgHCNsloXkkUEroxY2PerZ7lGCtxFP8ryXZxhUJYjxAW8BzGcqXsjLPs6Mc5r5YWj7Os
 iYblvyNbu/ohInffzdjfr35bLyMfUJv88sIJYtAp4L/aTlvOJpHyahQeX4323BXtWORh
 vmPQ==
X-Gm-Message-State: AA+aEWYLiJhZiI+iEzz0OpN5u456NMr8Zv1IOtCe8FiE+DrBr3AMfBSn
 Nk56kEExBlwOaKLEQa5+AlYBE/vTJ2pSbaq5fSE=
X-Google-Smtp-Source: AFSGD/WFz+hHyAbTw6G51bndfJKJpTZinA7Oeb8LgmzOw8RbImWIx3Bp3r6uydNftbAvP+LvFc6FtFDMJ7jYgaZQV7M=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr6908265jak.30.1544336449065; 
 Sat, 08 Dec 2018 22:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20181120161451.21149-1-tiny.windzz@gmail.com>
In-Reply-To: <20181120161451.21149-1-tiny.windzz@gmail.com>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Sun, 9 Dec 2018 14:20:26 +0800
Message-ID: <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
To: rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
 lorenzo.pieralisi@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_222100_436994_BE0A84FA 
X-CRM114-Status: GOOD (  16.55  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 21, 2018 at 12:14 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v3:
> -update changelog
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index db2ede565f1a..650f063ef809 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
>         /*
>          * Initialize the driver just for a compliant set of machines
>          */
> -       if (!of_match_node(compatible_machine_match, root))
> +       if (!of_match_node(compatible_machine_match, root)){
> +               of_node_put(root);
>                 return -ENODEV;
> +       }
> +
> +       of_node_put(root);
>
>         if (!mcpm_is_available())
>                 return -EUNATCH;
> --
> 2.17.0
>
ping......

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
