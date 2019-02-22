Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9840C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:10:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82882075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fOzI6rKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u60RQXTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82882075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6/EFTvU4pyYpYKuqWMtxcy/ZpgSAJBMlxcFo7igmhHU=; b=fOzI6rKmJvzE/f
	eGiklac1KvC2sUQ+z/1b/jvIxB9M80kP+WENiravkORmp8MsY6olFm1qewFS1IPqjpLAXjiFk1CSx
	aSXqvfq9UDVa1mJMmQFgnVh4KztowofW8Zm+mCtbz4LzyH8d3RAdsvmOLf4wCAHJxosJ8JGbUcCkB
	hKwVoKn8PcWqGm8FJOOa+ALnxZrCzK/7zbDG1vriBMtCRhNWMlAETi0rcNFw+wUSmMvhJT0Q40iW8
	RUM8Tf85SHU3Xcmrbw6OHp8TjcmKOWL1jJ3/w21TZZ3YWwVexwRyz/WnqmyEd5T3kc+GCyL/1gcfE
	s1lVV1SMH81QJ13bkF3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7mU-0008E6-5A; Fri, 22 Feb 2019 10:10:10 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7mQ-0007RX-Gb
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:10:08 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1MA9kDu109161;
 Fri, 22 Feb 2019 04:09:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550830186;
 bh=apoHTan6JzXHFpHaPCv8g4uTUzEl9U7WoWzQbZC2Obs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=u60RQXTNB2dSIKO6jvg4FdaFHk2BgD97HNOfmsuxowGHPllgv2z4+Fb+0uIkjj8F3
 Q6ZTd65yaJdFPcwoKIas+n75sHxy9wd2xZpHxizKrswzpIiHEAMdeS1Ty7etSN70yT
 IW2BXG4fAqDZUB2s8PiMfRDys83eh16ISUuuscV0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1MA9kLk047704
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Feb 2019 04:09:46 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 22
 Feb 2019 04:09:45 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 22 Feb 2019 04:09:45 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1MA9gLs016416;
 Fri, 22 Feb 2019 04:09:43 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To: Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <41a9780b-d971-2b20-1ecb-c55852292563@ti.com>
 <20190218143508.GD15711@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <69b430b2-42a8-4c5a-0a6c-a05f2416fa0b@ti.com>
Date: Fri, 22 Feb 2019 12:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218143508.GD15711@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_021006_676847_8ABABA02 
X-CRM114-Status: GOOD (  18.53  )
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
Cc: Nishanth Menon <nm@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 marc.zyngier@arm.com, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
 Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxOC8wMi8yMDE5IDE2LjM1LCBUb255IExpbmRncmVuIHdyb3RlOgo+ICogTG9rZXNoIFZ1
