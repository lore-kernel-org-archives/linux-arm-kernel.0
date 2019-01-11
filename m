Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23784C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:09:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8123206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KPY5Pbte";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="exwAG7BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8123206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WAss5n8PTOQ8xwSmNnfc2YB+r9B4E4KZMNkCRC1CGEg=; b=KPY5Pbteg2pXiG
	ZqkUy6e+t8c2sWcR/+K0fZ7r9V9bTirSM0NriJnEuB8ww6ldTwT/4Vw4bR1Ux/mGmr7ed/oFYbOwr
	8hdqH1e/hZGmAX6m/l3c3/Un4ViIBil1GUEh0ruyPwFNvTfzoEaSTi8nA6ckLXuELBqJLMXVDapso
	le1yGbblORGqLWFGt6AQZiDUPqEZ6JSeslirENWLxNGexEC4eyJnE1YltiaS0JGc1YUdUGOTj5hhL
	Vz31bMIS9VnBRN8uvrH7m5WcN0zBsxmWXrv4g/XMBY33vT+Q4Wufa7pYrgqyqqaul5vEYLFBgAwqP
	mC2+5jm/DijUCRZ2RvVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghlKa-0001FZ-K2; Fri, 11 Jan 2019 01:09:52 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghlKX-0001Et-NP
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 01:09:51 +0000
Received: by mail-pf1-x444.google.com with SMTP id h3so6138158pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Fe3Dsge2/sohKf/r8nrgeahTeYX3ZFgVWTGpS6oIbYo=;
 b=exwAG7BWUmUhPlaS5IB0HcVlJC6YNcNQw9B8Z9ue9kIVvBJsQvI/mKKDakPDH2hz2A
 EKGEOvBaImDZrL+VZbcvtbT6KTEEpocbcuZ6z/dcW967hiqxadHyAH0kPhBQbMyqBGDI
 f0napScDEG1iE5DzSqCFFN5ZCiFsLdpLHC2JFv5XpKrSuGlQSK81p65ctPHF8HjI6A7I
 afesE+fzaZVHE/zhItZpwNet/gOUnRamOHAdpeThktWU25BsbThnj6L9XTMyMn5zULfI
 t/spxqxtRMqvzkoy1qXFxbpPCl3zajc6AInAOTzyNZQ9cu6xzWctrfv/BM2CS8vkkUkP
 uo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Fe3Dsge2/sohKf/r8nrgeahTeYX3ZFgVWTGpS6oIbYo=;
 b=L8KfMOODVoDFSgkAEz+r8RUQKU+E9G3DTsnedArwjrbDVUekSB7gkjtg4ZFLVjpMCq
 l2F7bEPWGwqvERNZaG4cH8KWaamF40aVb6SKQwAAe0BtwM2p7+g4ZsHEMReQGk61TTQ+
 8cxeWWhZjP0NyZU7YhmQhZcDWebppSRPdDsK/Pjsxb6l2kAQjXL3dbdea8fl/h5Pw1El
 l31rfDFoHK3kQmQST1LQOvrIqHazq9yl5ZX6kl+uYHo4/7+/A9ax2KTklIEjRSyhkLRs
 i8oztjtz8JIOnQ554XuusacYw3LDFxsEDcmjeUM4XCDv6MUZOxTUEYlSIULDSQ+8KRTj
 dTRg==
X-Gm-Message-State: AJcUukee9gZ7adVpNbu60W862uKaRm+JVrmyUO33E4LvjUf1fAnrVYm8
 GO/3lvGLLTMrcYB6Y4NGy75kCQ==
X-Google-Smtp-Source: ALg8bN5bN0wcaHbKqr3YcVzQgDLoRUY/ZIr00aXgwMTBoQ5kj74bAhot55qnc4Qbbaveem3R8CUx2A==
X-Received: by 2002:a62:1f53:: with SMTP id f80mr12416371pff.92.1547168989096; 
 Thu, 10 Jan 2019 17:09:49 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 j197sm116794847pgc.76.2019.01.10.17.09.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 17:09:48 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, ingrassia@epigenesys.com
Subject: Re: [PATCH v3 2/2] ARM: dts: meson8b: fix the Ethernet data line
 signals in eth_rgmii_pins
