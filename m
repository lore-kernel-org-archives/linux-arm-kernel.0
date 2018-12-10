Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C809C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8142082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mzrbBKxF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzymLJJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OH7gHtOaz1b8Lvb0uAR5cDm2RWN4Iu/BhQpA7CezRM8=; b=mzrbBKxFpJqZzq
	IXarJ3fzms5vG+gdQ2c7ICZKMl0EnGi+XyPgt6BhpmAk2vEkJkdjxgi2tS05Tj6jTybSKzIl/RwgU
	3ng3wtZ7j388KVHgvl6ICYH9MGanJLOnkCeWA5zgSWUBh8gBy5qsjhNuBFhIeTN9vmkbSO+FZxVuS
	jtLfvDDnUGT03pgwtJmjEeXrPYSSkcvIHjUiaTKZyFf9OKU2ggYW1jgtgWxIutS5ncMM9fqQuxdW1
	/VYKhrN9q4PVHtZdmtVyzvAS1ihNfLByFFKm3oKOeZc1Jw3bRguI9yh7sO0usrG0GlHm4DEb3WKgZ
	t9on4Qr9wegUSyO4QMWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPUQ-0000Cx-Me; Mon, 10 Dec 2018 17:37:06 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPU2-00085X-6y
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:36:49 +0000
Received: by mail-pg1-x542.google.com with SMTP id z10so5282050pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
 b=NzymLJJRnKatfmJWgRKG8bAq9MZ+HEbSo4SRHnje6au6eEkc0sG2Er84QFmA408r+A
 SQNOyVrFo86xbbJh1AzLkGfjulDB4R5i628VHW6i9kgw+7OEg/yhiWgo5NN3pZKoEgqa
 MU7U04cpHLakl7+WS4tZ57/DGLoVtMd2iXAaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
 b=gyxaF27hrbvo9CNNP8hKpKDLDHQXTiARsQlEM6lJVT8tkiGWXI8ym7Gm9sSW6TUJ1y
 E8btp5WI/pLv+t86pjFYzoQ3n/HmzDmilxmIqF7sfo98YqBaT+cNQsgwnml567Cg5PQ0
 oE4S2+9axkMIirz8/oUWaXuamfOkTqWkarNVOfNw4fVQ326/o5Y30X3YUJxCMWqFKGls
 jjmFGmFPG85vxJH2IrQtiqBLkHCKowixtq0Yyy3CPZHwBDGHoNhy5OJ99/vi7WB4SLKo
 Ib8U8sgESW7EFQcbcTK/1hjuhNSiyFXx9Ar2Sjq3la+q1ab+3kqO6P4MBwKmAv+rrBdM
 dlhw==
X-Gm-Message-State: AA+aEWaPltnkx22ALSer/8S0hq9Zz+dLIlzPwz8YPwbIfkz4Qe4gzB93
 n7zieg42rjnCHow3Wdf5XFD+
X-Google-Smtp-Source: AFSGD/VeKFlAbjV+Wv3oSkXN/rie9y004cGnmF45hstwcDBq4L4ChwC8sHpHRdv6kpM1qSymRmwXhg==
X-Received: by 2002:a65:4784:: with SMTP id e4mr11363289pgs.12.1544463391519; 
 Mon, 10 Dec 2018 09:36:31 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:36:30 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 03/15] ARM: Prepare RDA8810PL SoC
