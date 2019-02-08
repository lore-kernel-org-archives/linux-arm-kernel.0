Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1933CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:36:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BFE2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CIArU7RK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bun0wgKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BFE2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oR58ZcLFrR1O3zbiMUQdqq8YYG5rryXaChNpKx8AtBc=; b=CIArU7RKlrKDPI
	NlYDWMEA/3BHIlH8Fgr1dXOGu1ml+jqkbXf5A7dvhOBHfKwy2oBvgvUC53638FaXQ/oKq+aSq1Jz9
	qx9eG1R9zJ/iEHQZr1sw8X/1MarnbW76qNsripAdiEbX3BsKqwa6siQXa6csyXja9KZHYwWgotEJI
	y523t2BPvY/0aS28J9yTCRWbf5/BhwLjn3IaxiHUkd7/QiRie5XXeM+HdAUX6ikiPeEfGv4/kHIE4
	AKmfhaaggLYGd4a/jqhHUFBkQ4IhtoSaJ01zcystETmyE4jpk7UT5p4g5QBGKTwsZzBkDFVEjkuBW
	Y8nFJSXs1Q629YdTaAGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsEkP-0006pX-MY; Fri, 08 Feb 2019 22:35:49 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsEkM-0006p4-N2
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 22:35:48 +0000
Received: by mail-pl1-x644.google.com with SMTP id p4so2340570plq.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i6GftFjwiUCvtcxvEAR034ySjK3PZ5xc2bnvkHKBDpk=;
 b=bun0wgKexaPR9h1OnV4KNy3aKndX2kD6XNTFbuR6SjmfPYmiiApvRoy+EDadujf8lr
 L6DiA66LmluEXijU+iVgYFs9wY+QXXCf81bQHP4QfS00zuGXMK2AsEKfclZoAWEp1jpO
 CVMMYWzNdbm+jPau6bNJ0StEAHUAKJ1B/FrDj/YovDMrGLhqW5250mMpiRSzKEvOWRCR
 BYl/fT7VKrpROvNNb7xSRMTNljt2JIv0jL0jYXgp6g3psaivxqLrTv26pUpuyqCOMoMW
 tdGzEva6qK6vbQVPGeafzaWet2C85C/8cZX22Xasad3TIgHCdQso7fuwSsiJ6oapASho
 +FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i6GftFjwiUCvtcxvEAR034ySjK3PZ5xc2bnvkHKBDpk=;
 b=WmQs9pYus8fHJeF1JEx2uS/8lu+lIKKgaSWBGNILmUkFOeOI1yglKoZyjXgxepZyVW
 x4ey7Xuh+nCkyDpNCXyjGcEmvaCuQT1Hb6WkD3P37w2vScxHG2QU4ZPfjz5wEWMbMOY7
 rLAlALLfPKOgG2IS9g8lyU4VV4METaTQLIOntF+iiR+VGWHIb8OGx9urLTsl59V6D/2G
 M6xFzGdK/sgdek+ghByBToaoz3fjhKOqpWwLPubAtNlkh+6iB07S8htNVsS1xm+szyyG
 qAtswJzFartExBQuc5cCpnz4Uz2enJy9CPG/Z4rtcEwXb8qoyiAxunwPRf9zAnYu8hLN
 vqIQ==
X-Gm-Message-State: AHQUAubeO0BG0ltPoHWPvCMcJrio7PvRhCmb0XtGLMFExFylx9jbvBaU
 HC4luS2ffvJTUDFhA2dtHHSeWQ==
X-Google-Smtp-Source: AHgI3IZbdR+luYjf6iojCCnmknIkV2mhrkTAJ9dJF/07q98Gth8zpCHzJpWXXtIH6n9fiUHHMtP57A==
X-Received: by 2002:a17:902:1008:: with SMTP id
 b8mr24548278pla.252.1549665345364; 
 Fri, 08 Feb 2019 14:35:45 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id h8sm3610634pgv.27.2019.02.08.14.35.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 14:35:44 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH] perf tools: Add proper header file for symbols
