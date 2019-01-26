Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA931C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:47:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2E321872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K31L34N/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlBlfJcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2E321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4pgKe9tjGlBifOX+WD5UsAfXva2cfw/Q0Pi56GZH378=; b=K31L34N/govrXG
	wUUvv7sGL79NCgRXYtJD6+OMwu8G5BmQd4m+STxjDyrf/1dYmr+/s+ToS/kz6SOU3+C5lhxBXKUDp
	dtokD88/HBNeITYKcsKMJl6mAZMUdAUhKDAVQarsXLoPtUlz4/2WQq4dA2+66wIiRmsl8G4++KFH1
	lty3rGhVHQ4dLD9Qgx7JKnubCYnfDATgnCPh1SnTFRMINMVcNM+DeGKyHFMXG6of/OqUdCU/5ebN8
	AfoPIKBRNkJGCCoTjbu8riO3ZwU0Qky87Hpv72o80vtGTKI83oGxsc7hK2KU5LaxWEwo2uRQstCxZ
	vUBD+YdtDwVu7a3ATfUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnTvO-0002kW-76; Sat, 26 Jan 2019 19:47:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnTvL-0002k5-NX
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 19:47:29 +0000
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3638321903
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548532046;
 bh=PcoAyqe8C7lwvuUK3oesFYWuqImdTTjmphhncXKOnfk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VlBlfJcI0Mwv2/Jz3tiuHSEhHZ3a5jKLw/mKA6cdXa+DssQsOGVqaaYn2SqEp+JdP
 TxQiAUr4YPnPRcVRdfZTwAKEe8GU78AK/QAj/O8xVL7iZf9hE3STRDdq+EMqlkrUj2
 Gy5CsdN/7AMRrsjKPOmcJMZWdFvAKw4PHsdjXyG0=
Received: by mail-qt1-f171.google.com with SMTP id n32so14311512qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 11:47:26 -0800 (PST)
X-Gm-Message-State: AJcUukfzDgUVZ0X3ua/aqvUmgIxMrMXMtGecRIqZDQfNmGh21/6TgWbh
 +u6vKDOITxo/2h1x9RAE+QW7Y3NSyo71CwQUSA==
X-Google-Smtp-Source: ALg8bN6tXfihtdpQ6K2viCeKMaL35awOQJFThS5Y6tk4YuShiuHqz2RIu1hAoV30ihUU1P80AB4K/ndJ5zjXvyS7PcY=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr14851739qve.246.1548532045415; 
 Sat, 26 Jan 2019 11:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
 <20190126041041.13173-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190126041041.13173-2-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Sat, 26 Jan 2019 13:47:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0zhp8X-K8PobfBmXgpvp6+EsqJL7ixHHu9b84ZoAmWA@mail.gmail.com>
Message-ID: <CAL_JsqJ0zhp8X-K8PobfBmXgpvp6+EsqJL7ixHHu9b84ZoAmWA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: arm: Document Bitmain BM1880 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_114727_787544_FB9F5978 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 darren.tsao@bitmain.com, Amit Kucheria <amit.kucheria@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, haitao.suo@bitmain.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 10:11 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Document Bitmain BM1880 SoC from Bitmain Technologies Ltd along with the
> Sophon Edge board.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/arm/bitmain.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bitmain.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
