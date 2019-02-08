Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E5CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:45:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA066217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fGpn7He1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uOhA3WNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA066217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zswY+vJAO0Tua98TAf72jZzAPZNTD2XlpwLg4T6y/rc=; b=fGpn7He1VbA8Sy
	MZ9TTGr5Yb2qGQj9uSXyMnsDOSUSn0VD1f4kIWe9/Bg/vr1c00T27xCRseDp2qEbQJiqCws2yHqwM
	Yv5HPDZSUq4OMR/lBPfdRJsg5cbw5t9G+YP4WXVsT9IsFBMVOLAIHfSFEzCK5rONwdrvKTGm6kg+1
	heWOpBU90UJUzlxyMBMO4JV8uUuagpTD5NOqPcr6Bc13H0evGNOhf51aPjUFtmZS/z4OGWDlUuLkE
	ytQ990xsufqMIN+ZzyaDlTJNT3Sr2mA26h5A6rwmE8IPvWptQQmdNb2lZWwjOcKqvWDDa7v8rZlcY
	hIFEO12DQVRURDKlPKwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4ak-0005kr-NT; Fri, 08 Feb 2019 11:45:10 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4ag-00055z-DV
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:45:08 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18Bhs5b122569;
 Fri, 8 Feb 2019 05:43:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549626234;
 bh=LzHUrENdQtad7aZ9C8w4CNHKlWbfppzru+yr3K9GrhE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=uOhA3WNMe86QOdtyAO3XEx52LK63fyqApmmHeXPr+/eMbjQCBBR9D5H6q50H13YeU
 0miZqOAo1yKISS1AMRdQdhNR71gm+7KYkBa7ohBPPJCPFbyfUPu6H+wNTJaF1GQgCe
 Poce4eAVF7ZnlkSb83W/CB/lhuNGoAkDfAJ9bLpM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18BhsdP081422
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Feb 2019 05:43:54 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 05:43:53 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 05:43:53 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18Bhnvx007023;
 Fri, 8 Feb 2019 05:43:51 -0600
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
 <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
Date: Fri, 8 Feb 2019 17:13:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_034506_561122_FCFFB55F 
X-CRM114-Status: GOOD (  18.69  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDUvMDIvMTkgOTo0MSBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPiBwb24uLCA0
IGx1dCAyMDE5IG8gMjI6NDkgRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5jb20+IG5h
cGlzYcWCKGEpOgo+Pgo+PiBPbiAxLzMxLzE5IDc6MzggQU0sIEJhcnRvc3ogR29sYXN6ZXdza2kg
d3JvdGU6Cj4+PiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGli
cmUuY29tPgo+Pj4KPj4+IFRoaXMgc2VyaWVzIHBvcnRzIHRoZSBkYXZpbmNpIHBsYXRmb3JtIHRv
IHVzaW5nIFNQQVJTRV9JUlEsIGNsZWFucyB1cAo+Pj4gdGhlIGlycWNoaXAgZHJpdmVycyBhbmQg
bW92ZXMgdGhlbSBvdmVyIHRvIGRyaXZlcnMvaXJxY2hpcC4KPj4+Cj4+Cj4+IFRoaXMgaGFzIGJl
ZW4gb24gbXkgdG9kbyBsaXN0IGZvciB5ZWFycywgYnV0IEkndmUgbmV2ZXIgaGFkIGVub3VnaAo+
PiB0aW1lIHRvIGZpZ3VyZSBpdCBvdXQuIE5pY2UgdG8gc2VlIGl0IGZpbmFsbHkgZ2V0dGluZyBk
b25lIQo+Pgo+PiBTZXJpZXMgdGVzdGVkIG9uIExFR08gTUlORFNUT1JNUyBFVjMgKGRhODUwLWxp
a2UpLiBJIGNhbiBub3cgdXNlCj4+IElJTyB0cmlnZ2VycyB3aXRob3V0IGhhdmluZyB0byBwYXRj
aCB0aGUga2VybmVsIHRvIGFkZCBleHRyYQo+PiBpbnRlcnJ1cHRzLgo+Pgo+PiBUZXN0ZWQtYnk6
IERhdmlkIExlY2huZXIgPGRhdmlkQGxlY2hub2xvZ3kuY29tPgo+Pgo+Pgo+IAo+IFdvdyB0aGFu
a3MgZm9yIHRha2luZyB0aGUgdGltZSB0byByZXZpZXcgaXQhCj4gCj4gSSdsbCBhZGRyZXNzIGNl
cnRhaW4gcmVtYXJrcyAtIGZvciB0aG9zZSB1bmFkZHJlc3NlZCAtIEknbGwgZml4IHRoZW0gaW4g
djIuCj4gCj4gU2VraGFyOiBhcmUgeW91IGZpbmUgd2l0aCBzZW5kaW5nIGJvdGggdGhlIGNsb2Nr
c291cmNlIGFuZCBpbnRlcnJ1cHQKPiBzZXJpZXMgdG9nZXRoZXIgbmV4dCB0aW1lIHdpdGggYWRk
aXRpb25hbCBwYXRjaGVzIG9uIHRvcCBtYWtpbmcKPiBkYXZpbmNpIHBhcnQgb2YgbXVsdGlfdjVf
ZGVmY29uZmlnPwoKSSB0aGluayBpdHMgYmV0dGVyIHRvIGtlZXAgdGhlbSBzZXBhcmF0ZS4gWW91
IGNhbiBiYXNlIGJvdGggb24gbGF0ZXN0Cm1haW5saW5lLgoKVGhhbmtzLApTZWtoYXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
