Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2866C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B225221852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NGJ16sAl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzXsMT5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B225221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KGcPSb1Ge4nazesozr4CRi/M6vQd56UbzhgO/Ktdsto=; b=NGJ16sAl1UhNYj
	7uz9LNwyneXrjlSzEnsEWTHxs5yBj+ebQcLeHTsT3SeuMfOAEx84DS/fgjIehv1FDygyM7e1kdjcr
	ckgIwYa+T60Kf8FNStrrjTgB+hiuZDbDw1YqfVdDPs6CzBD1HAFrl/nb9d89haqrQDjlbMA1O1i51
	bjOAVM8YxxDy1knQN8h07YD8dF0mL0w2qJfR9BN2qmeoyfEwxhPzhNHtaZgnxdoFhHWwcDU558THj
	51k2Uiy3yNMkIt2VU9qvF/QnKOLwmPhgvWpzr5JUYvCtOB5gXDZkM5y48vAcA1rg6xumryzNJ2EVL
	+/GeiyhOgjaJzy5ADetQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGuH-0000XW-GL; Tue, 18 Dec 2018 15:03:37 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGtq-0008VL-P1
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:03:19 +0000
Received: by mail-pg1-x542.google.com with SMTP id z10so7933900pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FesXI/CntZT7O17A7JC22Pf8CkQ9Of1LoOQsFlXVEvc=;
 b=RzXsMT5XP3gcdCACg6PIl6rRkWuwpdgeN/6/qhaN2JKZLuDSJC7hsGYxXeyaocea2f
 /XNEuMiwUi7p9xlnh+OUjwkqV67DSvdZllbieXmS1zJAB00jxE8Izmqjh5OSSTdZCtu5
 Ltq6pt81IUkWwCoUelEzq80A3NKL8bZQcBIWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FesXI/CntZT7O17A7JC22Pf8CkQ9Of1LoOQsFlXVEvc=;
 b=c6v12uBkUQny7UzTNNOWXLDpZlfVfmKUOlfCVspjZDK4lFeEobEh7+vcd2lHkK7zp5
 oj7yqz8ZupKuI0y/oD9kxFB1EajV3osk47650ZrnY3yRD2iiedRPSqBZh1br87C/+94y
 YZb7uMbkwda1l50H0SWZKQMVyauM4bzoXVnIMXygDDXSd7ojKRBfKnghQpmd7IEREcgB
 YiXwHGp3KYL7GMKoyL4b2J8kovVA7/IW/GTsHYn4JurzFVXrDoxPtLsbI7aCQQVhmtLm
 fWoVvF1ZHJ1YUfgco4+wOYqvsbEjAwye0TEfGQoDzMNffsAhXmaaUJ4hKyAaSGyHvHo8
 R04Q==
X-Gm-Message-State: AA+aEWY589ezgJg09sVwzLnIOCC+dgF3/RXcd6aI8FScv3AhqRVD1gt7
 mh6c65UwgJNaWAz2DacvSKToBap5og==
X-Google-Smtp-Source: AFSGD/Uk4HJ/aqLuiL5P7IxWeSMH7ytf82p/PHE7W47Ya8n2IeAjHsvZ1VnD8K6dipIN6ixf9HRD8g==
X-Received: by 2002:a63:7c13:: with SMTP id x19mr15069040pgc.336.1545145388131; 
 Tue, 18 Dec 2018 07:03:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:03:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 02/11] dt-bindings: arm: Document RDA8810PL and reference
 boards
Date: Tue, 18 Dec 2018 20:32:29 +0530
Message-Id: <20181218150238.23010-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070311_507813_1DADE34B 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKQWRkIGJpbmRpbmdzIGZv
ciBSREEgTWljcm8gUkRBODgxMFBMIFNvQyBhbmQgYmVsb3cgcmVmZXJlbmNlIGJvYXJkczoKCjEu
IE9yYW5nZSBQaSAyRy1Jb1QgLSBodHRwOi8vd3d3Lm9yYW5nZXBpLm9yZy9PcmFuZ2VQaTJHSU9U
LwoyLiBPcmFuZ2UgUGkgaTk2IC0gaHR0cHM6Ly93d3cuOTZib2FyZHMub3JnL3Byb2R1Y3Qvb3Jh
bmdlcGktaTk2LwoKQ2M6IHpoYW9fc3RldmVuQDI2My5uZXQKU2lnbmVkLW9mZi1ieTogQW5kcmVh
cyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgpSZXZpZXdlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KQWNrZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+Ci0tLQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9y
ZGEudHh0IHwgMTcgKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9yZGEudHh0CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9yZGEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9yZGEudHh0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uNDNjODA3
NjJjNDI4Ci0tLSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9yZGEudHh0CkBAIC0wLDAgKzEsMTcgQEAKK1JEQSBNaWNybyBwbGF0Zm9ybXMgZGV2
aWNlIHRyZWUgYmluZGluZ3MKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KKworUkRBODgxMFBMIFNvQworPT09PT09PT09PT09PQorCitSZXF1aXJlZCByb290IG5vZGUg
cHJvcGVydGllczoKKworIC0gY29tcGF0aWJsZSA6ICBtdXN0IGNvbnRhaW4gInJkYSw4ODEwcGwi
CisKKworQm9hcmRzOgorCitSb290IG5vZGUgcHJvcGVydHkgY29tcGF0aWJsZSBtdXN0IGNvbnRh
aW4sIGRlcGVuZGluZyBvbiBib2FyZDoKKworIC0gT3JhbmdlIFBpIDJHLUlvVDogInh1bmxvbmcs
b3JhbmdlcGktMmctaW90IgorIC0gT3JhbmdlIFBpIGk5NjogInh1bmxvbmcsb3JhbmdlcGktaTk2
IgotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
