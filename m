Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCDC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:28:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9AC20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u7nkGCTk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iUddjeMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9AC20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uCAhDFYAPNbsGhmcObBHMCjMMRL9sHoGvEXponZvJDQ=; b=u7nkGCTk4Avjdv
	n1y0RHu22iUcq/ZPYcXyDb+csiLaftrmQm9ENfHaz8bOsyJzYlhCW9IxvDdQEI72h9kYackEL3HWW
	Qn3H19oLy81RekDz3JzwyPCDc/3BpjnQjb1WmON/saFhCfZ7Yw939nt0IortclHa64rzj6K+ijwAF
	r779m/mnr97kOiV2GKJFkL52MDyW/zeNl4TTuRT6HolNE6QRVC7WW/WpkCDDynOQVvK/OzEhDEAqk
	6pHiPBj+AdT57d9/uVWplnallVW1iI8Or2TROr102hUyU9+VjFNKG+2sn8/Mu69fhLSIZwCKBmvS9
	O0cWUVvVvsMX+ZsEd97g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5GT-0001Qr-6t; Fri, 08 Feb 2019 12:28:17 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5Fq-0000fB-Df
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:28:13 +0000
Received: by mail-it1-x143.google.com with SMTP id h193so8355052ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rcwExCzNoL+yg617jsQnJerR6CSHpOTYTtf3KT5kGcw=;
 b=iUddjeMIr5uEDafh3drBAEn05JBVkVu3p7zC/+JqgG1WQJJmoB0vn5ecMydqLtIw8L
 gU2XsuvVAuxYvkRvhXyo9Sn1tfP8qYyBISMBOZKqH3UIHPSQxVNm9pj5M9Qqf7mP22a/
 4pgMfzqzGlL+uC9CPcp8HMa2WDfkwOtn8omfPESv7kLCfaGDUXGd8kr47g9sPzvj5JvG
 8zJcXiW+IEs0A4pRpImskD9OjodGr3jM286JF9fM9KfUV4VV5rwnJ8Ok7V+tAE1RmfmX
 QvnLDa5LXUNzbtLQefyJugKYsuxX9lcDuUSm3Pz9eXf2ytEM7WysDQG27beFRdiF8cDi
 uH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rcwExCzNoL+yg617jsQnJerR6CSHpOTYTtf3KT5kGcw=;
 b=qMIlhSByol6tX7219PIQE7eCGv9DfcMy2VyWSfDYeMufevdKsa/EnmDVQJXPPLgL0P
 5ABNEi9SIhia7rPfeuO5dXh4A7iCL4zN6aybO5b4UqDPAxZP5b9bqv7OPy7CCHoIUrSo
 ejpJFCWtv6PzpMBxBIjjSuPK4vOmWompyyy2lA12qyT9CHdJG8+INpdRGiZtsJOFRxd4
 PtfPhgxbIKjpIoRTTuoudehz4uJRSlf2ov+t5nxzsmFoxXDvF2T8bbIU+5itie9hYE9c
 lyP2kpQykapnKc6+QcyChp9vZZNj0aUUgMI0vrOgeKCFn4SntpgzqaBtlHpF7+i5Bgm7
 H/4Q==
X-Gm-Message-State: AHQUAuYQtpB5UTnMOpmc3odY4zom4l9EJWD4zIW28djpwl6O54AzGRbs
 9NRF4ha7lU8TarokSqPO8Pmy8ohIbXdrsd+ksR0KWQ==
X-Google-Smtp-Source: AHgI3IYzjk7sMJji7Y7S3Nhqtgur/rxitLL8oQLyEzaHW8raU0cFAN3cEMzrCTy5viobvZUYD1wZLzuhLrOLUP5eW0w=
X-Received: by 2002:a02:6f4d:: with SMTP id b13mr10837675jae.57.1549628857291; 
 Fri, 08 Feb 2019 04:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
 <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
 <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
