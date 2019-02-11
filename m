Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC152C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:46:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6652070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j8EuVSES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6652070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2VDLU4SL88WLCegiRLCUnsLXdkFIDBeiXAMLF504jd0=; b=j8EuVSESVqqP5e
	amge3HUGYsgWkmGQDJ/ixgo+ofL0dUTMrCU1UfhysR9YT4VRz+7zAJqjyp4EXyPso96Iuc3zEz0If
	ySeUJ95fmlsYOvt/ErLl9InqZnR0TQgS++4GkEZDtc1ziNydiU8AQ1Zv9/P0MEBW3DpnW7qyitBLO
	AeXdeuHsbl0JAroYWjRjCGLvcVFaWiNpkn8p6MHJS7WMVYQkeaxf/X6Kz4g9GdjAHmHUrwqM3YQsr
	65BkClo9ByD/8LvKcxzB0hAKyR5QFyBmoRmagguVK0pXIanqBC/+raqf25bVBsym0up0LH3KIhDml
	m7533rs/NFVBeGZdv12Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtA2R-0004SP-3c; Mon, 11 Feb 2019 11:46:15 +0000
Received: from [179.182.217.237] (helo=quaco.ghostprotocols.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtA2O-0004Rw-Uy; Mon, 11 Feb 2019 11:46:13 +0000
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 58D2340ECC; Mon, 11 Feb 2019 08:46:03 -0300 (-03)
Date: Mon, 11 Feb 2019 08:46:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] perf tools: Add proper header file for symbols
Message-ID: <20190211114603.GA3269@kernel.org>
References: <20190208223543.31836-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190208223543.31836-1-mathieu.poirier@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: suzuki.poulose@arm.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, jolsa@redhat.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RW0gRnJpLCBGZWIgMDgsIDIwMTkgYXQgMDM6MzU6NDNQTSAtMDcwMCwgTWF0aGlldSBQb2lyaWVy
IGVzY3JldmV1Ogo+IEFmdGVyICdjb21taXQgZTIyYzFjNzUxMTQwICgicGVyZiB0aHJlYWQ6IERv
bid0IGluY2x1ZGUgc3ltYm9sLmgsCj4gc3ltYm9sX2NvbmYuaCBpcyBlbm91Z2giKScKPiAKPiBD
b21waWxhdGlvbiBvZiB0aGUgcGVyZiB0b29scyBpcyBicm9rZW4gd2hlbiB1c2luZyB0aGUgZnVu
Y3Rpb25hbGl0eQo+IHByb3ZpZGVkIGJ5IHRoZSBvcGVuQ1NEIGxpYnJhcnk6Cj4gCj4gWy4uLl0K
PiAKPiAuLi4gICAgICAgICAgICAgICAgICAgICAgIHRpbWVyZmQ6IFsgb24gIF0KPiAuLi4gICAg
ICAgICAgICAgICAgICBzY2hlZF9nZXRjcHU6IFsgb24gIF0KPiAuLi4gICAgICAgICAgICAgICAg
ICAgICAgICAgICBzZHQ6IFsgT0ZGIF0KPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgc2V0
bnM6IFsgb24gIF0KPiAuLi4gICAgICAgICAgICAgICAgICAgIGxpYm9wZW5jc2Q6IFsgb24gIF0K
PiAKPiBbLi4uXQo+IAo+ICAgQ0MgICAgICAgdXRpbC9hcm0tc3BlLm8KPiAgIENDICAgICAgIHV0
aWwvYXJtLXNwZS1wa3QtZGVjb2Rlci5vCj4gICBDQyAgICAgICB1dGlsL3MzOTAtY3B1bXNmLm8K
PiAgIENDICAgICAgIHV0aWwvY3MtZXRtLm8KPiAgIENDICAgICAgIHV0aWwvcGFyc2UtYnJhbmNo
LW9wdGlvbnMubwo+IHV0aWwvY3MtZXRtLmM6IEluIGZ1bmN0aW9uIOKAmGNzX2V0bV9fbWVtX2Fj
Y2Vzc+KAmToKPiB1dGlsL2NzLWV0bS5jOjI5NzoyNDogZXJyb3I6IHN0b3JhZ2Ugc2l6ZSBvZiDi
gJhhbOKAmSBpc27igJl0IGtub3duCj4gICBzdHJ1Y3QgIGFkZHJfbG9jYXRpb24gYWw7Cj4gCj4g
QW5kIHJpZ2h0bHkgc28gc2luY2UgZmlsZSBjcy1ldG0uYyBkb2Vzbid0IGluY2x1ZGUgc3ltYm9s
LmgsIHNvbWV0aGluZwo+IHRoYXQgaXMgcmVjdGlmaWVkIGluIHRoaXMgcGF0Y2guCgpUaGFua3Ms
IEknbGwgbWFrZSBzdXJlIHRoZSBvcGVuQ1NEIGxpYnJhcnkgaXMgcHJlc2VudCBpbiBvbmUgb2Yg
bXkKY29udGFpbmVycyBkb2luZyBhcm02NCBjcm9zcyBidWlsZHMgc28gdGhhdCB0aGlzIGdldHMg
Y2F1Z2h0IGluIHRoZQpmdXR1cmUuCgotIEFybmFsZG8KIAo+IFNpZ25lZC1vZmYtYnk6IE1hdGhp
ZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+Cj4gLS0tCj4gIHRvb2xzL3Bl
cmYvdXRpbC9jcy1ldG0uYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
PiAKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2NzLWV0bS5jIGIvdG9vbHMvcGVyZi91
dGlsL2NzLWV0bS5jCj4gaW5kZXggOGIzZjg4MmQ2ZTJmLi4wYjExZDY1M2NmYmUgMTAwNjQ0Cj4g
LS0tIGEvdG9vbHMvcGVyZi91dGlsL2NzLWV0bS5jCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2Nz
LWV0bS5jCj4gQEAgLTI1LDYgKzI1LDcgQEAKPiAgI2luY2x1ZGUgIm1hY2hpbmUuaCIKPiAgI2lu
Y2x1ZGUgIm1hcC5oIgo+ICAjaW5jbHVkZSAicGVyZi5oIgo+ICsjaW5jbHVkZSAic3ltYm9sLmgi
Cj4gICNpbmNsdWRlICJ0aHJlYWQuaCIKPiAgI2luY2x1ZGUgInRocmVhZF9tYXAuaCIKPiAgI2lu
Y2x1ZGUgInRocmVhZC1zdGFjay5oIgo+IC0tIAo+IDIuMTcuMQoKLS0gCgotIEFybmFsZG8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
