Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32018C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:37:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FE32084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fPJso3Ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FE32084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2hM50TFxjNhjXLpAT4VapOsUgZMW+7Bpw8bz2OvQSxM=; b=fPJso3KiGLaP/u
	o9N+TYxJGHzD1pXFy55HokvaXwxzT1EbXfLnBHY9r/5BQXXcpwUakY+7raypEGqY8ZLzBc/4zQ3XP
	cViy2wIFnFNSbfA5VIUDX/SaRvblHko4q/ONhX9cDZXmxX4BNaih2RYIRrRfvk1JH6ZmK3iEROIb3
	9F95hZIO6/CgGKf8UCGRsn6fE/Lk20vm0qW58AIBOgT4eWdHFW4lIlx1X+SCMx+0f03NlbdBfTjw+
	W7N+KiwvAR6gTLEfhx/rJxX8GqeHuVaWdNuVVTVkILHsF7z88IOOMkAYeDuCV80O0xNDfW83bkYOO
	rTF10qidUN5WrcQibwiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeU8-0006ZD-BN; Tue, 11 Dec 2018 09:37:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeU0-0006X7-7c
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:37:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 556C9208BE; Tue, 11 Dec 2018 10:37:27 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 76F6F20DCC;
 Tue, 11 Dec 2018 10:37:06 +0100 (CET)
Date: Tue, 11 Dec 2018 10:37:06 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: mvebu: how to determine the address of the internal register
 window
Message-ID: <20181211103657.79713087@windsurf>
In-Reply-To: <f54e8ca9-0ca5-ce03-aaf8-e837f68b3024@kleine-koenig.org>
References: <f54e8ca9-0ca5-ce03-aaf8-e837f68b3024@kleine-koenig.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_013740_406749_3CD9B56E 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Gregory Clement <gregory.clement@bootlin.com>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8gVXdlLAoKT24gTW9uLCAxMCBEZWMgMjAxOCAxODowOTozOCArMDEwMCwgVXdlIEtsZWlu
ZS1Lw7ZuaWcgd3JvdGU6Cgo+IHVzaW5nIGJhcmVib3ggb24gYW4gbXZlYnUgbWFjaGluZSB0aGUg
aW50ZXJuYWwgcmVnaXN0ZXIgd2luZG93IGlzIG1vdmVkCj4gZnJvbSAweGQwMDAwMDAwIHRvIDB4
ZjEwMDAwMDAuIENvbXBhcmVkIHRvIFUtQm9vdCB0aGUgUENJIEV4cHJlc3MgQkFSMAo+IEludGVy
bmFsIFJlZ2lzdGVycyAob24gQXJtYWRhIDM3MDogMHg0MDAxMCBhbmQgMHg4MDAxMCwgb24gQXJt
YWRhIFhQIGEKPiBmZXcgbW9yZSkgYXJlIG5vdCBmaXhlZCB3aGljaCBtYWtlcyBhY2Nlc3Npbmcg
cGNpIGRldmljZXMgZmFpbC4gSW5zdGVhZAo+IG9mIGxldHRpbmcgYmFyZWJveCBmaXggdGhpcyB1
cCBJJ2QgbGlrZSB0byBtYWtlIExpbnV4IGVuc3VyZSB0aGUKPiByZWdpc3RlciBpcyBjb25maWd1
cmVkIGNvcnJlY3RseS4KPiAKPiBJIHRoaW5rIHRoZSByaWdodCBwbGFjZSBmb3IgdGhhdCBpcyBt
dmVidV9wY2llX3NldHVwX3dpbnMgd2hpY2ggbmVlZHMgdG8gZG8KPiAKPiAJbXZlYnVfd3JpdGVs
KHBvcnQsIGludHJlZ29mZnNldCwgUENJRV9CQVJfTE9fT0ZGKDApKTsKPiAKPiBJIHdvbmRlciBo
b3dldmVyIGhvdyBJIHNob3VsZCBkZXRlcm1pbmUgdGhlIGFjdHVhbCB2YWx1ZSB0byB3cml0ZSBo
ZXJlLgo+IEkgZGlkbid0IGZpbmQgYSBmdW5jdGlvbiB0aGF0IGV4cG9ydHMgdGhlIG9mZnNldCBv
ZiB0aGUgaW50ZXJuYWwKPiByZWdpc3RlciB3aW5kb3cuIERvIHlvdSBoYXZlIGEgaGludCBmb3Ig
bWU/CgpUaGUgYmFzZSBhZGRyZXNzIG9mIHRoZSBpbnRlcm5hbCByZWdpc3RlcnMgaXMgYXZhaWxh
YmxlIGluIHRoZSBEZXZpY2UKVHJlZToKCiAgICAgICAgc29jIHsKICAgICAgICAgICAgICAgIHJh
bmdlcyA9IDxNQlVTX0lEKDB4ZjAsIDB4MDEpIDAgMCAweGYxMDAwMDAwIDB4MTAwMDAwCgpTZWUg
dGhlIDB4ZjEwMDAwMDAgaGVyZT8gVGhhdCdzIHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIGludGVy
bmFsIHJlZ2lzdGVycy4KClNlZSBhbHNvIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9idXMvbXZlYnUtbWJ1cy50eHQgZm9yIG1vcmUKZGV0YWlscyBhYm91dCB0aGlzIGJpbmRpbmcu
CgpBbHRlcm5hdGl2ZWx5LCBzaW5jZSB0aGUgaW50ZXJuYWwgcmVnaXN0ZXIgd2luZG93IGlzIGFs
d2F5cyAxIE1CIGxhcmdlLApmcm9tIHRoZSBwY2ktbXZlYnUgZHJpdmVyLCB5b3UgY2FuIHRha2Ug
dGhlIGJhc2UgYWRkcmVzcyBvZiBhbnkgUENJCmNvbnRyb2xsZXIsIGRvICYgfjB4RkZGRkYsIGFu
ZCB5b3UgZ2V0IHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIGludGVybmFsCnJlZ2lzdGVyIHdpbmRv
dy4KCkRvZXMgdGhpcyBoZWxwcz8KCkJlc3QgcmVnYXJkcwoKVGhvbWFzCi0tIApUaG9tYXMgUGV0
YXp6b25pLCBDVE8sIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmlu
ZwpodHRwczovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
