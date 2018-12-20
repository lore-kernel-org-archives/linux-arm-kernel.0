Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC170218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tCY1i95J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC170218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z9GEaYjUpf30AwGlIaLY+Jby4CB57MiUnfSdHoyHss0=; b=tCY1i95JbRMwlv
	ta1f3hZcmQ7D6gr0scjSZDJpCSS9twT0Z3G+69OVwYL2zwxjkRqLqyqbsVjjuMjCqXVtUPf3TbZVB
	pOjDT9nKkh+vIr4RpBz+NDRsx0ODKdTesN+AKoy2AXzZgqOWNqFSJhbs31HtFPcH+soGssj0cEumc
	BUMMWyaLuqqpBhTWMVtR0kkQezvEMy/t6kE6jlTfzRwtnXQIk+/aNkpgoO3Fm2jQ+1CK9u5ScJ0pe
	umtJYz5GmaN26hbRxhabbEl0Qves2T9WX1TuXD8AV+61hnx9q+k8c2yGEb1zMbP+TBnjMVD2yp8W6
	VPvWQmjpFKwY5EmidLtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0Il-0005Ml-Ob; Thu, 20 Dec 2018 15:31:55 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0Ih-0005LS-R6; Thu, 20 Dec 2018 15:31:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 64D85AF8D;
 Thu, 20 Dec 2018 15:31:38 +0000 (UTC)
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
To: Ben Whitten <Ben.Whitten@lairdtech.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
 <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
 <BY1PR02MB1114B352A3A73F8478AE667DE7BF0@BY1PR02MB1114.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <cd61fd58-02c0-8d1e-e194-cec3f0dea65c@suse.de>
