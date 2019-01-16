Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31352C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:19:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8252082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="njkNWurc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BlTGINMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8252082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aKqsJIAkxGxDAnteD8IlpWONDlQmYP9qOYoHH/bTUbw=; b=njkNWurcFqvfDP
	AYF0nejeT5Sps2tP4lOtIOEo/JU5FAltrXZcUNQy+9lfyJaL0y3eDhGK3JaBPjC1dHv0JjRc89CWR
	SD4+icHIygclh2us/LAUiMGBgHO14T8p/2poSSYqbrk7JfskeMmdqL4G9pV0TOEsEWJSIEFSXsxS9
	vz/GoMwKC5pcZuaR4ge7PzPnB+c2zuMRQYmlBDDUAvTW0VwItYKT2oy4n3o9qDqyM48qqmPQ1PVvU
	jhdMVI7HPWUeitld3Vb//ptfx548CHx/DxNQ5g3xrIyvEbDEOpJIbelb4+EA2ZVRDOylWR4IwSEuS
	PMEL+JmCOz8/O34K0seA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhLs-0004aJ-Fk; Wed, 16 Jan 2019 09:19:12 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhLp-0004Zx-V0
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:19:11 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G9IqXY019762;
 Wed, 16 Jan 2019 03:18:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547630332;
 bh=ryocyKXPtCgerhuVhjnNWhnqnxSZKI0umfj2tX6E/Pk=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=BlTGINMXH7kUtm5oTXnsACSl7Ge8jzeBE2p3CQ9/OExR8/2Q3ty9Uge+iPxuHfyzK
 PLkMhuL9nk2VQzmPJ+CU/PHEkYi4pIdrFfsIEOXn3OrrA/rKUrDe2oAuWhvCscaBn7
 b7clZ8QFygF1PBQFzGjoXtht6ZzJsLg1yhhqTAzc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G9Iqlc100133
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 03:18:52 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 03:18:52 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 03:18:52 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G9ImSb027223;
 Wed, 16 Jan 2019 03:18:49 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
 <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
Date: Wed, 16 Jan 2019 14:48:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_011910_100235_CABD96AD 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTQvMDEvMTkgMTA6MDkgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6Cj4gcG9uLiwg
MTQgc3R5IDIwMTkgbyAxMzoyMCBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5hcGlzYcWC
KGEpOgo+Pgo+PiBIaSBCYXJ0b3N6LAo+Pgo+PiBPbiAxMS8wMS8xOSAxMDo1MSBQTSwgQmFydG9z
eiBHb2xhc3pld3NraSB3cm90ZToKPj4+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xh
c3pld3NraUBiYXlsaWJyZS5jb20+Cj4+Pgo+Pj4gQ3VycmVudGx5IHRoZSBjbG9ja3NvdXJjZSBh
bmQgY2xvY2tldmVudCBzdXBwb3J0IGZvciBkYXZpbmNpIHBsYXRmb3Jtcwo+Pj4gbGl2ZXMgaW4g
bWFjaC1kYXZpbmNpLiBJdCBoYXJkLWNvZGVzIG1hbnkgdGhpbmdzLCB1c2VkIGdsb2JhbCB2YXJp
YWJsZXMsCj4+PiBpbXBsZW1lbnRzIGZ1bmN0aW9uYWxpdGllcyB1bnVzZWQgYnkgYW55IHBsYXRm
b3JtIGFuZCBoYXMgY29kZSBmcmFnbWVudHMKPj4+IHNjYXR0ZXJlZCBhY3Jvc3MgbWFueSAob2Z0
ZW4gdW5yZWxhdGVkKSBmaWxlcy4KPj4+Cj4+PiBJbXBsZW1lbnQgYSBuZXcsIG1vZGVybiBhbmQg
c2ltcGxpZmllZCB0aW1lciBkcml2ZXIgYW5kIHB1dCBpdCBpbnRvCj4+PiBkcml2ZXJzL2Nsb2Nr
c291cmNlLiBXZSBzdGlsbCBuZWVkIHRvIHN1cHBvcnQgbGVnYWN5IGJvYXJkIGZpbGVzIHNvCj4+
PiBleHBvcnQgYSBjb25maWcgc3RydWN0dXJlIGFuZCBhIGZ1bmN0aW9uIHRoYXQgYWxsb3dzIG1h
Y2hpbmUgY29kZSB0bwo+Pj4gcmVnaXN0ZXIgdGhlIHRpbWVyLgo+Pj4KPj4+IFdlIGRvbid0IGNo
ZWNrIHRoZSByZXR1cm4gdmFsdWVzIG9mIHJlZ21hcCByZWFkcyBhbmQgd3JpdGVzIHNpbmNlIHdp
dGgKPj4+IG1taW8gaXQncyBvbmx5IGxpa2VseSB0byBmYWlsIGR1ZSB0byBwcm9ncmFtbWVyJ3Mg
ZXJyb3JzLgo+Pj4KPj4+IFdlIGFsc28gZG9uJ3QgYm90aGVyIGZyZWVpbmcgcmVzb3VyY2VzIG9u
IGVycm9ycyBpbgo+Pj4gZGF2aW5jaV90aW1lcl9yZWdpc3RlcigpIGFzIHRoZSBzeXN0ZW0gd29u
J3QgYm9vdCB3aXRob3V0IGEgdGltZXIgYW55d2F5Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEJh
cnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4+Cj4+IFdpdGgg
dGhpcyBzZXJpZXMsIERBODMwIGZhaWxzIHRvIGJvb3QuIFJlc3Qgb2YgdGhlIGRldmljZXMgYXJl
IG9rYXkgZnJvbQo+PiBib290IHBlcnNwZWN0aXZlLgo+Pgo+PiBEQTgzMCBpcyBwcmV0dHkgdW5p
cXVlIGJlY2F1c2UgaXQgdXNlcyB0aGUgc2FtZSB0aW1lci1oYWxmIGZvciBib3RoCj4+IGNsb2Nr
c291cmNlIGFuZCBjbG9ja2V2ZW50LiBNYXkgYmUgeW91IGNhbiBzZXQgdGhlIHNhbWUgY29uZmln
dXJhdGlvbiBvbgo+PiB5b3VyIERBODUwIHRvIHNlZSB0aGUgc2FtZSBpc3N1ZT8gRWxzZSwgSSB3
aWxsIGVuYWJsZSBsb3ctbGV2ZWwgZGVidWcKPj4gYW5kIHRyeSB0byBwcm92aWRlIG1vcmUgZGVi
dWcgZGF0YS4KPj4KPiAKPiBJIGNhbid0IGJvb3QgZGE4NTAgd2l0aCB0aGUgc2FtZSBjb25maWcg
YXMgZGE4MzAgKDB4NjAgY29tcGFyZQo+IHJlZ2lzdGVyLCBjb21wYXJlIGlycSA3NCkgZXZlbiB3
aXRoIHRoZSBvbGQgdGltZXIgY29kZS4gSnVzdCB0byBtYWtlCj4gc3VyZTogZG9lcyBkYTgzMCBi
b290IGZpbmUgd2l0aCBtYWlubGluZSB2NS4wLXJjMj8KClllYWgsIEkgZGlkIGNoZWNrIHRoYXQg
d2l0aG91dCB0aGUgcGF0Y2ggREE4MzAgZG9lcyBib290LgoKVGhhbmtzLApTZWtoYXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
