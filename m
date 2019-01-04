Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F19C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:36:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F7220675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hcyxJbPa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wYO4tnt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F7220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mYeO76zyA+PqDeMU78Hw3WkXH0mUG6wEpLU8Or2DFlQ=; b=hcyxJbPa/6EQ7U
	pGpVDJlPOCz99PuplgcGd8ZMnCg4Y/vhEN9D4aKfOu5ndy9rRkwbvpksjxdBBRNXv3pyPy5Om2HOE
	LbxRmOMsXBn6L3DbPSYBsaElQVqV/M3EvzFhlMAadbdsQWP831qcOHdOo/c25XCJV/aF8x6sosn9/
	uR4e69J1HfX5R8UwZCz6NlIw92K/Zm/j60e+g3OmayrbJzUGp0TXLvI9nAIgpjrfyov24QfOJzSgE
	3K5qOXZVEn+ROM1DnCZXW9B8H//z4qEckcsZ/y5FhDrXk/xgaSjSRBkREAXSkIBbAuWNZ2nplFyiO
	pvHIE58N0fbqiwcUmIMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMqC-0005vE-KO; Fri, 04 Jan 2019 10:36:36 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMq7-0005u1-Qv
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 10:36:34 +0000
Received: by mail-ed1-x541.google.com with SMTP id o10so31336879edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 02:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=JHFNuMXhkn6JkJ1AKiIggGsFpzQjYAkfcc/Ferbgp8c=;
 b=wYO4tnt4oVtFuZ/8hNXbLIzMeg//elvWv198r9sy05dgozlppbsgOuznFIBU3LWQWq
 9m/cSlry3A8WgYWbLEfqHOYI5ZcDjTY8uMsKC9mLgmTNLeVbNrQM8tkuziHPYes6ygrK
 GMQxR9OXJnawCDGj8PmUcaG4+O6a1kMhNn2fsdEFBXmp40WKI5NKsWCpWuogV0P2uSGK
 b2vIZZ++K4kYBGa1FFYLTVp7qZ3Crwo4CLOGoTliY4v6d3MpDg8ZLuH6EwhS18ZE76q4
 QaBGW/dgnuPtjXLsNmUud5qzNwY3m5AEPlrVMlvFh30VDJdioI9aMjpzSte5ciIWRQtW
 YJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=JHFNuMXhkn6JkJ1AKiIggGsFpzQjYAkfcc/Ferbgp8c=;
 b=uFG5RQ8TSR0czgC3/RsszBYGCe9wBLEbMKZBQH93PtpjPoxiDJew+QImoRmqQEQHdD
 zGXPSdlktflRX9ZQGDub3dAnke3Wnb4qVoxqnTfVBmuyioQzMWleK0552IHuJxhhNsqm
 cK1iKCwDd8D4BHP5B9dxAms6iyiKTpyfvIwnu7dOf1kj5uv4efXh6/14/OPq39rpQgxh
 LmvjFRxeiglsBCrpRxHfwYDMRt17bkrVELgY0kGrpWAVZrCCfnUAzgQ9TBqSqqLjbynk
 N0LDsf5U3Vy5RdvaJ0RUjWXDNMcko2ai24ULxslY1zkYUCefjkAWw3N4c2pye+da07Hj
 f4NA==
X-Gm-Message-State: AA+aEWZRAfLw5yrNLGvs6D8goGaSKlecC12V0q236TQNUss94WG2Gf7E
 IaZOlW7UwQ2pr2sa7zZG5OcVmg==
X-Google-Smtp-Source: AFSGD/VvaoF8MdqU8dVOeRVOWhaidMnHRUttyz5/5YctzrIGOdrD/9PZzK9ocQNULODyRbvytyw95A==
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr45134491edy.231.1546598189508; 
 Fri, 04 Jan 2019 02:36:29 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
 by smtp.googlemail.com with ESMTPSA id f6sm27533591ede.53.2019.01.04.02.36.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 02:36:28 -0800 (PST)
Date: Fri, 4 Jan 2019 11:36:26 +0100
From: LABBE Corentin <clabbe@baylibre.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: amlogic: fix build failure due to missing
 linux/gpio/consumer.h header