Date: Thu, 20 Dec 2018 16:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <BY1PR02MB1114B352A3A73F8478AE667DE7BF0@BY1PR02MB1114.namprd02.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_073152_170575_FE8B067D 
X-CRM114-Status: GOOD (  18.35  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Pirko <jiri@resnulli.us>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>,
 "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan - ML <linux-wpan@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gMjAuMTIuMTggdW0gMTE6MTkgc2NocmllYiBCZW4gV2hpdHRlbjoKPj4+PiBUaGUgaGFyZC1N
QUMgaW1wbGVtZW50YXRpb25zIHdpbGwgYmUgb24gbXkgcGxhdGUgbW9zdGx5LCBhcyBib3RoIFNY
MTI3Ngo+Pj4+IGFuZCBTWDEzMDEgbmVlZCB0aGUgc29mdC1NQUMuCj4+Pgo+Pj4gT24gdGhlIFNY
MTMwMSBzaWRlIG9mIHRoaW5ncywgdGhlIGFiaWxpdHkgdG8gc2VuZCBtZXNzYWdlcyBhcyBhIExv
UmFXQU4KPj4+IG5vZGUgZGV2aWNlIGlzIGEgbmljaGUgdXNlIGNhc2UsIHRoZSBtYWpvcml0eSBp
ZiBub3QgYWxsIHBlb3BsZSB3aWxsIHVzZSB0aGUKPj4+IGNvbmNlbnRyYXRvciBjYXJkIGFzIHRo
ZSBwYXNzIHRocm91Z2ggZ2F0ZXdheSB0byB0aGUgbm9kZS4KPj4+Cj4+PiBJbiB0aGlzIG1vZGUg
b2Ygb3BlcmF0aW9uIHRoZSBwYXJhbWV0ZXJzIGZvciB0cmFuc21pc3Npb24gc3VjaCBhczsKPj4g
ZnJlcXVlbmN5LAo+Pj4gc3ByZWFkaW5nIGZhY3RvciAvIGRhdGEgcmF0ZSwgcG93ZXIsIGFyZSBn
aXZlbiBieSBhIHJlbW90ZSBzZXJ2ZXIgYW5kIHBhc3NlZAo+Pj4gaW4gZnJvbSB0aGUgdXNlcnNw
YWNlIGFwcGxpY2F0aW9uIHdoaWNoIHJlY2VpdmVkIGl0Lgo+Pj4gRXZlbnR1YWxseSBpbiB0aGUg
a2VybmVsIHRoZXNlIG5lZWQgdG8gYmUgY2hlY2tlZCBsb2NhbGx5IHRvIGVuc3VyZQo+PiByZWd1
bGF0b3J5Cj4+PiBjb21wbGlhbmNlLgo+Pj4gVG8gdGhhdCBlbmQgSSBoYXZlIGV4cGVyaW1lbnRl
ZCB3aXRoIGZyYW1pbmcsIGFzIENBTiBkb2VzLCBzbyB0aGF0IHRoaXMKPj4+IG1ldGFkYXRhIGNh
biBiZSBwcm92aWRlZCBvbiBhIHdyaXRlIGZyb20gdXNlcnNwYWNlIHRvIHRoZSBTWDEzMDEgZHJp
dmVyLgo+Pj4KPj4+IFNvdW5kcyBsaWtlIHdlIG5lZWQgZGlmZmVyZW50IHByb3RvY29scyBmb3Ig
ZnJhbWluZyB3aXRoaW4gdGhlIHByb3RvY29sCj4+IGZhbWlseS4KPj4+IFJhdyBpbiB0aGUgY2Fz
ZSBvZiBub2RlcyBhbmQgZnJhbWVkIHdpdGggbWV0YWRhdGEgaW4gdGhlIGNhc2Ugb2YKPj4gY29u
Y2VudHJhdG9yCj4+PiBjYXJkcywgdGhvdWdodHM/Cj4+Cj4+IFllcywgSSBoYXZlIHRob3VnaHQg
dGhlIHJvbGVzIG9mIG5vZGUgYW5kIGdhdGV3YXkuICBUaGV5IG1heSBoYXZlCj4+IGRpZmZlcmVu
dCBza2IgcGFzc2luZyBwYXRocy4KPj4gQXMgeW91IG1lbnRpb25lZCwgbWFueSB0aGluZ3Mgb2Yg
dGhlIGdhdGV3YXkgaXMgY29udHJvbGxlZCBieSB0aGUKPj4gcmVtb3RlIHNlcnZlci4gIFNvLCBJ
IG9ubHkgaW1wbGVtZW50IHRoZSBwYXRoIGZvciBub2RlcyByaWdodCBub3cuCj4+IE1heWJlLCB3
ZSBjYW4gaGF2ZSBhIHJvbGUgZmxhZzogbm9kZSwgZ2F0ZXdheSB3aGljaCBjYW4gYmUgYXNzaWdu
ZWQgYnkKPj4gc29tZSB3YXkuICBUaGVuLCB0aGUgc2tiIGNhbiBiZSBkZWNvZGUsIGNoZWNrZWQg
YW5kIHBhc3NlZCBhY2NvcmRpbmcKPj4gdG8gdGhlIHJvbGUgZmxhZy4gIEFuZCBtb2R1bGUgYWxz
byBjaGVja3MgdGhlIGludGVncml0eSAoTUlDLCBsZW5ndGgKPj4gLi4uKSBhbmQgZmlsdGVyIG91
dCB0aGUgYmFkIHNrYiBiZWZvcmUgc2VuZHMgdG8gbmV4dCBzdG9wLgo+IAo+IEFzIElQIGhhdmUg
SVBQUk9UT19UQ1AsIElQUFJPVE9fVURQLCBldGMgbWF5YmUgd2UgY2FuIGhhdmUKPiBMT1JBX1BS
T1RPX01PRFVMRSwgTE9SQV9QUk9UT19HQVRFV0FZIHdoaWNoIGRpY3RhdGVzIHRoZQo+IHBhdGh3
YXkgYW5kIHNrYiBmb3JtYXQuCgpObywgcGxlYXNlIGRvbid0LiBZb3Ugd2VyZSBvbiB0cmFjayB3
aXRoIHlvdXIgZWFybGllciBjb21tZW50OiBUaGUgdXNlcgpkZWNpZGVzIHdoYXQgaGUgd2FudHMg
dG8gZG8gYnkgc2VsZWN0aW5nIFBGX0xPUkFXQU4gd2l0aApTT0NLX0RHUkFNL19TRVFQQUNLRVQg
dnMuIFNPQ0tfUkFXIChvciBQRl9QQUNLRVQgd2l0aCBFVEhfUF9MT1JBW1dBTl0pLgoKVGhlIHRl
cm1pbm9sb2d5ICJnYXRld2F5IiBoYXMgbGl0dGxlIHRvIGRvIHdpdGggaXQuIEkndmUgaGVhcmQg
b2YgcGFja2V0CmZvcndhcmRlcnMgdXNpbmcgSlNPTiBmb3JtYXQgZm9yIGNvbW11bmljYXRpb24g
d2l0aCB0aGVpciBiYWNrZW5kLCBzbyBpdAphcHBlYXJzIHRvIGhpZ2hseSBkZXBlbmQgb24gd2hh
dCBleGFjdGx5IHRoZSBnYXRld2F5IHdhbnRzIHRvIGRvIGFuZCBob3cKdGhlIHVzZXIgd2FudHMg
dG8gYWNjZXNzIHRoZSBuZWVkZWQgZGF0YS4KClJlZ2FyZHMsCkFuZHJlYXMKCi0tIApTVVNFIExp
bnV4IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQpHRjogRmVs
aXggSW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uCkhSQiAyMTI4NCAo
QUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
