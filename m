Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9839C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:13:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A28A20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RXBc5TB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A28A20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybernetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aH2lFGpNP8Ao/+fqQIa+ooJi6KFeMU7HcWFabn0uvAc=; b=RXBc5TB7Wb/WE0
	vkjrs1NSxAxjO5fjFpI7ji7lr15+7J/XcfX1EwkMmmgWRJAQcKbN2AEaPQO39PparBwCtQh7dqeow
	kNbmBsrQBc8YTJlw4k0pI1+eyvDIDL0Zn76BqVFM162566XG35O/AME+P59H6hkxXc85SjQisdc9C
	ol/FP8KfXTwBv39wY9THeBd4+EuvRD8nt89bV0G57GOnKI6MCVwVFycHYCue+sDATNYNQBxjvWLDU
	RGQm/8/WOvql9lQ2KhWESPWSQckV8nMkPiOP50/H20zQ3LqmnkxYtoACNhwvVgkb/Q5hypC6sOg5c
	rV+lsAz4JYzAdGTnVscw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwHM-00021O-Uk; Thu, 06 Dec 2018 16:13:32 +0000
Received: from mail.cybernetics.com ([173.71.130.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwHJ-00020z-Gi
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:13:30 +0000
X-ASG-Debug-ID: 1544112796-0fb3b01fb3c5b3f0001-tbGyMd
Received: from cybernetics.com ([10.157.1.126]) by mail.cybernetics.com with
 ESMTP id PGcOwVDYVPrI9Vwo (version=SSLv3 cipher=DES-CBC3-SHA bits=112
 verify=NO); Thu, 06 Dec 2018 11:13:16 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
 with ESMTPSA id 8570034; Thu, 06 Dec 2018 11:13:16 -0500
Subject: Re: dmapool regression in next
To: Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, tony@atomide.com, akpm@linux-foundation.org
X-ASG-Orig-Subj: Re: dmapool regression in next
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
 <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
From: Tony Battersby <tonyb@cybernetics.com>
Message-ID: <9187bbd9-3aaf-c1b3-16a3-4e1b3356c52e@cybernetics.com>
Date: Thu, 6 Dec 2018 11:13:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.157.1.126]
X-Barracuda-Start-Time: 1544112796
X-Barracuda-Encrypted: DES-CBC3-SHA
X-Barracuda-URL: https://10.157.1.122:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1890
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-BRTS-Status: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_081329_629994_576D4F31 
X-CRM114-Status: GOOD (  14.36  )
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
 linux@armlinux.org.uk, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
 linux-omap@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvNi8xOCAxMDo1MSBBTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBIZXJlIGlzIHRoZSBw
cm90b3R5cGU6Cj4+Cj4+IHZvaWQgZG1hX3Bvb2xfZnJlZShzdHJ1Y3QgZG1hX3Bvb2wgKnBvb2ws
IHZvaWQgKnZhZGRyLCBkbWFfYWRkcl90IGRtYSk7Cj4+Cj4+IFdpdGggdGhlIG9sZCBjb2RlLCB0
aGUgJ2RtYScgdmFsdWUgaGFkIHRvIGJlIGNvcnJlY3QgZm9yIHVzZSB3aXRoCj4+IHBvb2xfZmlu
ZF9wYWdlKCksIG9yIGVsc2UgeW91IHdvdWxkIGdldCBhbiBlcnJvci7CoCBJZiB0aGUgJ3ZhZGRy
JyB2YWx1ZQo+PiB3YXMgaW5jb3JyZWN0LCBpdCB3b3VsZCBjb3JydXB0IHRoZSBkbWFwb29sIGZy
ZWVsaXN0LCBidXQgeW91IHdvdWxkbid0Cj4+IGdldCBhbiBlcnJvciB1bmxlc3MgRE1BUE9PTF9E
RUJVRyB3YXMgZW5hYmxlZC4KPj4KPj4gV2l0aCBteSBwYXRjaCBhcHBsaWVkLCAndmFkZHInIGhh
cyB0byBiZSBjb3JyZWN0IGZvciB2aXJ0X3RvX3BhZ2UoKS7CoCBNeQo+PiBjb2RlIGFsc28gY2hl
Y2tzIHRoYXQgJ2RtYScgaXMgY29uc2lzdGVudCB3aXRoICd2YWRkcicgZXZlbiBpZgo+PiBETUFQ
T09MX0RFQlVHIGlzIGRpc2FibGVkLCBzaW5jZSB0aGUgY2hlY2sgaXMgZmFzdCBhbmQgaXQgd2ls
bCBwcmV2ZW50Cj4+IHByb2JsZW1zIGxpa2UgdGhpcyBpbiB0aGUgZnV0dXJlLgo+IFVuZm9ydHVu
YXRlbHkgdGhhdCBsb2dpYyBoYXMgYSBmYXRhbCBmbGF3IC0gRE1BIHBvb2xzIGFyZSBiYWNrZWQg
YnkgCj4gZG1hX2FsbG9jX2NvaGVyZW50KCksIGFuZCB0aGVyZSBpcyBhYnNvbHV0ZWx5IG5vIGd1
YXJhbnRlZSB0aGF0IHRoZSAKPiBtZW1vcnkgZG1hX2FsbG9jX2NvaGVyZW50KCkgcmV0dXJucyBp
cyBiYWNrZWQgYnkgYSBzdHJ1Y3QgcGFnZSBhdCBhbGwuIAo+IEV2ZW4gaWYgaXQgaXMsIHRoZXJl
IGlzIHN0aWxsIGFic29sdXRlbHkgbm8gZ3VhcmFudGVlIHRoYXQgdGhlIHZhZGRyIAo+IHZhbHVl
IGl0IHJldHVybnMgaXMgdmFsaWQgZm9yIHZpcnRfdG9fcGFnZSgpIC0gb24gbWFueSBzeXN0ZW1z
IGl0IHdpbGwgCj4gYmUgaW4gdm1hbGxvYyBvciBzb21lIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBy
ZWdpb24gb2YgYWRkcmVzcyBzcGFjZS4KPgo+IFRoZSBwcm9ibGVtIGlzIG5vdCB0aGF0IHRoZXNl
IGRyaXZlcnMgYXJlIGJ1Z2d5ICh0aGV5J3JlIG5vdCAtIHRoZSBhcmNoIAo+IGNvZGUgaXMgcmV0
dXJuaW5nIGEgdm1hbGxvYygpZWQgbm9uLWNhY2hlYWJsZSByZW1hcCBpbiB0aGUgZmlyc3QgcGxh
Y2UpLCAKPiBpdCdzIHRoYXQgMjZhYmU4OGU4MzBkIGlzIGZ1bmRhbWVudGFsbHkgdW53b3JrYWJs
ZSBhbmQgbmVlZHMgcmV2ZXJ0aW5nLiAKPiBBcHBhcmVudGx5IHRoZSBvcmlnaW5hbCBwYXRjaGVz
IG1hbmFnZWQgbm90IHRvIGNhdGNoIG15IGV5ZSBhcyBzb21ldGhpbmcgCj4gSSBuZWVkZWQgdG8g
cmV2aWV3LCBzb3JyeSBhYm91dCB0aGF0IDooCj4KPiBSb2Jpbi4KPgpUaGFua3MgZm9yIHRoZSBp
bmZvOyB0aGUgaW5uZXIgd29ya2luZ3Mgb2YgdGhlIHZtIHN5c3RlbSBhcmUgYSBiaXQgb3V0Cm9m
IG15IGFyZWEgb2YgZXhwZXJ0aXNlLsKgIE15IGZpcnN0IHZlcnNpb24gb2YgdGhlIHBhdGNoIHNl
cmllcyB1c2VkIGEKZGlmZmVyZW50IG1ldGhvZCB0aGF0IGRpZG4ndCByZWx5IG9uIHZpcnRfdG9f
cGFnZSgpOyBJIHdpbGwgZ28gYmFjayB0bwp0aGF0IHZlcnNpb24sIGNsZWFuIGl0IHVwLCBhbmQg
cmVzdWJtaXQgd2hlbiBJIGhhdmUgdGltZS4KCkFuZHJldywgcGxlYXNlIHJldmVydCBhbGwgOSBw
YXRjaGVzLsKgIEkgd2lsbCByZXN1Ym1pdCB0aGUgc2V0IHdoZW4gSQpoYXZlIGEgd29ya2FibGUg
c29sdXRpb24uCgpUb255IEJhdHRlcnNieQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
