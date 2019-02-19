Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:14:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1DE2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O5d8kCTn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="tWIv7glE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1DE2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GBwdIJgqS+STFOSHFTLq0KYG9hVckT5/DJh8oRIvmPg=; b=O5d8kCTnSJFQofKzREvjNuH5O
	q/tMSMfaGiAXxw9Gy0YIfux7sxZjDIjlQnBaJ9Siv1Hpkv4RX7dEZysZZdd2IZBKSQwA7tfKS5+Y1
	4u+nes2xFlVay1ZWXIeETpmxRp4W/I71fMkBaed4CRfZ05ngTAJivRj5qYVevcbyUzCenw873B7QQ
	zvJT5WAmF/D9qicVpoyqVnrCAGhFNPIY7zvdIuGTiGc2Sg6mcJZFUxftCA7PAxyxehwwB7QAUTWXa
	13CLo+MWSAo38aXA+yth+zsvdbengN2GLz3o4PxnHX1gUbkZkE11VmL1Xz2mKWf5WJjbtz+jD5RY8
	BywP70Zsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBmo-0007Fs-8M; Tue, 19 Feb 2019 20:14:38 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBmj-0007EP-Pc
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:14:36 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id E5EA2604AE26
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 20:13:48 +0000 (GMT)
X-ASG-Debug-ID: 1550607228-0554131265309360001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id HWA94RBMXnaE63MG
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 19 Feb 2019 20:13:48 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9fXYvxo0DhZPtepx2i6qipI9PaMPVFKmPWPBtLWyciQ=; b=tWIv7glE5XcWMTISOOBi/4oAr8
 2PlJ/myp2AYTvNL41g3xjbJtFLObCQtH3L2bhsfIsTHVH7sL2eeCybq4eZpi8VnHnY+6VcurVxcmP
 32aQvW0bqgObepkpVmMbwYoOxiF2f4PqKMXH083NHdS6onpeKuszAmDn/TRj3VMjTjIPWjLo9mSi8
 jTOMBCuEjIu3JNxs5iHmide8uXT3j0iNnznKnC6oAYNVQgnygxasLiiUAUE1TGekqtpc6xgUsH42c
 bDQ6W5HixgO9s1VJSCDVjLSH1qCHc8ROJwJeA22SlVMOLE8uPnZUl6K9lrfGKIngkA6Y08DQ+GNf1
 gIpnMMFw==;
