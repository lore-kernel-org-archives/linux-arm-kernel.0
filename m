Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E9CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34EC206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cx4L96UU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0Z0zz8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34EC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8CeX74TW6D8w7p+jlELazWSlk3e/kzt6sdSNeSpx0RU=; b=Cx4L96UUN3nLSZ
	1UnQ3rc96f39TIlq7Xfw/QzWJuEXO8Kzkj5+XHfV7dsjG8zjTSH3yPhz+RBRU6G0dtSs8Yg+OxjTM
	El+2FU2eG+RDVtmEUHYjXnNRjEx5WpB5VICCFfxIGyrJPwZvWuDesT2XcJhGmBdsVpV1boEcXBA53
	VxOTWnIbORbhYtJEiDYU462Qmwmejl5kx4NETC53Sq9CeHYYL479R39qFcDb5xVG4aYG7FhdwcV+g
	vCbF6pCKevZsTvleSfoGwed9t0tXuO7HdJtEPJTw0Rg1hZH24KUHLNe7AYgaQIWeQHrgfP607HBSF
	MlESDlvAkLiSZ71hVgxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEt3-0005U1-9x; Wed, 09 Jan 2019 14:31:17 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEt0-0005T4-32
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:31:15 +0000
Received: by mail-lf1-x143.google.com with SMTP id l10so5770809lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kuRc1byMVfVvYAQSmiN0h3OtipOlQk0WsxsJ7A6MPuI=;
 b=g0Z0zz8xa9oDo0mjfvt1dUTlQzcDVLhqpB7hOX+W1u32+4T2FS9v/nJeUCNXvXbFxf
 inhUeRiJmSXlxTBmlFFTncHRtUngzLs3nvfznrJptWjJbfN80CL9uWJ/OfgZJl1/RS92
 NQo5UMVLqf94Ok2nxnmTkjR8hkPo8Sk4diwFGguWnPCDt5t6reVAxNaxNMeSltUoO9Kk
 vPGD4vhvtnMLsmAgDXEKk/bcRMdfT6Jz7Le7aQZ0t8W1KD3OUgA3/cpC0hTVVfX+re6H
 vefgjz2EW/viVJXHpR2lfFnDQfSfoJnuzFpmmZVDJSmf7MTLu5N84KetsCYeNbo5PR1W
 4pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kuRc1byMVfVvYAQSmiN0h3OtipOlQk0WsxsJ7A6MPuI=;
 b=lCIFJbN1Zk6KEzqdWN7epC2V9sxrvLF/OTmoKByyX+6+olMtzQNHafgkR6PERiRlyc
 vcBnEAn6Caff8kVCTyTz1FFLLltPcpTU46HmEtfCZTREWcsbNvwPG/Bai4ZXZ3am7+SM
 2aYPH+xS/iTnHwh/G2Nc9pY/4nmC1E8/LS2ZVnvE1CxjYWxiZ+d2DDGTdwhDQd6rMPr1
 MUMjR80XVMZKUcciaNzpxivg0HJrD59A29gM5F0I9YbFys/TSCV+/Wmm6GRBbrkcS3/d
 YLmc/yJyfC5a+LPKzSMr1wF4oeCYmks8rpkxLrAaCnX0H0aGQ7oI9FOkNWlwfhpNh5Ey
 BtKg==
X-Gm-Message-State: AJcUukdsRacICHu7+rIUvOjnjtIcf8capx9k8ZXxo7eUoZPbll0ffWX4
 DMgCHIh4l2ivyYAgfHL5W8M=
X-Google-Smtp-Source: ALg8bN6EhaBj6aNB7S/H0Fg/oAyB7pzLg450eevrpw+jQVhMe4d7grezXYVPDnwY4C2UBqUrhU0g7w==
X-Received: by 2002:a19:945b:: with SMTP id w88mr3416873lfd.15.1547044268297; 
 Wed, 09 Jan 2019 06:31:08 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:c1c3:bc43:64cd:2432])
 by smtp.gmail.com with ESMTPSA id
 g15sm13540758lfb.1.2019.01.09.06.31.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Jan 2019 06:31:07 -0800 (PST)
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ARM: dts: s5pv210: Fix onenand's unit address format
 warning
