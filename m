Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C0BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2867420663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bn5UxxuQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iQb/5WSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2867420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LG+YtBqtpMoqOJ/sgOrunxj6lfFPl0YtE8jaeHX1iPk=; b=bn5UxxuQNbCeXX
	HQcZTEzyaN79vKC/XMNFEzWY+Z0uYSPXcbpm9jOQdafivJLHGQGyZZ8oAIdBSeJxSpJ5AOOh/dK3m
	Vq7FsTHEu7/mYin3L8pN71Hxs2xeWdSmVzzaU+v93xyfsCMP16SH4WHFXe7Ufmn0+vaVWM4IanNfF
	WDjV80orNHEK3EMjpHL3av0jnA6KjhruSzzKjo9Ti2YCsozbZF/oq4WcI5z6GlKXHeVGaEbva5prZ
	8i9lw0/4d9H5QmyjeKnq+W58sWQWYODeJWdHmR7U9Z6pOyJPvyU8iwStUMKRkqe3mmQBPha2WL1UV
	64CH0aLmV3uAvUJXg6gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIIw-0004jS-RY; Mon, 25 Feb 2019 15:36:30 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIIt-0004iU-Fj
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 15:36:29 +0000
Received: by mail-pg1-x544.google.com with SMTP id j3so4634417pgm.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Qe+IVDkuWKSRxzAKPE16Ky2OCPsnHiwLi8d9RolXnfI=;
 b=iQb/5WSmjcOtEKCrapUAGOE2G86cXohBP6lIoAtCpMeYr447LHPao/CDatxCJoNsFu
 U+TWW9l5NuYzZ8U1eUdyhulKD7W5KoP/okpxQFRRaCz/xCuACe+cZNDx2/AKsFAaax2S
 i2UibU12vp9j9g4iLZ9Dhyu7Bip+CAZfoXG9Uq3OS0+grxHAchambperluSiwv0oIR4G
 9U9fy+rcrpt/3cd/o9UZkwiBZgVWGrfwP/mGQ0OPpQi4RL5b6t33/okk/BNYFusJWKLw
 EP9xi4mO+8jzoOXBI5BPVC8LQIBP4i+EAYH5FB797kKOEEOsSI4SRmUcGpz/pzWVJjWU
 Jb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Qe+IVDkuWKSRxzAKPE16Ky2OCPsnHiwLi8d9RolXnfI=;
 b=l1MVEIG6dQjBvxO933vsMdz1wbUlnSM6NtdapwRU6mrh14IlgeG08bzS8Kd26RnZxn
 DkSBEjo8+dI+ICgCaQHMKgZHs8h09Cu0ITpJPp4lOsNUQuWXtMVpIc4tImT4tQe97C+l
 3Fs55NuZFNsDgIVjoBHF9a6IMTjcn2+RlGTixFrlaT6riFwySQV/wNVAgz8aVSVyNh1l
 jEdMA5n1inAp0VCznoAjp4JHcQVLa4X6zsgMtbJI7115QdViH4JHQK1H3kjbN30eWo6J
 RIJMH7Qargz9kAjdmEgLmZqCWm1ogCqhEHT+myMMPfuKcxF1IqNIpDcGtM6N61uxFAV9
 oSJQ==
X-Gm-Message-State: AHQUAubrinlIJZuw1Gyc1CMd730bNAJ7pP3IMuB3LR+hChR16/Q98kCf
 PDbzm/dxn/0PzEB33zLkAcj4MQ==
X-Google-Smtp-Source: AHgI3IbwgtoFGqAHhOODxEs5PyCjKPQoyIUe/mPAh6whs8B6EAYFmL3wsmWVmpZsuRdQyN5u+qz1KA==
X-Received: by 2002:a63:1723:: with SMTP id x35mr19202547pgl.364.1551108985545; 
 Mon, 25 Feb 2019 07:36:25 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:b988:7895:8212:7b97?
 ([2601:646:c200:7429:b988:7895:8212:7b97])
 by smtp.gmail.com with ESMTPSA id u184sm16177015pgd.13.2019.02.25.07.36.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 07:36:24 -0800 (PST)
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190225115344.GA32534@hirez.programming.kicks-ass.net>
Date: Mon, 25 Feb 2019 07:36:23 -0800
Message-Id: <8D4F1170-AE12-40A5-BA7F-C566FA39DE8A@amacapital.net>
References: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
 <20190225105144.GJ32477@hirez.programming.kicks-ass.net>
 <20190225115344.GA32534@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_073627_667035_C05C4A36 
