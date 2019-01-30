Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0540EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:23:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F4D20833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFljvHFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F4D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZJHdLu1Q1zbYPyb4bjrM4VbxZLNRqCtB3/JM70iL9vw=; b=BFljvHFzLa/2WM
	7yYdKduDhBCGBYuVQLGo7JJt2vTHKjMVGHCW5m4OEPOvM7VarUe4e7XxhKi1fM5FUDntAo6DgRsuu
	WnDfPpzni8WRgZkFfU2Y/1Vp4uoGFMTxHoo+TZOhRJ/NDqP6mopoj3XBMzGVPjbTA3pzIVBp5oTby
	cOuikaYynovKnbP1WxR4hTiWMa3ciGcAcsoQbklhaWyCjHJG9eMLmwcXMlz4ynUT0hrvi8CZOlxgg
	VGgTXFNhWlMQp9Fofiv2sDy1xDkaEQRvLg44mYfD+pAgf9T2ZxWAQJbO9uhE8KxVsI64Bk4qFQetD
	cuG3jvmADvptn+hEtcVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon1m-0005cg-KM; Wed, 30 Jan 2019 10:23:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon1d-0005ZA-2u
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:23:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC5EA78;
 Wed, 30 Jan 2019 02:23:20 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2B1C3F59C;
 Wed, 30 Jan 2019 02:23:17 -0800 (PST)
Date: Wed, 30 Jan 2019 10:23:13 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 6/7] arm64: dts: juno: Add cpu dynamic-power-coefficient
 information
Message-ID: <20190130102311.6ayym7bbo4lvlezl@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-7-quentin.perret@arm.com>
 <20190129152735.GA24772@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129152735.GA24772@e107155-lin>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022321_196003_25051437 
X-CRM114-Status: GOOD (  18.18  )
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
Cc: mark.rutland@arm.com, rjw@rjwysocki.net, nm@ti.com,
 lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, mka@chromium.org, linux-pm@vger.kernel.org,
 liviu.dudau@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlc2RheSAyOSBKYW4gMjAxOSBhdCAxNToyNzozNSAoKzAwMDApLCBTdWRlZXAgSG9sbGEg
d3JvdGU6Cj4gT24gTW9uLCBKYW4gMjgsIDIwMTkgYXQgMDQ6NTU6MjFQTSArMDAwMCwgUXVlbnRp
biBQZXJyZXQgd3JvdGU6Cj4gPiBGcm9tOiBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2Vt
YW5uQGFybS5jb20+Cj4gPgo+ID4gQSBDUFVmcmVxIGRyaXZlciwgbGlrZSB0aGUgc2NwaSBkcml2
ZXIgdXNlZCBvbiBKdW5vIGJvYXJkcywgd2hpY2gKPiA+IHByb3ZpZGUgdGhlIEVuZXJneSBNb2Rl
bCB3aXRoIHBvd2VyIGNvc3QgaW5mb3JtYXRpb24gdmlhIHRoZSBQTV9PUFAKPiA+IG9mX2Rldl9w
bV9vcHBfZ2V0X2NwdV9wb3dlcigpIGZ1bmN0aW9uLCBkbyBuZWVkIHRoZQo+ID4gZHluYW1pYy1w
b3dlci1jb2VmZmljaWVudCAoQykgaW4gdGhlIGRldmljZSB0cmVlLgo+ID4KPiA+IE1ldGhvZCB1
c2VkIHRvIG9idGFpbiB0aGUgQyB2YWx1ZToKPiA+IEMgaXMgY29tcHV0ZWQgYnkgbWVhc3VyaW5n
IGVuZXJneSAoRSkgY29uc3VtcHRpb24gb2YgYSBmcmVxdWVuY3kgZG9tYWluCj4gPiAoRkQpIG92
ZXIgYSAxMHMgcnVudGltZSAodCkgc3lzYmVuY2ggd29ya2xvYWQgcnVubmluZyBhdCBlYWNoIE9w
ZXJhdGluZwo+ID4gUGVyZm9ybWFuY2UgUG9pbnQgKE9QUCkgYWZmaW5lIHRvIDEgb3IgMiBDUFVz
IG9mIHRoYXQgRkQgd2hpbGUgdGhlIG90aGVyCj4gPiBDUFVzIG9mIHRoZSBzeXN0ZW0gYXJlIGhv
dHBsdWdnZWQgb3V0Lgo+ID4gQnkgZGVmaW5pdGlvbiBhbGwgQ1BVcyBvZiBhIEZEIGhhdmUgdGhl
IHRoZSBzYW1lIG1pY3JvLWFyY2hpdGVjdHVyZS4gQW4KPiA+IE9QUCBpcyBjaGFyYWN0ZXJpemVk
IGJ5IGEgY2VydGFpbiBmcmVxdWVuY3kgKGYpIGFuZCB2b2x0YWdlIChWKSB2YWx1ZS4KPiA+IFRo
ZSBjb3JyZXNwb25kaW5nIHBvd2VyIHZhbHVlcyAoUCkgYXJlIGNhbGN1bGF0ZWQgYnkgZGl2aWRp
bmcgdGhlIGRlbHRhCj4gPiBvZiB0aGUgRSB2YWx1ZXMgYmV0d2VlbiB0aGUgcnVucyB3aXRoIDIg
YW5kIDEgQ1BVcyBieSB0Lgo+ID4KPiA+IFdpdGggbiBkYXRhIHR1cGxlcyAoUCwgZiwgViksIG4g
ZXF1YWwgdG8gbnVtYmVyIG9mIE9QUHMgZm9yIHRoaXMKPiA+IGZyZXF1ZW5jeSBkb21haW4sIHdl
IGNhbiBzb2x2ZSBDIGJ5Ogo+ID4KPiA+IFAgPSBQc3RhdCArIFBkeW4KPiA+Cj4gPiBQID0gUHN0
YXQgKyBDVsKyZgo+ID4KPiA+IEN4ID0gKFB4IC0gUDEpLyhWeMKyZnggLSBWMcKyZjEpIHdpdGgg
eCA9IHsyLCAuLi4sIG59Cj4gPgo+ID4gVGhlIEMgdmFsdWUgaXMgdGhlIGFyaXRobWV0aWMgbWVh
biBvdXQgb2Yge0MyLCAuLi4sIENufS4KPiA+Cj4gPiBTaW5jZSBEVkZTIGlzIGJyb2tlbiBvbiBK
dW5vIHIxLCBubyBkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50Cj4gPiBpbmZvcm1hdGlvbiBoYXMg
YmVlbiBhZGRlZCB0byBpdHMgZHRzIGZpbGUuCj4gPgo+IAo+IFNpbmNlIHRoZSBiaW5kaW5nIGZv
ciAiZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCIgcHJvcGVydHkgYWxyZWFkeSBleGlzdCwKPiBh
bmQgSSBkb24ndCBzZWUgYW55IGRlcGVuZGVuY3kgZm9yIHRoaXMgYW5kIHRoZSBuZXh0IHBhdGNo
KFRDMikgb24gdGhpcwo+IHNlcmllcywgSSB3aWxsIGFwcGx5IHRoZW0uIFBsZWFzZSBzaG91dCBp
ZiBmb3IgYW55IHJlYXNvbiB0aGF0J3Mgbm90IHRydWUuCgpUaGFua3MgU3VkZWVwICEKUXVlbnRp
bgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