Date: Wed, 09 Jan 2019 15:31:06 +0100
Message-ID: <2629067.mKC4sQJUgE@acerlaptop>
In-Reply-To: <1547041383-16924-1-git-send-email-krzk@kernel.org>
References: <1547041383-16924-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_063114_134574_54C5EE89 
X-CRM114-Status: GOOD (  16.50  )
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
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5pYSDFm3JvZGEsIDkgc3R5Y3puaWEgMjAxOSAxNDo0MzowMyBDRVQgS3J6eXN6dG9mIEtvemxv
d3NraSBwaXN6ZToKPiBBY2NvcmRpbmcgdG8gRGV2aWNldHJlZSBzcGVjaWZpY2F0aW9uLCB0aGUg
dW5pdC1hZGRyZXNzIG11c3QgbWF0Y2ggdGhlCj4gZmlyc3QgYWRkcmVzcyBzcGVjaWZpZWQgaW4g
dGhlIHJlZyBwcm9wZXJ0eSBvZiB0aGUgbm9kZS4gIEZpeCB0aGUgRFRDCj4gd2FybmluZyBvbmVu
YW5kIG5vZGU6Cj4gCj4gICAgIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaTo4MS4yOS05
My41Ogo+ICAgICAgICAgV2FybmluZyAoc2ltcGxlX2J1c19yZWcpOiAvc29jL29uZW5hbmRAYjAw
MDAwMDA6IHNpbXBsZS1idXMgdW5pdCBhZGRyZXNzIGZvcm1hdCBlcnJvciwgZXhwZWN0ZWQgImIw
NjAwMDAwIgo+IAo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2Vy
bmVsLm9yZz4KPiAKPiAtLS0KPiAKPiBUaGUgcmVtYWluaW5nIHdhcm5pbmcgaXMgd3JvbmcgY2xv
Y2stY29udHJvbGxlciBzdWJub2RlIG9mIGZpbWMgY2FtZXJhLgo+ICAgICBhcmNoL2FybS9ib290
L2R0cy9zNXB2MjEwLmR0c2k6NTc4LjMyLTU4MC42OiBXYXJuaW5nIChzaW1wbGVfYnVzX3JlZyk6
IC9zb2MvY2FtZXJhL2Nsb2NrLWNvbnRyb2xsZXI6IG1pc3Npbmcgb3IgZW1wdHkgcmVnL3Jhbmdl
cyBwcm9wZXJ0eQo+IFRoZSBzdWJub2RlIGluIG15IHVuZGVyc3RhbmRpbmcgZG9lcyBub3QgZm9s
bG93IGJpbmRpbmdzIGFuZCB0aGUgZHJpdmVyLgo+IFRoZSBkcml2ZXIgd2l0aCBjdXJyZW50IHM1
cHYyMTAuZHRzaSB3aWxsIG5vdCByZWdpc3RlciBhIGNsb2NrIHByb3ZpZGVyLi4uIGJ1dAo+IEkg
ZG8gbm90IGhhdmUgYSBkZXZpY2UgdG8gY29uZmlybSB0aGlzLgo+IC0tLQo+ICBhcmNoL2FybS9i
b290L2R0cy9zNXB2MjEwLmR0c2kgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9z
NXB2MjEwLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kKPiBpbmRleCBjYzIy
YzlkYjgwZDIuLjI2ZWE1YzY2ZDhjZSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9z
NXB2MjEwLmR0c2kKPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kKPiBAQCAt
NzgsNyArNzgsNyBAQAo+ICAJCQl9Owo+ICAJCX07Cj4gIAo+IC0JCW9uZW5hbmQ6IG9uZW5hbmRA
YjAwMDAwMDAgewo+ICsJCW9uZW5hbmQ6IG9uZW5hbmRAYjA2MDAwMDAgewo+ICAJCQljb21wYXRp
YmxlID0gInNhbXN1bmcsczVwdjIxMC1vbmVuYW5kIjsKPiAgCQkJcmVnID0gPDB4YjA2MDAwMDAg
MHgyMDAwPiwKPiAgCQkJCTwweGIwMDAwMDAwIDB4MjAwMDA+LAo+IApDaGVja2VkIG9uIFNhbXN1
bmcgR2FsYXh5IFMgKHdpdGggbG9jYWwsIG5vdCB5ZXQgc3VibWl0ZWQgcGF0Y2hlcyBmb3IgZGV2
aWNldHJlZSBzdXBwb3J0IGZvciBvbmVuYW5kLCB3aGljaCBpcyBtaXNzaW5nIGluIG1haW5saW5l
KSBhbmQgaXQgbG9va3Mgb2sgKGRldmljZSBwcm9iZWQsIHdhcyBhYmxlIHRvIHVzZSB1YmkgdG9v
bHMpLgpUZXN0ZWQtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWls
LmNvbT4KCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
