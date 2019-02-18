Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084F2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:48:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63B82146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PJWAMXs1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="Z+0H+M+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63B82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=14vyif/Ir7nwTdWU33YhOJLX2Yg0dVKtGWG+SdVVJxs=; b=PJWAMXs1tnJxBAt9t8e7AI9O9
	AcrCsE1p9FrJmrGrP02rS+JAvpG59t9+PCazfbqC3fwMeLoOml7/nmL5ZnMgpwnXlKv8BPkwtMKea
	MyLvRTDz5GKp8tjj1FBI2/GlNXZ2//EhfOXxMgJ32INax240jubGVcywTfA/GruNuYOtjnax/082F
	BrP/adu/A35Bto8NuXuR5+9+qEu38/LySkl8rAtVWxIE1w9dOnQsazbBC4YTaR/WoS7Folw9xvNfs
	AxJSTLl/h4BbseitGBKh5NsYSE8COnFe8js8DPxF3c8/MG5dmo/Ry7V1lBBcPjVCC9I8KH+ir06e5
	jElfn/X8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvppW-0006aK-Ao; Mon, 18 Feb 2019 20:47:58 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvppS-0006Zf-RT
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 20:47:56 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id AB922600A1B9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 20:47:53 +0000 (GMT)
X-ASG-Debug-ID: 1550522872-055413126523c600001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id gSkNLJqgwXAG1t6d
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 18 Feb 2019 20:47:52 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BgwzmB/JE0VlXb+1cvqGYSH/CFlD+YLTtMQ2tiudoQY=; b=Z+0H+M+MBfcP9zRCpg7muhhoId
 vQBO8Puq7Dd3oQXbmnLKu8UHjE+ZWo0XC1IOlwBWkvnWrn7WFOo2xkCF4UA6e26zuqYujTGXpJTQF
 DSNAvYXtDWPibyJsNDChr4H991RK8h7X9cAjmHE2tEiugSB6kQy9AzAG6K2ypMMMArNqJA09+VAjt
 uG04wbIAd5FUCt3ht+CgkQsVUF5WiKHC2Dhowmq0WOAapdUw/t4qrmf/X75hW4bt9B5r2e8R0WFYi
 f1FE3P4hI2Cxt0U6gvdc/J3Rv7OUEURX3KzcDbmklcirqdML9kcutQlnyTpwhlYCdgUFLZQxXpUax
 iKzIJtQg==;
