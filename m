Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06DDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626620867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rOG+CXJ4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPPwxdEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OTnQK9/rySYFRTNiaSfvazZMjkJRKabCAW1FSSlbYYs=; b=rOG+CXJ4Hq9CLJ
	tELEZF4CpgsU8zblTd8JrNueR+vUW8Yg26myoOZsne+Gn3SxEPKu9bxE8bHyTWPYH9wtEY3xzw9k6
	GikGdYI726mK/eSo7qTJd4ktmZndwEi2hVgkIsFB6+uSzD4fGFqwvzfUUd+ih3kP9Q+IunQWUsqR8
	vuvaUqXayHZ3GaGztOI1gWmn4jODVnEcm9gTE72m1LTK9kZsBpXZjSC9xOMZfgI/CZtnErvb84Ogo
	/6MS5IFPme3aGUQW/wmNzrCa65qEe49d0SqB7HnpoPHBLTcQmg+OCcMgQGwfejSlgbetg/+4tzagI
	GOY1X+FRVYcE549UFNBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnAI-0001In-3N; Fri, 30 Nov 2018 18:05:22 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnAE-0000wy-BN
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:05:19 +0000
Received: by mail-lf1-x143.google.com with SMTP id b20so4724230lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ORrA66Jnsk2VmedMEWnNRYYi8IYilYtn+Su4c6IixN8=;
 b=nPPwxdEyQj9sT80fPOn1XnDy5MqcfYBpqUJtSnxw6qdjPA4FuoKb6khtnFcvGL9yNa
 fdVgdo9DErlTwps69SF5LsXM8X4dOlCizYSqDJoWgig4YXBEBGcLLgaND7haU1WIpw5U
 new5dGxAOtgOEoW66tBtzzfu/Ft4ZNKSvKmoOh72DaL9h2Gchhz36b+GCeCIMjGj0ihd
 6XeozdlpyaxO30Q+zRLFkQG5xT4GFuU00/xM5GwORovr3l/AxgIsq25xihjYoREIQQ00
 mEXAbWpx/gYsBrHw8TATZRR7gxwew2U4eQaM3MKcBuM/Vso4szC+isavFPv26as/gbK8
 /HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ORrA66Jnsk2VmedMEWnNRYYi8IYilYtn+Su4c6IixN8=;
 b=UiNajO4r9muR6++yLokKvyIwcFX9MD04//KIQ948GCI3GDIpfycPJKu7XdKXzmRc/E
 /EXfXCa8YgjrB5TEZ1kQ3TORfesRUoHcxyCJZeKW1I9LWTWL4S58BJ2V6KAk0jQawZkZ
 wLBPaSkJNhe8uJGSOYo0DEI6U5HR/QfvopBv8cNwVSFmnJYwkEFloYENVOgFOycLaXy2
 /QwFGQqJFtx5xJbh3Jk7MaVf67r+r+0K+2lyILjeJFxM2/ugjeTC61+JF1qTRLHgD5SF
 wocrzHbz1Ro3i1taOJG3Skgf3g2vkoIK0B18iAhEF6v9uaB08qOjtvq5JnSigikAxTNI
 X9Jw==
X-Gm-Message-State: AA+aEWbhdoi5V5flTNUepH+LebLL87nAUGzTI2v9NeUlwmY5oE8/yr9y
 /zDD5Rq81XftUYfk9Dhuc+A=
X-Google-Smtp-Source: AFSGD/VnLu/Gc48tTZjyAcqkqZJHYLTSydEi5RyJxIX3CKuyV6rPMYw0AR9uz1fkoMIKxYFhN0cfEw==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr4332600lfb.72.1543601105901;
 Fri, 30 Nov 2018 10:05:05 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:dd88:5bb0:9191:dab2])
 by smtp.googlemail.com with ESMTPSA id q6sm922199lfh.52.2018.11.30.10.05.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 10:05:05 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH] ARM: dts: s5pv210: Add s5p-jpeg codec node.
Date: Fri, 30 Nov 2018 19:04:23 +0100
Message-Id: <20181130180423.9421-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_100518_418005_D14907DF 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgYWRkcyBub2RlIGZvciBzNXAtanBlZyBjb2RlYywKd2hpY2ggaXMgcHJlc2Vu
dCBpbiBTNVBWMjEwIFNPQy4KClNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1p
a29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0
c2kgfCA5ICsrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRz
L3M1cHYyMTAuZHRzaQppbmRleCA3NWY0NTRhMjEwZDYuLjEyZWFjODkzMGVhYyAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L3M1cHYyMTAuZHRzaQpAQCAtNjI3LDYgKzYyNywxNSBAQAogCQkJCXNhbXN1bmcsbGNkLXdiOwog
CQkJfTsKIAkJfTsKKworCQlqcGVnX2NvZGVjOiBqcGVnLWNvZGVjQGZiNjAwMDAwIHsKKwkJCWNv
bXBhdGlibGUgPSAic2Ftc3VuZyxzNXB2MjEwLWpwZWciOworCQkJcmVnID0gPDB4ZmI2MDAwMDAg
MHgxMDAwPjsKKwkJCWludGVycnVwdC1wYXJlbnQgPSA8JnZpYzI+OworCQkJaW50ZXJydXB0cyA9
IDw4PjsKKwkJCWNsb2NrcyA9IDwmY2xvY2tzIENMS19KUEVHPjsKKwkJCWNsb2NrLW5hbWVzID0g
ImpwZWciOworCQl9OwogCX07CiB9OwogCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