dGxhIDxsb2tlc2h2dXRsYUB0aS5jb20+IFsxOTAyMTYgMDM6MzBdOgo+PiBPbiAyLzEyLzIwMTkg
MToxMiBQTSwgTG9rZXNoIFZ1dGxhIHdyb3RlOgo+Pj4gK1RJU0NJIEludGVycnVwdCBSb3V0ZXIg
Tm9kZToKPj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+PiArLSBjb21wYXRpYmxl
OgkJTXVzdCBiZSAidGksc2NpLWludHIiLgo+Pj4gKy0gaW50ZXJydXB0LWNvbnRyb2xsZXI6CUlk
ZW50aWZpZXMgdGhlIG5vZGUgYXMgYW4gaW50ZXJydXB0IGNvbnRyb2xsZXIKPj4+ICstICNpbnRl
cnJ1cHQtY2VsbHM6CVNwZWNpZmllcyB0aGUgbnVtYmVyIG9mIGNlbGxzIG5lZWRlZCB0byBlbmNv
ZGUgYW4KPj4+ICsJCQlpbnRlcnJ1cHQgc291cmNlLiBUaGUgdmFsdWUgc2hvdWxkIGJlIDQuCj4+
PiArCQkJRmlyc3QgY2VsbCBzaG91bGQgY29udGFpbiB0aGUgVElTQ0kgZGV2aWNlIElEIG9mIHNv
dXJjZQo+Pj4gKwkJCVNlY29uZCBjZWxsIHNob3VsZCBjb250YWluIHRoZSBpbnRlcnJ1cHQgc291
cmNlIG9mZnNldAo+Pj4gKwkJCXdpdGhpbiB0aGUgZGV2aWNlCj4+PiArCQkJVGhpcmQgY2VsbCBz
cGVjaWZpZXMgdGhlIHRyaWdnZXIgdHlwZSBhcyBkZWZpbmVkCj4+PiArCQkJaW4gaW50ZXJydXB0
cy50eHQgaW4gdGhpcyBkaXJlY3RvcnkuCj4+PiArCQkJRm91cnRoIGNlbGwgc2hvdWxkIGJlIDEg
aWYgdGhlIGlycSBpcyBjb21pbmcgZnJvbQo+Pj4gKwkJCWludGVycnVwdCBhZ2dyZWdhdG9yIGVs
c2UgMC4KPj4+ICstIHRpLHNjaToJCVBoYW5kbGUgdG8gVEktU0NJIGNvbXBhdGlibGUgU3lzdGVt
IGNvbnRyb2xsZXIgbm9kZS4KPj4+ICstIHRpLHNjaS1kc3QtaWQ6CVRJU0NJIGRldmljZSBJRCBv
ZiB0aGUgZGVzdGluYXRpb24gSVJRIGNvbnRyb2xsZXIuCj4+Cj4+IFBsZWFzZSBoZWxwIG1lIGhl
cmUuIEFzIHNhaWQgdGhpcyBpcyB0aGUgVElTQ0kgZGV2aWNlIGlkIGZvciB0aGUgaG9zdAo+PiBp
bnRlcnJ1cHQgY29udHJvbGxlci4gV2hpbGUgc2VuZGluZyBtZXNzYWdlIHRvIHRoZSBzeXN0ZW0g
Y28tcHJvY2Vzc29yCj4+IHRoaXMgSUQgbmVlZHMgdG8gYmUgc3BlY2lmaWVkIHNvIHRoYXQgdGhl
IGlycSByb3V0ZSBnZXRzIGRpc2NvdmVyZWQgYW5kCj4+IGNvbmZpZ3VyZWQuIEF0bGVhc3Qgd2l0
aCB0aGUgY3VycmVudCBkZXNpZ24gZGV2aWNlIElkcyBhcmUgbm90Cj4+IGRpc2NvdmVyYWJsZS4g
Q2FuIHlvdSBtZW50aW9uIHdoYXQgY2FuIGJlIGltcHJvdmVkIGhlcmU/IElzIHRoZXJlIGFueQo+
PiBzdWNoIGV4YW1wbGUgd2hlcmUgYSBmaXJtd2FyZSBzdXBwb3J0cyBxdWVyeWluZyB0aGUgZGVp
dmNlIGlkcz8KPj4KPj4gQWxzbyBkbyB5b3UgaGF2ZSBhbnkgZnVydGhlciBjb21tZW50cyBvbiB0
aGlzIHBhdGNoPwo+IAo+IE5vIHJlZyBwcm9wZXJ0eSBhYm92ZS4gU28gaWYgdGhlIGludGVycnVw
dCByb3V0ZXIgaXMgbm90IGFjY2Vzc2libGUKPiBieSBMaW51eCBsaWtlIHlvdSdyZSBzYXlpbmcs
IHlvdSBzaG91bGQgbm90IHNldCB1cCBhIGR0cyBub2RlIGZvcgo+IGl0IGF0IGFsbC4KCkl0IGlz
IGFjY2Vzc2libGUgdmlhIHRpc2NpIGJ1dCBubyBkaXJlY3QgcmVnaXN0ZXIgYWNjZXNzLgoKPiAK
PiBSZWdhcmRzLAo+IAo+IFRvbnkKPiAKCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5s
YW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5l
c3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
