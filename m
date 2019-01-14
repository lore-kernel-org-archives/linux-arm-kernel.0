Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C144220675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iFZkpoH0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5qmJpOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C144220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9TDvb2D3Y1K28jQoTG/m/2TpFa/IX6guS+N7sFvQp20=; b=iFZkpoH0on7iDG
	0DXncodZZ2yN1BMaSN3B0vnyq3NtfRBMHdw4mGB914FlRCZZhSBT1kcVn+G07xJvxAvKCNLsqh/rl
	BUZcViDvch5mQo2MV7gVWwb2CbeXLm3oa4c90nWlJykKe32G2/9Safnjw5a6iNIsLdJsW/vX0vry3
	9JpgiU+j5Ern+sJR5F+dg7kCjmHPyb19BzzuLoyqefODTq+QHasxIXcjG5epZN53LiH9Xyu03awzN
	94SoIZNKG5xw4c6i28RbiqH7jOJVy4sUDkc81OOZu+VFeZysRVIq7OcsDEHUa8rC2vgM9NShFiy+z
	G+PIWUifcHNxrSXECKug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gixbr-000462-SJ; Mon, 14 Jan 2019 08:28:39 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gixbn-00045c-CO
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 08:28:36 +0000
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so18215219ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 00:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PK+o5wSfNSAi8nHTgkusBFI+usEcOqlS3NIt5HaMg9A=;
 b=e5qmJpOIJCnTGIJsBcefQF4pczpWTlwUOulFSMHsESeMXkQShuduHIBQny5xjHEEGK
 65rR+/isOJ6hG+1BJieFHbJLww9GMaPs8vHtIH1QelUN8f5efReeRt7CjZe5wRfVmE+Z
 LxbItZC5dXwJ3nwS0Pt1kohi2cX2V5TIP3UaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PK+o5wSfNSAi8nHTgkusBFI+usEcOqlS3NIt5HaMg9A=;
 b=COE3mJZRpTAJAw4ldpooN08i2Q/yYokHlCv7VQQd5r/dVDIgVCg/gSIsGyKtMUqamJ
 cD+3jGQR9OuNn5jaqbFFjVOemjx4mbwW8HizwCaLCAWBtVWdMlUNwvG1wgdGlukRrpZP
 mZJNbxbtZafQTVTetPH05biuuJ+HmQkUhYGhvODwLdclQ2FB4RiuVyuVIcJIiyjsSkn4
 UEiX37g6LHEEIua7Dl2S5e6OvCP5ySEB98QD6BiFRQ5yHgliPIk/qEqNeTX7ALh4HZh5
 J3ZalKfiR+JXvk7i+/X/3egfrghZ2CbOAYTtXiN4yl50EYbUKDPjkJ9eYQwKR6s8/WK7
 hQ0Q==
X-Gm-Message-State: AJcUukdgSM2NzuQSdjkmBBO8N+JMIeeJDy4w85eVP1x+8ZsstpwE9sLQ
 9obGeenEIfVAHBm4MBleGQrIIzfKy3NozkW9GkplYw==
X-Google-Smtp-Source: ALg8bN59XwyzwevpO45r4pBAAEA8eEp4i9O/m05r7uvvx8aRYBrHspWiemAZF1S/QP8c0OphilKQdUS8JELRCYvCFbE=
X-Received: by 2002:a2e:7e04:: with SMTP id
 z4-v6mr13711685ljc.97.1547454513248; 
 Mon, 14 Jan 2019 00:28:33 -0800 (PST)
MIME-Version: 1.0
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Jan 2019 09:28:21 +0100
Message-ID: <CACRpkdY7c16C+NpoSXUV1QsLkQgNm3vjknOSea0p4aj-LM1xBg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_002835_442657_248EBBB5 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xu Wei <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 9:24 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:

> The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> Instead of adding cd-inverted, we should better set correctly cd-gpios
> to use GPIO_ACTIVE_LOW.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