Received: from [87.114.170.31] (port=59192 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gwBlz-0009rR-CR; Tue, 19 Feb 2019 20:13:47 +0000
Subject: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard changes
To: Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de, robh+dt@kernel.org, 
 mark.rutland@arm.com
X-ASG-Orig-Subj: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard
 changes
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
 <e83b0404-bd32-a5d5-2e32-e0f49b122b95@arm.com>
 <2d8ac4e6-b825-dca7-d3cb-57cb32b3230b@davidjohnsummers.uk>
 <6a15343b-554b-6059-09af-f6511e740866@arm.com>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <7a5acd4a-71bc-0c94-2b9c-4c3a47a3446a@davidjohnsummers.uk>
Date: Tue, 19 Feb 2019 20:13:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6a15343b-554b-6059-09af-f6511e740866@arm.com>
Content-Language: en-PH
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud706.unlimitedwebhosting.co.uk
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - davidjohnsummers.uk
X-Get-Message-Sender-Via: cloud706.unlimitedwebhosting.co.uk: authenticated_id:
 davidjoh/from_h
X-Authenticated-Sender: cloud706.unlimitedwebhosting.co.uk: beagleboard@davidjohnsummers.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Barracuda-Connect: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Start-Time: 1550607228
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 4171
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67590
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_121434_232271_0B061AB5 
X-CRM114-Status: GOOD (  24.61  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMDIvMjAxOSAxMTo1NCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDE3LzAyLzIwMTkg
MTU6MTksIERhdmlkIFN1bW1lcnMgd3JvdGU6Cj4+IE9uIDE3LzAyLzIwMTkgMTQ6MDAsIFJvYmlu
IE11cnBoeSB3cm90ZToKPj4+IEhpIERhdmlkLAo+Pj4KPj4+IE9uIDIwMTktMDItMTcgMTI6MTUg
cG0sIERhdmlkIFN1bW1lcnMgd3JvdGU6Cj4+Pj4gVGhpcyBwYXRjaCBtYWtlcyBzb21lIG1pbm9y
IGNoYW5nZXMgdG8gaG93IHRoZSBzZCBjYXJkIGlzCj4+Pj4gZGVzY3JpYmVkIGluIHRoZSBkZXZp
Y2UgdHJlZSBmb3IgdGhlIEFTVVMgVGlua2VyIEJvYXJkIChTKS4gSW4KPj4+PiBwYXJ0aWN1bGFy
IG9uIHRoZSBUaW5rZXIgQm9hcmQgUywgd2hlbiBib290ZWQgZnJvbSB0aGUgZU1NQywgYW5kIHdp
dGgKPj4+PiBubyBjYXJkIGluIHRoZSBzZCBzbG90LCBhbmQgdGhlIGxvZyBoYXMgZW5kbGVzcyBt
ZXNzYWdlcyBhYm91dCBub3QKPj4+PiBiZWluZyBhYmxlIHRvIGRldGVjdCB0aGUgY2FyZC4KPj4+
Pgo+Pj4+IFNldmVyYWwgbWV0aG9kcyB0byByZW1vdmUgdGhpcyBlcnJvciBoYXZlIGJlZW4gdHJp
ZWQsIHRoZSBvbmx5IG9uZQo+Pj4+IHRoYXQgd29ya3MgaXMgdGhlIGJyb2tlbi1jZCBhbmQgc28g
dGhhdCBpcyB3aGF0IGlzIGFwcGxpZWQgaGVyZS4KPj4+Cj4+PiBJIGRvbid0IGhhdmUgYSBUaW5r
ZXIgQm9hcmQsIGJ1dCB0aGUgc3ltcHRvbSBzb3VuZHMgaW5zdGFudGx5IAo+Pj4gZmFtaWxpYXIg
ZnJvbSBoYWNraW5nIG9uIGFub3RoZXIgUkszMjg4IGJveDsgaGF2ZSB5b3UgdHJpZWQgYWRkaW5n
IAo+Pj4gInJlZ3VsYXRvci1hbHdheXMtb24iIHRvIHRoZSB2Y2Npb19zZCByZWd1bGF0b3I/Cj4+
Pgo+Pj4gV2l0aCB0aGUgcmVmZXJlbmNlIGRlc2lnbiAod2hpY2ggSSB3b3VsZCBhc3N1bWUgdGhl
IFRpbmtlciBCb2FyZCBoYXMgCj4+PiBubyByZWFzb24gdG8gZGV2aWF0ZSBmcm9tIGluIHRoaXMg
YXJlYSksIHRoZSBDRCBwaW4gaXMgZWl0aGVyIHdpcmVkIAo+Pj4gZGlyZWN0bHkgdG8gdGhlIFNv
QyB3aXRoIG5vIGV4dGVybmFsIHB1bGwtdXAsIG9yIGV4cGxpY2l0bHkgcHVsbGVkIAo+Pj4gdXAg
dG8gVkNDSU9fU0QuIEVpdGhlciB3YXksIHdoZW4gdGhlIGR3bW1jIGRyaXZlciBwcm9iZXMgYW5k
IAo+Pj4gZGlzY292ZXJzIHRoZXJlIGlzIG5vIGNhcmQgcHJlc2VudCwgaXQgc2V0cyB0aGUgCj4+
PiBjdXJyZW50bHktdW5uZWNlc3NhcnkgdnFtbWMtc3VwcGx5IGFzIGluYWN0aXZlLCBhbmQgdGh1
cyB0aGUgCj4+PiByZWd1bGF0b3IgY29yZSB0dXJucyBvZmYgVkNDSU9fU0QgZW50aXJlbHkuIFVu
Zm9ydHVuYXRlbHksIHRoaXMgCj4+PiByZW1vdmVzIHRoZSB2b2x0YWdlIGZyb20gdGhlIGVudGly
ZSBJL08gZG9tYWluIGluY2x1ZGluZyB0aGUgCj4+PiBpbnRlcm5hbCBwdWxsLXVwLCB3aGljaCBl
bmRzIHVwIGxlYXZpbmcgdGhlIENEIHBpbiBmbG9hdGluZyBhbmQgCj4+PiBnZW5lcmF0aW5nIHNw
dXJpb3VzIGV2ZW50cy4KPj4+Cj4+PiBSb2Jpbi4KPj4KPj4gSGkgUm9iaW4sCj4+Cj4+IEFuIGlu
dGVyZXN0aW5nIHN1Z2dlc3Rpb24gLSBubyBpdCBoYXNuJ3QgYmVlbiB0cmllZCB0byBhbHdheXMg
c2V0IHRoZSAKPj4gdmNjaW9fc2QgcmVndWxhdG9yIG9uLiBXaWxsIGdpdmUgaXQgYSBnbyBvbiBB
cmNoTGludXggQXJtLgo+Pgo+PiBJIGd1ZXNzIHRoaXMgd291bGQgZXhwbGFpbiB3aHkgdGhlIFRp
bmtlciBCb2FyZCBib290aW5nIGZyb20gc2QgCj4+IGRvZXNuJ3Qgc2VlIHRoZSBlcnJvciwgYXMg
aXRzIGVuYWJsZWQgcHJvYmFibHkgaW4gdWJvb3QgYW5kIHRoZW4gCj4+IGtlZXBzIHdvcmtpbmcu
Cj4+Cj4+IElJUkMgdGhvdWdoLCBpZiBib290aW5nIHRoZSBUQlMgZnJvbSBlTU1DLCB0aGVuIGlu
c2VydGluZyBhbiBzZCBjYXJkIAo+PiBhbmQgdGhlIGVycm9ycyBzdG9wLiBJIGd1ZXNzIHRoaXMg
d291bGRuJ3QgaGFwcGVuIGlmIHRoZSBwb3dlciB3YXNuJ3QgCj4+IGFwcGxpZWQ/Cj4KPiBUaGF0
J3MgdGhlIGZ1biBwYXJ0IG9mIHRoaXMgc2NlbmFyaW8gLSB0aGUgcHJlc2VuY2Ugb2YgYSBjYXJk
IGlzIAo+IHVuYW1iaWd1b3VzLCBpdCdzIG9ubHkgdGhlIGFic2VuY2Ugb2Ygb25lIHdoaWNoIGRl
cGVuZHMgb24gdGhlIHB1bGwtdXAgCj4gc3RhdGUsIHNvIHdoZW5ldmVyIGFzIGEgY2FyZCBpcyBp
bnNlcnRlZCBldmVyeXRoaW5nIGRvZXMgd29yayAKPiBjb3JyZWN0bHkuIMKgQXNzdW1pbmcgdGhl
eSBhcmUgdGhlIHNhbWUgZXJyb3JzIEkgd2FzIHNlZWluZywgdGhleSdyZSAKPiBmcm9tIHRoZSBk
cml2ZXIgKnRoaW5raW5nKiBhIGNhcmQgaXMgaW5zZXJ0ZWQgZHVlIHRvIENEIGZsb2F0aW5nIGxv
dywgCj4gdGhlbiBmYWlsaW5nIHRvIGNvbW11bmljYXRlIHdpdGggaXQsIGFmdGVyIHdoaWNoIGl0
IHBvd2VycyBkb3duIHRoZSAKPiBJL08gaW50ZXJmYWNlIGFnYWluIGFuZCB0aGUgd2hvbGUgY3lj
bGUgYmVnaW5zIGFuZXcuCj4KPj4gSSBndWVzcyBhbHNvIHRoYXQgInJlZ3VsYXRvci1hbHdheXMt
b24iIGlzIGEgcXVpY2sgdGVzdCAtIGJ1dCB0aGF0IAo+PiBmb3Igc3VibWlzc2lvbiB0byBrZXJu
ZWwgaXQgd291bGQgYmUgYmV0dGVyIGRvbmUgdmlhIAo+PiAibW1jLXB3cnNlcS1zaW1wbGUiPwo+
Cj4gTm8sIGl0J3MgYSB2YWxpZCBkZXNjcmlwdGlvbiBvZiB0aGUgaGFyZHdhcmUgdG8gc2F5ICJk
aXNhYmxpbmcgdGhpcyAKPiByZWd1bGF0b3IgbWFrZXMgc29tZXRoaW5nIGZhaWwgdG8gd29yayBh
cyBleHBlY3RlZCIgaWYgdGhhdCBpcyB0cnVseSAKPiB0aGUgY2FzZS4gQmVzaWRlcywgcHdyc2Vx
IGlzIGFib3V0IGhvdyB0byBpbml0aWFsaXNlIGEgZGV0ZWN0ZWQgCj4gcHJlc2VudCBjYXJkLCBu
b3QgaG93IHRvIGNvcnJlY3RseSBkZXRlY3QgdGhhdCBwcmVzZW5jZSBpbiB0aGUgZmlyc3QgCj4g
cGxhY2UuCj4KPj4gQW55d2F5IEkgc2V0IHVwIGEgdGVzdCAtIHNvIHdlIGNhbiBjb25maXJtIHRo
aXMuCj4KPiBHcmVhdCAtIHRoZXJlIGlzIG9mIGNvdXJzZSBzdGlsbCB0aGUgcG9zc2liaWxpdHkg
dGhhdCB0aGUgcGluIHJlYWxseSAKPiBpc24ndCB3aXJlZCB1cCBhdCBhbGwsIGluIHdoaWNoIGNh
c2UgaWdub3JpbmcgQ0QgYW5kIHRha2luZyB0aGUgQ1BVIAo+IG92ZXJoZWFkIG9mIHBvbGxpbmcg
d291bGQgYmUgdGhlIG9ubHkgb3B0aW9uLCBidXQgdGhlIHZlbmRvciBEVCAKPiBkb2Vzbid0IGhh
dmUgYW55IHNpZ25zIHRvIHN1Z2dlc3QgdGhhdCdzIHRoZSBjYXNlLCBhbmQgbWFrZXMgbWUgbGVh
biAKPiBtb3JlIHRvd2FyZHMgdGhlIHB1bGwtdXAgaXNzdWUuCj4KPiBSb2Jpbi4KClJvYmluLAoK
SGVhcmQgYmFjayBmcm9tIHRoZSB1c2VyIG9uIEFyY2hMaW51eCBBcm0gd2hvIGhhcyBhIHRpbmtl
ciBCb2FyZCBTLCBoZSAKdGVzdGVkIHlvdXIgc29sdXRpb24sIGFuZCBpdCB3b3JrZWQuCgpFeGNl
bGxlbnQsIGFzIGl0IG1lYW5zIHRoZSBDUFUgd29uJ3QgaGF2ZSB0byBwb2xsIHRoZSBjYXJkIQoK
SSdsbCBwcm9iYWJseSBhZGQgYm90aCAicmVndWxhdG9yLWFsd2F5cy1vbjsiIGFuZCAicmVndWxh
dG9yLWJvb3Qtb247IiwgCmFzIHJlYWRpbmcgdGhlIHJlZ3VsYXRvciBkb2N1bWVudGF0aW9uLCBh
bmQgdGhlIFRpbmtlciBCb2FyZCBib290cyBmcm9tIApzZCBjYXJkLCBhbmQgdGhlIFRpbmtlckJv
YXJkIFMgaGFzIHRoZSBvcHRpb24gb2YgYm9vdGluZyBmcm9tIHRoZSBzZCAKY2FyZCAtIHdlIGNh
biBiZSBmYWlybHkgc3VyZSB0aGF0IHVib290IGhhcyBhbHJlYWR5IGVuYWJsZWQgdGhlIHBvd2Vy
IApzdXBwbHkuCgpTbyBiZXN0IHRvIHdpdGhkcmF3IHRoaXMgcGF0Y2guIEknbGwgZG8gYSBmcmVz
aCBvbmUsIHdoZW4gSSBnZXQgdGltZSAtIApwcm9iYWJseSB0aGUgd2Vla2VuZCAuLi4KClRoYW5r
cyBmb3IgdGhlIGhlbHAsIEkgc2hvdWxkIGhhdmUgdGhvdWdoIG9mIGxvb2tpbmcgYmV5b25kIHNk
bW1jIHBhcnQgCm9mIGRldmljZSB0cmVlLiBTbyB3ZSBhcmUgZ3JhdGVmdWwgdGhhdCB5b3UgcmVt
ZW1iZXJlZCB5b3VyIHNvbHV0aW9uIAp3aGVuIHlvdSBoYWQgdGhlIHByb2JsZW0gb24gYW5vdGhl
ciBib2FyZC4KClJlZ2FyZHMsCgpEYXZpZAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
