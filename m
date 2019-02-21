Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BD5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:03:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80A32083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TATJebYV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWZI2+83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80A32083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fNDORYWDKBgSEePBA0Z12N9/rH0WFmV60bpwL4BAJuk=; b=TATJebYVD0S4dT
	i5we0GTxqxbHnixnDI7v3LnbAz6jffRwQaHsKbBheNAStFu2BztNkiu21MrcgTcfl56hO/+7UiYwf
	I41y6wmHH4ykkJSJbp6jtF1f43EA8wZk7XB/5Og147TQZrS9QJcE4NrgSj/JMy747z3YurAYhLooZ
	xrBOtQjGmJPsSJGhSFHkC468kiZDig0DfgPRH7IcUkZdRRGED0G6n40XLDvxdrU5W2G0FJpeKCqVH
	4rKlKv7P8HyQ1MMCUdteNRGQSaEdw4e6h+N0bLxqV+pDC0873URAzSD72Bv0PgxH29cMcFWidCrrQ
	PHADpJvU99WHp8r3vBtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwxNT-0004nH-0b; Thu, 21 Feb 2019 23:03:39 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwxNP-0004mg-GL
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 23:03:36 +0000
Received: by mail-ed1-x544.google.com with SMTP id c55so275999edb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FXlxvF4xhFiRMVY9dsmk97DoXxTAN7l0XRbieA4sju4=;
 b=iWZI2+832YMkH7XL4pcR60BH69F+1P6eq3Sx+4B6f1/nuMqvpG1jZpsD3vxuyNYv8K
 ptmt8OphBlOX90c2+sz7HKYLx8/wulSEKzOGEhYZN0kW3vbNQUGchi8XSXgl33t6iZAT
 u8myPqU/bgcQpEexg6o5s84Kc7oI2QxcPBkMiDcFaLg3kYCtLkwRWuPyhBEQX0EYCkfa
 V7/c6qnUb5m+rcKxAq52l5s6EeiMZccPF2ht+4E1hguLO4kA/Wxf9UfN6nMQUwToFOrC
 W6L7u5vVo9747/TRYwuUwNlXHhzbsPLnbBmqeChhK0z4y+abne0yq4Z4I2ipgeu255HI
 oE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FXlxvF4xhFiRMVY9dsmk97DoXxTAN7l0XRbieA4sju4=;
 b=CG3TGo1/HC7rr1clUDo+gLIoKXW7F0liNkAzjrwNyOLn3stPtcmO1oFVkTC3PUYNwb
 CSdHoU47nHQJMfbrYiVpDqjlAKAlg6UG77ujmALWqWjNw14uZRMahIu/u1Est41CfyWQ
 i+REBTQfxAritdWgASAXZf5BfN52qnucOBoMxXasH/DbRY7mTkCU3wfCKZ3mvOXdVjdE
 CDLpYNGCKpy6hqfCwDIEyGNu/mc/59NGGCh5BDOdIXN+636doQF1mcB4SpCSx8YkEtpp
 Lekal93ZbMTFTBfaj5jTi/CKUvcvGn81nao1DK1qRwq5HqxJFbe4DeHXp3/vPvQiLR7A
 7zEw==
X-Gm-Message-State: AHQUAuYB56qoLWLbgTBdFmJcOiSLaGaTMEYOLNOdmcTv1d8qjdc/BL1K
 P47pk3haXLzhNT74tEZAu9gpib9l+FGA2E4M7iU=
X-Google-Smtp-Source: AHgI3IY6cWP1liHfymzWlnw5OQhm45XWPQ0FJx5U9jmWG9cYHeH/1sbmyKOzWnXjm+xeHUTemrW3pXX8onWq9TKSye0=
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr751453edq.14.1550790213842;
 Thu, 21 Feb 2019 15:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
 <20190220094841.11129-3-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190220094841.11129-3-thomas.petazzoni@bootlin.com>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Thu, 21 Feb 2019 23:03:22 +0000