In-Reply-To: <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 8 Feb 2019 13:27:26 +0100
Message-ID: <CAMRc=McNvvowdQG3zNhLpAuOL-Q_U1184mTwcJWJMRxto1LYbg@mail.gmail.com>
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042739_564422_D61D4168 
X-CRM114-Status: GOOD (  18.35  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cHQuLCA4IGx1dCAyMDE5IG8gMTI6NDMgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29tPiBuYXBp
c2HFgihhKToKPgo+IE9uIDA1LzAyLzE5IDk6NDEgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3Jv
dGU6Cj4gPiBwb24uLCA0IGx1dCAyMDE5IG8gMjI6NDkgRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVj
aG5vbG9neS5jb20+IG5hcGlzYcWCKGEpOgo+ID4+Cj4gPj4gT24gMS8zMS8xOSA3OjM4IEFNLCBC
YXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOgo+ID4+PiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tp
IDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPgo+ID4+Pgo+ID4+PiBUaGlzIHNlcmllcyBwb3J0
cyB0aGUgZGF2aW5jaSBwbGF0Zm9ybSB0byB1c2luZyBTUEFSU0VfSVJRLCBjbGVhbnMgdXAKPiA+
Pj4gdGhlIGlycWNoaXAgZHJpdmVycyBhbmQgbW92ZXMgdGhlbSBvdmVyIHRvIGRyaXZlcnMvaXJx
Y2hpcC4KPiA+Pj4KPiA+Pgo+ID4+IFRoaXMgaGFzIGJlZW4gb24gbXkgdG9kbyBsaXN0IGZvciB5
ZWFycywgYnV0IEkndmUgbmV2ZXIgaGFkIGVub3VnaAo+ID4+IHRpbWUgdG8gZmlndXJlIGl0IG91
dC4gTmljZSB0byBzZWUgaXQgZmluYWxseSBnZXR0aW5nIGRvbmUhCj4gPj4KPiA+PiBTZXJpZXMg
dGVzdGVkIG9uIExFR08gTUlORFNUT1JNUyBFVjMgKGRhODUwLWxpa2UpLiBJIGNhbiBub3cgdXNl
Cj4gPj4gSUlPIHRyaWdnZXJzIHdpdGhvdXQgaGF2aW5nIHRvIHBhdGNoIHRoZSBrZXJuZWwgdG8g
YWRkIGV4dHJhCj4gPj4gaW50ZXJydXB0cy4KPiA+Pgo+ID4+IFRlc3RlZC1ieTogRGF2aWQgTGVj
aG5lciA8ZGF2aWRAbGVjaG5vbG9neS5jb20+Cj4gPj4KPiA+Pgo+ID4KPiA+IFdvdyB0aGFua3Mg
Zm9yIHRha2luZyB0aGUgdGltZSB0byByZXZpZXcgaXQhCj4gPgo+ID4gSSdsbCBhZGRyZXNzIGNl
cnRhaW4gcmVtYXJrcyAtIGZvciB0aG9zZSB1bmFkZHJlc3NlZCAtIEknbGwgZml4IHRoZW0gaW4g
djIuCj4gPgo+ID4gU2VraGFyOiBhcmUgeW91IGZpbmUgd2l0aCBzZW5kaW5nIGJvdGggdGhlIGNs
b2Nrc291cmNlIGFuZCBpbnRlcnJ1cHQKPiA+IHNlcmllcyB0b2dldGhlciBuZXh0IHRpbWUgd2l0
aCBhZGRpdGlvbmFsIHBhdGNoZXMgb24gdG9wIG1ha2luZwo+ID4gZGF2aW5jaSBwYXJ0IG9mIG11
bHRpX3Y1X2RlZmNvbmZpZz8KPgo+IEkgdGhpbmsgaXRzIGJldHRlciB0byBrZWVwIHRoZW0gc2Vw
YXJhdGUuIFlvdSBjYW4gYmFzZSBib3RoIG9uIGxhdGVzdAo+IG1haW5saW5lLgo+Cj4gVGhhbmtz
LAo+IFNla2hhcgoKSWYgeW91IHByZWZlciBJIGNhbiBrZWVwIHRoZW0gc2VwYXJhdGUsIGFsdGhv
dWdoIHRoZXJlIHdlcmUgYSBjb3VwbGUKY29uZmxpY3RzIHdoZW4gSSBtZXJnZWQgdGhlbSBpbiBt
eSB0cmVlLCB3aGljaCBhcmUgbm93IHJlc29sdmVkLgoKTGV0J3MgbWF5YmUgc3RhcnQgd2l0aCB0
aGUgaW50ZXJydXB0cyAoSSdsbCBzZW5kIGEgdjIgdG9uaWdodCBpZiB5b3UKZG9uJ3QgaGF2ZSBh
bnkgbW9yZSBjb21tZW50cyksIGFuZCBvbmNlIHlvdSBoYXZlIHRoYXQgaW4geW91ciB0cmVlLCBJ
CndpbGwgcmViYXNlIHRoZSB0aW1lciBjb2RlIGFuZCB0aGVuIHRoZSBtdWx0aV92NSBzZXJpZXMu
CgpCYXJ0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
