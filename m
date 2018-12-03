Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:21:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C88220834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IKTPxpcY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhPinUzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C88220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r0n05Bc+a8E9oQ9sTwOPcxTdHintapqOJr5rPTT5QzM=; b=IKTPxpcYHSt6so
	HqwnoaBc3fzlQb3sCXZr0Fb9h4C7fOz4A/tRNL/B3BZiGCrfXPw7yMZ20FwR6l0uP8XYRA60A4zkp
	6hrwsKx3OJcT4mY+F+sltcQylMy8WrHwanLcxi4NrsSfGDtLP9Uv52wN099BDaKgztiysXFOCTqK3
	dgFDqCJOaPb663LzbUrlb7z/EiTMquVH79amGEJ/QawnwsSB21du0riLgNsg+L1LpHW1WjhddiEyM
	Ys5qqWwrszFx9PLiHcjPCUSqcvc6J2ixLBR6QYt3AlDyh5DqOImGNh+pVm62G26DgnaNjHpg+/7RK
	SQ3NPhvJTcdYOfMLE73Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmIK-0007tP-IK; Mon, 03 Dec 2018 11:21:44 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmII-0007ng-I4
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:21:43 +0000
Received: by mail-oi1-x242.google.com with SMTP id j21so10534436oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 03:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sRkTbs8OPIr0qRohpAMmmkhuapeAcwEG8TNQgdpb1dU=;
 b=MhPinUzsqNAqoNRgZ9f0OUGEDLc0NqsAMTNckWonzLenTp0Z3Uv9mOj7xjGGrdCHTa
 yChPli/rlZA+TxaBZ9vK1wCAvizpq9PYil2Slk7+TAN2l9qtyr7yFCphw1rGiWdNQVMP
 8pIGSsIRsMsBW8CSJHp7E3asQNUMIdGzQA73aCQiY3+SqKa/lHcxzQeWhXqDOpWvHfBj
 tpY5lbMNRK3JYrwWa0zOFRcQryIK2IJbvLM7Fc34gwUtnzkBnBrL0puULgwLUETiEDLP
 y3ZaJylNoxHSsZxuobCBqtcQNQ7RgS+kF1CRDByqu3NqOlGGyHky3OfgiSvGfFkKrIes
 a/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sRkTbs8OPIr0qRohpAMmmkhuapeAcwEG8TNQgdpb1dU=;
 b=cxP41NJC3217G9oKfCHogsKJsdUCXR5Wlb9hK8IK4jKZREZXOzoCpyDNVGzjcbAlki
 G+V6jI1Zc1Dc6J7k8swtzo++qaWVmFY+JXQ2AcRZvm8Adb+zHSSI+M59ipqlCxzfVRTb
 emrjVHGKpFdizEBXpc8OB4oW43eGH5zIe2VfULnQ3pfc72yQLq8lU79q0j2FOcbo6ChG
 dS8Mko4hk5Kl7sYIBM2ZKVIsBVaUl0/MRKtQMoYbFgQN0h+gsFg9ncBGKWtwaxtFNVjp
 NJcxowg9qVgebKjVP1j5BhjDSxQPitsDEGECfFk+itfrgbuIPKwUtP0vW/uUz2iYA0NC
 lWwA==
X-Gm-Message-State: AA+aEWY77QITrHa+kTXJWzMgm2CZdxFrDQ16ZJzGJBiU2S0rqcRzHRPp
 Y8jVFXrKkTJSOPX5EoYe9pDl7xDZRGmvbhXoDq8=
X-Google-Smtp-Source: AFSGD/Wq3yE5/KDXsKt6z/PUZ5ITWj6DIUc8V6hdgvTUMfWMAyVzfHCRhWiPpestN6ZzF9cksNJfZgeAp7F7CPI//GY=
X-Received: by 2002:aca:ab53:: with SMTP id u80mr10127830oie.261.1543836091432; 
 Mon, 03 Dec 2018 03:21:31 -0800 (PST)
MIME-Version: 1.0
References: <m3o9a2hni5.fsf@t19.piap.pl>
In-Reply-To: <m3o9a2hni5.fsf@t19.piap.pl>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Dec 2018 09:21:32 -0200
Message-ID: <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in
 i2c_imx_clk_notifier_call().
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_032142_617322_A75841E0 
X-CRM114-Status: UNSURE (   7.20  )
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
Cc: Lucas Stach <l.stach@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgS3J6eXN6dG9mLAoKT24gTW9uLCBEZWMgMywgMjAxOCBhdCA5OjEzIEFNIEtyenlzenRvZiBI
YcWCYXNhIDxraGFsYXNhQHBpYXAucGw+IHdyb3RlOgo+Cj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6
dG9mIEhhbGFzYSA8a2hhbGFzYUBwaWFwLnBsPgoKUGxlYXNlIHByb3ZpZGUgYSBjb21taXQgbG9n
LCBnaXZpbmcgc29tZSBjb250ZXh0IHRvIHlvdXIgZml4LgoKSXMgdGhpcyBhIHJlZ3Jlc3Npb24/
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
