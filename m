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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F78C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B3E206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="otAZFRbU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFo9zzpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B3E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KXmVR8w92lcQ3u3lqeldaLULp4/orSZtzZyMwqZenrI=; b=otAZFRbU4vj72W
	xQZKWmSg+yLUksmigfEbxgu0633F8fvIoRfcy4UxYM70kvs5FBj/mepzethXomSjoPPeoBoqwG4xX
	MjlsjtRx50O2Q22otv8bp0OBrCwbO4BoQ8dHsTOoBSW6mCyFEDDpzZTMNk5XXwxYuXtQ8FHt783je
	7lC+fJ5vNvdvDcnMy+05AYiax/olKRIdkPZc4a09+fpdEzQrhqp5da/ov/lybXoGSnJLfQjuB/p5c
	Emz4R/+KnjREbCn3TPKsdUX7RjGfvJTDjalJybp5W3FXn7zCJylhWGbl9fL/f+y4nQ55Px5gm1NAW
	/UWGjnPk0B9bhdRm56Cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXpAZ-0002aM-NZ; Fri, 14 Dec 2018 15:14:27 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp93-0001H4-Pk
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:13:06 +0000
Received: by mail-lj1-x244.google.com with SMTP id e5-v6so5196103lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qRMbrgz6GRxf6yeDCa+/ThuxnntpY3MOarYovcWFQ6M=;
 b=pFo9zzpzSc9AuhqD6m4diBv0MXXAqoaMxuil29dqVQwAj++oSDyUmNFyzDoFMjZ5hQ
 OBI0rcJKuz+jbyRYj4YhYRWWq55tPxud0M3BDLDM4+VuQ+/iyezGEE7qfjtDkLKjygjr
 9wiVJMKnziGIUYhded+0llC7JTSXRc/kC3uLkXgmlOaYDu3EIxAou/NAKhE5NvnGRwN4
 PH7UFeLYm8f2I8EmzyxuJiFtvCCDlNU92KxbgMNAa/AOiRV2U7HyKS76CUT/wdiDymzn
 Es+dIDlXTYtzxrO8y7X5cX/fQhSE2Zt70jBdcvndi7vSVftZc4HJNFWhhR8ONKMXXyhc
 9NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qRMbrgz6GRxf6yeDCa+/ThuxnntpY3MOarYovcWFQ6M=;
 b=GTtzl3fwb8dufXPgsBa6RMBZv+l5tpTn058n2sKlr11nTY/cR6kP+4HRWPZZZMWuIQ
 bubOdp/mBM1ZkxG1UMHYWMAOrcBlMtO0h6qjdHzX3pBXF4rnvMduOpb5wL+yfH66MPCQ
 lG3+cpthYXtk4lgTvdoIxWLUUTuqfVpW988CWa3Wf0DCitvkLVzexO0qbEQzPIOezL6C
 NpXwQjZIaSHvzFDkU0Rmf4b2EdpRS50RkK2gAnT32RVmk6FTkYViC7Kwjm6aEx5KjYQT
 9a0iiLsUGTL6AEvdfvnm4J+d86L5msiCL8vJDyiAKYTtunnrRAgxW5NnGGa+6bPavxwd
 l6fQ==
X-Gm-Message-State: AA+aEWY8e3biRvHdEyvPSo85WntYWw9B+WAxLhsElji8c3KM7Hz7Oy14
 p4Rv+QjaxbXwRxP7NKlmHjYmkw7efTE=
X-Google-Smtp-Source: AFSGD/VOnrKfX1vyv8a22wLq9u3naOibHehdLcak71xwAg9pclRRKGzlRDURaL0/8ScC700m9cy/Uw==
X-Received: by 2002:a2e:5054:: with SMTP id
 v20-v6mr2102682ljd.45.1544800361634; 
 Fri, 14 Dec 2018 07:12:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
 by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 07:12:41 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v5 2/3] Input: atmel_mxt_ts: Wait for device be ready for
 communication
Date: Fri, 14 Dec 2018 16:12:13 +0100
Message-Id: <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071254_155994_2957BFF0 
X-CRM114-Status: GOOD (  13.89  )
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

QWNjb3JkaW5nIHRvIGRvY3VtZW50YXRpb24sIGRldmljZSBpc24ndCByZWFkeSBmb3IgY29tbXVu
aWNhdGlvbiwKdW50aWwgZmlybXdhcmUgYXNzZXJ0cyB0aGUgQ0hHIGxpbmUuIEFkZCBtaXNzaW5n
IHdhaXQgZm9yIHRoaXMuCgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtv
bGFqLmNobWllbEBnbWFpbC5jb20+Ci0tLQpDaGFuZ2VzIGZyb20gdjE6CiAgLSBGaXggY2hlY2tw
YXRjaCBpc3N1ZXMKLS0tCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2F0bWVsX214dF90cy5j
IHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYyBiL2RyaXZl
cnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMKaW5kZXggNTVhMTA3ZmMxYjczLi5l
ODk0OWM2Y2VhZmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxf
bXh0X3RzLmMKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYwpA
QCAtMjAyLDYgKzIwMiw3IEBAIGVudW0gdDEwMF90eXBlIHsKICNkZWZpbmUgTVhUX0NSQ19USU1F
T1VUCQkxMDAwCS8qIG1zZWMgKi8KICNkZWZpbmUgTVhUX0ZXX1JFU0VUX1RJTUUJMzAwMAkvKiBt
c2VjICovCiAjZGVmaW5lIE1YVF9GV19DSEdfVElNRU9VVAkzMDAJLyogbXNlYyAqLworI2RlZmlu
ZSBNWFRfUE9XRVJPTl9ERUxBWQkxNTAJLyogbXNlYyAqLwogCiAvKiBDb21tYW5kIHRvIHVubG9j
ayBib290bG9hZGVyICovCiAjZGVmaW5lIE1YVF9VTkxPQ0tfQ01EX01TQgkweGFhCkBAIC0zMDcw
LDYgKzMwNzEsMTYgQEAgc3RhdGljIGludCBteHRfcmVndWxhdG9yX2VuYWJsZShzdHJ1Y3QgbXh0
X2RhdGEgKmRhdGEpCiAJCW1zbGVlcChNWFRfUkVHVUxBVE9SX0RFTEFZKTsKIAkJZ3Bpb2Rfc2V0
X3ZhbHVlKGRhdGEtPnJlc2V0X2dwaW8sIDEpOwogCQltc2xlZXAoTVhUX1JFU0VUX0lOVkFMSURf
Q0hHKTsKKworcmV0cnlfd2FpdDoKKwkJcmVpbml0X2NvbXBsZXRpb24oJmRhdGEtPmJsX2NvbXBs
ZXRpb24pOworCQlkYXRhLT5pbl9ib290bG9hZGVyID0gdHJ1ZTsKKwkJZXJyb3IgPSBteHRfd2Fp
dF9mb3JfY29tcGxldGlvbihkYXRhLCAmZGF0YS0+YmxfY29tcGxldGlvbiwKKwkJCQkJCU1YVF9Q
T1dFUk9OX0RFTEFZKTsKKwkJaWYgKGVycm9yID09IC1FSU5UUikKKwkJCWdvdG8gcmV0cnlfd2Fp
dDsKKworCQlkYXRhLT5pbl9ib290bG9hZGVyID0gZmFsc2U7CiAJfQogCiAJcmV0dXJuIDA7Ci0t
IAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