Message-ID: <CAEzXK1qiHaV_Ehfq_CAsDMVn=A65opeffpjyVAX-Mj73W7NGYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: pci-bridge-emul: Extend pci_bridge_emul_init()
 with flags
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_150335_543453_C2DBECA9 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leigh Brown <leigh@solinno.co.uk>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGVzdGVkIHBhdGNoIGFnYWluc3QgVmFuaWxsYSBrZXJuZWxzIDQuMjAuMTEgYW5kIDUuMC1yYzcu
IEl0IGlzCndvcmtpbmcgcHJvcGVybHkgb24gYm90aCBrZXJuZWxzLgoKVGVzdGVkLWJ5OiBMdWlz
IE1lbmRlcyA8bHVpcy5wLm1lbmRlc0BnbWFpbC5jb20+CgpPbiBXZWQsIEZlYiAyMCwgMjAxOSBh
dCA5OjQ4IEFNIFRob21hcyBQZXRhenpvbmkKPHRob21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+
IHdyb3RlOgo+Cj4gRGVwZW5kaW5nIG9uIHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhlIFBDSSBjb250
cm9sbGVyL3BsYXRmb3JtLCB0aGUKPiBQQ0ktdG8tUENJIGJyaWRnZSBlbXVsYXRpb24gYmVoYXZp
b3IgbWlnaHQgbmVlZCB0byBiZSBkaWZmZXJlbnQuIEZvcgo+IGV4YW1wbGUsIG9uIHBsYXRmb3Jt
cyB0aGF0IHVzZSB0aGUgcGNpLW12ZWJ1IGNvZGUsIHdlIGN1cnJlbnRseSBkb24ndAo+IHN1cHBv
cnQgcHJlZmV0Y2hhYmxlIG1lbW9yeSBCQVJzLCBzbyB0aGUgY29ycmVzcG9uZGluZyBmaWVsZHMg
aW4gdGhlCj4gUENJLXRvLVBDSSBicmlkZ2UgY29uZmlndXJhdGlvbiBzcGFjZSBzaG91bGQgYmUg
cmVhZC1vbmx5Lgo+Cj4gVG8gaW1wbGVtZW50IHRoaXMsIHRoaXMgY29tbWl0IGV4dGVuZHMgcGNp
X2JyaWRnZV9lbXVsX2luaXQoKSB0byB0YWtlCj4gYSAiZmxhZ3MiIGFyZ3VtZW50LCB3aXRoIGN1
cnJlbnRseSBvbmUgZmxhZyBzdXBwb3J0ZWQ6Cj4gUENJX0JSSURHRV9FTVVMX05PX1BSRUZFVENI
QUJMRV9CQVIsIHRoYXQgd2lsbCBtYWtlIHRoZSBwcmVmZXRjaGFibGUKPiBtZW1vcnkgYmFzZSBh
bmQgbGltaXQgcmVnaXN0ZXJzIHJlYWQtb25seS4KPgo+IFRoZSBwY2ktbXZlYnUgYW5kIHBjaS1h
YXJkdmFyayBkcml2ZXJzIGFyZSB1cGRhdGVkIGFjY29yZGluZ2x5Lgo+Cj4gUmVwb3J0ZWQtYnk6
IEx1w61zIE1lbmRlcyA8bHVpcy5wLm1lbmRlc0BnbWFpbC5jb20+Cj4gUmVwb3J0ZWQtYnk6IExl
aWdoIEJyb3duIDxsZWlnaEBzb2xpbm5vLmNvLnVrPgo+IENjOiBMdcOtcyBNZW5kZXMgPGx1aXMu
cC5tZW5kZXNAZ21haWwuY29tPgo+IENjOiBMZWlnaCBCcm93biA8bGVpZ2hAc29saW5uby5jby51
az4KPiBGaXhlczogMWYwODY3M2VlZjEyMyAoIlBDSTogbXZlYnU6IENvbnZlcnQgdG8gUENJIGVt
dWxhdGVkIGJyaWRnZSBjb25maWcgc3BhY2UiKQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBQZXRh
enpvbmkgPHRob21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpLWFhcmR2YXJrLmMgfCAyICstCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpLW12ZWJ1LmMgICAgfCAyICstCj4gIGRyaXZlcnMvcGNpL3BjaS1icmlkZ2UtZW11bC5j
ICAgICAgICAgfCA4ICsrKysrKystCj4gIGRyaXZlcnMvcGNpL3BjaS1icmlkZ2UtZW11bC5oICAg
ICAgICAgfCA3ICsrKysrKy0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
