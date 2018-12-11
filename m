Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EFCC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:43:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740422084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cH++AFx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740422084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fEIEQlYwFlHeDQM8qvLSJ3KdIMjTUUrleiiQ0xlGuso=; b=cH++AFx/XsGBPjT4THVcuWQHv
	AyvOFit+X03IC9lgLaQfFAfoQAjdN5GwYBWT6w8P81U/kLCKAAuRdsqhaIssiryPlAO34m3PrEL6u
	ePYdp3ZlBQpvaxp6RAsfPGtB9LvfbORvT/IMD2Up4Ve8j0tTCDtAXXHHT3uajd9Y1T2HDfd/8GiH3
	59dAdGz+25Y0CsCQfQpDPvPpc7guU90zQ0LB+bLnxBqdyRLTOoI5fojA+VuARxzTwBRgASHNiOge+
	AZZo2ZsxEtUbjnOV95dz0EQkNkTi8cDCJW9x/mNCUU4ZAIe6LnHXkDNH9vdm6kRoONY395f+aDzGR
	AYCUwRLoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeZL-00014g-WE; Tue, 11 Dec 2018 09:43:12 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeZ7-0000sG-Ap; Tue, 11 Dec 2018 09:42:58 +0000
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 11 Dec
 2018 17:43:11 +0800
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
 <20181210155057.38788656@xps13>
 <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
 <20181211085445.68e57e0e@xps13>
 <356aed95-518d-7cd0-4337-184f181472ad@amlogic.com>
 <20181211100718.51d2cd6c@xps13>
