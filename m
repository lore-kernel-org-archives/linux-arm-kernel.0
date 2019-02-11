Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A96EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:59:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FFC217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RM1Su9kz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I55zDR3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FFC217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DPBBgkzQ+s3tvCRXFOwsbu6CtsiPQk/Czq3a0ltJwL0=; b=RM1Su9kzNBXjuE
	Q0rTo3LhY9vq+FSPPJbm02PXId6DPf2UCXT+HR0I5M7d/jFPHopAaewD7GhXEh49nI+0BsMb70wzX
	wI3asCboCZUbjXPmeKbr00o94rD3OuPPPqw977tE1aC+bP+jxpko0mxp2D6HrmXGI7bTCq9+vtHuD
	3ExkbuPjizRo+qOiEboZUhMwPEnJbq2FVcVb6EJvXk2QbcCPSQ7/DpA683yZaUHSUX/KmTiln/US8
	TjEhzxUNH3w0KwXofmjEQi7XBDQkHuyxKmh7Onomu1zvqlOgGezi3+uU7vc2OlAQWw7NBxfE06gvm
	9wwDqq7oLVVyTuTg/C2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtIfM-0005l1-LP; Mon, 11 Feb 2019 20:59:00 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtIfI-0005kd-RE
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:58:58 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so211664lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cMS+mBtOfVK0ktn94KoinS4OGAfHOepGzJNe1ILwGHw=;
 b=I55zDR3dMrixwqtVv4jM1p8CAReb/z18xT6GT60Y6tovHGZoUGdog3AOTT7x0U1cw3
 CsnOw7osklLoJyvdjw6MOALFtF1OSEsXS3HZgdws/fbxbIe5HioK3BjOjddwOXcbK/sZ
 E3VDdrlUfAAWxMN+9GwTBe3iwde4laki+oXwCS8Lkbq59jKqLfIYF5wtWntRKwbfcY51
 7q8QoHOIoUWdycSqnFbl0Xq3GWd9H0y0EyRlRWXacSF+8uAHU9wGCxGBXOAr1G/AuvJL
 IMHM7khlj6oE3dtCaMgKmHqCsN5vfzGCwSBIUTRBtV1hIcG+8VWC14NoHOxeEMMFERsv
 0MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cMS+mBtOfVK0ktn94KoinS4OGAfHOepGzJNe1ILwGHw=;
 b=VJhJZQ9l+C6SuFDyy/KezZnXRdauvSYvhEFUGbX+woC482oiTxmYCdVAKQPAbaS02I
 h8eXsy6G6x7TVJ9M4q1gByapoLctUDXbXlIYJn8pv6LvpWgFiSvVvWNe7tmwVPEKGx0F
 qCezY5fhDFErgfXFmn5X7XXy+2+W/TG3k0yY1rqnRIeM1xDr+UkdMMDvb8Xk2YfQlJGJ
 XebfudUWVtyESsyFe+exhv0cj/+/yKc+rMihVizfrK+fleQnOW9Jg6ZArzrFCo6EPJIe
 x7ii5w/wIT1XDQGYRRnPD6tFslp6z/4KrXPb8l3t+JE0ANLAJ6yY3aco4jispm/1vL4t
 xrhw==
X-Gm-Message-State: AHQUAuaiM9WK6SHHHNWgG0MFyDqe5ig7AGw49Cxc0g0E1ed6uaI/d+pJ
 kvVQ4cmSxlWjXNOnP9tRYdUtSz4xpUP1E9M4FIgEjQ==
X-Google-Smtp-Source: AHgI3IZgDYtk5w53+pi+PZmy92lWfuGNB9fI6nGms2lmIJfXYxHPdOIeaMoUSFRu46yXsaS95raTLBv0zK+Sq2DLkN8=
X-Received: by 2002:a19:c48e:: with SMTP id u136mr69663lff.167.1549918733665; 
 Mon, 11 Feb 2019 12:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
