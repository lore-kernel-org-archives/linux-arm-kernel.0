Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A93BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2859520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aYtSmi/a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="V6H/psgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2859520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1DkUrJSl2g5tHiyIfXVElYSoyNX/Gw7E+jSyYaLf41s=; b=aYtSmi/ajSdZpT
	jVICI8ZznLCaUuaPzdOoBTmceOi9VXBcIg2SBQfk8qN5DQBhxYy1w9wJGKf8UDXBVX0fX+kG2la/J
	zbaDkdkfCfIcmvt0P+k1XVXDj8EdUilnesU//oZxN4o4f1cfztkFDblik+QCL+ahutQfMYc0c5HUQ
	rhiEtsB/b4R6K74KrUELnlhPWuhhACftMYDR+0qncc+hMEwyxKbLIkGfALWbvdBnqnSjyOF8w09eK
	auCgUYfZXdDGQp+lvYjXjbB4APjKhs73N2b9JPVOT46+hyIz151Gl8jLYeIw8sigDzDCtp2C3QCar
	v2fW4aKIhLhhCj6+d+4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZunF-0000rn-H6; Thu, 20 Dec 2018 09:39:01 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZunB-0000qB-H3
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:38:59 +0000
Received: by mail-pl1-x641.google.com with SMTP id u6so611196plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ingics-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1iUhDhIZ1xk9FGjJuaNFZaLpj2B2Rjon4JycLrDK7TY=;
 b=V6H/psgfubi2ZpcX1KcSuZloVb87/jIk1GnDUZsltHeipuJkZ8f1VCoPynfhff1c1c
 EjKaN2uhgMOBCosjaufOAgCgYu+yMrJTw9Pf8cSTV4+WQeQ7Robjx0IfkzT4wjLkjK4U
 KGCYr5aDhHM4RxbLQePEcLHD+B1gsIi0/R0dq4r0Zv/41Wa+iHcOGcyULZ4SIYksDuZY
 KmVajrBL/UhTdupusqU5tE8x0Udtj3Z+AY1gIP4Poke2NQKFmVR62BPjMyUcuHeQ+wRE
 la2b1qMCh8g2l0tE9y4v1ww1Of6sZQS8o6vv1HYgdDtPWAx2eJKawAOu9yhVD49y0c6R
 SDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1iUhDhIZ1xk9FGjJuaNFZaLpj2B2Rjon4JycLrDK7TY=;
 b=OvxA+Jypwm0KdXD1O1wGwsLc/8DopQYFUo6EtGL2vCvrPAcGLP2/Zca0P2SHjM667V
 afdA02mtS8HWt47XgT7RnjOVhdxJX9zXPZ43m9ziGbXnPa4NdrQTYH9c+t/AaBhAJofd
 J6YLSTnXTuwEnuSfpPlwPpIWT9211w+HcKB9NjcPQF7+e09+TLGVgq0SXvmDrN3gQ56s
 iOIEQmH8uEKWLXmSLT5wInQUvjdJtZU18jitPGDsl6Y+j/CGWTiIgRqusDNAjLlUcsRF
 OU9aDTMEf6YQeYjySIHkJsofKc3TqfaYZoVM6FJq19A+lqMbnb2fMzXryJOlI/XNOw03
 MkUA==
X-Gm-Message-State: AA+aEWazHNGWWZ3GEIJv8ogyI23Kou6CNoyX6e2BNkUlsJptXCsba4gK
 lMp45o+22UDQrvLcDAUzORAtow==
X-Google-Smtp-Source: AFSGD/U5p2Hoh5L4wPl040c5puKaXDHXPlrwcGXU2WsuUxZPDgnM90oglNVymgFW7rT5l7V7v45A/A==
X-Received: by 2002:a17:902:4a0c:: with SMTP id
 w12mr23741384pld.8.1545298725645; 
 Thu, 20 Dec 2018 01:38:45 -0800 (PST)
Received: from localhost.localdomain (36-239-205-170.dynamic-ip.hinet.net.
 [36.239.205.170])
 by smtp.gmail.com with ESMTPSA id j6sm32194261pfg.126.2018.12.20.01.38.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 01:38:44 -0800 (PST)
From: Axel Lin <axel.lin@ingics.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: mcp16502: Fix build error when !CONFIG_SUSPEND &&
 CONFIG_PM_SLEEP