From: Liang Yang <liang.yang@amlogic.com>
Message-ID: <ce821991-423b-837a-a936-699716791aad@amlogic.com>
Date: Tue, 11 Dec 2018 17:43:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181211100718.51d2cd6c@xps13>
Content-Language: en-US
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_014257_373088_83D2DCF0 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, Jian Hu <jian.hu@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAoKT24gMjAxOC8xMi8xMSAxNzowNywgTWlxdWVsIFJheW5hbCB3cm90ZToKPiBI
aSBMaWFuZywKPiAKPiBMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBv
biBUdWUsIDExIERlYyAyMDE4IDE2OjM2OjQ3Cj4gKzA4MDA6Cj4gCj4+IEhpIE1pcXVlbCwKPj4K
Pj4gVGhhbmtzIGZvciB5b3VyIHF1aWNrbHkgcmVwbHkuCj4+Cj4+IE9uIDIwMTgvMTIvMTEgMTU6
NTQsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4+PiBIaSBMaWFuZywKPj4+Cj4+PiBMaWFuZyBZYW5n
IDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBUdWUsIDExIERlYyAyMDE4IDA5OjU2
OjI1Cj4+PiArMDgwMDoKPj4+ICAgIAo+Pj4+IEhpIE1pcXVlbCwKPj4+Pgo+Pj4+IE9uIDIwMTgv
MTIvMTAgMjI6NTAsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4+Pj4+IEhpIExpYW5nLAo+Pj4+Pgo+
Pj4+PiBMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBNb24sIDEw
IERlYyAyMDE4IDIwOjEyOjM5Cj4+Pj4+ICswODAwOgo+Pj4+PiAgICAgPj4+PiBPbiAyMDE4LzEy
LzEwIDE5OjM4LCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6Cj4+Pj4+Pj4gT24gTW9uLCAxMCBEZWMg
MjAxOCAxOToyMzo0NiArMDgwMAo+Pj4+Pj4+IExpYW5nIFlhbmcgPGxpYW5nLnlhbmdAYW1sb2dp
Yy5jb20+IHdyb3RlOgo+Pj4+Pj4+ICAgICAgPj4+Pj4+ICsJCQltdGQtPmVjY19zdGF0cy5mYWls
ZWQrKzsKPj4+Pj4+Pj4+PiArCQkJY29udGludWU7Cj4+Pj4+Pj4+Pj4gKwkJfQo+Pj4+Pj4+Pj4+
ICsJCW10ZC0+ZWNjX3N0YXRzLmNvcnJlY3RlZCArPSBFQ0NfRVJSX0NOVCgqaW5mbyk7Cj4+Pj4+
Pj4+Pj4gKwkJYml0ZmxpcHMgPSBtYXhfdCh1MzIsIGJpdGZsaXBzLCBFQ0NfRVJSX0NOVCgqaW5m
bykpOwo+Pj4+Pj4+Pj4+ICsJfQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEFyZSB5b3Ugc3VyZSB5b3Ug
aGFuZGxlIGNvcnJlY3RseSBlbXB0eSBwYWdlcyB3aXRoIGJmPwo+Pj4+Pj4+Pj4gICAgICAgPj4g
aWYgc2NyYW1ibGUgaXMgZW5hYmxlLCBpIHdvdWxkIHNheSB5ZXMgaGVyZS4KPj4+Pj4+Pj4gd2hl
biBzY3JhbWJsZSBpcyBkaXNhYmxlZCwgaSBhbSBjb25zaWRlcmluZyBob3cgdG8gdXNlIHRoZSBo
ZWxwZXIKPj4+Pj4+Pj4gbmFuZF9jaGVja19lcmFzZWRfZWNjX2NodW5rLCBidXQgaXQgc2VlbXMg
dGhhdCBpIGNhbid0IGdldCB0aGUgZWNjCj4+Pj4+Pj4+IGJ5dGVzIHdoaWNoIGlzIGNhY3VsYXRl
ZCBieSBlY2MgZW5naW5lLmJ5IHRoZSB3YXksIG5mYyBkbWEgZG9lc24ndCBzZW5kCj4+Pj4+Pj4+
IG91dCB0aGUgZWNjIHBhcml0eSBieXRlcy4KPj4+Pj4+Pgo+Pj4+Pj4+IEV2ZW4gaWYgdGhlIEVD
QyBlbmdpbmUgaXMgZGlzYWJsZWQ/Cj4+Pj4+Pj4gICAgICA+PiBOby4KPj4+Pj4+IFdoZW4gRUND
IGVuZ2luZSBpcyBkaXNhYmxlZCwgaXQgY2FuIHJlYWQgdGhlIGVjYyBwYXJpdHkgYnl0ZXMgOyBi
dXQgdGhlcmUgaXMgYW5vdGhlciBwcm9ibGVtIHRoYXQgaSBuZWVkIHRvIGNvbnNpZGVyIGhvdyBj
b2RlIHN0cnVjdCBsb29rcyBiZXR0ZXIgd2hlbiByZWFkaW5nIGVycm9yIHdpdGggZWNjIG9wZW5l
ZCBhbmQgdGhlbiB0cnkgdG8gcmF3IHJlYWQuCj4+Pj4+PiBJcyB0aGVyZSBhIGdvb2QgaWRlYT8K
Pj4+Pj4KPj4+Pj4gV2hlbiByZWFkaW5nIHdpdGggRUNDIGVuYWJsZWQsIGluIGNhc2Ugb2YgdW5j
b3JyZWN0YWJsZSBlcnJvciB5b3UKPj4+Pj4gbXVzdCByZS1yZWFkIHdpdGhvdXQgRUNDLCB0aGVu
IGNoZWNrIGlmIHRoZSBwYWdlIGlzIGVtcHR5IG9yIG5vdCB3aXRoCj4+Pj4+IHRoZSBjb3JlIGhl
bHBlcnMgKG5hbmRfY2hlY2tfZXJhc2VkXyooKSkuCj4+Pj4+Cj4+Pj4+IElzIHRoaXMgd2hhdCB5
b3UgbWVhbnQ/Cj4+Pj4+ICAgICA+PiB5ZXMuIHdoZW4gdW5jb3JyZWN0YWJsZSBFQ0MgZXJyb3Is
IGkgbmVlZCBmaXJzdGx5IHJlYWQgb3V0IHRoZSBFQ0MgYnl0ZXMgd2l0aG91dCBFQ0MgZW5naW5l
IGFuZCB0aGVuIHVzZSB0aGUgaGVscGVyIG5hbmRfY2hlY2tfZXJhc2VkX2VjY19jaHVuayB0byBj
aGVjayBpZiBibGFuayBwYWdlLgo+Pj4+IE9mIGNvdXJzZSwgdGhlIHByZWNvbmRpdGlvbiBpcyB3
aXRob3V0IHNjcmFtYmxlciwgb3IgdGhlIGJsYW5kIHBhZ2UgY2FuIGJlIGRldGVjdGVkIGJ5IG1l
c29uIE5GQy4KPj4+Cj4+PiBBIHN1cHBvc2UgeW91IG1lYW50ICJibGFuayBwYWdlIj8gSWYgeWVz
LCB0aGVuIHlvdSBkb24ndCBuZWVkIHRoZQo+Pj4gaGVscGVyIHRvIGNoZWNrIGZvciBvbmx5LTB4
RkYgcGFnZXMuIElmIHRoZSBjb250cm9sbGVyIHRlbGxzIHlvdSBpZiB0aGUKPj4+IHBhZ2Ugd2Fz
IGJsYW5rLCB0aGVuIGp1c3QgY2hlY2sgZm9yIHRoYXQgYml0Lgo+Pj4gICAgCj4+Cj4+IGkgdGhp
bmsgbm90LiB3ZSBuZWVkIHRvIHJldHVybiBiYWNrIHRoZSBwcmV2aW91cyBwcm9ibGVtIHRoYXQg
aG93IGkgY2FuIGdldCB0aGUgYml0ZmxpcHMgb2Ygb25lIGJsYW5rIHBhZ2UuIGkgdGhpbmsgaSBu
ZWVkIHRoZSBoZWxwZXIuCj4gCj4gWW91IGFyZSByaWdodCwgSSBzdXBwb3NlIHRoZSAiYmxhbmsg
cGFnZSIgZmxhZyBpcyBvbmx5IHRyaWdnZXJlZCBpZgo+IHRoZXJlIGlzIG5vIGJpdGZsaXAuIElu
IHRoaXMgY2FzZSB5b3UgY2FuIGFzc3VtZSB0aGVyZSBhcmUgbm8KPiBiaXRmbGlwcy4gT3RoZXJ3
aXNlIHRoZSBjb250cm9sbGVyIHdpbGwgdHJpZ2dlciBhbgo+IHVuY29ycmVjdGFibGUgZXJyb3Ig
ZXZlbnQgYW5kIHlvdSB3aWxsIGhhdmUgdG8gcmUtcmVhZCB0aGUgcGFnZQo+IHdpdGhvdXQgRUND
IGFuZCBjaGVjayBmb3IgYml0ZmxpcHMgd2l0aCB0aGUgaGVscGVyLgo+IAp5ZXMsIHRoYXQgaXMg
cmlnaHQuIGkgd2lsbCBkbyB0aGUgInJlLXJlYWQiIHByb2Nlc3MuCj4gCj4gVGhhbmtzLAo+IE1p
cXXDqGwKPiAKPiAuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
