Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B71C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E01D20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L6wKXPi7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e11A58l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E01D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tTGt/FfIRYHY2bYXQXlsZ2X7WEAhc91eZO/pacersWU=; b=L6wKXPi73NEv/0
	qv4yTu7zzuFLx3c1+bjcCzT9Y02brpFDKCDYqVxn6+iEOyedtuw/CbBJRdw3grN8yy5vP7u4mIcOg
	lcnpOEXBBEqp9Lsdv0QB4CPUL1YKIEhOHJky6q2ZU5VJUDo9f4Ba5kYFwlEYKF4rJYS9DSmivpdxb
	IDHLtuDAaCKfIOLXaRNmqgoMbHt+P/Uexlrm9eJWQdHDWpW+Mpqv5lZdhJjPqqnAqSMt9egYEj2O+
	uDWLDT/29ipbkXeofrJKmM2c48pgkZPYGbK/hM2I7CU1tWcjbbflAGGYWc9wzHSARcZK8epBpFzF8
	+7gRUs2ETeAOzZ92eNuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVH8P-0007v1-SR; Fri, 07 Dec 2018 14:29:41 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVH80-0007Vj-Dm
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:29:17 +0000
Received: by mail-lj1-x244.google.com with SMTP id k19-v6so3691238lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vWNAi8KA5a8AOePm/F4rK7ibKNtgPheT1xDfWNYRieY=;
 b=e11A58l1OICddwBkd3QPB4OcLgtsliFd4zjJy+N9bQGigToT/1BMutBRd+QtlEq0pO
 5LILs7A2Lq1IguK022EApnKfxclTwl6Lk0siOrwEnjOvMPWwhwnJMb7K4znBRl9PMqjY
 7iFelOBgQN4qdgQ/Ccn71jD9m5ARPDAyzAvvTuwyZJdkdOqe4qqG2KbuO7F0zu4UqMCq
 Lbkf79c1fmzl0DIr3/R25r1Z4JJQvquvrsGcs29lV26z6fLl7+MasKIYjRGOeXXScP7k
 N2bKdnFvRiRdLSBowMW92NXuKlUeaLSqP30c9FPFmpiBbJ9DI5T9b7crQLPV/KH7geN0
 ZxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vWNAi8KA5a8AOePm/F4rK7ibKNtgPheT1xDfWNYRieY=;
 b=lrSci2010WCaiUYKj1G/2gPiwSgfiCg4fS4O8fjgIwwGiv5wGToUaz/YPRbO71ZdhV
 bYGQPsJHPwx8AuWY3vjU12GTQyDmcqevIbqoHerETCZfq8KqxkKMMuBtocZUrfOIrbTp
 SYKCdNXlK6Mo1NTbRHTSXhMjguCGGKePTO/J0wYIh39+Si8fz7Z3obtA+tDPBrjsQTpl
 EkBKuJ0JSumlaNGF7ghB8he4DJVI6CM42wSvTNIXkh01jB1TiFEJqF85evp5lWCww4JT
 93dSVD/ycdtKWb9u8cydEYqsCkOgab3Mt/zAImOjo8IiIMFzA2SIupkKI2NcXFGMn65Y
 nPQA==
X-Gm-Message-State: AA+aEWaI4Tw6D9R0/tHXNJF6uX7+wjjz2JHMndsGigkKqzvp8Ojr4HX6
 xe2tMb+wCf0CtuzoSdmBwq0=
X-Google-Smtp-Source: AFSGD/Up/wbof3FtQRCE3rUT1ZzDsRe88dk6wQP8OjxkQVHawaLT5xP91x8lz8V2gRHiotkgE7dz3g==
X-Received: by 2002:a2e:994:: with SMTP id
 142-v6mr1316978ljj.120.1544192944605; 
 Fri, 07 Dec 2018 06:29:04 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
 by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 06:29:04 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v4 2/3] Input: atmel_mxt_ts: Wait for device be ready for
 communication
Date: Fri,  7 Dec 2018 15:28:56 +0100
Message-Id: <20181207142857.15818-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_062916_460425_894B6573 
X-CRM114-Status: GOOD (  13.81  )
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
bGFqLmNobWllbEBnbWFpbC5jb20+Ci0tLQpDaGFuZ2VzIGZyb20gdjM6CiAgLSBGaXggY2hlY2tw
YXRjaCBpc3N1ZXMKLS0tCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2F0bWVsX214dF90cy5j
IHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYyBiL2RyaXZl
cnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMKaW5kZXggMWRjOGFkMGRhNWFmLi4z
Zjk1NmQwN2QwOWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxf
bXh0X3RzLmMKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYwpA
QCAtMjAyLDYgKzIwMiw3IEBAIGVudW0gdDEwMF90eXBlIHsKICNkZWZpbmUgTVhUX0NSQ19USU1F
T1VUCQkxMDAwCS8qIG1zZWMgKi8KICNkZWZpbmUgTVhUX0ZXX1JFU0VUX1RJTUUJMzAwMAkvKiBt
c2VjICovCiAjZGVmaW5lIE1YVF9GV19DSEdfVElNRU9VVAkzMDAJLyogbXNlYyAqLworI2RlZmlu
ZSBNWFRfUE9XRVJPTl9ERUxBWQkxNTAJLyogbXNlYyAqLwogCiAvKiBDb21tYW5kIHRvIHVubG9j
ayBib290bG9hZGVyICovCiAjZGVmaW5lIE1YVF9VTkxPQ0tfQ01EX01TQgkweGFhCkBAIC0zMDY4
LDYgKzMwNjksMTYgQEAgc3RhdGljIGludCBteHRfcmVndWxhdG9yX2VuYWJsZShzdHJ1Y3QgbXh0
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