Date: Thu, 20 Dec 2018 17:38:28 +0800
Message-Id: <20181220093828.28821-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_013858_217450_1F00B010 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: Axel Lin <axel.lin@ingics.com>,
 Andrei Stefanescu <andrei.stefanescu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VXNlICNpZmRlZiBDT05GSUdfUE1fU0xFRVAgZ3VhcmQgYXJvdW5kIHN1c3BlbmRfZm4vcmVzdW1l
X2ZuIHRvIGZpeCBiZWxvdwpidWlsZCBlcnJvci4KCiAgQ0MgW01dICBkcml2ZXJzL3JlZ3VsYXRv
ci9tY3AxNjUwMi5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvZGV2aWNl
Lmg6MjM6MCwKICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9ncGlvL2RyaXZl
ci5oOjUsCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvYXNtLWdlbmVyaWMvZ3Bpby5o
OjEzLAogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2dwaW8uaDo2MiwKICAg
ICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmM6MTE6CmRyaXZl
cnMvcmVndWxhdG9yL21jcDE2NTAyLmM6NTI4OjMyOiBlcnJvcjog4oCYbWNwMTY1MDJfc3VzcGVu
ZF9ub2lyceKAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKTsgZGlkIHlvdSBt
ZWFuIOKAmG1jcDE2NTAyX3N1c3BlbmTigJk/CiAgU0VUX05PSVJRX1NZU1RFTV9TTEVFUF9QTV9P
UFMobWNwMTY1MDJfc3VzcGVuZF9ub2lycSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeCi4vaW5jbHVkZS9saW51eC9wbS5oOjM0MjoxOTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBt
YWNybyDigJhTRVRfTk9JUlFfU1lTVEVNX1NMRUVQX1BNX09QU+KAmQogIC5zdXNwZW5kX25vaXJx
ID0gc3VzcGVuZF9mbiwgXAogICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fgpkcml2ZXJzL3Jl
Z3VsYXRvci9tY3AxNjUwMi5jOjUyOToxMDogZXJyb3I6IOKAmG1jcDE2NTAyX3Jlc3VtZV9ub2ly
ceKAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKA
mG1jcDE2NTAyX3N1c3BlbmRfbm9pcnHigJk/CiAgICAgICAgICBtY3AxNjUwMl9yZXN1bWVfbm9p
cnEpCiAgICAgICAgICBeCi4vaW5jbHVkZS9saW51eC9wbS5oOjM0MzoxODogbm90ZTogaW4gZGVm
aW5pdGlvbiBvZiBtYWNybyDigJhTRVRfTk9JUlFfU1lTVEVNX1NMRUVQX1BNX09QU+KAmQogIC5y
ZXN1bWVfbm9pcnEgPSByZXN1bWVfZm4sIFwKICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+CgpT
aWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AaW5naWNzLmNvbT4KLS0tCiBkcml2ZXJz
L3JlZ3VsYXRvci9tY3AxNjUwMi5jIHwgNyArKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9y
L21jcDE2NTAyLmMgYi9kcml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUwMi5jCmluZGV4IGVjNWI2ODM2
YTIwYy4uMjUwN2FjYjdmNWRjIDEwMDY0NAotLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUw
Mi5jCisrKyBiL2RyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMKQEAgLTQ5OCw3ICs0OTgsNyBA
QCBzdGF0aWMgaW50IG1jcDE2NTAyX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsCiAJ
cmV0dXJuIDA7CiB9CiAKLSNpZmRlZiBDT05GSUdfU1VTUEVORAorI2lmZGVmIENPTkZJR19QTV9T
TEVFUAogc3RhdGljIGludCBtY3AxNjUwMl9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRl
dikKIHsKIAlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwpA
QCAtNTE4LDEwICs1MTgsNyBAQCBzdGF0aWMgaW50IG1jcDE2NTAyX3Jlc3VtZV9ub2lycShzdHJ1
Y3QgZGV2aWNlICpkZXYpCiAKIAlyZXR1cm4gMDsKIH0KLSNlbHNlIC8qICFDT05GSUdfU1VTUEVO
RCAqLwotI2RlZmluZSBtY3AxNjUwMl9zdXNwZW5kIE5VTEwKLSNkZWZpbmUgbWNwMTY1MDJfcmVz
dW1lIE5VTEwKLSNlbmRpZiAvKiAhQ09ORklHX1NVU1BFTkQgKi8KKyNlbmRpZgogCiAjaWZkZWYg
Q09ORklHX1BNCiBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgbWNwMTY1MDJfcG1fb3Bz
ID0gewotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
