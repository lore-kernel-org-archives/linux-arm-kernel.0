Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA84C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:49:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C320218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hg2CoUIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C320218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6aHfp7UYLx6blNZ0UI0aLB1VbkZ9xQ/ez0nW/3LwjZY=; b=Hg2CoUIfpjA8kT
	+TpuU+O5CzxRq/4g1wT/XHe0/qdyaABB4+rqh7cg6+h8lqd/tsMg5OSM+PU1V9ywn4Dr6eWV3VIb8
	Ssnbmtz8Ee3J/6qWCY2t/5j8pNVjsxdDT4XPbz63vfu1X9DvWtYhfQsYOe6UC3Scy+uFvdwPWwF1L
	NzNcdOQ+NZcFo6YMvnRDKTModKffhnyMjW1u6a14HgjmJ4SZjitxA+N421qE2XzxfhEZ6mtCyTKh0
	VHuPu1DUKcvuiRtc4L7jzzsQHM9N2Nr6h6aFkkYCSGuAbcWPv/2zHuF69qPTVynngINel93uV9yKq
	U9aDz7jcA8h9RSQ/edPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKQp-00078g-2l; Tue, 18 Dec 2018 18:49:27 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKQl-00076z-OM; Tue, 18 Dec 2018 18:49:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8D859B0FB;
 Tue, 18 Dec 2018 18:49:07 +0000 (UTC)
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Jiri Pirko <jiri@resnulli.us>,
 Ben Whitten <ben.whitten@lairdtech.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
