Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D088C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBF720675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X3/fuZ75";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AwWM04jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBF720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lsgux94/kruzDGhnS8h+m6hXKf2/gza+X+onBgt8EDw=; b=X3/fuZ7519xXiu
	HDMDuf24nswy5cHh8D4ZfRk0zvjOgikTbOieMbY0iJ8L+YW8xWMoKPY0+U6Sxed8bGRxNhXVIgvI5
	KDxlkljEI7dgh6PcXjGuLw+j/ZnVDmKScExgBjKNR4NFz5DLVSC9+YAshKwTKfomkqVcLwQ/rSzxZ
	FVPYCXNzgybpZAUVbImz0JMxS4WrcoJXPE4rJKyQsrXBtflQQMmHFT6qCyU/G147L2JQs8BXB/GJQ
	jIozAIvHBr4qVrunZ+3c0wxUgYuI385Wiy9DqJhz61uSRvDWZrr5XdnHusIHkHxpIHQy+gi0Ln+qg
	zoOZtV7/7aWbpEPqF6yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu0kS-0005mU-E6; Wed, 13 Feb 2019 20:03:12 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu0kP-0005kI-5b
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 20:03:10 +0000
Received: by mail-lf1-x141.google.com with SMTP id f5so2726654lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e28LJ4tt7oVJKO7CgbJcVFBqC5tv55Rtb2nhIFWhcsA=;
 b=AwWM04joRrT5vs+hjoL9MmG7srLew3Te9ugMC75SXqOI/2uV0za5cgm9bc8pb8XXGn
 se+TPfIJUY4NYMOtH8GC9BwVPJFWIuFFqH0OPPPOg2Y/B3SCjVdMR3D9A7rLFl1GaaPs
 yUQL8R/8syuf+rS2mMXEgR8kDwmOiG+bDS59I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e28LJ4tt7oVJKO7CgbJcVFBqC5tv55Rtb2nhIFWhcsA=;
 b=XH8I9mHTXwGIw0OpzV2dbSOTM045qKsdKFtr5krxW8IjKETWHYbBwE6LBHLnDAJJkF
 YlfDVQnuG2dDEs/nhxhiruSS4uc3RZ0XY5LylOWROLhsbPXvpNmhx9KHyzo7zxLwG3Ul
 ucEeW8a+3//I80vzommdML7GjUIHYnLerbfUnSG9flpoDl3WqzzRgcNJQdb3KtldEfoL
 mepnE12CVIaGc0aktuB8xH8O21O7BmdOr6Kn2WV/8hfLsBdGIfg+0gZWNn/+Gkvyv4VH
 /FnKPDNtoN7cDqoEgPSjCPFLiwHLurTCiz03VvlHN2AK+r+U5F1cukyfkPF2SLU0Mwo9
 Tw9Q==
X-Gm-Message-State: AHQUAuaMFBPIulekDuP43iIQS4B4GJl5VzjqwWJ7FgTJIA0ZaV/u8Vcx
 4k44pqL8CZMrqYPmuLp+LBoYhsCq9R4=
X-Google-Smtp-Source: AHgI3IaPIwr+TWV2suwQAPd3ye8uWXuBLDAiDZsTtR2ELxzhQ2Idt+M9zIEvUD65+eKqzwch/wb8Hw==
X-Received: by 2002:a19:7b0e:: with SMTP id w14mr1394322lfc.8.1550088186474;
 Wed, 13 Feb 2019 12:03:06 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id j72-v6sm47761ljb.36.2019.02.13.12.03.06
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 12:03:06 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id z20so2113125ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 12:03:06 -0800 (PST)
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr1404666ljk.105.1550087814152; 
 Wed, 13 Feb 2019 11:56:54 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian>
In-Reply-To: <20190213091936.GA22829@shao2-debian>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Feb 2019 11:56:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Message-ID: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To: Chen Rong <rong.a.chen@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_120309_209844_F911C4B4 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 "IngoMolnar@shao2-debian" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T2ssIHRob3NlIHRlc3Qgcm9ib3QgcmVwb3J0cyBhcmUgaGFyZCB0byByZWFkLCBidXQgdHJ5aW5n
IHRvIGRpc3RpbGwgaXQgZG93bjoKCk9uIFdlZCwgRmViIDEzLCAyMDE5IGF0IDE6MTkgQU0gQ2hl
biBSb25nIDxyb25nLmEuY2hlbkBpbnRlbC5jb20+IHdyb3RlOgo+Cj4gICAgICAgICAgJXN0ZGRl
diAgICAgJWNoYW5nZSAgICAgICAgICVzdGRkZXYKPiAgICAgICAgICAgICAgXCAgICAgICAgICB8
ICAgICAgICAgICAgICAgIFwKPiAgICAgMTk2MjUwIMKxICA4JSAgICAgLTY0LjElICAgICAgNzA0
OTQgICAgICAgIHdpbGwtaXQtc2NhbGUucGVyX3RocmVhZF9vcHMKClRoYXQncyB0aGUgb3JpZ2lu
YWwgNjQlIHJlZ3Jlc3Npb24uLgoKQW5kIHRoZW4gd2l0aCB0aGUgcGF0Y2ggc2V0OgoKPiAgICAg
ICAgICAlc3RkZGV2ICAgICAgY2hhbmdlICAgICAgICAgJXN0ZGRldgo+ICAgICAgICAgICAgICBc
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgXAo+ICAgICAgNzExOTAgICAgICAgICAgICAgMTgw
JSAgICAgMTk5MjMyIMKxICA0JSAgd2lsbC1pdC1zY2FsZS5wZXJfdGhyZWFkX29wcwoKbG9va3Mg
bGlrZSBpdCdzIGJhY2sgdXAgd2hlcmUgaXQgdXNlZCB0byBiZS4KClNvIEkgZ3Vlc3Mgd2UgaGF2
ZSBudW1iZXJzIGZvciB0aGUgcmVncmVzc2lvbiBub3cuIFRoYW5rcy4KCkFuZCB0aGF0IGNsb3Nl
cyBteSBiaWdnZXN0IHF1ZXN0aW9uIGZvciB0aGUgbmV3IG1vZGVsLCBhbmQgd2l0aCB0aGUKbmV3
IG9yZ2FuaXphdGlvbiB0aGF0IGdldHMgaXJkIG9mIHRoZSBhcmNoLXNwZWNpZmljIGFzbSBzZXBh
cmF0ZWx5CmZpcnN0IGFuZCBtYWtlcyBpdCBhIGJpdCBtb3JlIGxlZ2libGUgdGhhdCB3YXksIEkg
Z3Vlc3MgSSdsbCBqdXN0IEFjawp0aGUgd2hvbGUgc2VyaWVzLgoKICAgICAgICAgICAgIExpbnVz
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