Date: Mon, 10 Dec 2018 23:05:38 +0530
Message-Id: <20181210173550.29643-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_093642_771743_ACDD09EA 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKSW50cm9kdWNlIEFSQ0hf
UkRBIGFuZCBtYWNoLXJkYSBmb3IgUkRBIE1pY3JvIFNvQ3MuCgpTaWduZWQtb2ZmLWJ5OiBBbmRy
ZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+Ci0tLQogYXJjaC9h
cm0vS2NvbmZpZyAgICAgICAgICAgfCAyICsrCiBhcmNoL2FybS9NYWtlZmlsZSAgICAgICAgICB8
IDEgKwogYXJjaC9hcm0vbWFjaC1yZGEvS2NvbmZpZyAgfCA5ICsrKysrKysrKwogYXJjaC9hcm0v
bWFjaC1yZGEvTWFrZWZpbGUgfCAxICsKIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtcmRhL0tjb25maWcKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL0tjb25maWcgYi9hcmNoL2FybS9LY29uZmlnCmluZGV4IDkxYmU3NGQ4ZGY2NS4uMDg0ZjA5
ODNlNmIyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9LY29uZmlnCisrKyBiL2FyY2gvYXJtL0tjb25m
aWcKQEAgLTgwNCw2ICs4MDQsOCBAQCBzb3VyY2UgImFyY2gvYXJtL3BsYXQtcHhhL0tjb25maWci
CiAKIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1xY29tL0tjb25maWciCiAKK3NvdXJjZSAiYXJjaC9h
cm0vbWFjaC1yZGEvS2NvbmZpZyIKKwogc291cmNlICJhcmNoL2FybS9tYWNoLXJlYWx2aWV3L0tj
b25maWciCiAKIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1yb2NrY2hpcC9LY29uZmlnIgpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vTWFrZWZpbGUgYi9hcmNoL2FybS9NYWtlZmlsZQppbmRleCAwNWE5MWQ4
Yjg5ZjMuLjEwMDU2Y2NkYjhiZSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vTWFrZWZpbGUKKysrIGIv
YXJjaC9hcm0vTWFrZWZpbGUKQEAgLTIwMiw2ICsyMDIsNyBAQCBtYWNoaW5lLSQoQ09ORklHX0FS
Q0hfT1JJT041WCkJCSs9IG9yaW9uNXgKIG1hY2hpbmUtJChDT05GSUdfQVJDSF9QSUNPWENFTEwp
CSs9IHBpY294Y2VsbAogbWFjaGluZS0kKENPTkZJR19BUkNIX1BYQSkJCSs9IHB4YQogbWFjaGlu
ZS0kKENPTkZJR19BUkNIX1FDT00pCQkrPSBxY29tCittYWNoaW5lLSQoQ09ORklHX0FSQ0hfUkRB
KQkJKz0gcmRhCiBtYWNoaW5lLSQoQ09ORklHX0FSQ0hfUkVBTFZJRVcpCQkrPSByZWFsdmlldwog
bWFjaGluZS0kKENPTkZJR19BUkNIX1JPQ0tDSElQKQkJKz0gcm9ja2NoaXAKIG1hY2hpbmUtJChD
T05GSUdfQVJDSF9SUEMpCQkrPSBycGMKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcmRhL0tj
b25maWcgYi9hcmNoL2FybS9tYWNoLXJkYS9LY29uZmlnCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAwMC4uMWVhNzUzZjU3YjJkCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9h
cm0vbWFjaC1yZGEvS2NvbmZpZwpAQCAtMCwwICsxLDkgQEAKK21lbnVjb25maWcgQVJDSF9SREEK
Kwlib29sICJSREEgTWljcm8gU29DcyIKKwlkZXBlbmRzIG9uIEFSQ0hfTVVMVElfVjcKKwlzZWxl
Y3QgQ09NTU9OX0NMSworCXNlbGVjdCBHRU5FUklDX0lSUV9DSElQCisJc2VsZWN0IFJEQV9JTlRD
CisJc2VsZWN0IFJEQV9USU1FUgorCWhlbHAKKwkgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciB0
aGUgUkRBIE1pY3JvIDg4MTBQTCBTb0MgZmFtaWx5LgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFj
aC1yZGEvTWFrZWZpbGUgYi9hcmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZQpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjZiZWEzZDNhMmRkNwotLS0gL2Rldi9udWxsCisr
KyBiL2FyY2gvYXJtL21hY2gtcmRhL01ha2VmaWxlCkBAIC0wLDAgKzEgQEAKK29iai0gKz0gZHVt
bXkubwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
