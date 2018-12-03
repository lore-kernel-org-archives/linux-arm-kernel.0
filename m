Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:50:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E497820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E86uVoRC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ag9O5Qw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E497820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dpEjVyixE5V301muWZ9WLw1gb0hcL0cRwxQAu6531/Q=; b=E86uVoRCMjoKIe
	O/8R/MqIybc3tGDaCjDU2E7UbMl4ePdqGokbhPu9Pa1HGmW3K57vIVvLBH5ECJ4BJbCRCkj3I51rk
	s9Vu/41hzeiV5CduRGHcvt6c2yIiHjOKdgkHprcOzS/zpTR8uBEDnZRnVUv8U90zOnWYzN4Tp+Eqt
	FaClGhlghEY9bZaNIakL7+sL33WRBv8Fhk7bxrweCcugwKCqU7Fup08qk8QkEkqLS+88Cq79HaySS
	ZVqDevyr6moTrtQM+5LbXLV0QxnfS21vNfg1yLnvhLmAr2zM2Wio5M2xzeAn/mO8LPFi/lLRcJNyd
	pBQ3DCH2pdOBsXHwT3YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTw6k-0006rb-Bp; Mon, 03 Dec 2018 21:50:26 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTw6a-0005Bu-De
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 21:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oC6xtxPGgX0vrAEYZdrzvcerpUBFv1AQjT/XCrxTgx0=; b=Ag9O5Qw/Egzm66DkweklyoxaqB
 LAua8LNWh6XYCsasEU9E6jA/ELGXaVp8SW3KvOEj6ADmZlre4c4HqOPzDI6mlfJaM4H3HZBV40mE4
 1+x6CmH6DTszK7IqOWm2low51tdWnE29S88tIP0PCDV4VctnFJnPizIEFkjMwwqtErImsBFTrOmvU
 yL4kw0cxRvGgg2eW9cl/AigtUPcXHRqebrNkcBDUQn+nxcpo3wUURENz3txnKpUgRMFsDxkxXIt9p
 nKSRzGF1B6Wbf1rhKXLzwkeWEUvuMEFVS0xoeamXEq1PA7BFKAK7zGjpIa8KsbgdoaJQ+S9wU7ldI
 sysRT+zA==;
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpx-000163-LY
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:07 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so12387303oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oC6xtxPGgX0vrAEYZdrzvcerpUBFv1AQjT/XCrxTgx0=;
 b=ld1xg8SLSu4FuFpyiHX6HXGQ6PQGbtAq5UuTQKFW8HADKDTTf71vQ4S1pjmYRrn9w7
 7DIOWKcuGTkklQNSjEfVUwSDLzHZWZvCa0QMhXjUmxYcE0qDEdHD1hCAvUAXvsGhseU3
 MwRq/xztuNzLo/dQU2vtJJQ2Hj+UydH2f+MxNis1LTwO7TbrO9kJLcccIlYRBnucSoV4
 AQdNL0HR4hdjrQuYX4KtyGC3koR6XVTyeJeGAbRwOYMaRmOnCxaBu1P0mIasVqY9GD1R
 DSWAPoSvdBdw9kzZKexXcJHOrY+u3R+PrUW8pbKDZ5Vbm3kQBk2P56W6S93JYLIEJtiZ
 LJIA==
X-Gm-Message-State: AA+aEWYRnaG72Z09CHrfEWf11glSyKutWLQ+LUYRHCL3Zviphrd96AKK
 5CjDIrIRPUmEq2g1nZMG5w==
X-Google-Smtp-Source: AFSGD/U4jSE9cLoojt1F8nCYnEN25i4Ed+nmzggq5QD7npe8dCtWHghkjfbGS0jwVDUPRG4QNPbaww==
X-Received: by 2002:aca:5b88:: with SMTP id p130mr10394553oib.96.1543872773873; 
 Mon, 03 Dec 2018 13:32:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:53 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/34] dt-bindings: arm: Convert Realtek board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:12 -0600
Message-Id: <20181203213223.16986-24-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_213305_708470_BC06E66B 
X-CRM114-Status: GOOD (  14.89  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Q29udmVydCBSZWFsdGVrIFNvQyBiaW5kaW5ncyB0byBEVCBzY2hlbWEgZm9ybWF0IHVzaW5nIGpz
b24tc2NoZW1hLgoKQ2M6ICJBbmRyZWFzIEbDpHJiZXIiIDxhZmFlcmJlckBzdXNlLmRlPgpDYzog
TWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4KQ2M6IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVk
LW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KLS0tCiAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vcmVhbHRlay50eHQgICAgICAgfCAyMiAtLS0tLS0tLS0tLS0tLS0tLS0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwgICAgICB8IDIzICsrKysr
KysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMjIgZGVs
ZXRpb25zKC0pCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9yZWFsdGVrLnR4dAogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay55YW1sCgpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnR4dCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay50eHQKZGVsZXRlZCBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDk1ODM5ZTE5YWU5Mi4uMDAwMDAwMDAwMDAwCi0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay50eHQKKysrIC9kZXYvbnVsbApAQCAt
MSwyMiArMCwwIEBACi1SZWFsdGVrIHBsYXRmb3JtcyBkZXZpY2UgdHJlZSBiaW5kaW5ncwotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLQotCi1SVEQxMjk1IFNvQwotPT09
PT09PT09PT0KLQotUmVxdWlyZWQgcm9vdCBub2RlIHByb3BlcnRpZXM6Ci0KLSAtIGNvbXBhdGli
bGUgOiAgbXVzdCBjb250YWluICJyZWFsdGVrLHJ0ZDEyOTUiCi0KLQotUm9vdCBub2RlIHByb3Bl
cnR5IGNvbXBhdGlibGUgbXVzdCBjb250YWluLCBkZXBlbmRpbmcgb24gYm9hcmQ6Ci0KLSAtIE1l
TEUgVjk6ICJtZWxlLHY5IgotIC0gUHJvQm94MiBBVkE6ICJwcm9ib3gyLGF2YSIKLSAtIFppZG9v
IFg5UzogInppZG9vLHg5cyIKLQotCi1FeGFtcGxlOgotCi0gICAgY29tcGF0aWJsZSA9ICJ6aWRv
byx4OXMiLCAicmVhbHRlayxydGQxMjk1IjsKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMDAwMDAwLi44NGVlOWIyMmVmN2EKLS0tIC9kZXYvbnVsbAorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbApAQCAtMCwwICsxLDIzIEBA
CisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCislWUFNTCAxLjIKKy0tLQorJGlk
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9hcm0vcmVhbHRlay55YW1sIworJHNjaGVt
YTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjCisKK3RpdGxl
OiBSZWFsdGVrIHBsYXRmb3JtcyBkZXZpY2UgdHJlZSBiaW5kaW5ncworCittYWludGFpbmVyczoK
KyAgLSBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+CisKK3Byb3BlcnRpZXM6Cisg
ICRub2RlbmFtZToKKyAgICBjb25zdDogJy8nCisgIGNvbXBhdGlibGU6CisgICAgIyBSVEQxMjk1
IFNvQyBiYXNlZCBib2FyZHMKKyAgICBpdGVtczoKKyAgICAgIC0gZW51bToKKyAgICAgICAgICAt
IG1lbGUsdjkKKyAgICAgICAgICAtIHByb2JveDIsYXZhCisgICAgICAgICAgLSB6aWRvbyx4OXMK
KyAgICAgIC0gY29uc3Q6IHJlYWx0ZWsscnRkMTI5NQorLi4uCi0tIAoyLjE5LjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
