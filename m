Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46AC67838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:12:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7980A20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BIz0R01u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7980A20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybernetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V9HxyuA9VH4Ap8capFPz0yM6u+ZRiIl4OORqDqEXiUI=; b=BIz0R01ua3/Eel
	swBDh4o94OakIPSF74xTbUFdPV8wfFC013kHOLfbho3e/O+KvwOXXGdH8gD/vV/cUS/BZz5fGdJyT
	n8NSuMYmeYckriKtAo8nQZVs+RFDa1ah013oVKB6yvf5n/MHwh92xBWM2c7HRLokYEZnldFt149A3
	mIsqxqwqwWSXDhtgC2VhQknhPkIR6G3d55fztOgCey/Cw7YTe4wiJxswcsoGb7e8ZotKqQgq9v2+Q
	RKJCrA1PI4Z5/UPIycvo/TSui+wGKMN5WuxWhCHlHxvYFz0yjqHzan9znzKSo2sFLlhAtu9DZNxwy
	3eh4SqoNwL3O0IKxThcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvKB-0004w8-8h; Thu, 06 Dec 2018 15:12:23 +0000
Received: from mail.cybernetics.com ([173.71.130.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvK5-0004vg-CG
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:12:21 +0000
X-ASG-Debug-ID: 1544109118-0fb3b01fb3c5a6c0002-tbGyMd
Received: from cybernetics.com ([10.157.1.126]) by mail.cybernetics.com with
 ESMTP id up9TucNETYmhGcU7 (version=SSLv3 cipher=DES-CBC3-SHA bits=112
 verify=NO); Thu, 06 Dec 2018 10:11:58 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
 with ESMTPSA id 8569752; Thu, 06 Dec 2018 10:11:58 -0500
Subject: Re: dmapool regression in next
To: Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com
X-ASG-Orig-Subj: Re: dmapool regression in next
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
From: Tony Battersby <tonyb@cybernetics.com>
Message-ID: <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
Date: Thu, 6 Dec 2018 10:11:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.157.1.126]
X-Barracuda-Start-Time: 1544109118
X-Barracuda-Encrypted: DES-CBC3-SHA
X-Barracuda-URL: https://10.157.1.122:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2200
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-BRTS-Status: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_071217_492707_34E78D25 
X-CRM114-Status: GOOD (  10.59  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, john.garry@huawei.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
 akpm@linux-foundation.org, linux-omap@vger.kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvNi8xOCA0OjI1IEFNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOgo+IE9uIFRodSwg
NiBEZWMgMjAxOCBhdCAwMjozMSwgVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4gd3Jv
dGU6Cj4+IEhpLAo+Pgo+PiBMb29rcyBsaWtlIHdpdGggY29tbWl0IDI2YWJlODhlODMwZCAoIm1t
L2RtYXBvb2wuYzogaW1wcm92ZSBzY2FsYWJpbGl0eQo+PiBvZiBkbWFfcG9vbF9mcmVlKCkiKSBJ
J20gbm93IGdldHRpbmcgc3BhbW1lZCB3aXRoIGxvdHMgb2YgIihiYWQgdmFkZHIpIgo+PiBvbiBh
dCBsZWFzdCBvbWFwNCBwYW5kYWJvYXJkLCBzZWUgYmVsb3cuCj4+Cj4+IEFueSBpZGVhcyB3aGF0
IG1pZ2h0IGJlIGdvaW5nIHdyb25nPwo+Pgo+PiBSZWdhcmRzLAo+Pgo+PiBUb255Cj4+Cj4+IDg8
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiBvbWFwLWRtYS1lbmdpbmUgNGEwNTYwMDAuZG1hLWNv
bnRyb2xsZXI6IGRtYV9wb29sX2ZyZWUgNGEwNTYwMDAuZG1hLWNvbnRyb2xsZXIsIChwdHJ2YWwp
IChiYWQgdmFkZHIpLzB4YmU4MDAwMDAKPj4gb21hcC1kbWEtZW5naW5lIDRhMDU2MDAwLmRtYS1j
b250cm9sbGVyOiBkbWFfcG9vbF9mcmVlIDRhMDU2MDAwLmRtYS1jb250cm9sbGVyLCAocHRydmFs
KSAoYmFkIHZhZGRyKS8weGJlODAwMDFjCj4+IG9tYXAtZG1hLWVuZ2luZSA0YTA1NjAwMC5kbWEt
Y29udHJvbGxlcjogZG1hX3Bvb2xfZnJlZSA0YTA1NjAwMC5kbWEtY29udHJvbGxlciwgKHB0cnZh
bCkgKGJhZCB2YWRkcikvMHhiZTgwMDAzOAo+PiAuLi4KPiBJIHNlZSBpdCBhcyB3ZWxsIG9uIGFs
bCBteSBFeHlub3MgYm9hcmRzLCBzaW5jZSB5ZXN0ZXJkYXkncyBuZXh0LiBJbgo+IG15IGNhc2Ug
aXQgaXMgdGhlIFVTQiBFSENJIGRyaXZlcjoKPiBleHlub3MtZWhjaSAxMjExMDAwMC51c2I6IGRt
YV9wb29sX2ZyZWUgZWhjaV9xdGQsIChwdHJ2YWwpIChiYWQKPiB2YWRkcikvMHhiODg0NDE4MAo+
IEZ1bGwgbG9nIGhlcmU6Cj4gaHR0cHM6Ly9rcnprLmV1LyMvYnVpbGRlcnMvMS9idWlsZHMvMjkz
Ny9zdGVwcy8xMi9sb2dzL3NlcmlhbDAKPgo+IEJlc3QgcmVnYXJkcywKPiBLcnp5c3p0b2YKPgpI
ZXJlIGlzIHRoZSBwcm90b3R5cGU6Cgp2b2lkIGRtYV9wb29sX2ZyZWUoc3RydWN0IGRtYV9wb29s
ICpwb29sLCB2b2lkICp2YWRkciwgZG1hX2FkZHJfdCBkbWEpOwoKV2l0aCB0aGUgb2xkIGNvZGUs
IHRoZSAnZG1hJyB2YWx1ZSBoYWQgdG8gYmUgY29ycmVjdCBmb3IgdXNlIHdpdGgKcG9vbF9maW5k
X3BhZ2UoKSwgb3IgZWxzZSB5b3Ugd291bGQgZ2V0IGFuIGVycm9yLsKgIElmIHRoZSAndmFkZHIn
IHZhbHVlCndhcyBpbmNvcnJlY3QsIGl0IHdvdWxkIGNvcnJ1cHQgdGhlIGRtYXBvb2wgZnJlZWxp
c3QsIGJ1dCB5b3Ugd291bGRuJ3QKZ2V0IGFuIGVycm9yIHVubGVzcyBETUFQT09MX0RFQlVHIHdh
cyBlbmFibGVkLgoKV2l0aCBteSBwYXRjaCBhcHBsaWVkLCAndmFkZHInIGhhcyB0byBiZSBjb3Jy
ZWN0IGZvciB2aXJ0X3RvX3BhZ2UoKS7CoCBNeQpjb2RlIGFsc28gY2hlY2tzIHRoYXQgJ2RtYScg
aXMgY29uc2lzdGVudCB3aXRoICd2YWRkcicgZXZlbiBpZgpETUFQT09MX0RFQlVHIGlzIGRpc2Fi
bGVkLCBzaW5jZSB0aGUgY2hlY2sgaXMgZmFzdCBhbmQgaXQgd2lsbCBwcmV2ZW50CnByb2JsZW1z
IGxpa2UgdGhpcyBpbiB0aGUgZnV0dXJlLgoKU28gaWYgYSBidWdneSBkcml2ZXIgcGFzc2VzIGlu
IGEgZ29vZCB2YWx1ZSBmb3IgJ2RtYScgYnV0IGEgYmFkIHZhbHVlCmZvciAndmFkZHInLCB0aGVu
IGl0IG1heSBoYXZlIGFwcGVhcmVkIHRvIHdvcmsgcHJldmlvdXNseSAoYnV0IHdpdGgKcG9zc2li
bGUgZGF0YSBjb3JydXB0aW9uLCBkZXBlbmRpbmcgb24gdGhlIGNpcmN1bXN0YW5jZXMpLCBidXQg
bXkgcGF0Y2gKd2lsbCBleHBvc2UgdGhlIHByb2JsZW0uwqAgWW91IGNhbiBjb25maXJtIGJ5IHJl
dmVydGluZyBteSBkbWFwb29sCnBhdGNoZXMgYW5kIGVuYWJsaW5nIERNQVBPT0xfREVCVUcsIHdo
aWNoIGlzIGF0IHRoZSB0b3Agb2YgbW0vZG1hcG9vbC5jOgoKI2lmIGRlZmluZWQoQ09ORklHX0RF
QlVHX1NMQUIpIHx8IGRlZmluZWQoQ09ORklHX1NMVUJfREVCVUdfT04pCiNkZWZpbmUgRE1BUE9P
TF9ERUJVRyAxCiNlbmRpZgoKVG9ueSBCYXR0ZXJzYnkKCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
