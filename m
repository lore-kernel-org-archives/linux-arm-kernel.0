Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003422133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lZg4qyTE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC6xbUYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003422133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C13D0g2I4UM5s2DgBzopLvS+bQD3pKi6ZJtcNG53whM=; b=lZg4qyTEUYm/6c
	MDFuE7RBYyqgL+54j0g99pA7O5pMXCM82MYBlfufWWYytAFXawN/cELNNtYQ7DQ5jvLIkT74b4Dig
	woi52lb7TD/Ptgcze6gg4wULzq3xP+bobd4UcdTIl4pS9TkEgEyAVbADtL3MaMdpEHF2jPmBOlSGm
	qhiRZ3qXkw9G5N5gl5S1VS1POBnWUax9L2poeKFRT5uC6uBcEpPfZGbbhodt8gSA4iwzKsOwUiQHO
	hDNmLbTqxPCd4UGQ5Pn/OV9WvB9yy9Jq4yUK1pJH+2becCN6FmiMxTYJkLWTa0MKZ4SQWrTgmjOXF
	gDOiDuSnFhml6hkvAcsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzJd-0008L2-Mo; Wed, 27 Feb 2019 13:32:05 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzJa-0008KJ-DB
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 13:32:04 +0000
Received: by mail-pg1-x542.google.com with SMTP id j3so7957673pgm.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 05:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xbEseNacy50dMLYxtJLe6gRrML5B5I7hT3fN3fbmwHc=;
 b=JC6xbUYM4JBEhX4Kjy+Qg7YxsdRFl1h287Y+qeC6hAINDR/rgaE8xHv5tgZz/7hjZ/
 9cwSjgp3pO6LmlHN7nZC/zMDvCoWMx+SX3Wfrk4Hzw7zO4yJDOzfwz0h3Y2LmlaCMqBe
 bChiMhnCRLn8poqMGZHyFEFr6Lmg2TePJh1/FZmH4LaLzyR/x6Lv8bThWnj4UGuGp0Gb
 V9mITmmbCQEZ9CGac2fYs4oI2c2VuzxpG4Rs10bNHDmDpeeqLcTZKJDnhCYR469HbR6z
 F46MISY/U61l7H3sGEvlKqjiDslOHabzg+Il5ZY8Ah4jkDpXp+XyR1goiSG4K+hBMcF/
 10DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xbEseNacy50dMLYxtJLe6gRrML5B5I7hT3fN3fbmwHc=;
 b=D+hYZ7g2KILoxFPXbOXvCkIjYpTgq41XM2hL2OTL9q1Dbt4VF6c7WWeOw/F4j/pICu
 PEuMeDEGLLSg3OpNpeunrOH/B+tlmE9GaehYMeYoHBAr202hWvP8+RCv6SXFr5sI/eF0
 /vr9sMaHa4M4Ft4pUGQvVKJvS9NNCCJoYnlSjJ17NsfFElsG/2XE88tlRHqwLjcOM6tq
 Sw+o9Y2/unHNEYlTdJlmPG7QzxLQuUx/Gzz/F28n7Qnm/iG/jJt87nyQJZIGVMyM8Ozf
 HI7z9bnTQC4QoLYeLEX8k1npdcPYYa9b3TW6Nw87bybEscITh2zxhst7SKsjVuuu9eQk
 pKJA==
X-Gm-Message-State: AHQUAuaH93KxDQvsPPAsVunYsg7k3g8XQNO5qOATPaaeh9buaQwroDgY
 zDkqb9FtLaFtjXXqVUEc9MA=
X-Google-Smtp-Source: AHgI3Ib9qdcyGEDXBUZgvyw0O2TV8wUyksRE+dWP7vA2lOCdeS/dpyR22wCM4/NlgLHUtkgUP5lJvw==
X-Received: by 2002:a63:7909:: with SMTP id u9mr3040303pgc.243.1551274321359; 
 Wed, 27 Feb 2019 05:32:01 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id a20sm38425337pfj.5.2019.02.27.05.31.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 05:32:00 -0800 (PST)
