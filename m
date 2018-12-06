Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A96CC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:33:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C97620661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ar0kzbIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C97620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=erjS9qrpVxCNY8/H57+ELmuLvGcrrXqs1xPRMG6arg0=; b=ar0kzbItkpfqdJ
	x9KNe9khyPx3AtvVGpx3AW9obxSrpF6p0CqJSD3NkVITMwSYV4YLazrnDkC0sEYVLHAfyM1WYPQJh
	tM9gyOLlmsaWQMRgZpjNH0zphrepmsYhOjFdFIP6C3KCWSgJ8BxdNckba+WlrEE9MJnrWVFDHNx5K
	wGDkN3euoc/8KWbYe3o2eRAijt47wj8izAm4fSpNGAY/napqlPBFU4GMUM0jqiFx0/y0xtnFz0DJN
	yTqaJNTjxjc3t4R+9BDIIX0vmDAK2B8+fWuQJodfMc8+YN6+bwKLB4Wq6lZhcdMlczwzizHAdnR1G
	6GqlX3iXd0Mj9je2cIFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwam-0003Aq-AV; Thu, 06 Dec 2018 16:33:36 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwag-0002zG-3m
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:33:34 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6EBC880F6;
 Thu,  6 Dec 2018 16:33:21 +0000 (UTC)
Date: Thu, 6 Dec 2018 08:33:15 -0800
From: Tony Lindgren <tony@atomide.com>
To: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: dmapool regression in next
Message-ID: <20181206163315.GL6707@atomide.com>
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
 <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
 <9187bbd9-3aaf-c1b3-16a3-4e1b3356c52e@cybernetics.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9187bbd9-3aaf-c1b3-16a3-4e1b3356c52e@cybernetics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_083330_194142_74CBCE4A 
X-CRM114-Status: GOOD (  22.00  )
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
 linux@armlinux.org.uk, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
 Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 linux-omap@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, hch@lst.de,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KiBUb255IEJhdHRlcnNieSA8dG9ueWJAY3liZXJuZXRpY3MuY29tPiBbMTgxMjA2IDE2OjEzXToK
