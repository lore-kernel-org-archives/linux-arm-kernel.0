Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B848C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6830D2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sX7nL3d7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgu3C/TT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6830D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V4DQ9njkRPk7A5qYjJK4oQgeAvBKIrc5SlUiPd0z83A=; b=sX7nL3d7S3fXwc
	yAVWfwmZfSHBPgH/+wzXe477fByn9UeT9ucvBz6y50yhX28Lm7Or5c/6NORVpDiMcBcfYVIXfY1H1
	mazWVhd/gkL95S6M5kz/6sTv3XMf8VzLegEwQxweCyhE8SC8PIweHN1BuwN6gWbX/hFrFXUR/bi1a
	SwgIx+kyymr1jYRSYplXqrBxxRCiaRIkgEPtUQlYIaS7n8DMUSQVh5ct5QldY0uUy6onmlCyPsAvo
	f4m+h55h9r6yaMntsClk28xbxuDeF6Jt7dOjHHI8bR3s3bDSZ9vTyqO6BIt1cyikwP5VShMEijNXi
	bT8baKs/HKimXgnehUVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwOZ7-00088f-Nz; Wed, 20 Feb 2019 09:53:21 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwOZ4-00087Z-9v
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:53:19 +0000
Received: by mail-lf1-x142.google.com with SMTP id l10so17070497lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 01:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6PzXl7HZONN4035fIPsM0lhsW6FZpjgMkeqMgrv9A4Q=;
 b=pgu3C/TTol1ilNPIOY1rtKDRXCawseSsW4U0HR/3Y2+y0jHI5gsebC92v1YuQJEcYw
 Hjm/ocy8py1zmSSPz5JqyAUZERF7BZjf7SjMrR+hqmepVHlP88B7T+L7b4gqoCbZ0otS
 UAcDfXdF2WgVTgETEIzf7vZ6NuTkJZBP6f7iuoEip1+0QDwwEl4ULqm1KDKhw2AUYha2
 ADbT84ujhlY9cUBCrZZs6/oaS1u2BPh62I7WLVN43NJ95VYeqd2d5kTAwgFD2brhgoRk
 jB0d43krntU3+gR7Z5ft/a5F/DH8b9tl7T3MYzqCWTgtSeyFviOTgkz/P6njaEe693vT
 elSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6PzXl7HZONN4035fIPsM0lhsW6FZpjgMkeqMgrv9A4Q=;
 b=tCOy8kVAUa0MxdXaqZFuwV4657Rw/ZrDo5s90t02bsbO76UvXtMXRYq9+xgh7m/WQs
 8WnfbbzN3fvV2Qu6sSQxNvzAwOF+I3Ybu+JqrR/ONf+yJVbKTKgyQcDD2oBh+yLDWJer
 gcZxHg9FfgLtGktSifgNANK7WnuYly7nNxJWLLhZO7cDb1crxv4oqSKNmKeHU0dAy50r
 frvqywUDvno1xqS9T1+OFa6KcGasW1YkQN/io3bHgJbg4gx/+PhfOghgDCgWclhjP2oZ
 99CA3mC01loWc1wN1X0Y9aZwN8lfG5muOelqyEMcyqmjmK3TUJBqzXws9KyCyMPCQtRJ
 kt+w==
X-Gm-Message-State: AHQUAuYUnzY6/dsH6xxc2Ud/gQdDijV88/hz4O94nE7KvYf8weOvEnUw
 V/SbH7WSOhHkZ+eBa9VIzFUCSOOrHDJpyvnw/W73yQ==
X-Google-Smtp-Source: AHgI3Ib3bG277c8Bai7doS0Z/elOaKF9LwTe7fQC/1cqsQc+uk2LP3pXYXk1ImA6G/dhIL5PMED8fju3xDwDm+cJa0I=
X-Received: by 2002:a19:7b0e:: with SMTP id w14mr19583160lfc.8.1550656395265; 
 Wed, 20 Feb 2019 01:53:15 -0800 (PST)
MIME-Version: 1.0
References: <1550217696-3006-1-git-send-email-wdjjwb@163.com>
In-Reply-To: <1550217696-3006-1-git-send-email-wdjjwb@163.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Feb 2019 10:53:03 +0100
Message-ID: <CACRpkdbt6VSrzLNWEGSY2OnR8=DovhTVpsuUPGC17YtmWmVnyQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: fix possible object reference leak
To: WangBo <wdjjwb@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_015318_345399_F0309223 
X-CRM114-Status: UNSURE (   8.41  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 wang.bo116@zte.com.cn,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 9:01 AM WangBo <wdjjwb@163.com> wrote:

> The of_find_device_by_node takes a reference to the struct device
> when find the match device ,we should release it when fail.
>
> Signed-off-by: WangBo <wang.bo116@zte.com.cn>

Patch applied!

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
