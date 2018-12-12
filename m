Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9204C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:23:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A36A20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFyBOLRm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="mOfWqmr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A36A20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ozVUaZ3g5IFOy9xnxtPGha2Y9xyQ98bz8s+P40V0kqo=; b=eFyBOLRmkBT6CG
	wuYMQdCcfOR7Hojl25db9yRl8pmvsp/pX9qHwSk+QslUPWkuItz5i8prH44cbMt8q6EpsNralbo6Z
	sOm41qu96sMCcWjDewgcuJqQlGnuO6Bb3j3x8STk5n+kEc2nR47Gv1IkXKGYYXlAykrp65kmCkMuH
	L66zqnaaEc712OXFAH1ClS/g13zN/y3m0hH0p751aE0DmR1STNg9yliAlYPHMSU2cir2FXy54SC7R
	xVggdgzZj5IjlGkOmuzur/MMs8MqRTeivq4rBZg//VbwL39Ku5JMD29xpV1c+7EVDPSBaUQRaE4CT
	FsyCQj2RB2c8HcW57BAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWznf-0005Bh-Rn; Wed, 12 Dec 2018 08:23:23 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWznc-0005AK-Vk
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 08:23:22 +0000
Received: by mail-io1-xd43.google.com with SMTP id w21so451163ioc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 00:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LI0Wl6BulX634HdsyTE9b5nHW86RHBJZvD2/gndbgVA=;
 b=mOfWqmr6h73vOycopbg1xDJoCT1ncnUKj3mKk8pbBrNMHw58kUhN0eCpe8nAi3XDXD
 5cP0iYjUyVWj4UzFYRctea0oKOvVdKYTcOqHV3K5yE2p9m1F36OlRxZPJKB4T9OXlQY1
 lmnLy0Lbd6B4ByVNoqkKd+/Ab2ERkzg4hjazTl17JoWEPla3ZFvEB5cI9nyxVfcv9IM0
 aYJNbohqVKyct5Kt/f94XgjLUEuV6a9Z/z7GYoOuqFPWrqyjfFVOYYRUyTBynWzoXDNe
 yUyNBJum4wo8Ap+E7IezPxxO2tEbNLfR7g+XjtVnsuhBg5L7fW6a7FcUn2JnKeifngaS
 szFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LI0Wl6BulX634HdsyTE9b5nHW86RHBJZvD2/gndbgVA=;
 b=jV+KfT+HsStu0s84MQxDCPJFY80kzUOHwO3clND0mCSudaH/1Ti3bqu2MIpQVS3bCs
 l+iXTc8kGvc/ZaOoyKG+VANyrQM/5FQchC8a81NiPBUeBXiZFyg4G4/RqkoTUO56gKv6
 Zi5KC4+b9Qi6XylBOFUWNou5dGJNsKbbejyCaWgcoZMI3J7y6f+9GqrhNnpqz01U/GS4
 tdKcntFVAJAZ3vlJvSzfd92kKSzejGm5JkhbNhlXi1IQQ9U9vzIqXFTWoQ5w9Bp4mMgE
 Z9wInNK4hSXO9bHDWkMapul0yJkIxznmes40WyZhRK8eBcXDE6/yPubMmLxcs2lt19Ml
 0Y/A==
X-Gm-Message-State: AA+aEWaMcGF6c1Kng0fSl+330HW3NPAHGsjhUBV9hETBPKa5yZuXAawA
 HsuUQcuRnERG7cU26UiqnYDsxsT4OAF8PhHYOYZu6w==
X-Google-Smtp-Source: AFSGD/V9wfJKlmKfzQtBMT01aGxF3Mwngb6JddBNct2ado2ztHeoMhQhjEizEB4x5nereQzCuJSJhmQDYN9CBst5c+o=
X-Received: by 2002:a5d:8049:: with SMTP id b9mr7591130ior.108.1544602990068; 
 Wed, 12 Dec 2018 00:23:10 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181212104304.49026ed2@xhacker.debian>
