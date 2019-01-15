Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C2C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E562085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K16U30cB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TqyikM+u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOeAT49E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E562085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99zA1FBLGKZYjrQQMEpzqQ0i7+Ir8Xr00TnHZasknJ8=; b=K16U30cBdq0Td+
	SCw4vEgp/hT6S7XMiwlUgEnHRYWJxUVN+jayhAn5ef0gRiF+hok09JMvvvJZiBejogfrf14T5QG18
	Fn8XMbMhLBfX9/0DiAZoIO3CA30owwujMz4nPGriLqdQTLZ+lttXoTCbbV8G1U7RSiuCieapKRN07
	rkSgXYcKC1IVE+G2KhFyzCHiUDs0Dv81v5I8vp6GhjOSGR/STZ4buGRKxasLwbi34SDLLXny3LI8e
	0NQjTZ0cz8pGoVHe+IdE8WTFeSWhaDChJSOzY/Ht6CxwuAsZqvsCd+SsapJR/Ag7NktXtDr3Cr9S+
	CaEe7qtsk7OWdolvnEPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjFkX-00080d-5m; Tue, 15 Jan 2019 03:50:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFkV-0007vJ-MR
 for linux-arm-kernel@bombadil.infradead.org; Tue, 15 Jan 2019 03:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=; b=TqyikM+uxx5wz8qXFoZrcGBU+R
 vOkRSJZmECgMeFbvrUTVbA6Avz/TCH56HyTJLHYJTftNYdK6npzhB+QGbEjUsP1X/zFZcwp2AOYnP
 93GcA/n2jv/FFFAnmrCpyjmEe41ZqWKEvDdT8nt02jc9hF3T+yiU5VYNhviU1rk8R2xQRZvXg/YEW
 DXr693I+lU196lyGilfLHMeqKYF8ii3gW3zDbuaGW3mO3SIWpuFEHhOCHH2tpyqq4vNg23pks5h0B
 sOEYR3zlp7BhqGTdVbPiWV5/RjNN1C7715acnLx5ya1KrYaDjK8oFiMVP5lFuTi8nL98G3zmUpUno
 bM2loUgA==;
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFUq-0000G0-SQ
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 03:34:39 +0000
Received: by mail-pl1-x644.google.com with SMTP id w4so628086plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 19:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
 b=UOeAT49EfP+Rsq2Ml3mAp3EkU3As23NLr50Mv1XxBlBhjOFda++dKfj+X6XIVABHWj
 lLBLF0nvAkDxOLpI5/Mo7wrfUtZKdxBDeZJy1gYseZ0sxsVbI5LQ/zjjKFP+ax/oV7+8
 XOnbUB1TaXdST+UPukWwWxdS9Qen/pI+/WUjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
 b=DzYOPbYWzo4WCN/BYMVXSXfM+ZkTN81mt/vBx05xVnJKrTpw1A9aC6vPj2kfvIrCDN
 M4nDjoUXYounTYo1scr/2odpDWqqlyw8/HT8Ot2cNr2qmY3j7lLG9SWq86j/A/3pR34U
 mrM3vhUel0ep/yKPU1ls2/phGe+aq2f8Q0Qfb9NhFFNBoaMZFUACDi1EMViBuLDdnx6D
 ElmAyN5Wm+l35HYaq3pMvDTfjlffiRKY6CjkY5k87KW8JuWjh1ZRG1N4ecgGZ41crzpv
 j6Kbk9ggW/zLIMoZLRe+sRzG/+gcJmX0pwbgrmV/NHK/iKtvJeiM/0o1tiyhHVcYiDpk
 knJw==
X-Gm-Message-State: AJcUukeC2dm+FRFQr4umpMbRIgBOt3a3AHxO+Y9A39OPoW0uDlPXkaI/
 vSmSfi2PRHSfP8t0dIsHWtfD
X-Google-Smtp-Source: ALg8bN4ZLK6UxLmvpUeFAZdUFyqbktfD1GNFKeDN9LOXQgJVnpUTwZ/PHbF/nNpnEFRcZuPAp+TKaQ==
X-Received: by 2002:a17:902:3143:: with SMTP id
 w61mr1927388plb.253.1547523273698; 
 Mon, 14 Jan 2019 19:34:33 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
 by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.34.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 19:34:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
Date: Tue, 15 Jan 2019 09:03:40 +0530
Message-Id: <20190115033340.25016-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_033436_922367_8DF4C433 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIHRoZSBsaW51eC1hY3Rpb25zIG1haWxpbmcgbGlzdCBmb3IgQWN0aW9ucyBTZW1pIFNvQyBh
cmNoaXRlY3R1cmUuCgpTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2
YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgotLS0KIE1BSU5UQUlORVJTIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTCmluZGV4IDdkMzdmOGE0NzQzYy4uZjMwZTI1YzhlNGE3IDEwMDY0NAotLS0gYS9N
QUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVSUwpAQCAtMTI0MCw2ICsxMjQwLDcgQEAgQVJNL0FD
VElPTlMgU0VNSSBBUkNISVRFQ1RVUkUKIE06CUFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3Vz
ZS5kZT4KIFI6CU1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxp
bmFyby5vcmc+CiBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVy
YXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQorTDoJbGludXgtYWN0aW9uc0BsaXN0cy5pbmZyYWRl
YWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykKIFM6CU1haW50YWluZWQKIE46
CW93bAogRjoJYXJjaC9hcm0vbWFjaC1hY3Rpb25zLwotLSAKMi4xNy4xCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