Date: Fri,  8 Feb 2019 15:35:43 -0700
Message-Id: <20190208223543.31836-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_143546_780249_6F285E51 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: suzuki.poulose@arm.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, jolsa@redhat.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWZ0ZXIgJ2NvbW1pdCBlMjJjMWM3NTExNDAgKCJwZXJmIHRocmVhZDogRG9uJ3QgaW5jbHVkZSBz
eW1ib2wuaCwKc3ltYm9sX2NvbmYuaCBpcyBlbm91Z2giKScKCkNvbXBpbGF0aW9uIG9mIHRoZSBw
ZXJmIHRvb2xzIGlzIGJyb2tlbiB3aGVuIHVzaW5nIHRoZSBmdW5jdGlvbmFsaXR5CnByb3ZpZGVk
IGJ5IHRoZSBvcGVuQ1NEIGxpYnJhcnk6CgpbLi4uXQoKLi4uICAgICAgICAgICAgICAgICAgICAg
ICB0aW1lcmZkOiBbIG9uICBdCi4uLiAgICAgICAgICAgICAgICAgIHNjaGVkX2dldGNwdTogWyBv
biAgXQouLi4gICAgICAgICAgICAgICAgICAgICAgICAgICBzZHQ6IFsgT0ZGIF0KLi4uICAgICAg
ICAgICAgICAgICAgICAgICAgIHNldG5zOiBbIG9uICBdCi4uLiAgICAgICAgICAgICAgICAgICAg
bGlib3BlbmNzZDogWyBvbiAgXQoKWy4uLl0KCiAgQ0MgICAgICAgdXRpbC9hcm0tc3BlLm8KICBD
QyAgICAgICB1dGlsL2FybS1zcGUtcGt0LWRlY29kZXIubwogIENDICAgICAgIHV0aWwvczM5MC1j
cHVtc2YubwogIENDICAgICAgIHV0aWwvY3MtZXRtLm8KICBDQyAgICAgICB1dGlsL3BhcnNlLWJy
YW5jaC1vcHRpb25zLm8KdXRpbC9jcy1ldG0uYzogSW4gZnVuY3Rpb24g4oCYY3NfZXRtX19tZW1f
YWNjZXNz4oCZOgp1dGlsL2NzLWV0bS5jOjI5NzoyNDogZXJyb3I6IHN0b3JhZ2Ugc2l6ZSBvZiDi
gJhhbOKAmSBpc27igJl0IGtub3duCiAgc3RydWN0ICBhZGRyX2xvY2F0aW9uIGFsOwoKQW5kIHJp
Z2h0bHkgc28gc2luY2UgZmlsZSBjcy1ldG0uYyBkb2Vzbid0IGluY2x1ZGUgc3ltYm9sLmgsIHNv
bWV0aGluZwp0aGF0IGlzIHJlY3RpZmllZCBpbiB0aGlzIHBhdGNoLgoKU2lnbmVkLW9mZi1ieTog
TWF0aGlldSBQb2lyaWVyIDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4KLS0tCiB0b29scy9w
ZXJmL3V0aWwvY3MtZXRtLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9jcy1ldG0uYyBiL3Rvb2xzL3BlcmYvdXRpbC9j
cy1ldG0uYwppbmRleCA4YjNmODgyZDZlMmYuLjBiMTFkNjUzY2ZiZSAxMDA2NDQKLS0tIGEvdG9v
bHMvcGVyZi91dGlsL2NzLWV0bS5jCisrKyBiL3Rvb2xzL3BlcmYvdXRpbC9jcy1ldG0uYwpAQCAt
MjUsNiArMjUsNyBAQAogI2luY2x1ZGUgIm1hY2hpbmUuaCIKICNpbmNsdWRlICJtYXAuaCIKICNp
bmNsdWRlICJwZXJmLmgiCisjaW5jbHVkZSAic3ltYm9sLmgiCiAjaW5jbHVkZSAidGhyZWFkLmgi
CiAjaW5jbHVkZSAidGhyZWFkX21hcC5oIgogI2luY2x1ZGUgInRocmVhZC1zdGFjay5oIgotLSAK
Mi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
