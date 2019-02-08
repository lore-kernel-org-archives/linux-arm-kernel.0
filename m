Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAB3C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2869D2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rWjWmeQt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wxLlntPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2869D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PJAMnVUFdFor2GiZqylCJ3hmKt8UxRz/vFqU5Ft01TM=; b=rWjWmeQtx1Ig6b
	0Wq9Jq0gvJ32/ncmNDc55Ef/7LfJ3/+8lUfjkJOrNxez651WMex0VktQVnl8TbQ0Ap0LDme0D4bt+
	6jmeWi6H2+ZIqmPEBfrFQKaFB55RsKsX7wg1dTialqEIbarwY46Kr3aI6173rxEWpRJTQ8yfSWaku
	QIexpf2oYuJtJ0/Z51zQLS2vtQ3iwn8h0ntpjY/+2T1pjjMHBtZO7eEZAsr5zyLwcf5L9y/em2Vj8
	eQinUmMNskdKkE2WifQ44rVWHAr/XIxxWTTchh4FVf3Y7r+uWzxuKEyYDipMwn9AKW4vORmL6zXNj
	BsvVu8hk4JGiZJR8pm3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gru5M-0002RP-EV; Fri, 08 Feb 2019 00:32:04 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3u-00017G-QZ
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:31:07 +0000
Received: by mail-pf1-x441.google.com with SMTP id f132so814189pfa.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=7S52tSANvStNoXW0WQ36+UsE+KrxcVitS5RILjsG2Rs=;
 b=wxLlntPqF3hw5HcVUT4Uo8fC0zp8kVBeWdsXIK8VgDh0wHsBNx1SL+W2ZcrFugtQwj
 34dEwKPa5aGl7JeQz4Zr3e1KeeQoKS4PsdyRxPa5F1b6fFW3hez99X9GftDbqDO44udW
 EeN13mmEb6/rplIGjSCTMzdFOS7McaHduPfgKOW0r4zY1Oc+RVaFHgCVUnhJCl9XjErQ
 UAZw2LoS9xN1z7U/RcQKb4DJDWo/BITDoELtwXbnvwOBfqKDA7rJ46FL8OG6IZ8BOPlh
 g8iV1j2Bmqhn6FznMKS1Xe4unyYrVF+6gAnvT7GRTsbkV0nOUAB2dphhEjAp0+7w3fPu
 T8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=7S52tSANvStNoXW0WQ36+UsE+KrxcVitS5RILjsG2Rs=;
 b=EI5jsd4l0+ym7nlgLqZhHDjAEwWPfTNhehhpAnNA7MZ1vWb37XhKom/ITz7oJ+fbCS
 j7YGGHWOrrJpqCS0YfCHvtddskwagogHYOv6unBNHdUUrsfj/Gko9J224v+iO0luo6fw
 RVUYA3kDzqRsq7e8RAo42FmqJ+Pq2oTX2GDZCT3o2+mDUT73nVYDRYVmR6DDJzoRBHfN
 VJQT0QDv1BG8wvPucvfIsIPH5wcMMh6fBkJTD9gIXzWlf0GPVXmQj3dQqn+FdTBPyEDD
 rpxkIC49U/W4yY/VEKm/cAspx5YhorlSgZDSTHpzr8/yz19RyGwzE4cyL8j3mK1aWpJT
 aDJQ==
X-Gm-Message-State: AHQUAuay1Qc7NytsjA7GevFucbJM8EjsHNhiRgjndMkHEPDnzx1+tnEU
 +JG9EeExywU+83oiGE+rhu/jKA==
X-Google-Smtp-Source: AHgI3Iacn7cfZS8n6FK+FM9vJoGuj1NVYzdEqSF1aCfM0VmNR1kr4OSXJqQlxLJjIhjbrVoVWXeNUg==
X-Received: by 2002:a63:2c8c:: with SMTP id
 s134mr16359331pgs.269.1549585833487; 
 Thu, 07 Feb 2019 16:30:33 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
 by smtp.googlemail.com with ESMTPSA id a13sm321291pgq.65.2019.02.07.16.30.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:30:32 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Maxime Jourdan <mjourdan@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] soc: amlogic: canvas: Fix meson_canvas_get when probe
 failed
In-Reply-To: <CAMO6nawKrH3d2X=TikdJy8yjiPyuJJRnpaBjyfPYuRx3d=7vVA@mail.gmail.com>
References: <20190204094937.22763-1-narmstrong@baylibre.com>
 <CAMO6nawKrH3d2X=TikdJy8yjiPyuJJRnpaBjyfPYuRx3d=7vVA@mail.gmail.com>
Date: Thu, 07 Feb 2019 16:30:31 -0800
Message-ID: <7h4l9fglzs.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_163035_822721_DC59A7B5 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> On Mon, Feb 4, 2019 at 10:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> When probe fails, a platforn_device is still associated to the node,
>> but dev_get_drvdata() returns NULL.
>>
>> Handle this case by returning a consistent error.
>>
>> Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/soc/amlogic/meson-canvas.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> This fix depends on "soc: amlogic: add missing of_node_put()" at [1]
>>
>> [1] https://patchwork.kernel.org/patch/10794545/
>>
>> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
>> index 87a6c6e23591..151aa84bc593 100644
>> --- a/drivers/soc/amlogic/meson-canvas.c
>> +++ b/drivers/soc/amlogic/meson-canvas.c
>> @@ -51,6 +51,7 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>>  {
>>         struct device_node *canvas_node;
>>         struct platform_device *canvas_pdev;
>> +       struct meson_canvas *canvas;
>>
>>         canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
>>         if (!canvas_node)
>> @@ -63,7 +64,17 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>>         }
>>
>>         of_node_put(canvas_node);
>> -       return dev_get_drvdata(&canvas_pdev->dev);
>> +
>> +       /*
>> +        * If priv is NULL, it's probably because the canvas hasn't
>> +        * properly initialized. Bait out with -EINVAL because, in the
>
> Bait -> Bail ?

Fixed this up locally.

[...]

> Thanks for the patch, I missed the fact that a driver could have a
> pdev yet with a failed probe.
>
> Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>

Queud for v5.1 with Maxime's tag. (branch: v5.1/drivers)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