Date: Tue, 18 Dec 2018 19:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_104924_099966_E961912B 
X-CRM114-Status: GOOD (  17.77  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
 linux-lpwan@lists.infradead.org, Dollar Chen <dollar.chen@wtmec.com>,
 Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gMTguMTIuMTggdW0gMTU6Mjcgc2NocmllYiBKaWFuLUhvbmcgUGFuOgo+PiBTdW4sIERlYyAx
NiwgMjAxOCBhdCAxMToxODo1OUFNIENFVCwgc3Rhcm5pZ2h0QGcubmN1LmVkdS50dyB3cm90ZToK
Pj4+IExvUmFXQU4gZGVmaW5lZCBieSBMb1JhIEFsbGlhbmNlKFRNKSBpcyB0aGUgTUFDIGxheWVy
IG92ZXIgTG9SYSBkZXZpY2VzLgo+Pj4KPj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBwYXJ0IG9m
IENsYXNzIEEgZW5kLWRldmljZXMgU29mdE1BQyBkZWZpbmVkIGluCj4+PiBMb1JhV0FOKFRNKSBT
cGVjaWZpY2F0aW9uIFZlci4gMS4wLjI6Cj4+PiAxLiBFbmQtZGV2aWNlIHJlY2VpdmUgc2xvdCB0
aW1pbmcKPj4+IDIuIE9ubHkgc2luZ2xlIGNoYW5uZWwgYW5kIHNpbmdsZSBkYXRhIHJhdGUgZm9y
IG5vdwo+Pj4gMy4gVW5jb25maXJtZWQgZGF0YSB1cC9kb3duIG1lc3NhZ2UgdHlwZXMKPj4+Cj4+
PiBPbiB0aGUgb3RoZXIgc2lkZSwgaXQgZGVmaW5lcyB0aGUgYmFzaWMgaW50ZXJmYWNlIGFuZCBv
cGVyYXRpb24KPj4+IGZ1bmN0aW9ucyBmb3IgY29tcGF0aWJsZSBMb1JhIGRldmljZSBkcml2ZXJz
Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEppYW4tSG9uZyBQYW4gPHN0YXJuaWdodEBnLm5jdS5l
ZHUudHc+ClsuLi5dCj4+PiBuZXQvbWFjbG9yYXdhbi9LY29uZmlnICB8ICAxNCArCj4+PiBuZXQv
bWFjbG9yYXdhbi9NYWtlZmlsZSB8ICAgMiArCj4+PiBuZXQvbWFjbG9yYXdhbi9tYWMuYyAgICB8
IDU1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+IG5ldC9tYWNsb3Jh
d2FuL21haW4uYyAgIHwgNjA2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPj4+IDQgZmlsZXMgY2hhbmdlZCwgMTE3NyBpbnNlcnRpb25zKCspCj4+PiBjcmVhdGUgbW9k
ZSAxMDA2NDQgbmV0L21hY2xvcmF3YW4vS2NvbmZpZwo+Pj4gY3JlYXRlIG1vZGUgMTAwNjQ0IG5l
dC9tYWNsb3Jhd2FuL01ha2VmaWxlCj4+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbmV0L21hY2xvcmF3
YW4vbWFjLmMKPj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBuZXQvbWFjbG9yYXdhbi9tYWluLmMKPj4K
Pj4gSSBkb24ndCBnZXQgaXQuIEluIHBhdGNoICJBZGQgTG9SYVdBTiBBUEkgZGVjbGFyYXRpb24g
Zm9yIExvUmEgZGV2aWNlcyIKPj4geW91IGFkZCBoZWFkZXJzIGZvciAiQVBJIiBhbmQgaGVyZSB5
b3UgaW1wbGVtZW50IGZ1bmN0aW9ucy4gVGhhdCBpcyBqdXN0Cj4+IHdlaXJkLiBEb2VzIGl0IG1l
YW4geW91IGNhbiBoYXZlIG90aGVyIGltcGxlbWVudGF0aW9ucz8KPiAKPiBMb1JhV0FOIGRlZmlu
ZWQgYnkgTG9SYSBBbGxpYW5jZShUTSkgaXMgdGhlIE1BQyBsYXllciBvdmVyIExvUmEgUEhZLgo+
IFRoaXMgcGFydCBpcyBzb2Z0LU1BQyBhcyBBbmRyZWFzIG1lbnRpb25lZAo+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1scHdhbi8yMDE4LURlY2VtYmVyLzAwMDAx
MC5odG1sCj4gCj4+IEFsc28sIHlvdSBkb24ndCByZWFsbHkgaGF2ZSBhbnkgdXNlciBvZiB0aGlz
IEFQSSBpbiB0aGUgc2V0LiBQbGVhc2UKPj4gaW50cm9kdWNlIGF0IGxlYXN0IDEgZHJpdmVyLCBw
cmVmZXJhYmx5IG1vcmUgKEkgc2VlIHRoYXQgQW5kcmVhcyBoYXMKPj4gbXVsdGlwbGUgb25lcyBp
biBoaXMgcGF0Y2hzZXQpLiBZb3UgY2Fubm90IHB1c2gga2VybmVsIGluZnJhc3RydWN0dXJlCj4+
IHdpdGhvdXQga2VybmVsIHVzZXIuCj4gCj4gVGhlIHNvZnQtTUFDIGlzIHN1aXRhYmxlIGZvciB0
aGUgTG9SYSBjaGlwcycgZGV2aWNlIGRyaXZlcnMsIGxpa2UKPiBzeDEyNzYvNzcvNzgvNzksIFJG
TTk1Lzk2Lzk3Lzk4VyAuLi4KPiBTdGlsbCB3YWl0aW5nIGZvciBBbmRyZWFzJyBzeDEyNzYgdmVy
c2lvbiAyIHBhdGNoIGFuZCBtb3JlIGRpc2N1c3Npb24uCgpzeDEyNzYgcmVnbWFwIGNvbnZlcnNp
b24gd2FzIHB1c2hlZCB0byBteSBzdGFnaW5nIHRyZWUgdG9nZXRoZXIgd2l0aApCZW4ncyBzeDEz
MDEgZmluYWwgY29udmVyc2lvbiBsYXN0IG5pZ2h0LCBsaWdodGx5IHRlc3RlZC4KCmh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FmYWVyYmVyL2xpbnV4LWxv
cmEuZ2l0L2xvZy8/aD1sb3JhLW5leHQKClRCRDogcmVuYW1lIHRvIHN4MTI3eCwgaW1wbGVtZW50
IHJlZ21hcCBmaWVsZHMsIG9ubHkgYXV0by1kZXRlY3QgcmVzZXQKd2hlbiBubyBPRiBub2RlIGF2
YWlsYWJsZSAoYWxsIGxvdyBwcmlvcml0eSBhdG0sIHBhdGNoZXMgd2VsY29tZSkKCihhbmQgZm9y
IHN4MTMwMSBJIHN0aWxsIG5lZWQgdG8gdXBkYXRlIG15IERUIG92ZXJsYXlzIHdpdGggdGhlIG5l
dyBjbGspCgo+IEZvciBleGFtcGxlLCBob3cgdG8gbWFrZSBQRl9MT1JBIGFuZCBQRl9MT1JBV0FO
IGxpa2UgRXRoZXJuZXQsIFBGX0lORVQKPiBhbmQgUEZfSU5FVDYgZG9uJ3QgbmVlZCBzZXBhcmF0
ZSBkZXZpY2VzIGVpdGhlciwgYm90aCB1c2UgZXRoMC4KPiBodHRwczovL2xrbWwub3JnL2xrbWwv
MjAxOC84LzMvMjY2CgpKaXJpLCBJIGFtIGV4cGVjdGluZyB0aGUgbWFjbG9yYXdhbiBkcml2ZXIg
dG8gbG93ZXIgcGFja2V0cyBmcm9tCkVUSF9QX0xPUkFXQU4gdG8gRVRIX1BfTE9SQSBpbiBhIGdl
bmVyaWMgd2F5LCBzbyB0aGF0IGFueSBvZiB0aGUgTG9SYQpkZXZpY2UgZHJpdmVycyBjYW4gYmVu
ZWZpdCBvZiBpdCwgd2l0aCBtYWNsb3Jhd2FuIHVzaW5nIHRoZSBMb1JhIG5ldGxpbmsKY29tbWFu
ZHMgdGhhdCB0aGUgaW5kaXZpZHVhbCBkcml2ZXJzIGltcGxlbWVudC4KTm90IHN1cmUgd2hhdCBp
ZiBhbnl0aGluZyBpcyBtaXNzaW5nIGZvciB0aGF0IGluIHRoZSBjdXJyZW50IHJldmlzaW9uPwpT
dGlsbCBkZWFsaW5nIHdpdGggdGhlIGxvd2VyLWxldmVsIGluZnJhc3RydWN0dXJlIGFuZCBteSB0
ZXN0IHNldHVwIC4uLgpwcm9ncmVzc2luZyBzbG93bHkuCgpJJ2xsIHByb2JhYmx5IG5lZWQgdG8g
cXVldWUgdGhlIHJlbWFpbmluZyBnZW5lcmljIExvUmFXQU4gcGFydCAxLzYgaW4gbXkKdHJlZSB0
byByZXNvbHZlIHRoaXMgY2lyY3VsYXIgZGVwZW5kZW5jeSBiZXR3ZWVuIEppYW4tSG9uZyBhbmQg
bWUsIHNvCnRoYXQgb25seSB0aGUgc29mdC1NQUMgaW1wbGVtZW50YXRpb24gcmVtYWlucyBhIHNl
cGFyYXRlIHBhdGNoIHNlcmllcy4KVGhlIGhhcmQtTUFDIGltcGxlbWVudGF0aW9ucyB3aWxsIGJl
IG9uIG15IHBsYXRlIG1vc3RseSwgYXMgYm90aCBTWDEyNzYKYW5kIFNYMTMwMSBuZWVkIHRoZSBz
b2Z0LU1BQy4KClJlZ2FyZHMsCkFuZHJlYXMKCi0tIApTVVNFIExpbnV4IEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQpHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBK
YW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uCkhSQiAyMTI4NCAoQUcgTsO8cm5iZXJnKQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
