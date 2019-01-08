Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DE2C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F9820883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxroQcB7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIXyMLEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F9820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DXEE+ypV2JXpVPGmJ5MLhFdWFXdWojG2TjWckEknHRc=; b=SxroQcB7+C7SYi
	80CwTn5pc2JTz9s/j74j+0SdFvfTaVNyZbORogB3G5E2Khs+i0TnxXMAcEHeVfZhdherXwzl2cR1k
	uJJDOfmXDwOcIawasoaW6BbF4p61MmpzEPd4p/FrwWWEapQKDhgga84BhEcFbU1Uv0NT730+WJWZh
	h6xHye1yMV/iHMEnrJMyFwWUfa9zIuvwQt9swqskMaVwudQ/Tj8Qi37DKxCPSaRDD3nSGNpej+H7z
	1svQt7trmgOgFwz3C9AcycQf3o2tzCQYVOEEWrmo42Hey2m68c/x53TIyfyIPXlPIJScQPAgiBevg
	pKMEyd3Q3GGk19w+nJZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggxdc-00019O-Ux; Tue, 08 Jan 2019 20:06:12 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggxcs-0000Np-OZ
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 20:05:30 +0000
Received: by mail-lf1-x143.google.com with SMTP id y14so3858697lfg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=guPCTwuWnn47rPONmcgssOljllOslnow0b18H5K7mjI=;
 b=LIXyMLEBheOJO3UAd9rTK0qeugFaM2RBAkfmNV0KTvKGlnkjD8AM+hWkuZ2ALCY0AV
 X/YOpK6l9DlwYTpfVIPLQ45RCkVeGW7xOYw5AKBUudMZ7uwcqmdhIsflNSqiOfrQ3muS
 9g1PbWTm7BPsElNOaTEO3j+vGh1WubrQCuuxoiFDY833BRGvkWxQjZv3NWkV2rnJ5qua
 hZP6SA/82NckRg2twRkmDdj47lOUrTzGEvn4zhcLaNX6ci2iEbdNONNPhz529vtmiUeR
 wqergCCjpmbR0PQz8Xq4OzD/YGMT2npObu/ulteYwyCJUd0DsXbOvPjAiE/vm8iJFci/
 pPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=guPCTwuWnn47rPONmcgssOljllOslnow0b18H5K7mjI=;
 b=VJADRDnuaMpcWMI2Q2/VeVba0NL+PPgxeTaX2pvHwtjnpNln3oZWn6XDOzV4SB6FBO
 d4a4nVRw3bdyEYz/6wmuVYzo4cTT0UMhcQGwlmIvt8wsm8Im/LKJQOV9iQyJMbN4NfMy
 9Vx8gXI3HnUkKtvGW1ven182VfcHUlLF4ybtTwceS8jrcMmWy7GFQA4z5gpQJhUvOIj1
 SuFWsteuPCQReGoe8rB8G5e7T4Jl9eYQE8lwOAzlkiwDhN5eh/GJ9GIwDYkbfHHs1rJC
 bi29ku0Arz4ENFzCAP/ZxhhjPVsHZGWCsBu+7kEkuqA8VVHUqXnfHnnD7OIHwHG/MGwV
 GxyA==
X-Gm-Message-State: AJcUukcPAzZuLaoHkQJ8qJxxx2TxTmabgLSKSt3OD4wjvNWYdb7rEl1N
 OeTZjYXA+gfqFzykE04hidI=
X-Google-Smtp-Source: ALg8bN5Tg3hlmHVJyiBjR7tOBcXM6cK0vSXgZxUTEU4dG4QVgn9I3JC31Hr6TBOtFWvOVpy3xQxK0w==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr1778838lfg.89.1546977925100; 
 Tue, 08 Jan 2019 12:05:25 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id
 y23-v6sm14486768ljk.95.2019.01.08.12.05.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 12:05:24 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH 2/4] cpufreq: s5pv210: Don't flood kernel log after cpufreq
 change
Date: Tue,  8 Jan 2019 21:05:07 +0100
Message-Id: <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_120527_013549_5AA8C305 
X-CRM114-Status: GOOD (  13.08  )
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

VGhpcyBjb21taXQgcmVwbGFjZXMgcHJpbnRrIHdpdGggcHJfZGVidWcsIHNvIHdlIGRvbid0IGZs
b29kIGtlcm5lbCBsb2cuCgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtv
bGFqLmNobWllbEBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJl
cS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jIGIvZHJpdmVy
cy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCmluZGV4IGRiZWNkNzY2N2RiMi4uZjUxNjk3ZjFl
MGIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMKKysrIGIv
ZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCkBAIC00ODEsNyArNDgxLDcgQEAgc3Rh
dGljIGludCBzNXB2MjEwX3RhcmdldChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwgdW5z
aWduZWQgaW50IGluZGV4KQogCQkJCWFybV92b2x0LCBhcm1fdm9sdF9tYXgpOwogCX0KIAotCXBy
aW50ayhLRVJOX0RFQlVHICJQZXJmIGNoYW5nZWRbTCVkXVxuIiwgaW5kZXgpOworCXByX2RlYnVn
KCJQZXJmIGNoYW5nZWRbTCVkXVxuIiwgaW5kZXgpOwogCiBleGl0OgogCW11dGV4X3VubG9jaygm
c2V0X2ZyZXFfbG9jayk7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