In-Reply-To: <20181229143556.27339-3-martin.blumenstingl@googlemail.com>
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-3-martin.blumenstingl@googlemail.com>
Date: Thu, 10 Jan 2019 17:09:47 -0800
Message-ID: <7hwoncov8k.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_170949_764300_73C62622 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org, jianxin.pan@amlogic.com,
 linus.luessing@c0d3.blue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4g
d3JpdGVzOgoKPiBBY2NvcmRpbmcgdG8gdGhlIE9kcm9pZC1DMSsgc2NoZW1hdGljcyB0aGUgRXRo
ZXJuZXQgVFhEMSBzaWduYWwgaXMKPiByb3V0ZWQgdG8gR1BJT0hfNSBhbmQgdGhlIFRYRDAgc2ln
bmFsIGlzIHJvdXRlZCB0byBHUElPSF82Lgo+IFRoZSBwdWJsaWMgUzgwNSBkYXRhc2hlZXQgc2hv
d3MgdGhhdCBUWEQwIGNhbiBiZSByb3V0ZWQgdG8gRElGXzJfUCBhbmQKPiBUWEQxIGNhbiBiZSBy
b3V0ZWQgdG8gRElGXzJfTiBpbnN0ZWFkLgo+Cj4gVGhlIHBpbiBncm91cHMgZXRoX3R4ZDBfMCAo
R1BJT0hfNikgYW5kIGV0aF90eGQwXzEgKERJRl8yX1ApIGFyZSBib3RoCj4gY29uZmlndXJlZCBh
cyBFdGhlcm5ldCBUWEQwIGFuZCBUWEQxIGRhdGEgbGluZXMgaW4gbWVzb244Yi5kdHNpLiBBdCB0
aGUKPiBzYW1lIHRpbWUgZXRoX3R4ZDFfMCAoR1BJT0hfNSkgYW5kIGV0aF90eGQxXzEgKERJRl8y
X04pIGFyZSBjb25maWd1cmVkCj4gYXMgVFhEMCBhbmQgVFhEMSBkYXRhIGxpbmVzIGFzIHdlbGwu
Cj4gVGhpcyByZXN1bHRzIGluIGEgYmFkIEV0aGVybmV0IHJlY2VpdmUgcGVyZm9ybWFuY2UuIFBy
ZXN1bWFibHkgdGhpcyBpcwo+IGR1ZSB0byB0aGUgZXRoX3R4ZDAgYW5kIGV0aF90eGQxIHNpZ25h
bCBiZWluZyByb3V0ZWQgdG8gdGhlIHdyb25nIHBpbnMuCj4gQXMgYSByZXN1bHQgb2YgdGhhdCBk
YXRhIGNhbiBvbmx5IGJlIHRyYW5zbWl0dGVkIG9uIGV0aF90eGQyIGFuZAo+IGV0aF90eGQzLiBI
b3dldmVyLCBJIGhhdmUgbm8gc2NvcGUgdG8gZnVsbHkgY29uZmlybSB0aGlzIGFzc3VtcHRpb24u
Cj4KPiBUaGUgdmVuZG9yIHUtYm9vdCBzb3VyY2VzIGZvciBPZHJvaWQtQzEgdXNlIHRoZSBmb2xs
b3dpbmcgRXRoZXJuZXQKPiBwaW5tdXggY29uZmlndXJhdGlvbjoKPiAgIFNFVF9DQlVTX1JFR19N
QVNLKFBFUklQSFNfUElOX01VWF82LCAweDNmNGYpOwo+ICAgU0VUX0NCVVNfUkVHX01BU0soUEVS
SVBIU19QSU5fTVVYXzcsIDB4ZjAwMDAwKTsKPiBUaGlzIHRyYW5zbGF0ZXMgdG8gdGhlIGZvbGxv
d2luZyBwaW4gZ3JvdXBzIGluIHRoZSBtYWlubGluZSBrZXJuZWw6Cj4gLSByZWdpc3RlciA2IGJp
dCAgMDogZXRoX3J4ZDEgKERJRl8wX1ApCj4gLSByZWdpc3RlciA2IGJpdCAgMTogZXRoX3J4ZDAg
KERJRl8wX04pCj4gLSByZWdpc3RlciA2IGJpdCAgMjogZXRoX3J4X2R2IChESUZfMV9QKQo+IC0g
cmVnaXN0ZXIgNiBiaXQgIDM6IGV0aF9yeF9jbGsgKERJRl8xX04pCj4gLSByZWdpc3RlciA2IGJp
dCAgNjogZXRoX3R4X2VuIChESUZfM19QKQo+IC0gcmVnaXN0ZXIgNiBiaXQgIDg6IGV0aF9yZWZf
Y2xrIChESUZfM19OKQo+IC0gcmVnaXN0ZXIgNiBiaXQgIDk6IGV0aF9tZGMgKERJRl80X1ApCj4g
LSByZWdpc3RlciA2IGJpdCAxMDogZXRoX21kaW9fZW4gKERJRl80X04pCj4gLSByZWdpc3RlciA2
IGJpdCAxMTogZXRoX3R4X2NsayAoR1BJT0hfOSkKPiAtIHJlZ2lzdGVyIDYgYml0IDEyOiBldGhf
dHhkMiAoR1BJT0hfOCkKPiAtIHJlZ2lzdGVyIDYgYml0IDEzOiBldGhfdHhkMyAoR1BJT0hfNykK
PiAtIHJlZ2lzdGVyIDcgYml0IDIwOiBldGhfdHhkMF8wIChHUElPSF82KQo+IC0gcmVnaXN0ZXIg
NyBiaXQgMjE6IGV0aF90eGQxXzAgKEdQSU9IXzUpCj4gLSByZWdpc3RlciA3IGJpdCAyMjogZXRo
X3J4ZDMgKERJRl8yX1ApCj4gLSByZWdpc3RlciA3IGJpdCAyMzogZXRoX3J4ZDIgKERJRl8yX04p
Cj4KPiBEcm9wIHRoZSBldGhfdHhkMF8xIGFuZCBldGhfdHhkMV8xIGdyb3VwcyBmcm9tIGV0aF9y
Z21paV9waW5zIHRvIGZpeCB0aGUKPiBFdGhlcm5ldCB0cmFuc21pdCBwZXJmb3JtYW5jZSBvbiBP
ZHJvaWQtQzEuIEFsc28gYWRkIHRoZSBldGhfcnhkMiBhbmQKPiBldGhfcnhkMyBncm91cHMgc28g
d2UgZG9uJ3QgcmVseSBvbiB0aGUgYm9vdGxvYWRlciB0byBzZXQgdGhlbSB1cC4KPgo+IGlwZXJm
MyBzdGF0aXN0aWNzIGJlZm9yZSB0aGlzIGNoYW5nZToKPiAtIHRyYW5zbWl0dGluZyBmcm9tIE9k
cm9pZC1DMTogNzQxIE1iaXRzL3NlYyAoMCByZXRyaWVzKQo+IC0gcmVjZWl2aW5nIG9uIE9kcm9p
ZC1DMTogMTk5IE1iaXRzL3NlYyAoMTcxMyByZXRyaWVzKQo+Cj4gaXBlcmYzIHN0YXRpc3RpY3Mg
YWZ0ZXIgdGhpcyBjaGFuZ2U6Cj4gLSB0cmFuc21pdHRpbmcgZnJvbSBPZHJvaWQtQzE6IDY2NyBN
Yml0cy9zZWMgKDAgcmV0cmllcykKPiAtIHJlY2VpdmluZyBvbiBPZHJvaWQtQzE6IDc1MCBNYml0
cy9zZWMgKDAgcmV0cmllcykKPgo+IEZpeGVzOiBiOTY0NDY1NDFkODM5MCAoIkFSTTogZHRzOiBt
ZXNvbjhiOiBleHRlbmQgZXRoZXJuZXQgY29udHJvbGxlciBkZXNjcmlwdGlvbiIpCj4gU2lnbmVk
LW9mZi1ieTogTWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVt
YWlsLmNvbT4KPiBDYzogRW1pbGlhbm8gSW5ncmFzc2lhIDxpbmdyYXNzaWFAZXBpZ2VuZXN5cy5j
b20+Cj4gQ2M6IExpbnVzIEzDvHNzaW5nIDxsaW51cy5sdWVzc2luZ0BjMGQzLmJsdWU+CgpRdWV1
ZWQgZm9yIHY1LjEgKGJyYW5jaDogdjUuMS9kdCkKCktldmluCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