In-Reply-To: <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Feb 2019 21:58:41 +0100
Message-ID: <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_125856_903681_6F5CCE9D 
X-CRM114-Status: GOOD (  25.08  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgNDozMCBQTSBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2ll
ckBhcm0uY29tPiB3cm90ZToKCj4gPiArc3RhdGljIGludCBpeHA0eHhfc2V0X2lycV90eXBlKHN0
cnVjdCBpcnFfZGF0YSAqZCwgdW5zaWduZWQgaW50IHR5cGUpCj4gPiArewo+ID4gKyAgICAgLyog
QWxsIGFyZSBsZXZlbCBhY3RpdmUgaGlnaCAoYXNzZXJ0ZWQpIGhlcmUgKi8KPgo+IEl0J2QgYmUg
Z29vZCB0byByZXR1cm4gYW4gZXJyb3IgaWYgdHlwZSBpc24ndCBMRVZFTF9ISUdILgoKT0sKCj4g
PiArICAgICBpZiAoaXhpLT5pc18zNTYgJiYgZC0+aHdpcnEgPj0gMzIpIHsKPiA+ICsgICAgICAg
ICAgICAgdmFsID0gX19yYXdfcmVhZGwoaXhpLT5pcnFiYXNlICsgSVhQNFhYX0lDTVIyKTsKPiA+
ICsgICAgICAgICAgICAgdmFsICY9IH5CSVQoZC0+aHdpcnEgLSAzMik7Cj4gPiArICAgICAgICAg
ICAgIF9fcmF3X3dyaXRlbCh2YWwsIGl4aS0+aXJxYmFzZSArIElYUDRYWF9JQ01SMik7Cj4gPiAr
ICAgICB9IGVsc2Ugewo+ID4gKyAgICAgICAgICAgICB2YWwgPSBfX3Jhd19yZWFkbChpeGktPmly
cWJhc2UgKyBJWFA0WFhfSUNNUik7Cj4gPiArICAgICAgICAgICAgIHZhbCAmPSB+QklUKGQtPmh3
aXJxKTsKPiA+ICsgICAgICAgICAgICAgX19yYXdfd3JpdGVsKHZhbCwgaXhpLT5pcnFiYXNlICsg
SVhQNFhYX0lDTVIpOwo+ID4gKyAgICAgfQo+ID4gK30KPgo+IFRoaXMgcHJvYmFibHkgY29tZXMg
ZnJvbSB0aGUgb3JpZ2luYWwgY29kZSwgYnV0IEknZCBsaWtlIHRvIGJlIGFibGUgdG8KPiB1c2Ug
YSBMRSBrZXJuZWwgb24gdGhpcyBIVyAoZnVsbCBkaXNjbG9zdXJlOiBJIGhhdmUgc29tZSBvZiB0
aGlzIGNyYXAKPiBzdGFzaGVkIHNvbWV3aGVyZSBpbiB0aGUgYmFzZW1lbnQuLi4gOy0pLgoKSXQg
d2lsbCB3b3JrLiBPbmUgcmVhc29uIEkgYW0gcmVmYWN0b3JpbmcgYW5kIHByZXNlcnZpbmcgSVhQ
NHh4CmlzIHRoaXMgc3R1ZmYgZnJvbSB0aGUgZGF0YXNoZWV0OgoKQW1iaWVudCBBaXIgVGVtcGVy
YXR1cmUgKEV4dGVuZGVkKSAgLTQwwrAgQyB0byA4NcKwIEMKQW1iaWVudCBBaXIgVGVtcGVyYXR1
cmUgKENvbW1lcmNpYWwpIDDCsCBDIHRvIDcwwrAgQwpNVEJGOiA2MCBZZWFycyBhdCA1NcKwQwoK
QW5kIEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYW55IGJpZyBkaWZmZXJlbmNlIGJldHdlZW4gdGhl
ICJleHRlbmRlZCIKYW5kICJjb21tZXJjaWFsIiB2ZXJzaW9uIG9mIHRoaXMgU29DLCB0aGV5IGFs
bCBjb21lIGluIHRoZSBzYW1lCnN0dXJkeSBwYWNrYWdpbmcgdG9vLiBEaWFtb25kcyBhbmQgSVhQ
NHh4IGFyZSBmb3JldmVyLgoKPiBIb3cgYWJvdXQgdXNpbmcgc29tZXRoaW5nIHRoYXQgZW5mb3Jj
ZXMgdGhlIGVuZGlhbm5lc3Mgb2YgdGhlIGFjY2Vzc2VzLAo+IGFzIEkgc3VzcGVjdCB0aGUgYnVz
IGlzIGhhcmRjb2RlZCB0byBCRT8KClNvLCBJSVVDIChLcnp5c3p0b2YgY2FuIGNvbmZpcm0pIElY
UDR4eCB3b3JrcyBsaWtlIHRoaXMgdGhhdCB3aGVuIHRoZQpDUFUgaXMgYnJvdWdodCB1cCBpbiBM
RSBtb2RlLCBhbGwgYnl0ZXMgb24gdGhlIGFkZHJlc3MgYnVzIGFyZQpzd2l6emxlZCBzbyB0aGF0
IHRoZSBhY2Nlc3MgY2FuIGFsd2F5cyB1c2UgdGhlIENQVSBuYXRpdmUKZW5kaWFubmVzcy4KCklz
bid0IGl0IGNyYXp5IDpECgpUaGlzIG1lYW5zIF9fcmF3X3dyaXRlbCgpIHdpbGwgYWx3YXlzIGRv
IHRoZSByaWdodCB0aGluZywgYmVjYXVzZQp0aGF0IHVzZXMgbmF0aXZlIGVuZGlhbm5lc3MsIGFu
ZCB0aGF0IGlzIHdoeSBpdCBpcyB1c2VkIHF1aXRlIGEgbG90CmluIElYUDR4eCBkcml2ZXJzLgoK
SWYgeW91IHdhbnQgZnVsbCBjb250cm9sIHlvdSBuZWVkIHRvIGRlZmluZSBsb2NhbCBoZWxwZXJz
IGZvcgpldmVyeXRoaW5nIHRoYXQgY2hhbmdlIGJlaGF2aW91ciBhdCBjb21waWxlLXRpbWUgc3Vj
aCBhczoKCnN0YXRpYyB2b2lkIGZvb193cml0ZWwodTMyIHZhbCwgX19pb21lbSB2b2lkICphZGRy
KQp7CiNpZiBkZWZpbmVkKENPTkZJR19DUFVfQklHX0VORElBTikKICAgaW93cml0ZTMyYmUodmFs
LCBhZGRyKTsKI2Vsc2UKICAgIHdyaXRlbCh2YWwsIGFkZHIpOwojZW5kaWYKfQoKV2hpY2ggd2ls
bCBoYXZlIHRoZSBzYW1lIGVmZmVjdCBhcyBfX3Jhd193cml0ZWwoKS4KClNvIHRoYXQgaXMgd2h5
IHdlIHVzZSB0aGUgKHVnbHkpIG1hY3JvIF9fcmF3X3dyaXRlbCgpIGEgbG90CmluIElYUDR4eCBk
cml2ZXJzLgoKPiBpb3JlYWQzMmJlL2lvd3JpdGUzMmJlIHNwcmluZ3MKPiB0byBtaW5kLCBhbmQg
SSBjYW4gc2VlIHRoZSBjdXJyZW50IElYUDR4eCBjb2RlIHByb3ZpZGVzIHN1Y2ggYW4KPiBpbXBs
ZW1lbnRhdGlvbiBpbiBpdHMgb3duIGlvLmggKHdoaWNoIHlvdSBtYXkgaGF2ZSB0byBtYWtlIHBy
aXZhdGUpLgoKVGhlIHN0dWYgaW4gPG1hY2gvaW8uaD4gaXMgdGhlcmUgZm9yIGluZGlyZWN0IFBD
SSwgd2hpY2ggaXMKYW5vdGhlciB1bnJlbGF0ZWQgb2RkaXR5LiBQQ0kgZGV2aWNlcyBhcmUgYWx3
YXlzIExFIChhcyBpcwpwcm9wZXIpLiBJdCBpcyB0aGVyZSBiZWNhdXNlIHRoZSBQQ0kgaG9zdCBv
biB0aGUgSVhQNHh4IGNhbgpvbmx5IGFjY2VzcyA+IDY0TUIgUENJIG1lbW9yeSBzcGFjZSB3aXRo
IGNlcnRhaW4gcXVpcmtzIHRoYXQKbm8gb3RoZXIgUENJIGhvc3QgY29udHJvbGxlciBuZWVkcy4K
Ckkgd2lsbCBnZXQgdG8gdGhpcyB3aGVuIEkgdHJ5IHRvIG1vdmUgdGhhdCBkcml2ZXIgdG8gZHJp
dmVycy9wY2kgLi4uCkl0J3MgdW5yZWxhdGVkIHRvIHRoaXMgYnVzaW5lc3MgaG93ZXZlci4KCj4g
PiArICAgICBpeGktPmlycWNoaXAubmFtZSA9ICJJWFA0eHgiOwo+ID4gKyAgICAgaXhpLT5pcnFj
aGlwLmlycV9tYXNrID0gaXhwNHh4X2lycV9tYXNrOwo+ID4gKyAgICAgaXhpLT5pcnFjaGlwLmly
cV91bm1hc2sgPSBpeHA0eHhfaXJxX3VubWFzazsKPiA+ICsgICAgIGl4aS0+aXJxY2hpcC5pcnFf
c2V0X3R5cGUgPSBpeHA0eHhfc2V0X2lycV90eXBlOwo+Cj4gQXJlbid0IHlvdSBndWFyYW50ZWVk
IHRvIG9ubHkgaGF2ZSBvbmUgc3VjaCBpcnFjaGlwPyBJZiBzbywgdGhpcyBjb3VsZAo+IGJlY29t
ZSBhIHN0YXRpYyBjb25zdCBvYmplY3QsIGluc3RlYWQgb2YgYWxsb2NhdGluZyBpdCBkeW5hbWlj
YWxseS4gTm90Cj4gYSBiaWcgZGVhbCB0aG91Z2guCgpGb3JjZSBvZiBoYWJpdC4gQ29tZXMgZnJv
bSB0aGUgR1BJTyBzaWRlIG9mIHRoaW5ncyB3aGVyZSB3ZQpuZXZlciBrbm93IGhvdyBtYW55IGlu
c3RhbmNlcyB0aGVyZSBhcmUgb2Ygc3R1ZmYsIGlmIGl0J3MgT0sKSSdkIGxpa2UgdG8ga2VlcCBp
dC4KCj4gPiArICAgICBmd25vZGUgPSBpcnFfZG9tYWluX2FsbG9jX2Z3bm9kZShiYXNlKTsKPgo+
IEkgYXNzdW1lIHRoaXMgaXMgYSB0ZW1wb3Jhcnkgc29sdXRpb24gdW50aWwgdGhlIFNvQyBnYWlu
cyBhIERUIHBvcnQgKGFuZAo+IHRoZSBpcnFjaGlwIGEgRFQgbm9kZSk/CgpZZXMsIHNlZSB0aGUg
bGF0ZXIgRFQgcGF0Y2ggdGhhdCBwYXNzZXMgdGhlIHBhcmVudCBhcwpmd25vZGUsIG9uY2UgYWxs
IGJvYXJkcyBhcmUgY29udmVydGVkIHdlIGNhbiBkcm9wIHRoaXMuCgpCVFcgaGVyZSBpcyBob3cg
SSB0aGVuIHVzZSB0aGUgaGllcmFyY2hpY2FsIHBhcmVudCBpbiB0aGUKR1BJTyBjaGlwOgpodHRw
czovL21hcmMuaW5mby8/bD1saW51eC1hcm0ta2VybmVsJm09MTU0OTIzMDIzOTA3NjIzJnc9Mgpo
dHRwczovL21hcmMuaW5mby8/bD1saW51eC1hcm0ta2VybmVsJm09MTU0OTIzMDM4NzA3Njg2Jnc9
MgoKWW91cnMsCkxpbnVzIFdhbGxlaWoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
