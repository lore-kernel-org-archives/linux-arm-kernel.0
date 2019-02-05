Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A320C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:16:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6A4217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="trOmcqte";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XiE1A8wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6A4217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9jNj8okNJ8jZm7iQmxJplSqOumLeAN9gVy2Xx044k+g=; b=trOmcqtebSCAWI
	wMp7R6gzeRBJ1m9/xeI4CVXDkCsAEsnTo5Rpvur7HSuVvFP78CjFqUKlXjep6uewCaIo+NEsDBsAg
	/jgR9RhxtB75asQlshZwn227H5bMngCXJSifxSpWpjUDaFgf2nRNMMc43NrdIpz96XMmvwCyRYB1a
	IbyJZsI4UViVzfxHj9a8v1MQKarMrp5UMQDvnRs7IppHvXO5FCb5S78FhpeASeftDgn4PhmIDWSy3
	IXLYtvGfGxLhkhoUZzEwojQlt23f8MsfZnkb24uU0nECaZR+kk0HtPb0MItCY2BqhD8K87/5Q8344
	IZxl2tx92se8PHVXWUlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3Ow-0007Vs-S5; Tue, 05 Feb 2019 16:16:46 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3Ot-0007V5-Dt
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 16:16:44 +0000
Received: by mail-it1-x142.google.com with SMTP id d11so9732270itf.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3YOiGZDXVeVb+PqdpffE1ymvFvsSY64s9CxiJy1tZz8=;
 b=XiE1A8wy6TEiht9WrFV9kb8WMiGpdFDp00lYY2SyumWmYnbBrT+fkTMXVbhARsWSlI
 VP4U8c+zLoLuQFA5+r+SgpyGatleRkReeTUgGbc5FfyZUVa+CH8MrSnKyLQ6P7DsnsOo
 7Ds4CTP0qNWx8wH9fpa8UgaV14AGJuYGivs4njJT9x1QZ49psj1fSF1bUPAQhsflz94Y
 RFtaQdF/+5RhPh7DfXxDAR07/bGPKT8SmzUO0kQMjXm4/SrG00L8APCSJ6qfppJH5Tw5
 AkteO4whyUp81HmbN9wEYdXRdYtjB7X1dbheMRkj5mzNc7cC4KmPbQrnXFF9sNiptiu4
 50WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3YOiGZDXVeVb+PqdpffE1ymvFvsSY64s9CxiJy1tZz8=;
 b=PG8gkM1Ynz1zsJEMpQirDnd3XcqxGVU3Ctq3eXinn5fD3bkv8oBRFrrM8Spyh2VCrg
 BBoeq675TFMMYMSBrOlnBCAEDa+r9UWOBYzrZT4b8XZonHF/gTZsw3g1digYgLYevMa1
 EEuMtuXgp2yRRe3r7HTFkMGCc/9eE3qgJL3M5pcvpHy2ktCjjUHqEyQPHcgkPnMvdFEK
 r06JgR124jcZ34vpP+g/dNKgjbtJNkWC+CX4YeMVdA6XEacI56NhCofv0Q43amsorlei
 VPhSaKk3+19f2OU/bKknLSm1uPJZWDDbFbm969C5vmQ5LQmRX9LfsrqgPIGFJ4kkIXbI
 YE/Q==
X-Gm-Message-State: AHQUAuY+BLyL4xsngdNpfhNvX0SNKFYv8AGf2+tqh0BC9b5pnmRgpKsi
 qyUP9TdOAVnkybQZDieO7m5NTiLaiyy5kQWLAbO8NQ==
X-Google-Smtp-Source: AHgI3IbmLxZOfvE26SlMUeQFsubB+gvAQj2XcL9KrYdDDqdcr96PZNDTHR8Ix2bNwqOgSPGHg9maO3AeFxiZi3eTdHk=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr593456iop.258.1549383400360; 
 Tue, 05 Feb 2019 08:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-6-brgl@bgdev.pl>
 <28694e1b-415a-d53f-f2e5-ba2a407fa88c@lechnology.com>
In-Reply-To: <28694e1b-415a-d53f-f2e5-ba2a407fa88c@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Feb 2019 17:16:29 +0100
Message-ID: <CAMRc=McRiemxKQTYJx1om21XrXcEmur1HJP=YSB5XocXRCbg2A@mail.gmail.com>
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from
 default_priorites
To: David Lechner <david@lechnology.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_081643_463657_B0894720 
X-CRM114-Status: GOOD (  14.01  )
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
 Marc Zyngier <marc.zyngier@arm.com>, Sekhar Nori <nsekhar@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

d3QuLCA1IGx1dCAyMDE5IG8gMDE6MjAgRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5j
b20+IG5hcGlzYcWCKGEpOgo+Cj4gT24gMS8zMS8xOSA3OjM4IEFNLCBCYXJ0b3N6IEdvbGFzemV3
c2tpIHdyb3RlOgo+ID4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJh
eWxpYnJlLmNvbT4KPiA+Cj4gPiBJbiBvcmRlciB0byBzZWxlY3QgU1BBUlNFX0lSUSB3ZSBuZWVk
IHRvIG1ha2UgdGhlIGludGVycnVwdCBudW1iZXJzCj4gPiBkeW5hbWljIChhdCBsZWFzdCBhdCBi
dWlsZC10aW1lIGZvciB0aGUgdG9wLWxldmVsIGNvbnRyb2xsZXIpLiBUaGUKPiA+IGludGVycnVw
dCBudW1iZXJzIGFyZSB1c2VkIGFzIGFycmF5IGluZGV4ZXMgZm9yIGlycSBwcmlvcml0aWVzLgo+
ID4KPiA+IERyb3AgdGhlIGRlZmluZXMgYW5kIGp1c3QgaW5pdGlhbGl6ZSB0aGUgYXJyYXlzIGlu
IGEgbGluZWFyIG1hbm5lci4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBCYXJ0b3N6IEdvbGFzemV3
c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPgo+ID4gLS0tCgpbc25pcCFdCgo+ID4KPgo+
IFRlY2huaWNhbGx5LCBhbnkgaG9sZXMgaW4gdGhlIGFycmF5IHRoYXQgYXJlIGJlaW5nIGRlbGV0
ZWQKPiBoZXJlIGhhdmUgYSBkZWZhdWx0IHByaW9yaXR5IG9mIDE1IGFzc2lnbmVkIGluIHRoZSBj
cF9pbnRjCj4gZHJpdmVyIGluc3RlYWQgb2YgNy4gSSBkb24ndCB0aGluayB0aGlzIGlzIGEgcHJv
YmxlbSwgYnV0IGl0Cj4gbWlnaHQgYmUgd29ydGggbWVudGlvbmluZyBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UuIFNhbWUgZ29lcwo+IGZvciBEQTg1MC4KPgoKQWN0dWFsbHkgdGhlIGRlZmF1bHRpbmcg
aXMgb25seSBkb25lIGlmIG5vIHByaW9yaXRpZXMgaGF2ZSBiZWVuCmRlZmluZWQgYXQgYWxsLiBJ
J2xsIGRvdWJsZSBjaGVjayB0aG91Z2ggaWYgdGhlcmUgYXJlIG5vIGhvbGVzIGhlcmUuCgpCYXJ0
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
