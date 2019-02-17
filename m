Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:55:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD1F218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YAxMvV0H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="xSibKyKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD1F218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YpTI/r3Zx7Ol6X5TV5Umgqiq/Ruc466UHvmk5nu/dbs=; b=YAxMvV0H4D/AxTP1l9+ZpWEhV
	nsdh8p9xwohxOJ5qv9/rUIkE7ABIPBgAYkYwS2Eze5smhLwujoOhFS/3mJLuyKJ0M0QcH44ysGvYn
	E1luQCWbSlWAL+YmMjRBO9Jos/yir9R2FAhy9mcOIQCLVa0//qnybmwDIn/ldzEPSsVBYsiqHff+G
	6u4UfsGNhUsFLYe2ySmL8RBani9HJyckkSbOJtB8iNFUbGy3wu3pgUPCCDYwH+rOPQn7uOvYuhDK2
	aGdJsOh1/Jzb2MvUZ0ajgAKA22Tq/UXV9gM6gclDauZwl3i7QoCTGthgJVazgIYSUsr5F7vbrGG8E
	DLsGhzwzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvOmd-0002A7-KO; Sun, 17 Feb 2019 15:55:11 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvOma-0001un-He
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 15:55:10 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id 3F5B66014D5F
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 15:55:07 +0000 (GMT)
X-ASG-Debug-ID: 1550418906-0554131266151480001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id PIwinUq57PX61EzX
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 17 Feb 2019 15:55:06 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZB0O4OfQc4NkD8/jBZ1Bp8svsUZsjI6TeN21wm7ohYg=; b=xSibKyKwPF2XgNNZ9vf9bghwpP
 SvZEUGKLg3iUuLMF0KAfs0eK/XPCE+2x4PXUkZAU1hxM5ENHoPXy/DJzEqlRTzH0z21ml6/pyjwsQ
 tVZGjRsU6G2Igin8fu4Jcmj6T3IRuH/A5+6WHioMDmAS0VHJ19oy2DDqW8Hvw1QOpUdCM9M7FEbkz
 W3nsXiEpXMHpiAe0x/YUvJhwMfXocju7+YZaYsnvlfUb0pzAd3mGQuXRdlpjqY/pEy+5WqZ9F/Kjt
 uC+FiEbBpesaKENklMth/UCoVI9oX6xeVNKCqRk5MhFFecBsvic8h9+aXQEEfftnE7TEOPCQOUOKM
 soF5hAUQ==;
