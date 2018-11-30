Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C607DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:35:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E2320867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2RBZB+D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f69MIrmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E2320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eJCHJs6olFUhZ/Hii45fmDHbtw/bKPP/YWf2O8NGYdk=; b=u2RBZB+DYwJu1H
	r13pXxoXWJ01dBenpM86QwUDjmGouztBf63ZfB62kJ20REjUPl9mhcPcvjC0jsVruCkkrMBuCod2f
	nmY9Qmd66ayCEQlZhF2awF6n1cQHB/hobIh+tAMAgSU/p4rBxKTMRBWawCbsOWyt8D7aLIv1BZEoF
	mnkHpzSmXolKVZ6uWyMx5LjSUtGuf9q43EyzkxFDENMfDTubtxUm9UXggySeZjMre+sWuQogymx3x
	dBpwpCyEqctAj7fT/qeoo2y1swoC6KrPtlSxSiYDHSIxGwIvkDhGnDAkWI0v0KRU+VJ4bwyE5ya6N
	T0OAmujBnKov15LY9qvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSndI-00057Z-4s; Fri, 30 Nov 2018 18:35:20 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSndE-0004Vg-Oj
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:35:18 +0000
Received: by mail-pg1-x532.google.com with SMTP id z11so2870756pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
 :references:content-transfer-encoding;
 bh=KXLrCLfpWy/lmfnMXrCyJaGs/uo0EXnDCzoNwfNxGXY=;
 b=f69MIrmJDI9kaARawVJyiJXpfTNOWezukglOmNJ8aLBkiN37DbGTq2QIUwtPqxoMPx
 cUe7epZN6X95DTvJGXKSYZZIhV8NC0+s/8zeV/wzmhTJqCnL3qDjFKtzKXH89VvQPzLu
 IvQ7o8GAj9Skj1epaKw/OxO9eJ50WkkKQUD0YIDavAeRnKiuMm7+moIwxKKwBE8f6DPP
 QFAJKfX2m+8HqEsLudt9R9udZbVyW6fbZpmSmuX0uON+d5ovI3qZD/GeF0SqCME6BfFO
 KsvE3rDUjboDTFqMacpXpGF7M7Rk1D4AR46BLcWJpGUgWVVCDOJW/TsV+Ovr7dYbXviE
 GT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :in-reply-to:references:content-transfer-encoding;
 bh=KXLrCLfpWy/lmfnMXrCyJaGs/uo0EXnDCzoNwfNxGXY=;
 b=cj4J3g4RIsbmBGNlxiZOxcNOJ+MWd1ohj9BkYZTuhi1+z5gn9UQ+e4b2zNHixnI1Da
 C/DFMA5Bya5kcBdx1QGgUPV1uuZjoIqpV/Yb5qri6AubnQYd1hiFWIru3u0QGUQKwcWp
 x4O0DMI23HkvTUhJruOnTthMkOD2nAfQqP8WzfSp/LHXXJ/mUxscQ1u92nQhAsc9/ODZ
 jdL4mcowa1mKhPCQxtUg0tbHDvmKmV7/ElioD8C0ehT/FTM/2XfopU3HlkkHSosQZd8p
 eqFVU6sVwfLLjrguACzV+EVFDcoEzNJ0hNbY6nAiWAG73OgjRYQ6dF7AweSFW4fZcd9Z
 uxfA==
X-Gm-Message-State: AA+aEWYdiJ3ebWcbSPoblGAl5IybV21B7ZK+oAlr/2qYHv713we/lW4W
 TZqZg1C1Ql86fk4BOt64dqQ=
X-Google-Smtp-Source: AFSGD/VPtyD3qlpHo12qlwxBffztQ8NE8FfM4JoYzhWwz1ExKVfGKraRpv30yaeWKWHHoSPre4wfqQ==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr4525453pgr.333.1543602905533; 
 Fri, 30 Nov 2018 10:35:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net
 (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
 by smtp.gmail.com with ESMTPSA id b5sm15544423pfc.150.2018.11.30.10.35.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 10:35:04 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
 =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Describe Northstar pins mux controller
Date: Fri, 30 Nov 2018 10:35:03 -0800
Message-Id: <20181130183503.9659-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20181109085649.31772-1-zajec5@gmail.com>
References: <20181109085649.31772-1-zajec5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_103516_804289_F6231DB9 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Hauke Mehrtens <hauke@hauke-m.de>, Rob Herring <robh+dt@kernel.org>,
 =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAgOSBOb3YgMjAxOCAwOTo1Njo0OSArMDEwMCwgUmFmYcWCIE1pxYJlY2tpIDx6YWpl
YzVAZ21haWwuY29tPiB3cm90ZToKPiBGcm9tOiBSYWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVj
a2kucGw+Cj4gCj4gVGhpcyBkZXNjcmliZXMgaGFyZHdhcmUgJiB3aWxsIGFsbG93IHJlZmVyZW5j
aW5nIHBpbiBmdW5jdGlvbnMuIFRoZQo+IGZpcnN0IHVzYWdlIGlzIFVBUlQxIHdoaWNoIGFsbG93
cyBzdXBwb3J0aW5nIGRldmljZXMgdXNpbmcgaXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmFmYcWC
IE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPgo+IC0tLQoKQXBwbGllZCB0byBkZXZpY2V0cmVl
L25leHQsIHRoYW5rcyEKLS0KRmxvcmlhbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
