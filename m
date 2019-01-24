Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20A7C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:59:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54F3217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EKzEFhlk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jYpkP8v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54F3217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3POvWCqYaapY7yu59RwaqyxVvdKwEnxvR7nOGEMzA+k=; b=EKzEFhlk7qAQaB
	cZZKnoCJyjlgdZVEsohI6+MWrsR0W5CmYOLzns4Gb/JJE7l4V6UtFed5jze54wJ0NBu9DiTcLlWwf
	f41bwTIhxsGYqH6BJ+LV0LPwyzss3Rh0jJRi11WA5cP8IwshsAanO1l/N3Pr6l5F9CaX8DtR47DpX
	uXtNpBVno+cYJJnP9Lbla/OVT2cafrrvuR3bY3pV/JZd2y+KVKzcPZw2xKru3GsOwYU5Za0ppuSol
	cF9cWU5mtHjnQwFAjizTVZ7t7AekFbgyMoiGloj0L9nmxyDsnyiJVaovV9Jr6y/hAeTsseaJIVxTL
	hfbkToI7KrJMd2RJzesw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiLm-0001Nw-Gm; Thu, 24 Jan 2019 16:59:34 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiLS-00016u-52
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:59:27 +0000
Received: by mail-ed1-x543.google.com with SMTP id y20so5146208edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2vqXGdcBTElXpx8czNA3HuBOnAjGELcZxCvOFKHxtkg=;
 b=jYpkP8v8JScCko9UDYDq8LTLN/koJQMeUvxuelrwD2lzAxC/0EOydxFygEZgIRnpKC
 udT/XhyKwHbCPBsZ/ei+e4lS8m9kJLK3WLSQejxhUy2IBrWwFaA52nRyJFgW8K157OjY
 5Gyn+knKL/6FBCPjhEqmw7+UBnbiZwgNfuGKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2vqXGdcBTElXpx8czNA3HuBOnAjGELcZxCvOFKHxtkg=;
 b=IzGagcEsTNeAFcsRXrmIhgvnT6wSyqT1ee671qsAw99X+Wpd/O36KnfL+PtEdEHawQ
 GOdRAJjNj/V4dt5UPiLRkcrxMfCxiDUyqpe1ZOhDlAfRqfHNIpkYkutWVCDwwehhAQeW
 XYZeqvMsvG8CG7foWZjhNn0GKdg4Ig3uCeIzqDyF9HKhsEeptJERKCF39awU/pVF4iHZ
 TA8w6RQ7MF7gRd0805zT5/qAl3G49eFt1PoYOQzMk7lDcPvkAT4ugiIwX2/f9KI2/5V4
 EnUU7PatS2xsuW+VeQymfalOiVuwfjAcx0dUwohg48unyiaucmhCX5t+uhl7mbmcaYDq
 a2ZA==
X-Gm-Message-State: AJcUukfW+O3WT0zv8cib88o4O4QAFqeUqdXOqnGyIRYZ/8KuZk9yMtq4
 oVsG4AMvJEoaTnSHFl2rK6/8rQ==
X-Google-Smtp-Source: ALg8bN7cOL0YTkSOuQZjTVQOUZrzbYTzPVTRvraG0t2Eic45Tqm3ET1hI/oyywZ+01nx0xbi3JojUA==
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr4956818ejb.204.1548349152448; 
 Thu, 24 Jan 2019 08:59:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id w31sm11219233edw.82.2019.01.24.08.59.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 08:59:11 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 21/26] drm/rockchip: Use drm_fb_helper_fill_info
Date: Thu, 24 Jan 2019 17:58:26 +0100
Message-Id: <20190124165831.16427-22-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_085914_460705_C0DB24B5 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Daniel Vetter <daniel.vetter@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyB3aWxsIHNldCBhbiBmYiBuYW1lIGZvciB0aGUgZmlyc3QgdGltZSEKClNpZ25lZC1vZmYt
Ynk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgpDYzogU2FuZHkgSHVh
bmcgPGhqY0Byb2NrLWNoaXBzLmNvbT4KQ2M6ICJIZWlrbyBTdMO8Ym5lciIgPGhlaWtvQHNudGVj
aC5kZT4KQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogbGludXgt
cm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwotLS0KIGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hp
cC9yb2NrY2hpcF9kcm1fZmJkZXYuYyB8IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yb2Nr
Y2hpcC9yb2NrY2hpcF9kcm1fZmJkZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2Nr
Y2hpcF9kcm1fZmJkZXYuYwppbmRleCA3YmQzYjg5MDIyYmUuLmQxMjE2NDg3OGUwNSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9mYmRldi5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZmJkZXYuYwpAQCAtOTAsMTMg
KzkwLDExIEBAIHN0YXRpYyBpbnQgcm9ja2NoaXBfZHJtX2ZiZGV2X2NyZWF0ZShzdHJ1Y3QgZHJt
X2ZiX2hlbHBlciAqaGVscGVyLAogCQlnb3RvIG91dDsKIAl9CiAKLQlmYmktPnBhciA9IGhlbHBl
cjsKIAlmYmktPmZsYWdzID0gRkJJTkZPX0ZMQUdfREVGQVVMVDsKIAlmYmktPmZib3BzID0gJnJv
Y2tjaGlwX2RybV9mYmRldl9vcHM7CiAKIAlmYiA9IGhlbHBlci0+ZmI7Ci0JZHJtX2ZiX2hlbHBl
cl9maWxsX2ZpeChmYmksIGZiLT5waXRjaGVzWzBdLCBmYi0+Zm9ybWF0LT5kZXB0aCk7Ci0JZHJt
X2ZiX2hlbHBlcl9maWxsX3ZhcihmYmksIGhlbHBlciwgc2l6ZXMtPmZiX3dpZHRoLCBzaXplcy0+
ZmJfaGVpZ2h0KTsKKwlkcm1fZmJfaGVscGVyX2ZpbGxfaW5mbyhmYmksIGhlbHBlcik7CiAKIAlv
ZmZzZXQgPSBmYmktPnZhci54b2Zmc2V0ICogYnl0ZXNfcGVyX3BpeGVsOwogCW9mZnNldCArPSBm
YmktPnZhci55b2Zmc2V0ICogZmItPnBpdGNoZXNbMF07Ci0tIAoyLjIwLjEKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
