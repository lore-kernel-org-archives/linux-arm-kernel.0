Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:19:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C60821720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RNCM4cY9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEnARfrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C60821720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qcMhA//1SnrbUgUHgTKsYctBd1wUAVxdMOFDcmrAnk0=; b=RNCM4cY9Hdd1T4
	zECc5/P8UdGThAeZAH7Bm7pRLwVjq5Nyn0YzlRhEVlwuFh5J303F4yRgr7J/wX2+D1rhEORSsghFl
	XRlUfabkWYRgAeJR3ZKgzh5lWqjs7iYFND3pZqAh568GguRlbXhaxXOsOZ+LxGnSCyArYRGHIej9i
	a3E8hz5bqLK7/SyzpqQ6LeUERNl7hfWtfElAsmMYwpU7ciabTZz3fTemFMAX8IkxiIj4Yrdgz3Gc0
	0wNMyRG2q0OfAzVdX7yHP7KImZPn92RSXQ1PgDEP6Nql1SwdRwWo+IqxAanPAzKoKyhgBYlF6BEan
	i7tWjVP2oifPueucW9PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzAr-0002M1-DY; Thu, 20 Dec 2018 14:19:41 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzAo-0002Ki-0F
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 14:19:40 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so1945741wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Hq5fNvnqcKLZYKprqkFMFjWqTZS/AiLTdVGUsHsuR8c=;
 b=aEnARfrRojPdKsQyHVTrmsOAbJWqTAaLrlOEb8nUgjsrKcHOoFWwyr7SeEIQumz11d
 0ibw4KZA/OD+/YQHPY4ZROW9oMUT0cPGR2AnMm1e85Cd/jjSp+Hbq/qp7xJE6Mr5ynyd
 tSO1CgMX6RSlXUUvn+cgzvzH9xT76fFJKDHwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hq5fNvnqcKLZYKprqkFMFjWqTZS/AiLTdVGUsHsuR8c=;
 b=JCbAWWtky7t0TY1YrdrAzbg3a/uXxp7rzm01ytjKCw6Wd4E5xzFNoUVsSNHJKXUz7p
 V5Rdb1Lvrxf0y2h9QgAKa00+5QwQQB6fYvtlORb6XgO47fwSAAjO0M6nrOT+5AC+/4kO
 n5Ui6d1Dr1Shv0Vo7TUlFJY2A0pDlb2Hylby5hU05A4XLaMXkN481bW4f3fUtRtoEy2Q
 SMLABOaXEGvS3/g8FIeuF04+ORbXb14PkfB/DvI1hSTIpeIXmh4JIBo1JtL68iv8tg1S
 Aguv5B8iGjXzX2jrV3QRiEPQQQf0l4C+BHL6ewQuZ85vlm5UbI404fLLgy3niGpWkOey
 DYug==
X-Gm-Message-State: AA+aEWZ3b6ZEjxwcEKZlTi9IbLOa+52SOVnfxV3TVzSBH1yNWynD2aZz
 /eF7v4Q12amosHqRBRQg40oCQA==
