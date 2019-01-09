Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACCC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:34:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7890120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qxar1WtN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B6okbu1O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nW5pOslc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7890120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b8/KFdV/2LtPLU3x/jt2vDTxm4z108XqMeTfQgPCVY8=; b=Qxar1WtNiJKYfw3iEQE8Kkiwh
	ITFFtVIEFcclg8f/c1srEo9Aff7quj1oNCxN/eOjSDh0pVEpqU/6nw2UUyv9WO4RpTg0IfI8o5nMO
	LZr3bIyGxWD4D1UdTT/ZOiKtt0XgIqgecUHgogYDqBeeEyWviNlpNfdGxH0QkSuFIYCWnw7SDnGJE
	j9uYGNzgVvBZ13FBcKgrmC0En5QwrjYA4XqUPnyKrUR8ylAMiu79dqX4jyQQFz0h/+qWJpm6s9+ZZ
	XgHfi8iOlpA4QQSKU/K6B4GpFpbSBbwF8wjb1YV3oGrAWtgWoUP8HeMTbJ5JzORSOqLo9WIcNgzNE
	g8tLoRqFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh6Vo-00059W-VE; Wed, 09 Jan 2019 05:34:44 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh6Vl-000597-Ru
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 05:34:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E5B6760886; Wed,  9 Jan 2019 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547012080;
 bh=Px+VPNjOCZJ9TeXJ/SnsBY+UVYAyqE9tD4YaxE/J+zU=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=B6okbu1O46YicjNVNk6BCmoGZlH//zEO+4bB4V0etjGVddGuch1fcBGwEafI3btMs
 Kn1CWzyFFr18H0EY15VD+APfvYUDoO6GYXEqRjVcdoDAaJ6hMYqX1xDfRzwShh6Qdh
 fO/Za2l12sValUCGCcQ5uMj6kwHX8rR1yHY57MWk=
Received: from [10.206.16.85]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: rplsssn@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D49060234;
 Wed,  9 Jan 2019 05:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547012079;
 bh=Px+VPNjOCZJ9TeXJ/SnsBY+UVYAyqE9tD4YaxE/J+zU=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=nW5pOslcBoy9NCiCmMPwRul1q5GLVMPpvZvOp5FX6bwhO50ugHvBl+HvoNN9EM3Tn
 5RohgyVgNRXmu9aleYly3eWroIVHoCdSNA5g6F1apffxTXNaXRd4oY+QCY+8LOh8B8
 osha5j/3UlUeTLTVlvMW9G8nJfTjPBnkA3E1g4Mo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D49060234
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
From: Raju P L S S S N <rplsssn@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
 david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
 <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
 <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
 <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
Message-ID: <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
Date: Wed, 9 Jan 2019 11:04:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_213441_940632_1793C3AC 
X-CRM114-Status: GOOD (  29.44  )
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
Cc: devicetree@vger.kernel.org, rnayak@codeaurora.org, linux-pm@vger.kernel.org,
 dianders@chromium.org, evgreen@chromium.org, linux-kernel@vger.kernel.org,
 mka@chromium.org, ilina@codeaurora.org, bjorn.andersson@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzcvMjAxOSA5OjQ3IFBNLCBSYWp1IFAgTCBTIFMgUyBOIHdyb3RlOgo+IAo+IAo+IE9u
