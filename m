Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE954C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:58:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02132192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VGxUQLpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02132192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B5eCDYXXkFdOg4gHmFgYHO7I1FkmtMu1HWE3HiPNDy0=; b=VGxUQLpphsziYoDRfXjioVxeM
	QmG7ET0Pi/u8JGm/0MI8+0A5frS8BRR8rEF2lSbYLY9eg180ueVp1KWjzGnnjhwGMdmCOQavGPnov
	Dhc8VGjTBpYnTNB2IZE4XNA74gjsVX1IRC9/P//hgm/SE7D4fKe7gALOd46QZtkEI9ussfghfIKrT
	5lXNGy+QbAZwGG+J3wWUutmtfY8F3BhTsSJjd1tnf8bdZOuN0ERNAvR/7Z0JQeI5MNaMi/CGgF+cg
	u1lDbGVhb0P45VXUFe0HeG4OwQgj5JqBSTM3YHd2ZYC9RT78cFarpnfne4WuVVXscwZaOKwwVOdAM
	BwyNem77w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvK9t-0003oL-D9; Sun, 17 Feb 2019 10:58:53 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvK9p-0003nx-TZ; Sun, 17 Feb 2019 10:58:51 +0000
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1HAwakg030582;
 Sun, 17 Feb 2019 19:58:37 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Sun, 17 Feb 2019 19:58:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1HAwaEH030577
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Sun, 17 Feb 2019 19:58:36 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <20190202043444.9308-1-katsuhiro@katsuster.net>
 <1970132.3b67tCGWFf@phil>
 <c4ce7f7a-c791-ae0a-ad3d-02b2efa41709@katsuster.net>
 <2275914.n7pQDzs7mT@diego>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <16f4fcf0-e9c2-e925-e463-282cfff088c7@katsuster.net>