In-Reply-To: <20181212104304.49026ed2@xhacker.debian>
From: Marcin Wojtas <mw@semihalf.com>
Date: Wed, 12 Dec 2018 09:22:57 +0100
Message-ID: <CAPv3WKctDNJVq7SgHBZLO_TU50ponCLu7h5oMKLTndBiDadhaA@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To: Jisheng.Zhang@synaptics.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_002321_018162_25CAC045 
X-CRM114-Status: GOOD (  27.81  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev <netdev@vger.kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, nadavh@marvell.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, Stefan Chulski <stefanc@marvell.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmlzaGVuZywKCsWbci4sIDEyIGdydSAyMDE4IG8gMDM6NDggSmlzaGVuZyBaaGFuZyA8Smlz
aGVuZy5aaGFuZ0BzeW5hcHRpY3MuY29tPiBuYXBpc2HFgihhKToKPgo+IEhpLAo+Cj4gT24gVHVl
LCAxMSBEZWMgMjAxOCAxMzo1Njo0OSArMDEwMCBNYXJjaW4gV29qdGFzIHdyb3RlOgo+Cj4gPiBS
ZWNlbnQgY2hhbmdlcyBpbiB0aGUgbXZuZXRhIGRyaXZlciByZXdvcmtlZCBhbGxvY2F0aW9uCj4g
PiBhbmQgaGFuZGxpbmcgb2YgdGhlIGluZ3Jlc3MgYnVmZmVycyB0byB1c2UgZW50aXJlIHBhZ2Vz
Lgo+ID4gQXBhcnQgZnJvbSB0aGF0IGluIFNXIEJNIHNjZW5hcmlvIHRoZSBIVyBtdXN0IGJlIGlu
Zm9ybWVkCj4gPiB2aWEgUFJYRFFTIGFib3V0IHRoZSBiaWdnZXN0IHBvc3NpYmxlIGluY29taW5n
IGJ1ZmZlcgo+ID4gdGhhdCBjYW4gYmUgcHJvcGFnYXRlZCBieSBSWCBkZXNjcmlwdG9ycy4KPiA+
Cj4gPiBUaGUgQnVmZmVyU2l6ZSBmaWVsZCB3YXMgZmlsbGVkIGFjY29yZGluZyB0byB0aGUgTVRV
LWRlcGVuZGVudAo+ID4gcGt0X3NpemUgdmFsdWUuIExhdGVyIGNoYW5nZSB0byBQQUdFX1NJWkUg
YnJva2UgUlggb3BlcmF0aW9uCj4gPiB3aGVuIHVzaW4gNjRLIHBhZ2VzLCBhcyB0aGUgZmllbGQg
aXMgc2ltcGx5IHRvbyBzbWFsbC4KPiA+Cj4gPiBUaGlzIHBhdGNoIGNvbmRpdGlvbmFsbHkgbGlt
aXRzIHRoZSB2YWx1ZSBwYXNzZWQgdG8gdGhlIEJ1ZmZlclNpemUKPiA+IG9mIHRoZSBQUlhEUVMg
cmVnaXN0ZXIsIGRlcGVuZGluZyBvbiB0aGUgUEFHRV9TSVpFIHVzZWQuCj4gPiBPbiB0aGUgb2Nj
YXNpb24gcmVtb3ZlIG5vdyB1bnVzZWQgZnJhZ19zaXplIGZpZWxkIG9mIHRoZSBtdm5ldGFfcG9y
dAo+ID4gc3RydWN0dXJlLgo+ID4KPiA+IEZpeGVzOiA1NjJlMmY0NjdlNzEgKCJuZXQ6IG12bmV0
YTogSW1wcm92ZSB0aGUgYnVmZmVyIGFsbG9jYXRpb24KPiA+IG1ldGhvZCBmb3IgU1dCTSIpCj4K
PiBJTUhPLCB3ZSdkIGJldHRlciByZXZlcnQgNTYyZTJmNDY3ZTcxIGFuZCA3ZTQ3ZmQ4NGI1NmJi
Cj4KPiBUaGUgaXNzdWUgY29tbWl0IDU2MmUyZjQ2N2U3MSB3YW50cyB0byBzb2x2ZSBpcyBkdWUg
dG8gY29tbWl0IDdlNDdmZDg0YjU2YmIKPiBJdCBsb29rcyBhIGJpdCB3aXJlZCwgdG8gaW50cm9k
dWNlIHJlZ3Jlc3Npb24gdGhlbiBzdWJtaXQgYW5vdGhlciBjb21taXQoaW4KPiB0aGUgc2FtZSBw
YXRjaCBzZXQpIHNvbHZlIGl0Cj4KPiBQZXIgbXkgdGVzdCwgYWZ0ZXIgcmV2ZXJ0aW5nIDU2MmUy
ZjQ2N2U3MSBhbmQgN2U0N2ZkODRiNTZiYiwgSSBjYW4ndCByZXByb2R1Y2UKPiB3aGF0J3MgY2xh
aW1lZCBpbiBjb21taXQgNTYyZTJmNDY3ZTcxIC0tICJXaXRoIHN5c3RlbSBoYXZpbmcgYSBzbWFs
bCBtZW1vcnkKPiAoYXJvdW5kIDI1Nk1CKSwgdGhlIHN0YXRlICJjYW5ub3QgYWxsb2NhdGUgbWVt
b3J5IHRvIHJlZmlsbCB3aXRoIG5ldyBidWZmZXIiCj4gaXMgcmVhY2ggcHJldHR5IHF1aWNrbHku
IgoKSSBhbSBub3QgdGhlIG9uZSB0byBkZWNpZGUgYWJvdXQgcGF0Y2ggcmV2ZXJ0aW5nLiBGcm9t
IHdoYXQgSQp1bmRlcnN0YW5kLCBjb21taXQgN2U0N2ZkODRiNTZiYiB3YXMgaW50b3JkdWNlZCBp
biBvcmRlciB0byBpbmNyZWFzZQpwZXJmb3JtYW5jZSB0aGFua3MgdG8gcmVwbGFjaW5nIG12bmV0
YV9mcmFnX2FsbG9jL2ZyZWUgd2l0aCB1c2luZwplbnRpcmUgcGFnZXMgZm9yIFJYIGJ1ZmZlcnMu
IEkgaGF2ZSAyIHF1ZXN0aW9uczoKLSB3aXRob3V0IHJldmVydGluZyBhbnl0aGluZywgZG8geW91
IG9ic2VydmUgbWVtb3J5IGFsbG9jYXRpb24KcHJvYmxlbXMgZHVyaW5nIHJlZmlsbD8KLSBhcmUg
eW91IGFibGUgdG8gY2hlY2sgTDIgZm9yd2FyZGluZyBudW1iZXJzIG9uIHRvcCBvZiB0aGUgcHVy
ZQptYWlubGluZSBicmFuY2ggYW5kIGFmdGVyIHJldmVydGluZyB0aGUgbWVudGlvbmVkIHBhdGNo
ZXM/IEknbQp3b25kZXJpbmcgd2hhdCB3b3VsZCBiZSB0aGUgcGVyZm9ybWFuY2UgcGVuYWx0eSAo
aWYgYW55KS4KCkJlc3QgcmVnYXJkcywKTWFyY2luCgo+Cj4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBNYXJjaW4gV29qdGFzIDxtd0BzZW1paGFsZi5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9tYXJ2ZWxsL212bmV0YS5jIHwgNiArKystLS0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212bmV0YS5jIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9tdm5ldGEuYwo+ID4gaW5kZXggZTUzOTdjOC4uNjFiMjM0OSAxMDA2NDQKPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvbXZuZXRhLmMKPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvbXZuZXRhLmMKPiA+IEBAIC00MDgsNyArNDA4LDYg
QEAgc3RydWN0IG12bmV0YV9wb3J0IHsKPiA+ICAgICAgIHN0cnVjdCBtdm5ldGFfcGNwdV9zdGF0
cyBfX3BlcmNwdSAgICAgICAqc3RhdHM7Cj4gPgo+ID4gICAgICAgaW50IHBrdF9zaXplOwo+ID4g
LSAgICAgdW5zaWduZWQgaW50IGZyYWdfc2l6ZTsKPiA+ICAgICAgIHZvaWQgX19pb21lbSAqYmFz
ZTsKPiA+ICAgICAgIHN0cnVjdCBtdm5ldGFfcnhfcXVldWUgKnJ4cXM7Cj4gPiAgICAgICBzdHJ1
Y3QgbXZuZXRhX3R4X3F1ZXVlICp0eHFzOwo+ID4gQEAgLTI5MDUsNyArMjkwNCw5IEBAIHN0YXRp
YyB2b2lkIG12bmV0YV9yeHFfaHdfaW5pdChzdHJ1Y3QgbXZuZXRhX3BvcnQgKnBwLAo+ID4gICAg
ICAgaWYgKCFwcC0+Ym1fcHJpdikgewo+ID4gICAgICAgICAgICAgICAvKiBTZXQgT2Zmc2V0ICov
Cj4gPiAgICAgICAgICAgICAgIG12bmV0YV9yeHFfb2Zmc2V0X3NldChwcCwgcnhxLCAwKTsKPiA+
IC0gICAgICAgICAgICAgbXZuZXRhX3J4cV9idWZfc2l6ZV9zZXQocHAsIHJ4cSwgcHAtPmZyYWdf
c2l6ZSk7Cj4gPiArICAgICAgICAgICAgIG12bmV0YV9yeHFfYnVmX3NpemVfc2V0KHBwLCByeHEs
IFBBR0VfU0laRSA8IFNaXzY0SyA/Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFBBR0VfU0laRSA6Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE1WTkVUQV9SWF9CVUZfU0laRShwcC0+cGt0X3NpemUpKTsKPiA+ICAgICAgICAgICAgICAg
bXZuZXRhX3J4cV9ibV9kaXNhYmxlKHBwLCByeHEpOwo+ID4gICAgICAgICAgICAgICBtdm5ldGFf
cnhxX2ZpbGwocHAsIHJ4cSwgcnhxLT5zaXplKTsKPiA+ICAgICAgIH0gZWxzZSB7Cj4gPiBAQCAt
Mzc2MCw3ICszNzYxLDYgQEAgc3RhdGljIGludCBtdm5ldGFfb3BlbihzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2KQo+ID4gICAgICAgaW50IHJldDsKPiA+Cj4gPiAgICAgICBwcC0+cGt0X3NpemUgPSBN
Vk5FVEFfUlhfUEtUX1NJWkUocHAtPmRldi0+bXR1KTsKPiA+IC0gICAgIHBwLT5mcmFnX3NpemUg
PSBQQUdFX1NJWkU7Cj4gPgo+ID4gICAgICAgcmV0ID0gbXZuZXRhX3NldHVwX3J4cXMocHApOwo+
ID4gICAgICAgaWYgKHJldCkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
