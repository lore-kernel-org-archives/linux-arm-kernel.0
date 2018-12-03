Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D7C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:25:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1082145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uKED3eTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1082145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CPD63ZCZuKdK0ERikeFQOLe3nfqdI1rIvACJhoOqhxk=; b=uKED3eTOGbjwQd
	4lmc9O+ucI+3nV4Enpg+1zXUrQfhDzYWXcKjND+6+DFAlqq5qeRIY2OaI5FNX9UM66XBREmf+bQpC
	zqU2diPlEl1Gxq+2jU95JuqR5BXjbJ3KG45AHwyxG0TE6b/yG/lcMWhbOR8rwODI2h+paDhoMgzUW
	k/RM9DgJWllEXQKb9OEMpJ55SbH2RysCMvVWTJLNi2ORX+nuwWtkivQIZAabgbjVtu5xWSazMWJ4u
	JvpeO2F0o6L/Cidkzst/wSYqHiAXk1fZJXpr4fry95baQVnhj0IXGRkpl1A+2iVxbQthMEecBmpbZ
	TaVaK6YWKyRp3/ZldPsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsuH-00088y-7Z; Mon, 03 Dec 2018 18:25:21 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsuD-0007D7-5a
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:25:19 +0000
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so12326193ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 10:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WgJilwBUStRKSYZLqAxIg/s8z1+rPB4jtNqLSi/f7zA=;
 b=p7uA+V9x8X8InbrzHgiwYUqErpLp+b0bEbskvVP3vD1YCvUT4GG4ywLwIcmWuMpozG
 iMry+LEhZvwmG6w027kLYqWtPz1VfzZz/I/N5UV3RvyIbwpNzn8GZ+Gi9/5/KuKlJtBa
 IQC9D+HopiORvERBiuT3dFdGaPY3fuQA7Zkv52EOnXnHPV9Yuq9shhL6ATnqpfrbOsYV
 DzZeq1gXZb7zTmUVA8sKkHZDUPoqQInP1lqBQL7mBjDR2Oq89IbeJ/ctQ7S/2O/49BtV
 1PeofEcuDRpsBMlY9ge3g20ox0Oe+qNP8mFMHLvdQ7huRhi0ELKTvWgFl03/qYms2jS6
 nW6Q==
X-Gm-Message-State: AA+aEWZ3GM3065npJwlFAjll7VhQZAhR/8jkGB8yZrPEX5N9o/2deUdY
 +Wj56edvB9nN0Fqq5lF3N8k=
X-Google-Smtp-Source: AFSGD/Wd9zZ1suZVBNqPGdt7RiHv4a1eiguzhdCRVgSqxQ9yB6iDp1nbNX0umvrSNeoOB5q9hJyU3g==
X-Received: by 2002:a2e:2909:: with SMTP id
 u9-v6mr10831504lje.28.1543861504746; 
 Mon, 03 Dec 2018 10:25:04 -0800 (PST)
Received: from [192.168.42.35] ([213.87.151.70])
 by smtp.gmail.com with ESMTPSA id q67sm2510847lfe.19.2018.12.03.10.25.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 10:25:03 -0800 (PST)