Message-ID: <20190104103626.GA8448@Red>
References: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
 <20190104103015.GA3738@red-moon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104103015.GA3738@red-moon>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_023631_922708_C93DFACC 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: khilman@baylibre.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBKYW4gMDQsIDIwMTkgYXQgMTA6MzA6MjVBTSArMDAwMCwgTG9yZW56byBQaWVyYWxp
c2kgd3JvdGU6Cj4gT24gRnJpLCBKYW4gMDQsIDIwMTkgYXQgMDk6MDg6MzdBTSArMDAwMCwgQ29y
ZW50aW4gTGFiYmUgd3JvdGU6Cj4gPiBXaGVuIGJ1aWxkaW5nIG9uIHg4NiwgSSBnb3QgdGhlIGZv
bGxvd2luZyBidWlsZCBmYWlsdXJlOgo+IAo+IEhpLAo+IAo+IHdoYXQgdHJlZSBhcmUgeW91IHRl
c3Rpbmcgb24gYW5kIHdoaWNoIGNvbmZpZyA/CgpJIHVzZSB0aGUgbmV4dC0yMDE5MDEwMiB0cmVl
ClRoZSBjb25maWcgY2FuIGJlIGZvdW5kIGF0IGh0dHA6Ly9rZXJuZWwubW9udGpvaWUub3ZoL2Nv
bmZpZ3MveDg2CgpSZWdhcmRzCgo+IAo+IFRoYW5rcywKPiBMb3JlbnpvCj4gCj4gPiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbWVzb24uYzogSW4gZnVuY3Rpb24g4oCYbWVzb25fcGNp
ZV9hc3NlcnRfcmVzZXTigJk6Cj4gPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbWVz
b24uYzoyOTA6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGdw
aW9kX3NldF92YWx1ZV9jYW5zbGVlcOKAmTsgZGlkIHlvdSBtZWFuIOKAmGdwaW9fc2V0X3ZhbHVl
X2NhbnNsZWVw4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiA+
ICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKG1wLT5yZXNldF9ncGlvLCAwKTsKPiA+ICAgXn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAgIGdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwCj4gPiBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbWVzb24uYzogSW4gZnVuY3Rpb24g4oCYbWVz
b25fcGNpZV9wcm9iZeKAmToKPiA+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1tZXNv
bi5jOjU0MDoxOTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGRl
dm1fZ3Bpb2RfZ2V04oCZOyBkaWQgeW91IG1lYW4g4oCYZGV2bV9ncGlvX2ZyZWXigJk/IFstV2Vy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ID4gICBtcC0+cmVzZXRfZ3BpbyA9
IGRldm1fZ3Bpb2RfZ2V0KGRldiwgInJlc2V0IiwgR1BJT0RfT1VUX0xPVyk7Cj4gPiAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4KPiA+ICAgICAgICAgICAgICAgICAgICBkZXZtX2dw
aW9fZnJlZQo+ID4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLW1lc29uLmM6NTQwOjQ4
OiBlcnJvcjog4oCYR1BJT0RfT1VUX0xPV+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhp
cyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhHUElPRl9JTklUX0xPV+KAmT8KPiA+ICAgbXAt
PnJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9MT1cp
Owo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgR1BJT0ZfSU5JVF9MT1cKPiA+IAo+ID4gVGhpcyBpcyBkdWUgdG8gdGhlIG1pc3Npbmcg
bGludXgvZ3Bpby9jb25zdW1lci5oIGhlYWRlcgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBDb3Jl
bnRpbiBMYWJiZSA8Y2xhYmJlQGJheWxpYnJlLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1tZXNvbi5jIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktbWVzb24uYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1tZXNvbi5j
Cj4gPiBpbmRleCAyNDFlYmUwYzQ1MDUuLmUzNWU5ZWFhNTBlZSAxMDA2NDQKPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1tZXNvbi5jCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktbWVzb24uYwo+ID4gQEAgLTgsNiArOCw3IEBACj4gPiAgCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgo+
ID4gKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+Cj4gPiAgI2luY2x1ZGUgPGxpbnV4
L29mX2RldmljZS5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9ncGlvLmg+Cj4gPiAgI2luY2x1
ZGUgPGxpbnV4L3BjaS5oPgo+ID4gLS0gCj4gPiAyLjE5LjIKPiA+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