Received: from [87.114.170.31] (port=56872 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gvOmX-000OiI-HC; Sun, 17 Feb 2019 15:55:05 +0000
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
To: Tony McKahan <tonymckahan@gmail.com>,
 David Summers <beagleboard@davidjohnsummers.uk>
X-ASG-Orig-Subj: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
 <CAERgokmpHQb2czJdx++qFoogFRmkvXZm=4BNOsVuCz-ZvgTEaw@mail.gmail.com>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <4ef63671-f58d-3b16-9055-09e69314a0e6@davidjohnsummers.uk>
Date: Sun, 17 Feb 2019 15:55:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAERgokmpHQb2czJdx++qFoogFRmkvXZm=4BNOsVuCz-ZvgTEaw@mail.gmail.com>
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
X-Barracuda-Start-Time: 1550418906
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 1392
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67485
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_075509_030983_FDAC9386 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: mark.rutland@arm.com, Stefan Wahren <stefan.wahren@i2se.com>,
 =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTcvMDIvMjAxOSAxNDozMiwgVG9ueSBNY0thaGFuIHdyb3RlOgo+IEEgc2ltaWxhciBjb25m
aWd1cmF0aW9uIGhhcyBiZWVuIGluIHVzZSBvbiBBcm1iaWFuIGltYWdlcyBzaW5jZSBrZXJuZWwK
PiA0LjE0LCBidXQgbm90IGluIGEgY2xlYW4gZW5vdWdoIGZvcm1hdCBmb3Igc3VibWlzc2lvbi4g
SSB3aWxsIHRlc3QKPiB0aGlzLCBidXQgdGhlIG9ubHkgZGlmZmVyZW5jZXMgSSBzZWUgY29tcGFy
ZWQgdG8gb3VycyBhcmUgY29tYmluYXRpb24KPiBvZiB0aGUgbXlzdGVyeSAiY2hpcF9oIiBwb3dl
ciBkb21haW4vcmVzZXQgd2l0aCB0aGUgV2lmaSBvbmUgYW5kIHRoZQo+IGluY2x1c2lvbiBvZiBz
ZF91aHNfZGRyNTAuCj4KPiAtVG9ueQo+Cj4gT24gU3VuLCBGZWIgMTcsIDIwMTkgYXQgNzoxNiBB
TSBEYXZpZCBTdW1tZXJzCj4gPGJlYWdsZWJvYXJkQGRhdmlkam9obnN1bW1lcnMudWs+IHdyb3Rl
Ogo+PiBUaGlzIHBhdGNoIGFkZHMgdGhlIHdpZmkgdG8gdGhlIEFTVVMgVGlua2VyIEJvYXJkIChT
KSBtYWNoaW5lcy4KPj4KVG9ueSwgdGhhbmtzIGZvciB0aGUgaW50ZXJlc3QgaW4gdGhpcyBhbmQg
dGhlIEJsdWV0b290aCBSRkMuIFRvIG15IG1pbmQgCml0IHdvdWxkIGJlIGdvb2QgaWYgd2UgY291
bGQgbWFpbmxpbmUgYW4gYWdyZWVkIHNvbHV0aW9uLiBBcyBtdWNoIGFzIAphbnl0aGluZyBkb2Vz
bid0IG1ha2Ugc2Vuc2UgdG8gbWUgZm9yIEFybWJpYW4gYW5kIEFyY2hMaW51eCBBcm0gdG8gaGF2
ZSAKaW5kZXBlbmRlbnQgc29sdXRpb25zLgoKSW4gdGhlIEFyY2hMaW51eCBBcm3CoCBjYW1wIEkn
bSBub3QgYSBmYW4gb2YgYXBwbHlpbmcgbWFueSBwYXRjaGVzIHRvIApzdXBwb3J0IGEgYm9hcmQs
IGFzIG11Y2ggYXMgYW55dGhpbmcgaXQgbWFrZXMgdGhhdCBib2FyZCBub24gZ2VuZXJpYyAtIAph
bmQgc28gaGFzIHRvIGhhdmUgaXRzIG93biBoYW5kIGNyYWZ0ZWQga2VybmVsLiBUaGlzIHRvIG1l
IGlzbid0IGEgZ29vZCAKc29sdXRpb24sIHNvIGlmIHBvc3NpYmxlIHByZWZlciB0aGUgcGFpbiBv
ZiBnZXR0aW5nIGl0IG1haW5saW5lZC4KClN0ZWZhbiBXYWhyZW4gaGFzIGNvbWUgdXAgd2l0aCBh
IG1pbmltYWwgcGF0Y2ggdG8gaGNpX2g1IGZvciBibHVldG9vdGgsIAp0aGF0IHNheXMgdGhlIHJl
bGV2YW50IHByb3BlcnRpZXMgY2FuIGJlIHJlYWQgZnJvbSB0aGUgZGV2aWNlIHRyZWUuIFRoaXMg
Cm1lYW5zIHRoYXQgYWNwaSBpcyBubyBsb25nZXIgbmVjZXNzYXJ5LiBUaGF0cyBjdXJyZW50bHkg
b3V0IGluIHRlc3RpbmcuCgpBbnl3YXkgd291bGQgYmUgZ29vZCBpZiBBcmNoIGFuZCBBcm1iaWFu
IGNvdWxkIG1lcmdlIG91ciBlZmZvcnRzIC4uLgoKUmVnYXJkcywKCkRhdmlkLgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
