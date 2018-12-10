Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ABAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C66A2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EImnDGGY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jYcVHH5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C66A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k9SFJ/MCzG54Rd8uold1yHs5QWM/sIBUBRqHY2kxFx4=; b=EImnDGGYVYEsuA
	ckli9RDZMZHGj/yNK8U2228aTYV/WbELq699CQLndlI4KNc0T7E9/PEvWr0ZBvHJ8TcURL/3SovuH
	KxNy481QcW68zLDk9+JrwI3zJqEP8KTM1ZTbOWgXwZK5t2hqxoCDMGC7PQnRuRVj2/9Zl/kGbHzLQ
	seziDnJRNYHZcIDFzNORp+3xP168iTx/0dJeRfTjiihXeRlq3kB03m0IKdOGOxYb7XGZ6VZ/ax++a
	dIcE13ObVwGp4nJHhm+fxrdJ1OuwpeOVuuH8tEtDvn/bPFEnwtNhGw6u0SWJYoyul8Fbkw26Vtts3
	9Q02bBueiCYE7om8Iekg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKQu-0002D1-1d; Mon, 10 Dec 2018 12:13:08 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKQa-0001im-P3
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:12:58 +0000
Received: by mail-it1-x144.google.com with SMTP id h193so17684230ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9hm893cXkmDQdbPIUIDLRoDuib2EeYqoLTsgSUztgKM=;
 b=jYcVHH5qk9IfBft6Na9Q3xVUs0IMy6nf9YAmDhbFA8h7Q2gPSTDFbmVB5haHGC3K+s
 uP6SoGc1QGVfcg3JvR0P3a5fZhwfYOzQIpXOKP/ineGQf1cQDyFFlXTybrQDlqB/xX98
 1tP4pUeqBfKIo6HDcRA1V+eAP5+T5YhiVngkGz8iyEq6bQ8Aa/QJ2YjdVAeNMslPFcrn
 xVzB0L/Q2fWni67Vx8F8pqG8c4K73t9LaEI2KFMZ/w2OzdoC2CSu4xJkW09qskqJ+kK5
 KdAbduqXmMyb+YsEbbFfJlDOTyUjnaUkQ6CqEQfhugXpF0YNrVWSfTtZh7XtdcReXA4f
 9qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9hm893cXkmDQdbPIUIDLRoDuib2EeYqoLTsgSUztgKM=;
 b=DiVl05LOu4sRMj8nwj+6TpLIS1lPwNNb2UtTm8bK7jkx0+SzlxF1nL62fO9h1lBriY
 K59R//2ibo8Cc23alaurXJfD0B5ZHIcHtiW8tvSsJdJDG5kPOL7zUmp2SOSpehf859qc
 xnCTITZkLf14MDW6MLdtg3gP4sIrbAIVAoqcbgdj2y3Lf8FN+BeeBkCjNMCu1ILjM6UB
 Jf11l3VHPaoHA9QlNUYaPdwo+7OVtLSBRbMvvxDrvJinbfasdJTswtqFiWtTCZP5GBux
 wrtqLBiakzrUNUfoz/QuqFHKyM6p0uXJyetYauDEscTZ9xs4nv9IeTBG26uffDYipUnM
 VlMQ==
X-Gm-Message-State: AA+aEWbPCLWFtiQPZ+T8v7iMb67W+0lt7XpZ013nI6JEzkbxqHY6XfN+
 Y0OeAqq9BO8MYZk03dcYtCIYNNSfy4h9hWhpZOf8eQ==
X-Google-Smtp-Source: AFSGD/VDvDMNV1ObyQKoTKEb9f5nIWOANn1ALbJNgjDt/DtKu1cjjceBe4EskxiaRZEv5vwJna8PoSOCnuLHw1/ObK0=
X-Received: by 2002:a24:9b89:: with SMTP id o131mr9321411itd.41.1544443954523; 
 Mon, 10 Dec 2018 04:12:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com>
 <5cc1b789aad7c99cf4f3ec5b328b147ad53edb40.1544099024.git.andreyknvl@google.com>
 <CAP=VYLo-o8vpGrpM_+0jdvxLC9uxw+F7_OtsSfRyq24HR1dDwA@mail.gmail.com>