Received: from [87.114.170.31] (port=58500 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gvppQ-000Vza-0u; Mon, 18 Feb 2019 20:47:52 +0000
Subject: Re: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add bluetooth
To: Stefan Wahren <stefan.wahren@i2se.com>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
X-ASG-Orig-Subj: Re: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add
 bluetooth
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
 <2003821439.343814.1550437552156@email.ionos.de>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <d5b6ffaf-cf7a-22af-f2fc-c085897ef95f@davidjohnsummers.uk>
Date: Mon, 18 Feb 2019 20:47:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <2003821439.343814.1550437552156@email.ionos.de>
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
X-Barracuda-Start-Time: 1550522872
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 4985
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67543
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_124755_167645_DC22DB5F 
X-CRM114-Status: GOOD (  24.86  )
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
Cc: linux-rockchip@lists.infradead.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTcvMDIvMjAxOSAyMTowNSwgU3RlZmFuIFdhaHJlbiB3cm90ZToKPiBIaSBEYXZpZCwKPgo+
PiBEYXZpZCBTdW1tZXJzIDxiZWFnbGVib2FyZEBkYXZpZGpvaG5zdW1tZXJzLnVrPiBoYXQgYW0g
MTcuIEZlYnJ1YXIgMjAxOSB1bSAxMzoxNSBnZXNjaHJpZWJlbjoKPj4KPj4KPj4gVGhpcyBwYXRj
aCBpcyB0byBhZGQgQmx1ZXRvb3RoIHRvIHRoZSBBU1VTIFRpbmtlciBCb2FyZCAoUykgZGV2aWNl
Cj4+IHRyZWUuCj4+Cj4+IFRoaXMgcGF0Y2ggaXMgbW9yZSBjb250cmF2ZXJzYWwgLSBzbyBwcm9i
YWJseSB2aWV3IGl0IGFzIGEgcmVxdWVzdCBmb3IKPj4gY29tbWVudHMuCj4+Cj4+IFRoZSByZWFz
b24gYmVoaW5kIHRoaXMsIGlzIHRoaXMgcGF0Y2ggZG9lcyBub3QgY3VycmVudGx5IHNldCBCbHVl
dG9vdGgKPj4gd29ya2luZyBvbiB0aGUgdGhlc2UgYm9hcmRzLiBUaGUgcHJvYmxlbSBpcyB0aGF0
IHRoZQo+PiBibHVldG9vdGgvaGNpX2g1LmMgZHJpdmVyLCB0aGF0IGlzIHVzZWQgZm9yIFJlYWx0
ZWsgc2VyaWFsIGRldmljZXMsCj4+IGRlcGVuZHMgb24gQUNQSS4gVW5mb3J0YW50bHkgQUNQSSBj
YW4gbm90IGJlIGVuYWJsZWQgb24gYXJtdjcgbWFjaGluZXMKPj4gc3VjaCBhcyB0aGUgVEIoUyku
IEFuZCBzbyB0aGUga2VybmVsIG1vZHVsZSBmb3IgdGhlIFJUTDg3MjNCUwo+PiBCbHVldG9vdGgg
Y2FuIG5vdCBiZSBsb2FkZWQuCj4+Cj4+IEhvd2V2ZXIgdGhpcyBwYXRjaCBpcyBiZWxpZXZlZCB0
byBiZSBhbiBhY2N1cmF0ZSBkZXNjcmlwdGlvbiBvZiB0aGUKPj4gVGlua2VyIEJvYXJkIChTKSB3
aXJpbmcuIEl0IGlzIHN0cm9uZ2x5IGJhc2VkIG9uIHRoZSBBU1VTIHBhdGNoOgo+Pgo+PiBodHRw
czovL2dpdGh1Yi5jb20vVGlua2VyQm9hcmQvZGViaWFuX2tlcm5lbC9jb21taXQvNmEzMTI4YWRl
MzNmNzU4ODg3MDQ4NTc4YWRhNjFhNGI3YWI4ZTY3OAo+Pgo+PiBBcyB0aGUgQmx1ZXRvb3RoIGlz
IGNvbm5lY3RlZCB2aWEgYSBVQVJUIGFuZCB0aGlzIGlzIHdpcmVkIGludG8gdWFydDAsCj4+IHRo
aXMgaGFzIGJlZW4gZGVzY3JpYmVkIGFzIGEgU2VyRGV2Lgo+Pgo+PiBUaGUgQVNVUyBwYXRjaCBt
ZW50aW9ucyB0aGUgVUFSVF9DVFMsIGJ1dCBub3QgdGhlIF9SVFMuIE5vdyBhcyB0aGUKPj4gUlRM
ODcyM0JTIGhhcyBib3RoIENUUyBhbmQgUlRTIG9uIHRoZSB1YXJ0LCBpdCBoYXMgYmVlbiBhc3N1
bWVkIGJvdGgKPj4gYXJlIHdpcmVkIGludG8gdWFydDAgb24gdGhlIGNwdS4KPiB3aGljaCB3b3Vs
ZCBiZSB2ZXJ5IHN0cmFuZ2UsIGJlY2F1c2Ugd2UgY291bGQgdXNlIEg0IGluc3RlYWQgb2YgSDUu
CgpXZWxsIHRoZSBibHVldG9vdGggbWFpbnRhaW5lciBzYWlkIGl0IHdhcyBoY2lfaDUuCgpUaGUg
ZGV2aWNlIGlzIEJUNC4wIGFuZCB0aGF0IHVuZGVyIFZvbHVtZSA0IEhDSSwgUGFydCBEIC0gMiB3
aXJlIFVBUlQgClRyYW5zcG9ydCBMYXllciwgaW4gc2VjdGlvbiAxMS4yIHNheXMgdGhhdCBIYXJk
d2FyZSBmbG93IGNvbnRyb2wgbWF5IGJlIAp1c2VkLgoKQWxzbyBpZiB5b3UgY2hlY2sgd2hhdCBB
U1VTIGRpZDoKCmh0dHBzOi8vZ2l0aHViLmNvbS9UaW5rZXJCb2FyZC9kZWJpYW5fa2VybmVsL2Nv
bW1pdC81MTA2ZDk0ODZjZjFjMmJhZDRmNzAxNjExZjUxYTUyNjE5MWM1NmFkCgpUaGV5IGFkZGVk
IEg1IGNvZGUgdG8gdGhlIGhjaV9oNC5jLCBzZWVtcyBzdHJhbmdlIGJ1dCB0aGF0cyB3aGF0IHRo
ZXkgCnNhaWQgdGhleSBkaWQuCgpOb3cgbWF5YmUgdGhlIFJUTDg3MjNCUyBjb3VsZCB3b3JrIHdp
dGggdGhlIFVBUlQgVHJhbnNwb3J0IExheWVyLCBidXQgCnRoYXQgaGFzbid0IGJlZW4gZG9uZSB5
ZXQuIDMgd2lyZSBoYXMgc29tZSBvdmVyaGVhZCwgYnV0IGl0IGRvZXNuJ3QgbG9vayAKbGlrZSBt
dWNoLgoKVG8gbXkgbWluZCB0aG91Z2ggaXQgZG93biB0byB0aGUgYmx1ZXRvb3RoIE1haW50YWlu
ZXIgLSBzbyBDQ2luZyBNYXJjZWwgCkhvbHRtYW5uIGluIC4uLgoKCj4+IFRoZSBCbHVldG9vdGgg
Y29ubmVjdGlvbiBoYXMgc2V2ZXJhbCB3YWtlIHVwIHBpbnMgYm90aCBkZXZpY2UgYW5kIGhvc3QK
Pj4gYW5kIGEgcmVzZXQgcGluLiBUaGUgd2lyaW5nIG9mIHRoZXNlIGhhcyBiZWVuIGRlc2NyaWJl
ZDsgaG93ZXZlciBob3cKPj4gdGhlIGtlcm5lbCBkcml2ZXIgd2lsbCB1c2UgdGhlc2UgaXNuJ3Qg
Y2xlYXIuIEUuZy4gc2hvdWxkIEhPU1RfV0FLRSBiZQo+PiBhbiBpbnRlcnVwdD8KPj4KPj4gVGhl
IG1haW4gcmVhc29uIGZvciBhc2tpbmcgZm9yIGNvbW1lbnRzLCBpcyB0aGF0IHdoZW4gaXQgY29t
ZXMgdGltZSB0bwo+PiBtYWtlIHRoZSBjaGFuZ2VzIHRvIHRoZSBibHVldG9vdGggdWFydCBjb2Rl
LCBhbmQgYWRkIGNvbXBhdGlibGUgZmxhZ3MsCj4+IHJvYmggaGFzIGluZGljYXRlZCB0aGF0IHRo
aXMgd2lsbCBvbmx5IGJlIGFjY2VwdGVkIHdpdGggYSB2YWxpZAo+PiBleGFtcGxlLiBTbyB0aGUg
Y29kZSBiZWxvdyBpcyB0aGF0IGV4YW1wbGUuIFNvIEkgd291bGQgbGlrZSBjb21tZW50cwo+PiB0
aGF0IHRoaXMgYXBwcm9hY2ggaXMgdmFsaWQsIHdoaWNoIGNhbiBiZSB1c2VkIHdoZW4gdGhlIGxh
dGVyCj4+IHN1Ym1pc3Npb24gY29tZXMuCj4gQXNraW5nIGZvciBjb21tZW50IHNob3VsZCBiZSBt
YXJrIHdpdGggUkZDIGluIHRoZSBwYXRjaCBzdWJqZWN0LgpPT3BzIG15IG1pc3Rha2UuCj4+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIFN1bW1lcnMgPGJlYWdsZWJvYXJkQGRhdmlkam9obnN1bW1lcnMu
dWs+Cj4+IC0tLQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3JrMzI4OC10aW5rZXIuZHRzaSB8IDEx
ICsrKysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKPj4KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3JrMzI4OC10aW5rZXIuZHRzaSBiL2FyY2gv
YXJtL2Jvb3QvZHRzL3JrMzI4OC10aW5rZXIuZHRzaQo+PiBpbmRleCBlMTc5NmYzNDBlZWYuLjkz
MWI0YzY1MmZkYyAxMDA2NDQKPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvcmszMjg4LXRpbmtl
ci5kdHNpCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JrMzI4OC10aW5rZXIuZHRzaQo+PiBA
QCAtNDgxLDYgKzQ4MSwxNyBAQAo+PiAgIAo+PiAgICZ1YXJ0MCB7Cj4+ICAgCXN0YXR1cyA9ICJv
a2F5IjsKPj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+PiArCXBpbmN0cmwtMCA9IDwm
dWFydDBfeGZlcj4sIDwmdWFydDBfY3RzPiwgPCZ1YXJ0MF9ydHM+Owo+PiArCj4+ICsJYmx1ZXRv
b3RoIHsKPj4gKwkJY2xvY2tzID0gPCZyazgwOCBSSzgwOF9DTEtPVVQxPjsKPiBBcyB3ZSBhbHJl
YWR5IGxpbmtlZCB0aGUgUks4MDggY2xvY2sgaW4gdGhlIHNkaW8gcHdyc2VxLCB3ZSBzaG91bGRu
J3QgZG8gdGhpcyBoZXJlIGFnYWluLgo+Cj4+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvNCBSS19Q
RDUgR1BJT19BQ1RJVkVfTE9XPjsKPiByZXNldC1ncGlvcyBpc24ndCBjb21wYXRpYmxlIHRvIGhj
aV9oNSwgcGxlYXNlIHVzZSBteSBwcmVsaW1pbmFyeSBkdC1iaW5kaW5nCj4KPj4gKwkJZGV2aWNl
LXdha2UtZ3Bpb3MgPSA8JmdwaW80IFJLX1BEMiBHUElPX0FDVElWRV9ISUdIPjsKPj4gKwkJaG9z
dC13YWtlLWdwaW9zID0gPCZncGlvNCBSS19QRDcgR1BJT19BQ1RJVkVfSElHSD47Cj4gQUZBSUsg
aGNpX2g1IGRvZXNuJ3Qgc3VwcG9ydCBob3N0LXdha2UgeWV0LiBTbyBpZiB5b3Ugd2FudCB0byBr
ZWVwIGZvciB0aGUgZnV0dXJlIHdlIHNob3VsZCBtYWtlIGEgY29tbWVudC4KPgo+PiArCQl2Y2Mt
MTgtc3VwcGx5ID0gPCZ2Y2NfMTg+Owo+PiArCQl2Y2MtaW8tc3VwcGx5ID0gPCZ2Y2NfaW8+Owo+
IFBsZWFzZSBkcm9wIHRoZXNlIGFzIHRoZSBkcml2ZXIgZG9lc24ndCB1c2UgaXQgYW5kIGl0J3Mg
YWxyZWFkeSBsaW5rZWQgaW4gdGhlIHNkaW8gcHdyc2VxLgo+Cj4gVGhhbmtzIFN0ZWZhbgo+Cj4+
ICsJfTsKPiBbMV0gLSBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9sYXRlZ29vZGJ5ZS83OWJhYzk5
ZDRmMTE1OGE3MTlhNDhlYTNjNDVlYjdmMSNmaWxlLTAwMDItZHQtYmluZGluZ3MtYWRkLXN1cHBv
cnQtZm9yLXJlYWx0ZWstYmx1ZXRvb3RoLXNlcmlhbC1wYXRjaAoKU29ycnkgSSBkaXNhZ3JlZSBo
ZXJlLgoKTGFzdCB0aW1lIEkgcG9zdGVkIGFuIGV4YW1wbGUgcGF0Y2ggbGlrZSB0aGlzIHJvYmgg
c2FpZCBjbGVhcmx5IHRoYXQgCnRoZXNlIHNob3VsZCBnaXZlIGNsb2NrcywgcG93ZXIsIGV0YzoK
Cmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWJsdWV0b290aC9tc2c3ODU0NS5o
dG1sCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWJsdWV0b290aC9tc2c3ODU4
NS5odG1sIAo8aHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtYmx1ZXRvb3RoL21z
Zzc4NTg1Lmh0bWw+CgphbmQgYXMgaGUgaXMgbWFpbnRhaW5lciBoZSB3aW5zLgoKSSBjYW4gdW5k
ZXJzdGFuZCBSb2JzIHBvc2l0aW9uLCBkZXZpY2UgdHJlZSBhcmUgZm9yIGRlc2NyaWJpbmcgaGFy
ZHdhcmUsIAp0aGV5IGFyZW4ndCBwcmltYXJpbHkgZm9yIGhlbHBpbmcgY29kZSB0byBsb2FkLiBZ
ZXMgdGhhdCBpcyBhIHNlY29uZCAKZWZmZWN0LCBpdHMgc28gaXQga25vd3Mgd2hhdCBpcyBpbsKg
IHRoZSBoYXJkd2FyZS4gSW4gdGhpcyBjYXNlIHdoYXQgaWYgCnNvbWVvbmUgd2FudGVkIEJsdWV0
b290aCwgYnV0IG5vdCBXaUZpIC0gdGhlbiB0aGUgQmx1ZXRvb3RoIHNob3VsZCBrbm93IAp3aGF0
IHBvd2VyIGFuZCBjbG9ja3MgYXJlIG5lZWRlZC4gTm93IHRoYXQgdGhlIGRyaXZlciBkb2Vzbid0
IHVuZGVyc3RhbmQgCnRoZXNlIHRoaW5ncyBpcyBzZWNvbmRhcnkuIE1heWJlIHRoYXQgd2lsbCBi
ZSBjdXJlZCBpbiBmdXR1cmU/CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