PiBPbiAxMi82LzE4IDEwOjUxIEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gPj4gSGVyZSBpcyB0
aGUgcHJvdG90eXBlOgo+ID4+Cj4gPj4gdm9pZCBkbWFfcG9vbF9mcmVlKHN0cnVjdCBkbWFfcG9v
bCAqcG9vbCwgdm9pZCAqdmFkZHIsIGRtYV9hZGRyX3QgZG1hKTsKPiA+Pgo+ID4+IFdpdGggdGhl
IG9sZCBjb2RlLCB0aGUgJ2RtYScgdmFsdWUgaGFkIHRvIGJlIGNvcnJlY3QgZm9yIHVzZSB3aXRo
Cj4gPj4gcG9vbF9maW5kX3BhZ2UoKSwgb3IgZWxzZSB5b3Ugd291bGQgZ2V0IGFuIGVycm9yLsKg
IElmIHRoZSAndmFkZHInIHZhbHVlCj4gPj4gd2FzIGluY29ycmVjdCwgaXQgd291bGQgY29ycnVw
dCB0aGUgZG1hcG9vbCBmcmVlbGlzdCwgYnV0IHlvdSB3b3VsZG4ndAo+ID4+IGdldCBhbiBlcnJv
ciB1bmxlc3MgRE1BUE9PTF9ERUJVRyB3YXMgZW5hYmxlZC4KPiA+Pgo+ID4+IFdpdGggbXkgcGF0
Y2ggYXBwbGllZCwgJ3ZhZGRyJyBoYXMgdG8gYmUgY29ycmVjdCBmb3IgdmlydF90b19wYWdlKCku
wqAgTXkKPiA+PiBjb2RlIGFsc28gY2hlY2tzIHRoYXQgJ2RtYScgaXMgY29uc2lzdGVudCB3aXRo
ICd2YWRkcicgZXZlbiBpZgo+ID4+IERNQVBPT0xfREVCVUcgaXMgZGlzYWJsZWQsIHNpbmNlIHRo
ZSBjaGVjayBpcyBmYXN0IGFuZCBpdCB3aWxsIHByZXZlbnQKPiA+PiBwcm9ibGVtcyBsaWtlIHRo
aXMgaW4gdGhlIGZ1dHVyZS4KPiA+IFVuZm9ydHVuYXRlbHkgdGhhdCBsb2dpYyBoYXMgYSBmYXRh
bCBmbGF3IC0gRE1BIHBvb2xzIGFyZSBiYWNrZWQgYnkgCj4gPiBkbWFfYWxsb2NfY29oZXJlbnQo
KSwgYW5kIHRoZXJlIGlzIGFic29sdXRlbHkgbm8gZ3VhcmFudGVlIHRoYXQgdGhlIAo+ID4gbWVt
b3J5IGRtYV9hbGxvY19jb2hlcmVudCgpIHJldHVybnMgaXMgYmFja2VkIGJ5IGEgc3RydWN0IHBh
Z2UgYXQgYWxsLiAKPiA+IEV2ZW4gaWYgaXQgaXMsIHRoZXJlIGlzIHN0aWxsIGFic29sdXRlbHkg
bm8gZ3VhcmFudGVlIHRoYXQgdGhlIHZhZGRyIAo+ID4gdmFsdWUgaXQgcmV0dXJucyBpcyB2YWxp
ZCBmb3IgdmlydF90b19wYWdlKCkgLSBvbiBtYW55IHN5c3RlbXMgaXQgd2lsbCAKPiA+IGJlIGlu
IHZtYWxsb2Mgb3Igc29tZSBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgcmVnaW9uIG9mIGFkZHJlc3Mg
c3BhY2UuCj4gPgo+ID4gVGhlIHByb2JsZW0gaXMgbm90IHRoYXQgdGhlc2UgZHJpdmVycyBhcmUg
YnVnZ3kgKHRoZXkncmUgbm90IC0gdGhlIGFyY2ggCj4gPiBjb2RlIGlzIHJldHVybmluZyBhIHZt
YWxsb2MoKWVkIG5vbi1jYWNoZWFibGUgcmVtYXAgaW4gdGhlIGZpcnN0IHBsYWNlKSwgCj4gPiBp
dCdzIHRoYXQgMjZhYmU4OGU4MzBkIGlzIGZ1bmRhbWVudGFsbHkgdW53b3JrYWJsZSBhbmQgbmVl
ZHMgcmV2ZXJ0aW5nLiAKPiA+IEFwcGFyZW50bHkgdGhlIG9yaWdpbmFsIHBhdGNoZXMgbWFuYWdl
ZCBub3QgdG8gY2F0Y2ggbXkgZXllIGFzIHNvbWV0aGluZyAKPiA+IEkgbmVlZGVkIHRvIHJldmll
dywgc29ycnkgYWJvdXQgdGhhdCA6KAo+ID4KPiA+IFJvYmluLgo+ID4KPiBUaGFua3MgZm9yIHRo
ZSBpbmZvOyB0aGUgaW5uZXIgd29ya2luZ3Mgb2YgdGhlIHZtIHN5c3RlbSBhcmUgYSBiaXQgb3V0
Cj4gb2YgbXkgYXJlYSBvZiBleHBlcnRpc2UuwqAgTXkgZmlyc3QgdmVyc2lvbiBvZiB0aGUgcGF0
Y2ggc2VyaWVzIHVzZWQgYQo+IGRpZmZlcmVudCBtZXRob2QgdGhhdCBkaWRuJ3QgcmVseSBvbiB2
aXJ0X3RvX3BhZ2UoKTsgSSB3aWxsIGdvIGJhY2sgdG8KPiB0aGF0IHZlcnNpb24sIGNsZWFuIGl0
IHVwLCBhbmQgcmVzdWJtaXQgd2hlbiBJIGhhdmUgdGltZS4KPiAKPiBBbmRyZXcsIHBsZWFzZSBy
ZXZlcnQgYWxsIDkgcGF0Y2hlcy7CoCBJIHdpbGwgcmVzdWJtaXQgdGhlIHNldCB3aGVuIEkKPiBo
YXZlIGEgd29ya2FibGUgc29sdXRpb24uCgpPSyBzb3VuZHMgZ29vZCB0byBtZS4gSSBjYW4gdGVz
dCB0aGUgbmV3IHNldCBlYXNpbHkgd2hlbiBhdmFpbGFibGUKaWYgeW91IENjIG1lIG9uIHRoZW0u
CgpUaGFua3MsCgpUb255CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
