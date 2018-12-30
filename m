Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F21C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:34:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3160A20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t5HQj8uq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8W7vf0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3160A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bzyBdTm8icgZ/8sToJSEY265hX13LmOGtyP60p4l39g=; b=t5HQj8uqtrr6/M
	6m3/BcfQtTkE9dco5zzBrANCKWkVv6zgoV2C1ebyYsAAhI97af7DCiK3pPm+6vSRGnnj5GASkfQLk
	1x/0989j+8A38vgSuoVSuBh0yTTDCuBXdGkj6DlKc/2prT7hmuSSidlKy8kyDxOWh1rJHuaXspifp
	mpm7ALoJyvwy8B6p/+PjNKNajKi74kp6mSUz5RoRsvBhSVtPQ1KpoLCpvkoqJixHCg/HyRyD7Du55
	3/c2FJMKHLdu8z77eY5zDZnHXW8dgAMOrOifQXey6qswY4iH6foQnhNZXRdPgF7k4cEb6qoOWOjub
	9FkzfCTVTl3hgZIXUlrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdfv5-0002wM-V3; Sun, 30 Dec 2018 18:34:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdfv3-0002vF-1V
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 18:34:38 +0000
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3736A21848
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 30 Dec 2018 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546194863;
 bh=XpZKn3oE/sDBvKfNTpEt4GTJdArEb4qRbcjgEjNxwBw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=h8W7vf0ZvwxcrqSh1OLDWcqYIsWdLWgfUTqXBJF3HE6CGvziVBTS/+EtPW0K9nVuC
 eK1EjIZLS5xFdPvFvsw+Y/NTSs7CWaKf0Zb97WakKCQDjw0SGJ83BYT3kuqwpEx3R1
 TKqgA4lx5eBVObq1Vq4hKV40cGA4vcm3r5xntJYw=
Received: by mail-oi1-f174.google.com with SMTP id x23so20760062oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 30 Dec 2018 10:34:23 -0800 (PST)
X-Gm-Message-State: AJcUukco00F8XxT748hMA0EBY67DI39AbFxXMEXt2A7OaXVqrwzkb/pX
 EksKAiANURVfkWLqqdEFCJTjnl51tEHSmXchIz0=
X-Google-Smtp-Source: ALg8bN6k+kmxaeSFAcfEJdYfL5P32GwdzoZtaEuQLJKprO16AW3MPMQJhzQkJnieCzxJhKI5mRtlvoUCwBglq02rMQw=
X-Received: by 2002:aca:5e09:: with SMTP id s9mr6882243oib.153.1546194862485; 
 Sun, 30 Dec 2018 10:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20181228201119.11920-1-pakki001@umn.edu>
In-Reply-To: <20181228201119.11920-1-pakki001@umn.edu>
From: Sinan Kaya <Okaya@kernel.org>
Date: Sun, 30 Dec 2018 21:34:12 +0300
X-Gmail-Original-Message-ID: <CAK9iUCPvmoN4_0jyZ+DP+ROmmoKTpqCoRPgOCKTmjT-o73zW4A@mail.gmail.com>
Message-ID: <CAK9iUCPvmoN4_0jyZ+DP+ROmmoKTpqCoRPgOCKTmjT-o73zW4A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom_hidma: Check for driver register failure
To: Aditya Pakki <pakki001@umn.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_103437_102011_2F4BDCA3 
X-CRM114-Status: GOOD (  16.36  )
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
Cc: dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org, kjlu@umn.edu,
 open list <linux-kernel@vger.kernel.org>, David Brown <david.brown@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 11:11 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> While initializing the driver, the function platform_driver_register can
> fail and return an error. Consistent with other invocations, this patch
> returns the error upstream.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---

Acked-by: Sinan Kaya <okaya@kernel.org>


>  drivers/dma/qcom/hidma_mgmt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> index d64edeb6771a..681de12f4c67 100644
> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -423,9 +423,8 @@ static int __init hidma_mgmt_init(void)
>                 hidma_mgmt_of_populate_channels(child);
>         }
>  #endif
> -       platform_driver_register(&hidma_mgmt_driver);
> +       return platform_driver_register(&hidma_mgmt_driver);
>
> -       return 0;
>  }
>  module_init(hidma_mgmt_init);
>  MODULE_LICENSE("GPL v2");
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