X-Google-Smtp-Source: AFSGD/X01KB/Wa9mN5zcuhWpx8jI3g8+zWAoQUQvBzzGLN2WfFGxkDWqPSUAxQN4JcCJs+h0LHKA0A==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr24704743wrn.185.1545315565566; 
 Thu, 20 Dec 2018 06:19:25 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
 by smtp.googlemail.com with ESMTPSA id h129sm18428162wma.0.2018.12.20.06.19.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 06:19:24 -0800 (PST)
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
Date: Thu, 20 Dec 2018 15:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-18-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_061938_044892_FC222DEF 
X-CRM114-Status: GOOD (  29.56  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gRm9sbG93aW5nIGNoYW5n
ZXMgYXJlIGFib3V0IHRvIGltcGxlbWVudCBzdXBwb3J0IGZvciBQTSBkb21haW5zIHRvIFBTQ0ku
Cj4gVGhvc2UgY2hhbmdlcyBhcmUgbWFpbmx5IGdvaW5nIHRvIGJlIGltcGxlbWVudGVkIGluIGEg
bmV3IHNlcGFyYXRlIGZpbGUsCj4gaGVuY2UgYSBjb3VwbGUgb2YgdGhlIGludGVybmFsIFBTQ0kg
ZnVuY3Rpb25zIG5lZWRzIHRvIGJlIHNoYXJlZCB0byBiZQo+IGFjY2Vzc2libGUuIFNvLCBsZXQn
cyBkbyB0aGF0IHZpYSBhZGRpbmcgbmV3IFBTQ0kgaGVhZGVyIGZpbGUuCj4gCj4gTW9yZW92ZXIs
IHRoZSBjaGFuZ2VzIGRlcGxveWluZyBzdXBwb3J0IGZvciBQTSBkb21haW5zLCBuZWVkcyB0byBi
ZSBhYmxlIHRvCj4gc3dpdGNoIHRoZSBQU0NJIEZXIGludG8gdGhlIE9TIGluaXRpYXRlZCBtb2Rl
LiBGb3IgdGhhdCByZWFzb24sIGxldCdzIGFkZCBhCj4gbmV3IGZ1bmN0aW9uIHRoYXQgZGVhbHMg
d2l0aCB0aGlzIGFuZCBzaGFyZSBpdCB2aWEgdGhlIG5ldyBQU0NJIGhlYWRlcgo+IGZpbGUuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+Cj4g
LS0tCj4gCj4gQ2hhbmdlcyBpbiB2MTA6Cj4gCS0gTmV3IHBhdGNoLiBSZS1wbGFjZXMgdGhlIGVh
cmxpZXIgcGF0Y2g6ICJkcml2ZXJzOiBmaXJtd2FyZTogcHNjaToKPiAJICBTaGFyZSBhIGZldyBp
bnRlcm5hbCBQU0NJIGZ1bmN0aW9ucyIuCj4gCj4gLS0tCj4gIGRyaXZlcnMvZmlybXdhcmUvcHNj
aS9wc2NpLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gIGRyaXZlcnMvZmly
bXdhcmUvcHNjaS9wc2NpLmggfCAxNCArKysrKysrKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQs
IDM1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5oCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmly
bXdhcmUvcHNjaS9wc2NpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jCj4gaW5kZXgg
OGRiY2RlY2MyYWU0Li42MjM1OTFiNTQxYTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9maXJtd2Fy
ZS9wc2NpL3BzY2kuYwo+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmMKPiBAQCAt
MzQsNiArMzQsOCBAQAo+ICAjaW5jbHVkZSA8YXNtL3NtcF9wbGF0Lmg+Cj4gICNpbmNsdWRlIDxh
c20vc3VzcGVuZC5oPgo+ICAKPiArI2luY2x1ZGUgInBzY2kuaCIKPiArCj4gIC8qCj4gICAqIFdo
aWxlIGEgNjQtYml0IE9TIGNhbiBtYWtlIGNhbGxzIHdpdGggU01DMzIgY2FsbGluZyBjb252ZW50
aW9ucywgZm9yIHNvbWUKPiAgICogY2FsbHMgaXQgaXMgbmVjZXNzYXJ5IHRvIHVzZSBTTUM2NCB0
byBwYXNzIG9yIHJldHVybiA2NC1iaXQgdmFsdWVzLgo+IEBAIC05MCwyMyArOTIsMzUgQEAgc3Rh
dGljIHUzMiBwc2NpX2Z1bmN0aW9uX2lkW1BTQ0lfRk5fTUFYXTsKPiAgc3RhdGljIERFRklORV9Q
RVJfQ1BVKHUzMiwgZG9tYWluX3N0YXRlKTsKPiAgc3RhdGljIHUzMiBwc2NpX2NwdV9zdXNwZW5k
X2ZlYXR1cmU7Cj4gIAo+IC1zdGF0aWMgaW5saW5lIHUzMiBwc2NpX2dldF9kb21haW5fc3RhdGUo
dm9pZCkKPiArdTMyIHBzY2lfZ2V0X2RvbWFpbl9zdGF0ZSh2b2lkKQo+ICB7Cj4gIAlyZXR1cm4g
X190aGlzX2NwdV9yZWFkKGRvbWFpbl9zdGF0ZSk7Cj4gIH0KPgo+IC1zdGF0aWMgaW5saW5lIHZv
aWQgcHNjaV9zZXRfZG9tYWluX3N0YXRlKHUzMiBzdGF0ZSkKPiArdm9pZCBwc2NpX3NldF9kb21h
aW5fc3RhdGUodTMyIHN0YXRlKQo+ICB7Cj4gIAlfX3RoaXNfY3B1X3dyaXRlKGRvbWFpbl9zdGF0
ZSwgc3RhdGUpOwo+ICB9Cj4gIAo+ICtib29sIHBzY2lfc2V0X29zaV9tb2RlKHZvaWQpCj4gK3sK
PiArCWludCByZXQ7Cj4gKwo+ICsJcmV0ID0gaW52b2tlX3BzY2lfZm4oUFNDSV8xXzBfRk5fU0VU
X1NVU1BFTkRfTU9ERSwKPiArCQkJUFNDSV8xXzBfU1VTUEVORF9NT0RFX09TSSwgMCwgMCk7Cj4g
KwlpZiAocmV0KQo+ICsJCXByX3dhcm4oImZhaWxlZCB0byBlbmFibGUgT1NJIG1vZGU6ICVkXG4i
LCByZXQpOwo+ICsKPiArCXJldHVybiAhcmV0Owo+ICt9CgpQbGVhc2Uga2VlcCB0aGUgY29udmVu
dGlvbiB3aXRoIHRoZSBlcnJvciBjb2RlICgwID0+IHN1Y2Nlc3MpCgpJbiB0aGUgbmV4dCBwYXRj
aCBpdCBjYW4gYmUgY2FsbGVkOgoKaWYgKHBzY2lfaGFzX29zaV9zdXBwb3J0KCkpCglvc2lfbW9k
ZV9lbmFibGVkID0gcHNjaV9zZXRfb3NpX21vZGUoKSA/IGZhbHNlIDogdHJ1ZTsKCj4gKwo+ICBz
dGF0aWMgaW5saW5lIGJvb2wgcHNjaV9oYXNfZXh0X3Bvd2VyX3N0YXRlKHZvaWQpCj4gIHsKPiAg
CXJldHVybiBwc2NpX2NwdV9zdXNwZW5kX2ZlYXR1cmUgJgo+ICAJCQkJUFNDSV8xXzBfRkVBVFVS
RVNfQ1BVX1NVU1BFTkRfUEZfTUFTSzsKPiAgfQo+ICAKPiAtc3RhdGljIGlubGluZSBib29sIHBz
Y2lfaGFzX29zaV9zdXBwb3J0KHZvaWQpCj4gK2Jvb2wgcHNjaV9oYXNfb3NpX3N1cHBvcnQodm9p
ZCkKPiAgewo+ICAJcmV0dXJuIHBzY2lfY3B1X3N1c3BlbmRfZmVhdHVyZSAmIFBTQ0lfMV8wX09T
X0lOSVRJQVRFRDsKPiAgfQo+IEBAIC0yODUsMTAgKzI5OSw3IEBAIHN0YXRpYyBpbnQgX19pbml0
IHBzY2lfZmVhdHVyZXModTMyIHBzY2lfZnVuY19pZCkKPiAgCQkJICAgICAgcHNjaV9mdW5jX2lk
LCAwLCAwKTsKPiAgfQo+ICAKPiAtI2lmZGVmIENPTkZJR19DUFVfSURMRQo+IC1zdGF0aWMgREVG
SU5FX1BFUl9DUFVfUkVBRF9NT1NUTFkodTMyICosIHBzY2lfcG93ZXJfc3RhdGUpOwo+IC0KPiAt
c3RhdGljIGludCBwc2NpX2R0X3BhcnNlX3N0YXRlX25vZGUoc3RydWN0IGRldmljZV9ub2RlICpu
cCwgdTMyICpzdGF0ZSkKPiAraW50IHBzY2lfZHRfcGFyc2Vfc3RhdGVfbm9kZShzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wLCB1MzIgKnN0YXRlKQo+ICB7Cj4gIAlpbnQgZXJyID0gb2ZfcHJvcGVydHlf
cmVhZF91MzIobnAsICJhcm0scHNjaS1zdXNwZW5kLXBhcmFtIiwgc3RhdGUpOwo+ICAKPiBAQCAt
MzA1LDYgKzMxNiw5IEBAIHN0YXRpYyBpbnQgcHNjaV9kdF9wYXJzZV9zdGF0ZV9ub2RlKHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnAsIHUzMiAqc3RhdGUpCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiAr
I2lmZGVmIENPTkZJR19DUFVfSURMRQoKSXQgd291bGQgYmUgbmljZXIgaWYgeW91IGNhbiByZW1v
dmUgdGhlIENPTkZJR19DUFVfSURMRSBieSByZXBsYWNpbmcgaXQKd2l0aCBhIHNwZWNpZmljIG9u
ZSAoZWcuIENPTkZJR19QU0NJX0lETEUpIGFuZCBtYWtlIGl0IGRlcGVuZCBvbgpDT05GSUdfQ1BV
X0lETEUsIHNvIHRoZSBjb25maWcgb3B0aW9ucyBzdGF5IGNvbnRhaW5lZCBpbiB0aGVpcgpyZXNw
ZWN0aXZlIHN1YnN5c3RlbXMgZGlyZWN0b3J5LgoKPiArc3RhdGljIERFRklORV9QRVJfQ1BVX1JF
QURfTU9TVExZKHUzMiAqLCBwc2NpX3Bvd2VyX3N0YXRlKTsKPiArCj4gIHN0YXRpYyBpbnQgcHNj
aV9kdF9jcHVfaW5pdF9pZGxlKHN0cnVjdCBjcHVpZGxlX2RyaXZlciAqZHJ2LAo+ICAJCQlzdHJ1
Y3QgZGV2aWNlX25vZGUgKmNwdV9ub2RlLCBpbnQgY3B1KQo+ICB7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmggYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5o
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLjdkOWQzOGZkNTdl
MQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5oCj4g
QEAgLTAsMCArMSwxNCBAQAo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAq
Lwo+ICsKPiArI2lmbmRlZiBfX1BTQ0lfSAo+ICsjZGVmaW5lIF9fUFNDSV9ICj4gKwo+ICtzdHJ1
Y3QgZGV2aWNlX25vZGU7Cj4gKwo+ICtib29sIHBzY2lfc2V0X29zaV9tb2RlKHZvaWQpOwo+ICt1
MzIgcHNjaV9nZXRfZG9tYWluX3N0YXRlKHZvaWQpOwo+ICt2b2lkIHBzY2lfc2V0X2RvbWFpbl9z
dGF0ZSh1MzIgc3RhdGUpOwo+ICtib29sIHBzY2lfaGFzX29zaV9zdXBwb3J0KHZvaWQpOwo+ICtp
bnQgcHNjaV9kdF9wYXJzZV9zdGF0ZV9ub2RlKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHUzMiAq
c3RhdGUpOwo+ICsKPiArI2VuZGlmIC8qIF9fUFNDSV9IICovCj4gCgoKLS0gCiA8aHR0cDovL3d3
dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFS
TSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xp
bmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRl
ciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