X-CRM114-Status: GOOD (  21.87  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIEZlYiAyNSwgMjAxOSwgYXQgMzo1MyBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPiAKPj4gT24gTW9uLCBGZWIgMjUsIDIwMTkgYXQgMTE6NTE6
NDRBTSArMDEwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4+PiBPbiBGcmksIEZlYiAyMiwgMjAx
OSBhdCAwMzo1NToyNVBNIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+PiBJJ20gd29u
ZGVyaW5nIGlmIHdlIGNhbiBqdXN0IGNoYW5nZSB0aGUgY29kZSB0aGF0IGRvZXMgZ2V0cmVnKCkg
YW5kCj4+PiBsb2FkX2dzX2luZGV4KCkgc28gaXQgZG9lc24ndCBkbyBpdCB3aXRoIEFDIHNldC4g
IEFsc28sIHdoYXQgYWJvdXQKPj4+IHBhcmF2aXJ0IGtlcm5lbHM/ICBUaGV5J2xsIGNhbGwgaW50
byBQViBjb2RlIGZvciBsb2FkX2dzX2luZGV4KCkgd2l0aAo+Pj4gQUMgc2V0Lgo+PiAKPj4gUGFy
YXZpcnQgY2FuIGdvIGJ1Z2dlciBvZmYuIFRoZXJlJ3Mgbm8gc2FuZSB3YXkgdG8gZml4IHRoYXQu
Cj4gCj4+IEkgZG9uJ3QgZnVsbHkgdW5kZXJzdGFuZCB0aGF0IGNvZGUgYXQgYWxsOyBJIGFsc28g
aGF2ZSBubyBjbHVlIHdoeSBHUwo+PiBoYXMgcGFyYXZpcnQgYml0cyBvbiBidXQgdGhlIG90aGVy
IHNlZ21lbnRzIGRvIG5vdC4gCj4gCj4gKnNpZ2gqIFNXQVBHUwo+IAo+PiAqdGhvdWdodCouLi4g
d2UgY291bGQgZGVsYXkgdGhlIGFjdHVhbCBzZXRfdXNlcl9zZWcoKSB0aGluZyB1bnRpbCBhZnRl
cgo+PiB0aGUgZ2V0X3VzZXJfY2F0Y2goKSwgd291bGQgdGhhdCB3b3JrPwo+IAo+IAo+IEhvdyBo
b3JyaWJsZSAvIGJyb2tlbiBpcyB0aGlzPwo+IAo+IC0tLQo+IAo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9pYTMyL2lhMzJfc2lnbmFsLmMgYi9hcmNoL3g4Ni9pYTMyL2lhMzJfc2lnbmFsLmMKPiBp
bmRleCAzMjFmZTVmNWQwZTkuLjY3Yzg2Njk0MzEwMiAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9p
YTMyL2lhMzJfc2lnbmFsLmMKPiArKysgYi9hcmNoL3g4Ni9pYTMyL2lhMzJfc2lnbmFsLmMKPiBA
QCAtNjAsMTcgKzYwLDIxIEBACj4gICAgcmVncy0+c2VnID0gR0VUX1NFRyhzZWcpIHwgMzsgICAg
ICAgICAgICBcCj4gfSB3aGlsZSAoMCkKPiAKPiAtI2RlZmluZSBSRUxPQURfU0VHKHNlZykgICAg
ICAgIHsgICAgICAgIFwKPiAtICAgIHVuc2lnbmVkIGludCBwcmUgPSBHRVRfU0VHKHNlZyk7ICAg
IFwKPiAtICAgIHVuc2lnbmVkIGludCBjdXIgPSBnZXRfdXNlcl9zZWcoc2VnKTsgICAgXAo+IC0g
ICAgcHJlIHw9IDM7ICAgICAgICAgICAgICAgIFwKPiAtICAgIGlmIChwcmUgIT0gY3VyKSAgICAg
ICAgICAgICAgICBcCj4gLSAgICAgICAgc2V0X3VzZXJfc2VnKHNlZywgcHJlKTsgICAgICAgIFwK
PiArI2RlZmluZSBMT0FEX1NFRyhzZWcpICAgICAgICB7ICAgICAgICAgICAgXAo+ICsgICAgcHJl
XyMjc2VnID0gMyB8IEdFVF9TRUcoc2VnKTsgICAgICAgICAgICBcCj4gKyAgICBjdXJfIyNzZWcg
PSBnZXRfdXNlcl9zZWcoc2VnKTsgICAgICAgICAgICBcCj4gK30KPiArCj4gKyNkZWZpbmUgUkVM
T0FEX1NFRyhzZWcpICAgICAgICB7ICAgICAgICAgICAgXAo+ICsgICAgaWYgKHByZV8jI3NlZyAh
PSBjdXJfIyNzZWcpICAgICAgICAgICAgXAo+ICsgICAgICAgIHNldF91c2VyX3NlZyhzZWcsIHBy
ZV8jI3NlZyk7ICAgICAgICBcCj4gfQo+IAo+IHN0YXRpYyBpbnQgaWEzMl9yZXN0b3JlX3NpZ2Nv
bnRleHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsCj4gICAgICAgICAgICAgICAgICAgc3RydWN0IHNp
Z2NvbnRleHRfMzIgX191c2VyICpzYykKPiB7Cj4gKyAgICB1MTYgcHJlX2dzLCBwcmVfZnMsIHBy
ZV9kcywgcHJlX2VzOwo+ICsgICAgdTE2IGN1cl9ncywgY3VyX2ZzLCBjdXJfZHMsIGN1cl9lczsK
PiAgICB1bnNpZ25lZCBpbnQgdG1wZmxhZ3MsIGVyciA9IDA7Cj4gICAgdm9pZCBfX3VzZXIgKmJ1
ZjsKPiAgICB1MzIgdG1wOwo+IEBAIC04NSwxMCArODksMTAgQEAgc3RhdGljIGludCBpYTMyX3Jl
c3RvcmVfc2lnY29udGV4dChzdHJ1Y3QgcHRfcmVncyAqcmVncywKPiAgICAgICAgICogdGhlIGhh
bmRsZXIsIGJ1dCBkb2VzIG5vdCBjbG9iYmVyIHRoZW0gYXQgbGVhc3QgaW4gdGhlCj4gICAgICAg
ICAqIG5vcm1hbCBjYXNlLgo+ICAgICAgICAgKi8KPiAtICAgICAgICBSRUxPQURfU0VHKGdzKTsK
PiAtICAgICAgICBSRUxPQURfU0VHKGZzKTsKPiAtICAgICAgICBSRUxPQURfU0VHKGRzKTsKPiAt
ICAgICAgICBSRUxPQURfU0VHKGVzKTsKPiArICAgICAgICBMT0FEX1NFRyhncyk7Cj4gKyAgICAg
ICAgTE9BRF9TRUcoZnMpOwo+ICsgICAgICAgIExPQURfU0VHKGRzKTsKPiArICAgICAgICBMT0FE
X1NFRyhlcyk7Cj4gCj4gICAgICAgIENPUFkoZGkpOyBDT1BZKHNpKTsgQ09QWShicCk7IENPUFko
c3ApOyBDT1BZKGJ4KTsKPiAgICAgICAgQ09QWShkeCk7IENPUFkoY3gpOyBDT1BZKGlwKTsgQ09Q
WShheCk7Cj4gQEAgLTEwNiw2ICsxMTAsMTEgQEAgc3RhdGljIGludCBpYTMyX3Jlc3RvcmVfc2ln
Y29udGV4dChzdHJ1Y3QgcHRfcmVncyAqcmVncywKPiAgICAgICAgYnVmID0gY29tcGF0X3B0cih0
bXApOwo+ICAgIH0gZ2V0X3VzZXJfY2F0Y2goZXJyKTsKPiAKPiArICAgIFJFTE9BRF9TRUcoZ3Mp
Owo+ICsgICAgUkVMT0FEX1NFRyhmcyk7Cj4gKyAgICBSRUxPQURfU0VHKGRzKTsKPiArICAgIFJF
TE9BRF9TRUcoZXMpOwo+ICsKPiAgICBlcnIgfD0gZnB1X19yZXN0b3JlX3NpZyhidWYsIDEpOwo+
IAo+ICAgIGZvcmNlX2lyZXQoKTsKCkkgd291bGQgY2FsbCB0aGlzIHByZXR0eSBob3JyaWJsZS4g
SG93IGFib3V0IHdlIGRvIGl0IHdpdGhvdXQgbWFjcm9zPyA6KQoKQnV0IHllcywgZGVmZXJyaW5n
IHRoZSBzZWdtZW50IGxvYWQgdW50aWwgYWZ0ZXIgdGhlIHJlYWQgc2VlbXMgZmluZSB0byBtZS4g
RnJhbmtseSwgd2UgY291bGQgYWxzbyBqdXN0IGNvcHlfZnJvbV91c2VyIHRoZSB3aG9sZSB0aGlu
ZyB1cCBmcm9udCDigJQgdGh1cyBjb2RlIGlzIG5vdCByZWFsbHkgYSBzZXJpb3VzIGZhc3QgcGF0
aC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