Date: Sun, 17 Feb 2019 19:58:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2275914.n7pQDzs7mT@diego>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_025850_188361_A6AF1D34 
X-CRM114-Status: GOOD (  15.66  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8gSGVpa28sCgpPbiAyMDE5LzAyLzEyIDIwOjEyLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToK
PiBIaSwKPiAKPiBBbSBNb250YWcsIDQuIEZlYnJ1YXIgMjAxOSwgMTM6NTk6MzcgQ0VUIHNjaHJp
ZWIgS2F0c3VoaXJvIFN1enVraToKPj4gT24gMjAxOS8wMi8wMyAxODowNiwgSGVpa28gU3R1ZWJu
ZXIgd3JvdGU6Cj4+PiBBbSBTYW1zdGFnLCAyLiBGZWJydWFyIDIwMTksIDA1OjM0OjQ0IENFVCBz
Y2hyaWViIEthdHN1aGlybyBTdXp1a2k6Cj4+Pj4gVGhpcyBwYXRjaCBhZGRzIEhETUkgc291bmQg
KEkyUzApIG5vZGUgYW5kIHJlbW92ZSBkbWEgcHJvcGVydGllcwo+Pj4+IGZyb20gVUFSVDIgbm9k
ZSBmb3Igcm9jazY0Lgo+Pj4+Cj4+Pj4gVGhlIERNQUMgb2YgcmszMzI4IGNhbiB1c2UgOCBjaGFu
bmVscyBhdCBzYW1lIHRpbWUuIEN1cnJlbnRseSwgdG90YWwKPj4+Pgo+Pj4+IDcgY2hhbm5lbHMg
YXJlIHVzZWQgYXMgZm9sbG93czoKPj4+PiAgICAgLSBJMlMxICAyY2gKPj4+PiAgICAgLSBVQVJU
MiAyY2gKPj4+PiAgICAgLSBTUERJRiAxY2gKPj4+PiAgICAgLSBTUEkwICAyY2gKPj4+Pgo+Pj4+
IEhETUkgYXVkaW8gdXNpbmcgSTJTMCB0aGF0IHJlcXVpcmVzIDJjaCBidXQgRE1BQyBoYXMgb25s
eSAxIGNoYW5uZWwuCj4+Pj4KPj4+PiBVQVJUMiBjYW4gd29yayB3aXRob3V0IERNQSByZXNvdXJj
ZXMsIHNvIHRoaXMgcGF0Y2ggcmVtb3ZlcyBkbWEKPj4+PiBhbGxvY2F0aW9uIGZvciBVQVJUMiBh
bmQgcmV1c2VzIGl0IHRvIEkyUzAuCj4+Pgo+Pj4gSSBkb24ndCBmb2xsb3cgdGhhdCBkZXNjcmlw
dGlvbi4gSG93IGNhbiBpMnMwIHJlLXVzZSB0aGUgdWFydDIgZG1hCj4+PiBjaGFubmVscz8gTG9v
a2luZyBhdCB0aGUgZG1hIHRhYmxlIGluIHRoZSBUUk0sIHVhcnQyIGhhcyBjaGFubmVscyA2KzcK
Pj4+IHdoaWxlIGkyczAgdXNlcyBjaGFubmVscyAxMSsxMi4gVGhleSBzaG91bGQganVzdCBydW4g
Y29uY3VycmVudGx5Pwo+Pgo+PiBTb3JyeSBmb3IgY29uZnVzaW5nLi4uIDYgb3IgNyBpcyBhcyBJ
RCBudW1iZXIgb2Ygc2xhdmUgRE1BIGNoYW5uZWwuCj4+IFRSTSBjYWxscyBpdCAnUmVxIG51bWJl
cicuIFJlcSBudW1iZXIgNis3IGFuZCAxMSsxMiBjYW4gd29yawo+PiBjb25jdXJyZW50bHkgYnV0
IFRSTSBzYXlzIERNQUMgY2FuIHRyYW5zZmVyIDggRE1BIGNoYW5uZWxzIGF0IHNhbWUKPj4gdGlt
ZS4gU28gYWxsIDE2IFJlcSBudW1iZXJzIGNhbm5vdCBhY3RpdmF0ZSBhdCBzYW1lIHRpbWUuIEl0
IHNob3VsZAo+PiBiZSBrZWVwIGxlc3Mgb3IgZXF1YWwgdGhhbiA4IG51bWJlcnMuCj4gCj4gQnV0
IHRoYXQgInNob3J0Y29taW5nIiBvZiBoYXZpbmcgbW9yZSByZXF1ZXN0cyB0aGFuIGNoYW5uZWxz
IGlzIG5vdAo+IHNvbWV0aGluZyBzcGVjaWZpYyB0byB0aGUgcGwzMzAsIGluc3RlYWQgbW9zdCBk
bWEgY29udHJvbGxlcnMgaGF2ZSB0aGF0Cj4gInByb2JsZW0iLCB3aGljaCBzZWVtcyB0byBnZXQg
c29sdmVkIGJ5IHRoZSB2aXJ0LWRtYSBtZWNoYW5pc20gb2YKPiBkbWFlbmdpbmUgLSB3aGljaCBw
bDMzMCBkb2Vzbid0IHVzZSBzbyBmYXIuIChidXQgc2VlIHBsMDgwIGZvciBleGFtcGxlKQo+IAoK
SSB1bmRlcnN0YW5kLiBJIGRyb3AgdGhlc2UgcGF0Y2hlcy4KCgo+IFRoZSBkZXZpY2V0cmVlIG9u
bHkgZGVzY3JpYmVzIHRoZSBoYXJkd2FyZSBhbmQgaXMgbmV2ZXIgbWVhbnQgYXMgYQo+IGNvbmZp
Z3VyYXRpb24gc3BhY2UgZm9yIGtlcm5lbC1jb2RlIHNob3J0Y29taW5ncy4KPiAKClllcywgcmln
aHQuIEkgZG9uJ3Qgd2FudCB0byB1c2UgZGV2aWNlLXRyZWUgYXMgY29uZmlndXJhdGlvbiBzcGFj
ZSwKc28gd2hpY2ggaXMgYmV0dGVyPwoKLSBGaXggdGhlIHBsMzMwIGRyaXZlciBmaXJzdCBhbmQg
YWZ0ZXIgdGhhdCBhZGQgSERNSS1zb3VuZCBub2RlCiAgIHRvIGRldmljZS10cmVlLgotIEp1c3Qg
YWRkIEhETUktc291bmQgbm9kZSB0byBkZXZpY2UtdHJlZS4gSWYgc29tZW9uZSAoaW5jbHVkZSBt
ZSkKICAgd2FudCB0byBzdXBwb3J0IHZpcnQtZG1hIG9uIHBsMzMwIGRyaXZlciwgdGhleSB3aWxs
IGZpeCBpdC4KICAgKFBMMzMwIHdpbGwgZmFjZSBlcnJvciBidXQgYWxsIHNvdW5kcyB3b3JrcyBm
aW5lIGFuZCBVQVJUIHN0aWxsCiAgIHdvcmtzIGZpbmUgd2l0aCBETUEgZXJyb3IpCgo+IAo+IEhl
aWtvCj4gCj4gCj4gCgpCZXN0IFJlZ2FyZHMsCkthdHN1aGlybyBTdXp1a2kKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