Subject: Re: [PATCH 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the 'mach' pass
To: Kees Cook <keescook@chromium.org>
References: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
 <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
 <CAGXu5jKcRLcAg7r-E-9LMjK0YisLJp2TVYoiBwE+4ctYzi5wkg@mail.gmail.com>
From: Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <e1259720-423c-c1ca-1fe5-b9ef89ad19a3@linux.com>
Date: Mon, 3 Dec 2018 21:25:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKcRLcAg7r-E-9LMjK0YisLJp2TVYoiBwE+4ctYzi5wkg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_102517_218121_50DFA61C 
X-CRM114-Status: GOOD (  19.34  )
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
Reply-To: alex.popov@linux.com
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
 Emese Revfy <re.emese@gmail.com>, Laura Abbott <labbott@redhat.com>,
 Segher Boessenkool <segher@kernel.crashing.org>, Jann Horn <jannh@google.com>,
 amonakov@ispras.ru, Steven Rostedt <rostedt@goodmis.org>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Florian Weimer <fweimer@redhat.com>, gcc@gcc.gnu.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMzAuMTEuMjAxOCAyMDoxMiwgS2VlcyBDb29rIHdyb3RlOgo+IE9uIEZyaSwgTm92IDMwLCAy
MDE4IGF0IDk6MDkgQU0gS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+IHdyb3RlOgo+
Pgo+PiBPbiBGcmksIE5vdiAzMCwgMjAxOCBhdCA1OjIwIEFNIEFsZXhhbmRlciBQb3BvdiA8YWxl
eC5wb3BvdkBsaW51eC5jb20+IHdyb3RlOgo+Pj4KPj4+IEN1cnJlbnRseSB0aGUgJ3N0YWNrbGVh
a19jbGVhbnVwJyBwYXNzIGRlbGV0aW5nIGEgQ0FMTCBpbnNuIGlzIGV4ZWN1dGVkCj4+PiBhZnRl
ciB0aGUgJ3JlbG9hZCcgcGFzcy4gVGhhdCBhbGxvd3MgZ2NjIHRvIGRvIHNvbWUgd2VpcmQgb3B0
aW1pemF0aW9uIGluCj4+PiBmdW5jdGlvbiBwcm9sb2d1ZXMgYW5kIGVwaWxvZ3Vlcywgd2hpY2gg
YXJlIGdlbmVyYXRlZCBsYXRlciBbMV0uCj4+Pgo+Pj4gTGV0J3MgYXZvaWQgdGhhdCBieSByZWdp
c3RlcmluZyB0aGUgJ3N0YWNrbGVha19jbGVhbnVwJyBwYXNzIGJlZm9yZQo+Pj4gdGhlICdtYWNo
JyBwYXNzLCB3aGljaCBwZXJmb3JtcyB0aGUgbWFjaGluZSBkZXBlbmRlbnQgY29kZSB0cmFuc2Zv
cm1hdGlvbnMuCj4+PiBJdCdzIHRoZSBtb21lbnQgd2hlbiB0aGUgc3RhY2sgZnJhbWUgc2l6ZSBp
cyBmaW5hbCBhbmQgZnVuY3Rpb24gcHJvbG9ndWVzCj4+PiBhbmQgZXBpbG9ndWVzIGFyZSBhbHJl
YWR5IGdlbmVyYXRlZC4KPj4+Cj4+PiBbMV0gaHR0cHM6Ly93d3cub3BlbndhbGwuY29tL2xpc3Rz
L2tlcm5lbC1oYXJkZW5pbmcvMjAxOC8xMS8yMy8yCj4+Pgo+Pj4gUmVwb3J0ZWQtYnk6IGtidWls
ZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVy
IFBvcG92IDxhbGV4LnBvcG92QGxpbnV4LmNvbT4KPj4KPj4gVGhhbmtzLCBhcHBsaWVkIQo+IAo+
IEVlaywgbm8sIHRoaXMgaXMgYnJlYWtpbmcgbXkgYnVpbGQgYmFkbHk6Cj4gCj4gKioqIFdBUk5J
TkcgKioqIHRoZXJlIGFyZSBhY3RpdmUgcGx1Z2lucywgZG8gbm90IHJlcG9ydCB0aGlzIGFzIGEg
YnVnCj4gdW5sZXNzIHlvdSBjYW4gcmVwcm9kdWNlIGl0IHdpdGhvdXQgZW5hYmxpbmcgYW55IHBs
dWdpbnMuCj4gRXZlbnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBQbHVnaW5zCj4gUExV
R0lOX1NUQVJUX1VOSVQgICAgICAgICAgICAgICAgfCBzdGFja2xlYWtfcGx1Z2luCj4ga2VybmVs
L2V4aXQuYzogSW4gZnVuY3Rpb24g4oCYcmVsZWFzZV90YXNr4oCZOgo+IGtlcm5lbC9leGl0LmM6
MjI4OjE6IGludGVybmFsIGNvbXBpbGVyIGVycm9yOiBTZWdtZW50YXRpb24gZmF1bHQKPiAgfQo+
IAo+IEZhaWxpbmcgd2l0aDoKPiAKPiBnY2MgKFVidW50dSA3LjMuMC0xNnVidW50dTMpIDcuMy4w
CgpJJ3ZlIGRvbmUgZGVidWdnaW5nIG9mIGdjYyB3aXRoIGdkYiBhbmQgbm93IHVuZGVyc3RhbmQg
bXkgbWlzdGFrZS4KCkl0IHR1cm5lZCBvdXQgdGhhdCBJIHJlZ2lzdGVyIHRoZSAnc3RhY2tsZWFr
X2NsZWFudXAnIHBhc3MgZGVsZXRpbmcgQ0FMTCBpbnNuCmZvciB0aGF0IHBhcnRpY3VsYXIgbW9t
ZW50IHdoZW4gdGhlIGNvbnRyb2wgZmxvdyBncmFwaCBpcyBpbmNvbnNpc3RlbnQuCgpUaGF0J3Mg
d2hhdCB0aGUgbWFjaGluZS1zcGVjaWZpYyByZW9yZyBwYXNzZXMgZG8gb24gdmFyaW91cyBhcmNo
aXRlY3R1cmVzOgoKICAvKiBXZSBhcmUgZnJlZWluZyBibG9ja19mb3JfaW5zbiBpbiB0aGUgdG9w
bGV2IHRvIGtlZXAgY29tcGF0aWJpbGl0eQogICAgIHdpdGggb2xkIE1ERVBfUkVPUkdTIHRoYXQg
YXJlIG5vdCBDRkcgYmFzZWQuICBSZWNvbXB1dGUgaXQgbm93LiAgKi8KICBjb21wdXRlX2JiX2Zv
cl9pbnNuICgpOwoKU28gcmVjb21wdXRpbmcgYmFzaWMgYmxvY2sgaW5mbyBmb3IgaW5zbnMgYmVm
b3JlIGNhbGxpbmcgZGVsZXRlX2luc25fYW5kX2VkZ2VzKCkKZml4ZXMgdGhlIGlzc3VlLgoKQnV0
IEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gcmVnaXN0ZXIgdGhlICdzdGFja2xlYWtfY2xlYW51cCcg
cGFzcyBqdXN0IG9uZSBwYXNzCmVhcmxpZXIgLS0gYmVmb3JlIHRoZSAnKmZyZWVfY2ZnJyBwYXNz
LiBJJ2xsIGRvdWJsZSBjaGVjayBpdCBmb3IgZGlmZmVyZW50CnZlcnNpb25zIG9mIGdjYyBvbiBh
bGwgc3VwcG9ydGVkIGFyY2hpdGVjdHVyZXMgYW5kIHJldHVybiB3aXRoIGEgbmV3IHBhdGNoLgoK
QmVzdCByZWdhcmRzLApBbGV4YW5kZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