IDEvNC8yMDE5IDI6NDkgQU0sIFN0ZXBoZW4gQm95ZCB3cm90ZToKPj4gUXVvdGluZyBSYWp1IFAg
TCBTIFMgUyBOICgyMDE5LTAxLTAzIDA0OjIyOjU4KQo+Pj4KPj4+IE9uIDEyLzI5LzIwMTggMzow
OCBBTSwgU3RlcGhlbiBCb3lkIHdyb3RlOgo+Pj4+IFF1b3RpbmcgUmFqdSBQIEwgUyBTIFMgTiAo
MjAxOC0xMi0yNiAwMTo0NDo0MykKPj4+Pj4KPj4+Pj4gVGhlcmUgYXJlIHR3byBSU0MgZGV2aWNl
cyBpbiBTb0Mgb25lIGZvciBhcHBsaWNhdGlvbiBwcm9jZXNzb3IgCj4+Pj4+IHN1YnN5c3RlbQo+
Pj4+PiAmIG90aGVyIGRpc3BsYXkgc3Vic3lzdGVtLiBCb3RoIFJTQyBjb250YWluIHJlZ2lzdGVy
cyBmb3IgUERDIHRpbWVycwo+Pj4+PiAob25lIGZvciBlYWNoIHN1YnN5c3RlbSkuCj4+Pj4KPj4+
PiBXaGVuIGlzIHRoZSB0aW1lciBwcm9ncmFtbWVkIG9uIHRoZSBkaXNwbGF5IHN1YnN5c3RlbSdz
IFJTQz8gSXQncyBoYXJkCj4+Pj4gdG8gZ2l2ZSBhZHZpY2Ugd2l0aG91dCBhbGwgdGhlIGluZm9y
bWF0aW9uLgo+Pj4KPj4+IEZvciBkaXNwbGF5IHN1YnN5c3RlbSBSU0MsIGhhcmR3YXJlIHNsZWVw
IHNvbHZlciB0YWtlcyBjYXJlIG9mIHRpbWVyCj4+PiBwcm9ncmFtbWluZyBmb3Igd2FrZXVwIHdo
ZW4gdGhlIHN1YnN5c3RlbSBnb2VzIHRvIFBvd2VyIGNvbGxhcHNlLgo+Pgo+PiBTbyB0aGUgZGlz
cGxheSBzdWJzeXN0ZW0gZG9lc24ndCBuZWVkIHRvIHByb2dyYW0gdGhlaXIgUERDIGluIHRoZWly
IFJTQwo+PiBmcm9tIHNvZnR3YXJlPwo+IFllcy4KPiAKPj4KPj4+Pgo+Pj4+IEkgd291bGQgdGhp
bmsgdGhhdCBpdCB3b3VsZCBtYWtlIHNlbnNlIGZvciB0aGUgYXBwbGljYXRpb24gcHJvY2Vzc29y
J3MKPj4+PiBSU0MgdGltZXIgdG8gYmUgcHJvZ3JhbW1lZCBmcm9tIHRoZSBicm9hZGNhc3QgdGlt
ZXIgbWVjaGFuaXNtIGluIHRoZQo+Pj4+IGtlcm5lbCBzbyB0aGF0IHRpbWVycyBkdXJpbmcgaWRs
ZSB3b3JrIGFuZCBzdXNwZW5kIHR1cm5zIG9mZiB0aGUgdGltZXIKPj4+PiBhcHByb3ByaWF0ZWx5
IHdpdGggYSBzaHV0ZG93biBob29rLiBJIGd1ZXNzIHRoZSBQREMgY2FuJ3QgdGVsbCB5b3UgdGhl
Cj4+Pj4gdGltZSB0aG91Z2g/IEl0IGxvb2tzIGxpa2UgYSBzaGFkb3cgKGFuZCBsaW1pdGVkKSB2
ZXJzaW9uIG9mIHRoZSBBUk0KPj4+PiBhcmNoaXRlY3RlZCBNTUlPIHRpbWVyIHRoYXQgd2UgYWxy
ZWFkeSBwcm9ncmFtIGZvciB0aGUgYnJvYWRjYXN0IHRpbWVyCj4+Pj4gbWVjaGFuaXNtLiBJcyB0
aGF0IGJlY2F1c2UgZXZlbiB0aGUgTU1JTyB0aW1lciBjYW4ndCB3YWtldXAgdGhlIHN5c3RlbQo+
Pj4+IGluIGRlZXAgaWRsZT/CoCBBc3N1bWluZyB0aGF0J3MgdHJ1ZSwgaXQgbWVhbnMgdGhlIEFS
TSBNTUlPIHRpbWVyIGNhbid0Cj4+Pj4gYWx3YXlzIGJlIHVzZWQgYXMgdGhlIHN5c3RlbSB3aWRl
IGJyb2FkY2FzdCBtZWNoYW5pc20gYmVjYXVzZSB3ZSAKPj4+PiBuZWVkIHRvCj4+Pj4gYXVnbWVu
dCBpdCB3aXRoIHRoZSBQREMgdGltZXIgdG8gZ2V0IHRoZSBhY3R1YWwgd2FrZXVwLgo+Pj4+Cj4+
Pgo+Pj4gWWVzLiB0aGlzIGlzIGNvcnJlY3QuCj4+Pgo+Pj4+IE1heWJlIHdlIHNob3VsZCBiZSBh
ZGRpbmcgaG9va3MgaW50byB0aGUgYnJvYWRjYXN0IHRpbWVyIG1lY2hhbmlzbSB0bwo+Pj4+IHBy
b2dyYW0gdGhpcyB3YWtldXAgZXZlbnQgaGFyZHdhcmUgaW4gYWRkaXRpb24gdG8gdGhlIEFSTSBN
TUlPIAo+Pj4+IHRpbWVyLiBPcgo+Pj4+IHdlIHNob3VsZCBzdG9wIHVzaW5nIHRoZSBBUk0gTU1J
TyB0aW1lciBvbiB0aGVzZSBzeXN0ZW1zIGFuZCByZWFkIHRoZQo+Pj4+IHN5c3RlbSByZWdpc3Rl
ciBiYXNlZCBwaHlzaWNhbCB0aW1lIGluIHRoZSBSU0MgdGltZXIgZHJpdmVyIGFuZCAKPj4+PiBy
ZWdpc3Rlcgo+Pj4+IHRoaXMgNjQtYml0IFBEQyByZWdpc3RlciBhcyB0aGUgYnJvYWRjYXN0IHRp
bWVyLiBTbyB0aGUgdGltZSByZWFkaW5nCj4+Pj4gd291bGQgYmUgdGhyb3VnaCBzeXNyZWcgYW5k
IHRoZSB3YWtldXAgcHJvZ3JhbW1pbmcgd291bGQgYmUgZG9uZSBieQo+Pj4+IHdyaXRpbmcgdGhl
IFBEQyB0aW1lci4gVGhlIGFzc3VtcHRpb24gd291bGQgYmUgdGhhdCB3ZSBoYXZlIGFjY2VzcyB0
bwo+Pj4+IHRoZSBwaHlzaWNhbCB0aW1lIHJlZ2lzdGVycyAod2hpY2ggc291bmRzIGxpa2UgdGhl
IGFzc3VtcHRpb24gd2UgCj4+Pj4gaGF2ZSB0bwo+Pj4+IG1ha2UpLgo+Pj4KPj4+IFRoZXJlIGFy
ZSBubyBwaHlzaWNhbCB0aW1lciByZWdpc3RlcnMgYXZhaWxhYmxlIGluIFJTQyBmb3IgdGhpcyBw
dXJwb3NlLgo+Pj4KPj4+Pgo+Pj4+IERvIHdlIGdldCBhbiBpbnRlcnJ1cHQgc29tZXdoZXJlIGZy
b20gdGhlIFJTQyBoYXJkd2FyZSB3aGVuIHRoZSB0aW1lcgo+Pj4+IGZpcmVzPyBPciBkb2VzIHRo
YXQganVzdCBjYXVzZSBhIHN5c3RlbSB3YWtldXAgZXZlbnQgd2l0aG91dCBhbnkgCj4+Pj4gcGVu
ZGluZwo+Pj4+IGlycSBhbmQgdGhlbiBhbm90aGVyIGlycSAobGlrZSB0aGUgQVJNIGFyY2hpdGVj
dGVkIHRpbWVyKSBqdXN0IGhhcHBlbnMKPj4+PiB0byBiZSBwZW5kaW5nIGFyb3VuZCB0aGUgc2Ft
ZSB0aW1lPyBJZiB3ZSBnZXQgYW4gaW50ZXJydXB0IHNvbWVob3cgdGhlbgo+Pj4+IEkgd291bGQg
cHJlZmVyIHRvIGRyb3AgdGhlIEFSTSBNTUlPIHRpbWVyIGFuZCBkbyB0aGlzIGh5YnJpZCBicm9h
ZGNhc3QKPj4+PiB0aW1lciBhcHByb2FjaC4KPj4+Cj4+PiBUaGVyZSBpcyBubyBpbnRlcnJ1cHQg
Zm9yIFBEQyB0aW1lb3V0LiBJdCBqdXN0IGNhdXNlcyBzeXN0ZW0gd2FrZXVwCj4+PiB3aXRob3V0
IGEgcGVuZGluZyBpcnEuIEFSTSBNTUlPIGlzIG5lY2Vzc2FyeSBmb3IgaXJxLgo+Pgo+PiBEb2Vz
IHRoYXQgc3lzdGVtIHdha2V1cCBjYXVzZSB0aGUgQ1BVcyB0byBiZSBlbmFibGVkPyBTbyB0aGUg
c3lzcmVnCj4+IGJhc2VkIHRpbWVyIGluIHRoZSBDUFUgd291bGQgc3RhcnQgd29ya2luZz8gT3Ig
ZG9lcyBpdCBvbmx5IG1ha2UgdGhlCj4+IHN5c3RlbSBjb21lIG91dCBvZiBhIGRlZXAgZW5vdWdo
IGlkbGUgc3RhdGUgdG8gbWFrZSBhbiBhbHdheXMgb24gZG9tYWluCj4+IHdvcmsgdGhhdCBvbmx5
IGNvbnRhaW5zIHRoZSBNTUlPIGJhc2VkIEFSTSBhcmNoaXRlY3RlZCB0aW1lcj8KPiAKPiBJdCBv
bmx5IG1ha2VzIHRoZSBzeXN0ZW0gY29tZSBvdXQgb2YgZGVlcCBzbGVlcCBzdGF0ZSBmb3IgTU1J
TyB0aW1lciB0byAKPiBmdW5jdGlvbi4KPiAKPj4KPj4gSSdkIGhvcGUgdGhhdCBlYWNoIFJTQydz
IFBEQyB0aW1lciB3YWtlcyB1cCB0aGUgb3duZXIgb2YgdGhlIFJTQyBzbyB0aGF0Cj4+IHdlIGNh
biB1c2UgdGhlIHN5c3JlZyBiYXNlZCB0aW1lcnMgYW5kIGlnbm9yZSB0aGUgTU1JTyBiYXNlZCB0
aW1lcnMKPj4gaGVyZS4gVGhpcyBpc24ndCBhIHZlcnkgaW1wb3J0YW50IGRpc3RpbmN0aW9uIHRv
IG1ha2UgdGhvdWdoLCBzbyBpZiB5b3UKPj4gaGF2ZSB0byB1c2UgdGhlIE1NSU8gdGltZXJzIHRo
ZW4gaXQganVzdCBtZWFucyBzb21lIGV4dHJhIERUIHRoaW5ncyBuZWVkCj4+IHRvIGJlIGRvbmUg
dG8gcmVsYXRlIHRoZSBNTUlPIHRpbWVycyB3aXRoIHRoZSBSU0MgdGhhdCBoYXMgdGhlIHRpbWVy
Cj4+IHRoYXQgbmVlZHMgdG8gYmUgcHJvZ3JhbW1lZCB0b28uCj4gCj4+Cj4+IEVpdGhlciB3YXkg
d2Ugd291bGQgbmVlZCBhIHdheSB0byBlaXRoZXIgaG9vayB0aGUgQVJNIGFyY2hpdGVjdGVkIHRp
bWVyCj4+IGRyaXZlciBpbiB0aGUga2VybmVsLCBvciByZWltcGxlbWVudCB0aGUgYml0IG9mIGNv
ZGUgbmVlZGVkIHRvIGltcGxlbWVudAo+PiB0aGUgY2xvY2tldmVudCBiYXNlZCBvbiB0aGUgQVJN
IGFyY2hpdGVjdGVkIHRpbWVyIHRoYXQgcHJvZ3JhbXMgdGhlIEFSTQo+PiB0aW1lciBhbmQgdGhl
IFBEQyB0aW1lciB0b2dldGhlci4KPj4KPiAKPiBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgc29t
ZSBtb3JlIGRldGFpbHMgb24gdGhlIGltcGxlbWVudGF0aW9uPwoKSGkgU3RlcGhlbiwKClJlZ2Fy
ZGxlc3Mgb2YgaW1wbGVtZW50YXRpb24gb3B0aW9ucyBhYm91dCBhcHBsaWNhdGlvbiBwcm9jZXNz
b3IgCnN1YnN5dGVtIFBEQyB0aW1lciwgSSB0aGluayB0aGVyZSBpcyBhIG5lZWQgdG8gZGlmZmVy
ZW50aWF0ZSB0aGUgZmFjdCAKdGhhdCBmb3IgYXBwbGljYXRpb24gcHJvY2Vzc29yIHN1YnN5c3Rl
bSBQREMgdGltZXIgcHJvZ3JhbW1pbmcgaXMgZG9uZSAKYnkgU1cgYnV0IG5vdCBmb3IgZGlzcGxh
eSBwcm9jZXNzb3Igc3Vic3lzdGVtIGFzIEhXIHNsZWVwIHNvbHZlciB0YWtlcyAKY2FyZSBvZiBQ
REMgdGltZXIgZHVyaW5nIHNsZWVwIGVudHJ5L2V4aXQuIEhvdyBhYm91dCBoYXZpbmcgYSBkdCAK
cHJvcGVydHkgbGlrZSBxY29tLHBkYy10aW1lci1tb2RlID0gInNvbHZlciIvInN3IiA/IFRoZSBj
dXJyZW50IHBhdGNoIAppbnRyb2R1Y2VkIGNsaWVudCBiYXNlZCBtb2RlbCB1c2luZyByZWdtYXAg
dG8gYWNoaWV2ZSB0aGlzIApkaWZmZXJlbnRpYXRpb24gYmV0d2VlbiB0aGVzZSB0d28gc3Vic3lz
dGVtcy4gQnkgdXNpbmcgdGhlIGR0IHByb3BlcnR5LCAKb25jZSBycG1oLXNyYyBkcml2ZXIgaW5z
dGFuY2UgZm9yIGFwcGxpY2F0aW9uIHN1YnN5c3RlbSBjYW4gaGF2ZSBQREMgCnRpbWVyIHByb2dy
YW1pbmcgaW1wbGVtZW50ZWQuIExldCBtZSBrbm93IGlmIHRoZXJlIGlzIGFub3RoZXIgd2F5LgoK
Rm9yIGltcGxlbWVudGF0aW9uIG9mIFBEQyB0aW1lciwgSSBzZWUgdGhlIGZvbGxvd2luZyBiYXNl
ZCBvbiBhYm92ZSAKZGlzY3Vzc2lvbiAtCjEuIFRha2UgdGhlIGV4aXN0aW5nIGNwdV9wbV9ub3Rp
ZnkgYXBwcm9hY2ggYW5kIG1vdmUgdGhlIGN1cnJlbnQgc2VyaWVzIAphcHByb2FjaCBvZiBwcm9n
cmFtaW5nIFBEQyB0aW1lciByZWdpc3RlcnMgdG8gUlNDIGRyaXZlci4gVGhpcyB3b3VsZG4ndCAK
aW52b2x2ZSBhbnkgY2hhbmdlcyBpbiBjbG9ja19ldmVudF9mcmFtZXdvcmsvYnJvYWRjYXN0IGZy
YW1ld29yay4KCjIuIEFkZCBhcGkgaG9va3MgKGxpa2UgcmVhZGluZyB0aGUgbmV4dCB3YWtlIHVw
IHByb2dyYW1tZWQpIHRvIEFSTSAKYXJjaGl0ZWN0dXJlIHRpbWVyIGRyaXZlciBzbyB0aGF0IHRo
ZSB2YWx1ZSBpcyBjb3BpZWQgdG8gUERDIHRpbWVyIHVzaW5nIAp0aGUgYXBpIHdpdGggaW4gUlND
IGRyaXZlciBiYXNlZCBvbiBjcHVfcG1fbm90aWZpY2F0aW9ucy4KCjMuIENoYW5nZXMgaW4gY2xv
Y2tldmVudCB0byBwcm9ncmFtIGJvdGggQVJNIG1lbSB0aW1lciAmIFBEQyB0aW1lciAKdG9nZXRo
ZXIuIENvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgc29tZSBtb3JlIGRldGFpbHMgb24gdGhpcz8KCgpQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlIGZpcnN0IGFwcHJvYWNoIGlzIG9rLgoKVGhhbmtzLApS
YWp1LgoKPiAKPiAKPj4+Cj4+Pj4KPj4+PiBIb3cgdGhlIFJTQyBpcyB1c2VkIGluIGdlbmVyYWwg
Ynkgb3RoZXIgZGV2aWNlcywgbGlrZSBkaXNwbGF5LCBpcyBub3QKPj4+PiBjbGVhciB0byBtZS4g
V2UgZG9uJ3QgaGF2ZSBhICJ3YWtldXAgZXZlbnQiIGZyYW1ld29yayBpbiB0aGUga2VybmVsIAo+
Pj4+IHRoYXQKPj4+PiBkZXZpY2UgZHJpdmVycyBsaWtlIHRoZSBkaXNwbGF5IGRyaXZlciBjYW4g
Z3JhYiBhIHJlZmVyZW5jZSB0byBhbmQKPj4+PiBwcm9ncmFtIHNvbWUgc3lzdGVtIHdpZGUgd2Fr
ZXVwIGZvci4gVGhhdCBzb3VuZHMgbGlrZSBzb21ldGhpbmcgbmV3IAo+Pj4+IHRoYXQKPj4+PiBj
b3VsZCBiZSBoYW5kbGVkIGVudGlyZWx5IGluIHRoZSBkaXNwbGF5IGRyaXZlciB3aXRoIGRpcmVj
dCByZWdpc3Rlcgo+Pj4+IHdyaXRlcywgb3IgaXQgY291bGQgYmUgc29tZSBxY29tIHNwZWNpZmlj
IEFQSS9mcmFtZXdvcmsgdGhhdCBldmVudHVhbGx5Cj4+Pj4gY2FsbHMgZG93biBpbnRvIHRoZSBz
YW1lIFJTQyBkcml2ZXIgdGhhdCBrbm93cyB3aGF0IG9mZnNldHMgdG8gd3JpdGUKPj4+PiBpbnRv
IGluIHRoZSBkaXNwbGF5IFJTQydzIHJlZ2lzdGVyIHNwYWNlLCBvciBpdCBjb3VsZCBiZSBhbiBl
bnRpcmVseQo+Pj4+IGdlbmVyaWMgZnJhbWV3b3JrIGxpa2UgY2xrIG9yIHJlZ3VsYXRvciBmcmFt
ZXdvcmtzIHRoYXQgY291bGQgYmUgCj4+Pj4gdXNlZCBieQo+Pj4+IGFueXRoaW5nLiBCVFcsIGFy
ZSB3ZSB1c2luZyB0aGUgZGlzcGxheSBSU0MgeWV0Pwo+Pj4+Cj4+Pgo+Pj4gT25seSBkaXNwbGF5
IHN1YnN5c3RlbSBSU0MgaXMgcHJvZ3JhbW1lZCBhbG9uZyB3aXRoIENQVSBSU0MgaW4gTGludXgu
Cj4+PiBkaXNwbGF5IFJTQyBpbnN0YW5jZSBpcyBub3QgcHJlc2VudCBpbiB1cHN0cmVhbSBidXQg
aXQgaXMgcHJlc2VudCBpbgo+Pj4gZG93bnN0cmVhbSBhbmQgdXNlZCBmb3IgcmVzb3VyY2UgY29t
bXVuaWNhdGlvbiBwdXJwb3NlIG9ubHkuCj4+Cj4+IMKgRnJvbSB0aGUgY29tbWVudCBhYm92ZSBp
dCBzb3VuZHMgbGlrZSB0aGUgZGlzcGxheSBSU0MgaGFuZGxlcyB0aGUgd2FrZXVwCj4+IHByb2dy
YW1taW5nIGluIGhhcmR3YXJlPyBTbyB0aGVyZSBpc24ndCBhIG5lZWQgdG8gYWRkIGEgJ3dha2V1
cCBldmVudCcKPj4gZnJhbWV3b3JrIG9yIGFueXRoaW5nIGxpa2UgdGhhdC4gUGxlYXNlIGNvcnJl
Y3QgbWUgaWYgSSdtIHdyb25nLgo+IAo+IFllcy4gVGhlcmUgaXMgbm8gbmVlZCBmb3IgYW55IGZy
YW1ld29yay4gRnJvbSBSU0MgZHJpdmVyIHBvaW50IG9mIHZpZXcgCj4gdGhlcmUgaXMgYSBuZWVk
IHRvIGRpZmZlcmVudGlhdGUgYXBwc19yc2MgdnMgZGlzcGxheV9yc2MgYXMgU1cgcHJvZ3JhbXMg
Cj4gUERDIHRpbWVyIG9ubHkgaW4gYXBwc19yc2MgY2FzZS4gSG93IGFib3V0IGhhdmluZyBhIGR0
IHByb3BlcnR5IHRvIAo+IGNhcHR1cmUgdGhpcz8KPiAKPiBUaGFua3MsCj4gUmFqdQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