Subject: Re: [PATCH v3] ARM: tegra: enforce PM requirement
To: Sameer Pujar <spujar@nvidia.com>, linux@armlinux.org.uk,
 jhogan@kernel.org, jonathanh@nvidia.com, treding@nvidia.com
References: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6e5bf310-12b5-26a3-f466-95cc56c6932a@gmail.com>
Date: Wed, 27 Feb 2019 16:31:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_053202_474357_F3E39325 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MjcuMDIuMjAxOSAxMToyMCwgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Cj4gQ3VycmVudGx5IHJ1
bnRpbWUgUE0gaXMgZW5hYmxlZCBmb3IgVGVncmEgSERBIGRyaXZlci4gT25lIG9mIHRoZSBjb25j
ZXJuCj4gcmFpc2VkIHdhcyBhYm91dCBoYW5kbGluZyAhUE0gY2FzZSBpbiBIREEgZHJpdmVyLiBJ
biB0aGlzIGNhc2UsIHRoZXJlIGlzCj4gYSBuZWVkIHRvIG1hbmFnZSBjbG9ja3MgYW5kIHBvd2Vy
IGV4cGxpY2l0bHkgaW4gdGhlIGRyaXZlciBhbmQgcmV2aWV3ZXJzCj4gd2VyZSBub3QgcmVhbGx5
IGNvbnZpbmNlZCBhYm91dCB0aGlzLiBUaGUgY29uc2Vuc3VzIGF0IHRoZSBlbmQgd2FzIHRvCj4g
ZW5mb3JjZSBQTSByZXF1aXJlbWVudCB0byBrZWVwIHRoaW5ncyBzaW1wbGUsIHJhdGhlciBkcml2
ZXIgbWVudGlvbmluZyBhCj4gZGVwZW5kZW5jeSBvbiBQTS4gVGhpcyBpcyBob3cgaXQgaXMgZG9u
ZSBmb3IgQVJNIDY0LWJpdCBUZWdyYSBwbGF0Zm9ybXMKPiBhbmQgdGhlIHNhbWUgY2FuIGJlIGRv
bmUgZm9yIDMyLWJpdCBUZWdyYSBwbGF0Zm9ybXMgdG9vLgo+IAo+IEZpbmFsbHkgdGhlIG9iamVj
dGl2ZSBpcyB0byByZW1vdmUgZGVwZW5kZW5jeSBvbiBQTSBhdmFpbGFiaWxpdHkgZm9yIGFsbAo+
IFRlZ3JhIGRyaXZlcnMuIFRoZSBkZXRhaWxlZCBkaXNjdXNzaW9uIGNhbiBiZSBmb3VuZCBpbiBm
b2xsb3dpbmcgcGF0Y2gsCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMDMx
MDA3Lwo+IAo+IFNpZ25lZC1vZmYtYnk6IFNhbWVlciBQdWphciA8c3B1amFyQG52aWRpYS5jb20+
Cj4gUmV2aWV3ZWQtYnk6IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+Cj4gUmV2
aWV3ZWQtYnk6IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+Cj4gLS0tCgpU
aGUgY29tbWl0IG1lc3NhZ2UgaXMgb2theSB0byBtZSB0aGlzIHRpbWUsIHRoYW5rcyEgSSdtIHN0
aWxsIG5vdCBzdXBlci1oYXBweSB0byBsb3NlIHRoZSAhUE0gb3B0aW9uIGJlY2F1c2Ugb2YgaXRz
IHZhbHVlIGluIHJlZ2FyZHMgdG8gdGhlIFBNIGRlYnVnZ2luZywgYnV0IGFnYWluIHdlIGNhbiBq
dXN0IGRvIHNvbWV0aGluZyBiZXR0ZXIgaW4gdGhhdCByZWdhcmRzIGxhdGVyIG9uIGlmIHdpbGwg
YmUgcmVhbGx5IG5lZWRlZC4gICAKClJldmlld2VkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0
eEBnbWFpbC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
