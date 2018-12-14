Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:14:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2D3206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aqRMmdCp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA+sTsi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2D3206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vk/0v38ub7BW/laUWrkGZfffltDq94dC7NSuXPeQE78=; b=aqRMmdCpHNkOqi
	E9TA4ieosVyQZxj5wL7aUo+IxESQ8/NMNlhP/q4fecppZW6jwSk/MTm+Dqc/gxWc+4lA0Bgzp3PvB
	8peZvOrpCJx2Xweuh6cLfWpvtNhJxw4RCxwakYmozUVjfLSGXNI3vY+bPbGJ/bvXv2u/b7ggx91jO
	Xb5XBhsn/U86+90EKKGPH7o6UrTH19uvlG+1Y6jZwRBacBwzf6PyjXqHUBKgxndoOg+7/i0v0fPRx
	0sHzQiiO9Zzn5ySlZR+PU7v4FUy9UA/SBRJgSCkCfg5PJ7cz+EsuweayxLjjRQE3nZMLn0vxBJAQ3
	bDZVH3GqYqeXiu1e/wjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXpAP-0002SA-6Z; Fri, 14 Dec 2018 15:14:17 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp93-0001IF-PD
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:13:05 +0000
Received: by mail-lj1-x244.google.com with SMTP id x85-v6so5210037ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
 b=AA+sTsi+2r9TaO4AjoiPveHi7QEZ6CyRaTCdXyKbmlI4V5cPPLC9vA20OsRILHzxQr
 CvZg0bUe/UPRkXVS0MVkXtL6IhiWSOfC8Kex/z1PmxDwJchTZm4w+muB6fO9ewNLO+as
 XyS86vKWHrbwDakwcrtK8Ol3ZbSCqYn251CyJjaeuF1BOY6QpNqzP2ygsQ+7zLkid0gB
 hVA9d4lK73+xUAZeUDzFPv0m1UGCnRpfA1DEY5OSjFhs7u07FasCp7QwhuOTcZP0JWPj
 anWcHm7OQpXHjxwVdu7QwF6x2wSJQauFEY6WcE1OE+hJkLwH7cHdgNkSNKlrPcnrQeWo
 kfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
 b=H1SydnwP5B2vQ6ffKnUUm71OXoKAxABlIhVns3530zoPanHsrzkB2ziYOp8C18EW7u
 tv78+6oraMWbuh0lyjv1y4TLQLhAKOdkyvFo94BHrtX1vaOSJ9szbFVCGogU8V3SdPig
 H5PtEghvEetPge7ffCvu0qfi5SC2qCvyfK5Mo4GgITbsFwnxprj2nQwTCwwRZ+ysagKu
 Wq6d9yPU+kVEJwTmur6WWQaL8YSHXufCq0Lee/An4AgrqBaCwfhfplYcN6iR5qzSGxV4
 zqCUlmcpeWG784HgpMSaGn2H4MFKZpLzJipBkYNhLWgtNHWumuOMD8ei7CSe6S6osp6n
 aWmw==
X-Gm-Message-State: AA+aEWZydBynHm4UgKyHeJGbEG0z6JWdwm00zlAYEPx+gDOGTD1mMDqm
 88nK90eLaH8UjbN6xaekU8k=
X-Google-Smtp-Source: AFSGD/UpvwuG6QLqDJlXq4Uy1lBkqEcft6k+rwE4UIl4p+PwyZEFl5PQO5/79a6L9O4ktaEg+Nx93Q==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr2259538ljj.13.1544800363045; 
 Fri, 14 Dec 2018 07:12:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
 by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 07:12:42 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v5 3/3] Input: atmel_mxt_ts: Document optional voltage
 regulators
Date: Fri, 14 Dec 2018 16:12:14 +0100
Message-Id: <20181214151214.5391-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071254_134223_51565970 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG9jdW1lbnQgbmV3IG9wdGlvbmFsIHZvbHRhZ2UgcmVndWxhdG9ycywgd2hpY2ggY2FuIGJlIHVz
ZWQKdG8gcG93ZXIgZG93bi91cCB0b3VjaHNjcmVlbi4KClNpZ25lZC1vZmYtYnk6IFBhd2XFgiBD
aG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIGZyb20gdjE6CiAgLSBBZGRlZCBy
ZXZpZXdlZC1ieQotLS0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2F0bWVsLG1heHRv
dWNoLnR4dCAgICAgICAgICB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5w
dXQvYXRtZWwsbWF4dG91Y2gudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lucHV0L2F0bWVsLG1heHRvdWNoLnR4dAppbmRleCBjODg5MTk0ODBkMzcuLjE3OTMwZWNhZGFk
MyAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2F0
bWVsLG1heHRvdWNoLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW5wdXQvYXRtZWwsbWF4dG91Y2gudHh0CkBAIC0zMSw2ICszMSwxMiBAQCBPcHRpb25hbCBwcm9w
ZXJ0aWVzIGZvciBtYWluIHRvdWNocGFkIGRldmljZToKIAogLSByZXNldC1ncGlvczogR1BJTyBz
cGVjaWZpZXIgZm9yIHRoZSB0b3VjaHNjcmVlbidzIHJlc2V0IHBpbiAoYWN0aXZlIGxvdykKIAor
LSBhdmRkLXN1cHBseTogQW5hbG9nIHBvd2VyIHN1cHBseS4gSXQgcG93ZXJzIHVwIHRoZSBhbmFs
b2cgY2hhbm5lbCBibG9jaworICAgIG9mIHRoZSBjb250cm9sbGVyIHRvIGRldGVjdCB0aGUgdG91
Y2hlcy4KKworLSB2ZGQtc3VwcGx5OiBEaWdpdGFsIHBvd2VyIHN1cHBseS4gSXQgcG93ZXJzIHVw
IHRoZSBkaWdpdGFsIGJsb2NrCisgICAgb2YgdGhlIGNvbnRyb2xsZXIgdG8gZW5hYmxlIGkyYyBj
b21tdW5pY2F0aW9uLgorCiBFeGFtcGxlOgogCiAJdG91Y2hANGIgewpAQCAtMzgsNCArNDQsNiBA
QCBFeGFtcGxlOgogCQlyZWcgPSA8MHg0Yj47CiAJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8+
OwogCQlpbnRlcnJ1cHRzID0gPFRFR1JBX0dQSU8oVywgMykgSVJRX1RZUEVfTEVWRUxfTE9XPjsK
KwkJYXZkZC1zdXBwbHkgPSA8JmF0c3BfcmVnPjsKKwkJdmRkLXN1cHBseSA9IDwmdHNwX3JlZz47
CiAJfTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
