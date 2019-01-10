Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375B02173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kSWkEJJZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syQrfQTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375B02173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4gCeN3RkBHw9gaYD6fMys2hRLy384HQ1zipA0TFJ89c=; b=kSWkEJJZ4Y27lD
	4qgdyXYs3e/5cljAEKDjfy4gesykidTBfHnOWhlCGvXvtgSh5/Pu/+U6etLyesIryV5dg/fAitd4z
	knmLHhrbYha3KK36iVyuwcIfrKvYxex/EDXMobM23TjmOA0GRfmPQzVIkd5hicXobjIYe7/RDm3rT
	4MjeYVtkdCSctHpc6GJ+ewWDQoT8dldKpnWzRK3cfz0aElWQBXMdMgiPtrzn5bbj4EY04nhOSPJQk
	a9IGvgryClIcVjeHY5B6FynjstK9NHWkWYgtSQidy0+Gz7cVUiv0cHm26ghMsE3/0THDrVY8SJ2u4
	95etR4CWTljGMvWtA+3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhKI-0001nG-0u; Thu, 10 Jan 2019 20:53:18 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhKE-0001lv-JG
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:53:16 +0000
Received: by mail-lf1-x142.google.com with SMTP id v5so9302520lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+eSlKha60Px6UNpdnXSUR6EysfM1BrF6z25Bgwx9Baw=;
 b=syQrfQTQs9KEuxcdxHKh/J8TQDTXYNQXWajawLtDCuKIr8Xs+EQIyINcpDDD4iV39u
 SzHmgdPFUB4u1PNUNNxzgu5aVsa9395Kmnu0LzHLYmnLrXqSBoAAYr219egJf9U5B2gT
 +IQ3lMp7mV3A2A/MpPNNQ3N41WI0k6YWe4nUK7yMiz46ZlnUG/HHCo94+5LQoximT5t7
 h2PcR4B1LETbvc0kKeZ9PHd+7hNqkQPLG4if8pE0yyFjcLHGRGkud8+rH+/Xt5SgszEp
 CcHaa9PIMdWehX18NEhjyqdX2m8ZbSOC0I1DP4U+vm0eCIahbw4/nHPecZCNvi5z/G/n
 +XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+eSlKha60Px6UNpdnXSUR6EysfM1BrF6z25Bgwx9Baw=;
 b=AlP7Ld0WMp3jPIE3PpvfaoVVSUJ1XPSPY3MVhtgqsFM4m6sNqfZXNGqCMKiPCRe6FG
 12CJLNMBSDYif1A2rksEcw6nRJfO1CXNyx4u8iURRZ8PQaXivPrNcA6LPg9CvcBfPR9g
 52yRYse2uhv1ZQhxwQOYVx4l4gLVHWt3lJhvJIb/xqRfx2gxNnn7zaZEUnIePyfZwCoA
 T2SfqK2bvvnStcUDEUssZUXLAXnVCwqPfBvAa9ghpV3GoAf6Y6ZetsT4dmxE7mpBk6tY
 y3ROrXTHrTiIjvFCKRTDp2PT/YuU0v4WaAmwxqMCgyZLFwyhLYP1sOogs/MFadA5LjaN
 34xA==
X-Gm-Message-State: AJcUukegar5fDecNGLPAnsIS1wy+H8V+4BTgS/brb5NCvjgbNksV4dwS
 k65OWsZQ0+iswPlfkGh2va8=
X-Google-Smtp-Source: ALg8bN5yVCtk0zO/TczaR04e9HTgOfd/c5nRqiqJXlWlxRa65MMcLq2etLGQG3et7RgZkQjlwp1lIw==
X-Received: by 2002:a19:ef15:: with SMTP id n21mr7162146lfh.21.1547153591755; 
 Thu, 10 Jan 2019 12:53:11 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
 by smtp.googlemail.com with ESMTPSA id
 z7-v6sm15389690lji.42.2019.01.10.12.53.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 12:53:10 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH v2 0/4] ARM: dts: s5pv210: Enable cpufreq support
Date: Thu, 10 Jan 2019 21:52:11 +0100
Message-Id: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_125314_657936_3432DEFD 
X-CRM114-Status: GOOD (  12.14  )
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
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaHNldCBlbmFibGVzIGNwdWZyZXEgc3VwcG9ydCB1c2luZyBzNXB2MjEwLWNwdWZy
ZXEgZHJpdmVyLgoKRmlyc3QgcGF0Y2ggYWRkcyBtaXNzaW5nIGRtYyBub2Rlcywgd2hpY2ggYXJl
IHJlcXVpcmVkIGJ5IGRyaXZlci4KClNlY29uZCBwYXRjaCBpcyBjb3NtZXRpYywgaXQgc3RvcHMg
ZHJpdmVyIGZyb20gZmxvb2Rpbmcga2VybmVsIGxvZyB3aXRoCiBtZXNzYWdlcywgYWZ0ZXIgZXZl
cnkgY2hhbmdlIG9mIGZyZXEuCgpUaGlyZCBwYXRjaCBhZGRzIGRlZmVyIHByb2JlIHN1cHBvcnQg
Zm9yIHJlZ3VsYXRvcnMsIG5lZWRlZCBieSBkcml2ZXIuCkl0IHdhcyBvYnNlcnZlZCwgdGhhdCB0
aG9zZSByZWd1bGF0b3JzIGNhbiBiZSBubyB5ZXQgaW5pdGlhbGl6ZWQsIHdoZW4KIGRyaXZlciBp
cyBwcm9iZWQsIHNvIHdlIHNob3VsZCB3YWl0IHRpbGwgd2UgY2FuIGdldCB0aGVtLgoKTGFzdCBw
YXRjaCBlbmFibGVzIHJlcXVpcmVkIGtlcm5lbCBjb25maWcgb3B0aW9ucy4KCkNoYW5nZXMgZnJv
bSB2MToKICAtIEFkZGVkIEFja2VkLWJ5IHRvIG9uZSBvZiBwYXRjaGVzCiAgLSBGaXggY29tcGls
YXRpb24gZXJyb3IgYWZ0ZXIgY2hhbmdlcyBpbiBkcml2ZXIKICAtIFJlb3JnYW5pemUgY29kZSAo
c28gaXQncyBzbWFsbGVyKSwgaW5zaWRlIHBhdGNoIHdoaWNoIGxvZ3MgaW5mb3JtYXRpb24KICAg
IGFib3V0IGRlZmVyZWQgcHJvYmUgb2YgcmVndWxhdG9ycwoKUGF3ZcWCIENobWllbCAoNCk6CiAg
QVJNOiBkdHM6IHM1cHYyMTA6IEFkZCBkbWMgbm9kZXMKICBjcHVmcmVxOiBzNXB2MjEwOiBEb24n
dCBmbG9vZCBrZXJuZWwgbG9nIGFmdGVyIGNwdWZyZXEgY2hhbmdlCiAgY3B1ZnJlcTogczVwdjIx
MDogRGVmZXIgcHJvYmUgaWYgZ2V0dGluZyByZWd1bGF0b3JzIGZhaWwKICBBUk06IGRlZmNvbmZp
ZzogczVwdjIxMDogQWRkIGNwdWZyZXEgc3VwcG9ydAoKIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYy
MTAuZHRzaSAgICAgfCAxMiArKysrKysrKysrKwogYXJjaC9hcm0vY29uZmlncy9zNXB2MjEwX2Rl
ZmNvbmZpZyB8ICA2ICsrKysrKwogZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jICB8
IDM0ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzOCBp
bnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