In-Reply-To: <CAP=VYLo-o8vpGrpM_+0jdvxLC9uxw+F7_OtsSfRyq24HR1dDwA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 10 Dec 2018 13:12:23 +0100
Message-ID: <CAAeHK+wWRG6kp7mn-bNpYQ5cV8ygbXKnwS9f0mDCAnwiTqEoMg@mail.gmail.com>
Subject: Re: [PATCH v13 08/25] kasan: initialize shadow to 0xff for tag-based
 mode
To: paul.gortmaker@windriver.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_041249_913817_541E824B 
X-CRM114-Status: GOOD (  24.86  )
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
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMTAsIDIwMTggYXQgMjozNSBBTSBQYXVsIEdvcnRtYWtlcgo8cGF1bC5nb3J0
bWFrZXJAd2luZHJpdmVyLmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIERlYyA2LCAyMDE4IGF0IDc6
MjUgQU0gQW5kcmV5IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPiB3cm90ZToKPj4K
Pj4gQSB0YWctYmFzZWQgS0FTQU4gc2hhZG93IG1lbW9yeSBjZWxsIGNvbnRhaW5zIGEgbWVtb3J5
IHRhZywgdGhhdAo+PiBjb3JyZXNwb25kcyB0byB0aGUgdGFnIGluIHRoZSB0b3AgYnl0ZSBvZiB0
aGUgcG9pbnRlciwgdGhhdCBwb2ludHMgdG8gdGhhdAo+PiBtZW1vcnkuIFRoZSBuYXRpdmUgdG9w
IGJ5dGUgdmFsdWUgb2Yga2VybmVsIHBvaW50ZXJzIGlzIDB4ZmYsIHNvIHdpdGgKPj4gdGFnLWJh
c2VkIEtBU0FOIHdlIG5lZWQgdG8gaW5pdGlhbGl6ZSBzaGFkb3cgbWVtb3J5IHRvIDB4ZmYuCj4+
Cj4+IFJldmlld2VkLWJ5OiBBbmRyZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2aXJ0dW96em8uY29t
Pgo+PiBSZXZpZXdlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPgo+PiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+Cj4+
IC0tLQo+PiAgYXJjaC9hcm02NC9tbS9rYXNhbl9pbml0LmMgfCAxNSArKysrKysrKysrKysrLS0K
Pj4gIGluY2x1ZGUvbGludXgva2FzYW4uaCAgICAgIHwgIDggKysrKysrKysKPgo+Cj4gVGhlIHZl
cnNpb24gb2YgdGhpcyBpbiAgbGludXgtbmV4dCBicmVha3MgYXJtNjQgYWxsbW9kY29uZmlnIGZv
ciBtZToKPgo+IG1tL2thc2FuL2NvbW1vbi5jOiBJbiBmdW5jdGlvbiDigJhrYXNhbl9tb2R1bGVf
YWxsb2PigJk6Cj4gbW0va2FzYW4vY29tbW9uLmM6NDgxOjE3OiBlcnJvcjog4oCYS0FTQU5fU0hB
RE9XX0lOSVTigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4gICAg
X19tZW1zZXQocmV0LCBLQVNBTl9TSEFET1dfSU5JVCwgc2hhZG93X3NpemUpOwo+ICAgICAgICAg
ICAgICAgICAgXgo+IG1tL2thc2FuL2NvbW1vbi5jOjQ4MToxNzogbm90ZTogZWFjaCB1bmRlY2xh
cmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0
IGFwcGVhcnMgaW4KPiBtYWtlWzNdOiAqKiogW21tL2thc2FuL2NvbW1vbi5vXSBFcnJvciAxCj4g
bWFrZVszXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KPiBtYWtlWzJdOiAq
KiogW21tL2thc2FuXSBFcnJvciAyCj4gbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNo
ZWQgam9icy4uLi4KPiBtYWtlWzFdOiAqKiogW21tL10gRXJyb3IgMgo+IG1ha2U6ICoqKiBbc3Vi
LW1ha2VdIEVycm9yIDIKCkhpIFBhdWwsCgpUaGlzIGlzIG15IGJhZCwgdGhpcyBzaG91bGQgYmUg
Zml4ZWQgaW4gdjEzIG9mIHRoaXMgcGF0Y2hzZXQsIHdoaWNoIGlzCmluIG1tIHJpZ2h0IG5vdyBi
dXQgbm90IGluIGxpbnV4LW5leHQgeWV0IGFzIGl0IHNlZW1zLgoKVGhhbmtzIQoKPgo+IEFuIGF1
dG9tYXRlZCBnaXQgYmlzZWN0LXJ1biBwb2ludHMgYXQgdGhpczoKPgo+IDVjMzYyODc4MTM3MjE5
OTllNzlhYzc2ZjYzN2YxYmE3ZTUwNTQ0MDIgaXMgdGhlIGZpcnN0IGJhZCBjb21taXQKPiBjb21t
aXQgNWMzNjI4NzgxMzcyMTk5OWU3OWFjNzZmNjM3ZjFiYTdlNTA1NDQwMgo+IEF1dGhvcjogQW5k
cmV5IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPgo+IERhdGU6ICAgV2VkIERlYyA1
IDExOjEzOjIxIDIwMTggKzExMDAKPgo+ICAgICBrYXNhbjogaW5pdGlhbGl6ZSBzaGFkb3cgdG8g
MHhmZiBmb3IgdGFnLWJhc2VkIG1vZGUKPgo+IEEgcXVpY2sgbG9vayBhdCB0aGUgY29tbWl0IG1h
a2VzIG1lIHRoaW5rIHRoYXQgdGhlIGNhc2Ugd2hlcmUgdGhlCj4gIiMgQ09ORklHX0tBU0FOX0dF
TkVSSUMgaXMgbm90IHNldCIgaGFzIG5vdCBiZWVuIGhhbmRsZWQuCj4KPiBJJ20gdXNpbmcgYW4g
b2xkZXIgZ2NjIDQuOC4zIC0gb25seSB1c2VkIGZvciBidWlsZCB0ZXN0aW5nLgo+Cj4gUGF1bC4K
PiAtLQo+Cj4+ICBtbS9rYXNhbi9jb21tb24uYyAgICAgICAgICB8ICAzICsrLQo+PiAgMyBmaWxl
cyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9tbS9rYXNhbl9pbml0LmMgYi9hcmNoL2FybTY0L21tL2thc2FuX2lu
aXQuYwo+PiBpbmRleCA0ZWJjMTk0MjI5MzEuLjdhNGEwOTA0Y2FjOCAxMDA2NDQKPj4gLS0tIGEv
YXJjaC9hcm02NC9tbS9rYXNhbl9pbml0LmMKPj4gKysrIGIvYXJjaC9hcm02NC9tbS9rYXNhbl9p
bml0LmMKPj4gQEAgLTQzLDYgKzQzLDE1IEBAIHN0YXRpYyBwaHlzX2FkZHJfdCBfX2luaXQga2Fz
YW5fYWxsb2NfemVyb2VkX3BhZ2UoaW50IG5vZGUpCj4+ICAgICAgICAgcmV0dXJuIF9fcGEocCk7
Cj4+ICB9Cj4+Cj4+ICtzdGF0aWMgcGh5c19hZGRyX3QgX19pbml0IGthc2FuX2FsbG9jX3Jhd19w
YWdlKGludCBub2RlKQo+PiArewo+PiArICAgICAgIHZvaWQgKnAgPSBtZW1ibG9ja19hbGxvY190
cnlfbmlkX3JhdyhQQUdFX1NJWkUsIFBBR0VfU0laRSwKPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgX19wYShNQVhfRE1BX0FERFJFU1MpLAo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1CTE9DS19BTExP
Q19BQ0NFU1NJQkxFLAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBub2RlKTsKPj4gKyAgICAgICByZXR1cm4gX19wYShwKTsKPj4gK30KPj4gKwo+PiAg
c3RhdGljIHB0ZV90ICpfX2luaXQga2FzYW5fcHRlX29mZnNldChwbWRfdCAqcG1kcCwgdW5zaWdu
ZWQgbG9uZyBhZGRyLCBpbnQgbm9kZSwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBib29sIGVhcmx5KQo+PiAgewo+PiBAQCAtOTIsNyArMTAxLDkgQEAgc3RhdGljIHZv
aWQgX19pbml0IGthc2FuX3B0ZV9wb3B1bGF0ZShwbWRfdCAqcG1kcCwgdW5zaWduZWQgbG9uZyBh
ZGRyLAo+PiAgICAgICAgIGRvIHsKPj4gICAgICAgICAgICAgICAgIHBoeXNfYWRkcl90IHBhZ2Vf
cGh5cyA9IGVhcmx5ID8KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX3BhX3N5
bWJvbChrYXNhbl9lYXJseV9zaGFkb3dfcGFnZSkKPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDoga2FzYW5fYWxsb2NfemVyb2VkX3BhZ2Uobm9kZSk7Cj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGthc2FuX2FsbG9jX3Jhd19wYWdl
KG5vZGUpOwo+PiArICAgICAgICAgICAgICAgaWYgKCFlYXJseSkKPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgbWVtc2V0KF9fdmEocGFnZV9waHlzKSwgS0FTQU5fU0hBRE9XX0lOSVQsIFBBR0Vf
U0laRSk7Cj4+ICAgICAgICAgICAgICAgICBuZXh0ID0gYWRkciArIFBBR0VfU0laRTsKPj4gICAg
ICAgICAgICAgICAgIHNldF9wdGUocHRlcCwgcGZuX3B0ZShfX3BoeXNfdG9fcGZuKHBhZ2VfcGh5
cyksIFBBR0VfS0VSTkVMKSk7Cj4+ICAgICAgICAgfSB3aGlsZSAocHRlcCsrLCBhZGRyID0gbmV4
dCwgYWRkciAhPSBlbmQgJiYgcHRlX25vbmUoUkVBRF9PTkNFKCpwdGVwKSkpOwo+PiBAQCAtMjM5
LDcgKzI1MCw3IEBAIHZvaWQgX19pbml0IGthc2FuX2luaXQodm9pZCkKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcGZuX3B0ZShzeW1fdG9fcGZuKGthc2FuX2Vhcmx5X3NoYWRvd19wYWdlKSwK
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUdFX0tFUk5FTF9STykpOwo+Pgo+
PiAtICAgICAgIG1lbXNldChrYXNhbl9lYXJseV9zaGFkb3dfcGFnZSwgMCwgUEFHRV9TSVpFKTsK
Pj4gKyAgICAgICBtZW1zZXQoa2FzYW5fZWFybHlfc2hhZG93X3BhZ2UsIEtBU0FOX1NIQURPV19J
TklULCBQQUdFX1NJWkUpOwo+PiAgICAgICAgIGNwdV9yZXBsYWNlX3R0YnIxKGxtX2FsaWFzKHN3
YXBwZXJfcGdfZGlyKSk7Cj4+Cj4+ICAgICAgICAgLyogQXQgdGhpcyBwb2ludCBrYXNhbiBpcyBm
dWxseSBpbml0aWFsaXplZC4gRW5hYmxlIGVycm9yIG1lc3NhZ2VzICovCj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2thc2FuLmggYi9pbmNsdWRlL2xpbnV4L2thc2FuLmgKPj4gaW5kZXgg
ZWMyMmQ1NDhkMGQ3Li5jNTZhZjI0YmQzZTcgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgv
a2FzYW4uaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2thc2FuLmgKPj4gQEAgLTE1Myw2ICsxNTMs
OCBAQCBzdGF0aWMgaW5saW5lIHNpemVfdCBrYXNhbl9tZXRhZGF0YV9zaXplKHN0cnVjdCBrbWVt
X2NhY2hlICpjYWNoZSkgeyByZXR1cm4gMDsgfQo+Pgo+PiAgI2lmZGVmIENPTkZJR19LQVNBTl9H
RU5FUklDCj4+Cj4+ICsjZGVmaW5lIEtBU0FOX1NIQURPV19JTklUIDAKPj4gKwo+PiAgdm9pZCBr
YXNhbl9jYWNoZV9zaHJpbmsoc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlKTsKPj4gIHZvaWQga2Fz
YW5fY2FjaGVfc2h1dGRvd24oc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlKTsKPj4KPj4gQEAgLTE2
Myw0ICsxNjUsMTAgQEAgc3RhdGljIGlubGluZSB2b2lkIGthc2FuX2NhY2hlX3NodXRkb3duKHN0
cnVjdCBrbWVtX2NhY2hlICpjYWNoZSkge30KPj4KPj4gICNlbmRpZiAvKiBDT05GSUdfS0FTQU5f
R0VORVJJQyAqLwo+Pgo+PiArI2lmZGVmIENPTkZJR19LQVNBTl9TV19UQUdTCj4+ICsKPj4gKyNk
ZWZpbmUgS0FTQU5fU0hBRE9XX0lOSVQgMHhGRgo+PiArCj4+ICsjZW5kaWYgLyogQ09ORklHX0tB
U0FOX1NXX1RBR1MgKi8KPj4gKwo+PiAgI2VuZGlmIC8qIExJTlVYX0tBU0FOX0ggKi8KPj4gZGlm
ZiAtLWdpdCBhL21tL2thc2FuL2NvbW1vbi5jIGIvbW0va2FzYW4vY29tbW9uLmMKPj4gaW5kZXgg
NWY2OGM5MzczNGJhLi43MTM0ZTc1NDQ3ZmYgMTAwNjQ0Cj4+IC0tLSBhL21tL2thc2FuL2NvbW1v
bi5jCj4+ICsrKyBiL21tL2thc2FuL2NvbW1vbi5jCj4+IEBAIC00NzMsMTEgKzQ3MywxMiBAQCBp
bnQga2FzYW5fbW9kdWxlX2FsbG9jKHZvaWQgKmFkZHIsIHNpemVfdCBzaXplKQo+Pgo+PiAgICAg
ICAgIHJldCA9IF9fdm1hbGxvY19ub2RlX3JhbmdlKHNoYWRvd19zaXplLCAxLCBzaGFkb3dfc3Rh
cnQsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHNoYWRvd19zdGFydCArIHNoYWRvd19zaXpl
LAo+PiAtICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVMIHwgX19HRlBfWkVSTywKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCwKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgUEFHRV9LRVJORUwsIFZNX05PX0dVQVJELCBOVU1BX05PX05PREUsCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgIF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKSk7Cj4+Cj4+ICAgICAg
ICAgaWYgKHJldCkgewo+PiArICAgICAgICAgICAgICAgX19tZW1zZXQocmV0LCBLQVNBTl9TSEFE
T1dfSU5JVCwgc2hhZG93X3NpemUpOwo+PiAgICAgICAgICAgICAgICAgZmluZF92bV9hcmVhKGFk
ZHIpLT5mbGFncyB8PSBWTV9LQVNBTjsKPj4gICAgICAgICAgICAgICAgIGttZW1sZWFrX2lnbm9y
ZShyZXQpOwo+PiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+IC0tCj4+IDIuMjAuMC5yYzEu
Mzg3LmdmODUwNTc2MmUzLWdvb2cKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
