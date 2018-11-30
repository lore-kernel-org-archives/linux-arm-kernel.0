Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:22:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936502146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rjbTXWFj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HUb14pqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936502146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yJR6cOVzcOdjADJ2Om8WZfhJ++KdjT0zUJ9f/uJTKb0=; b=rjbTXWFjutr1TR
	WWSafK7yhPdJYwouRnD53YMd9+PAmSEvoQ3ycd2CgsbQK1GYB3ENMvrrjyCx0oTaAStpiRsHStlni
	k86YAjM1CQEiBq97wu9oREsC156IPYo7VCourJ3SDwHs0IplUbYeu7/sg2Q2VytwcuGpbIEBlmt81
	/dz2KM1QHHL/B3SBmEX+mJ7QDoc865uMI+nTE/ENs00KXGftHaiGDRyRZSLwIsU1o1RcmB6uloo0A
	e6uFZI+f9jj1YQfbTY3VN7kSKmSbnUBj2gce65y7JC+2DxX9iJ01NeJuXgCdaU/E5hOG1YjA9piaJ
	UURlM8K5cNQ9HXuIS3bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmUF-0003MF-T7; Fri, 30 Nov 2018 17:21:55 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmRo-0000Ou-JO
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:19:38 +0000
Received: by mail-yb1-xb43.google.com with SMTP id a67-v6so2515721ybg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 09:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QkzUvpQuJ8ST4pylyvDHIiPnZIKJ3MooKGdce0pdQ0w=;
 b=HUb14pqW3xOlVjm+6lWQd/ZwKcC5V76i+K/+bOfHw4eVCu2Jpb0IFgvszRTm7CTbO6
 +jshAgHfYrgcnINhwn5zze8ZNQsaDzhQxOvztPCcr+ii5zat0KpjqiUpJ0nO+qf4zQkA
 qmBVX+3acnqilv6kGmLezK35ANQNfYT5pQOjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QkzUvpQuJ8ST4pylyvDHIiPnZIKJ3MooKGdce0pdQ0w=;
 b=iK2CJIhrRwa0oO3uw1QBCjfgnTKMjo2Eh81mp9XH9c6Z78f7+VjAk+8zMDdP0TJi6I
 YgEM1In9QbHqGZP8JkrmEnVrgeY2vO2XJw3i+WsglTb1OD7cPCfkzxxYXl/j6m5KCzam
 jLtwcXsPAMxdttGBztCZd4cbwbUeNLjcVRpf3LXoetYkKlzpLvzey2gxQYUzSjHh9dre
 Jk+QodHov52SOrYrcANIV4lRZILAo0d03mNsmv+8+FOlD5pe9yH2hwouTGqzEHXxUT2d
 I2ZAHgyI2s0P9r9Tg9RL8SQ3a7eYbQjdqrLENOzbcIPo2VOQiB+2GUxxR/WcXFj7cFs6
 fx+w==
X-Gm-Message-State: AA+aEWZ07GjuB5l+z8YpKe6jwg+IC2/6oE04YDQMfngpbS7/9ETntCQv
 U7dbOpUotkwCsmyBJ1+N5YWaXA1H9G4=
X-Google-Smtp-Source: AFSGD/VF57uUnOrcf8RfNUgi47bk+u9X0a7GVrObGepiaP9QvqHe8GOGu8y6ZA5TZTkpwGB7ZCKRnA==
X-Received: by 2002:a25:5b03:: with SMTP id
 p3-v6mr6121559ybb.385.1543598352903; 
 Fri, 30 Nov 2018 09:19:12 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173])
 by smtp.gmail.com with ESMTPSA id n16sm2378158ywn.31.2018.11.30.09.19.12
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 09:19:12 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id i78-v6so2513021ybg.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 09:19:12 -0800 (PST)
X-Received: by 2002:a25:1cc1:: with SMTP id
 c184-v6mr6336927ybc.421.1543597957550; 
 Fri, 30 Nov 2018 09:12:37 -0800 (PST)
MIME-Version: 1.0
References: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
 <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
In-Reply-To: <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 30 Nov 2018 09:12:26 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKcRLcAg7r-E-9LMjK0YisLJp2TVYoiBwE+4ctYzi5wkg@mail.gmail.com>
Message-ID: <CAGXu5jKcRLcAg7r-E-9LMjK0YisLJp2TVYoiBwE+4ctYzi5wkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the 'mach' pass
To: Alexander Popov <alex.popov@linux.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091924_705525_B7C8D661 
X-CRM114-Status: GOOD (  20.20  )
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

T24gRnJpLCBOb3YgMzAsIDIwMTggYXQgOTowOSBBTSBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9t
aXVtLm9yZz4gd3JvdGU6Cj4KPiBPbiBGcmksIE5vdiAzMCwgMjAxOCBhdCA1OjIwIEFNIEFsZXhh
bmRlciBQb3BvdiA8YWxleC5wb3BvdkBsaW51eC5jb20+IHdyb3RlOgo+ID4KPiA+IEN1cnJlbnRs
eSB0aGUgJ3N0YWNrbGVha19jbGVhbnVwJyBwYXNzIGRlbGV0aW5nIGEgQ0FMTCBpbnNuIGlzIGV4
ZWN1dGVkCj4gPiBhZnRlciB0aGUgJ3JlbG9hZCcgcGFzcy4gVGhhdCBhbGxvd3MgZ2NjIHRvIGRv
IHNvbWUgd2VpcmQgb3B0aW1pemF0aW9uIGluCj4gPiBmdW5jdGlvbiBwcm9sb2d1ZXMgYW5kIGVw
aWxvZ3Vlcywgd2hpY2ggYXJlIGdlbmVyYXRlZCBsYXRlciBbMV0uCj4gPgo+ID4gTGV0J3MgYXZv
aWQgdGhhdCBieSByZWdpc3RlcmluZyB0aGUgJ3N0YWNrbGVha19jbGVhbnVwJyBwYXNzIGJlZm9y
ZQo+ID4gdGhlICdtYWNoJyBwYXNzLCB3aGljaCBwZXJmb3JtcyB0aGUgbWFjaGluZSBkZXBlbmRl
bnQgY29kZSB0cmFuc2Zvcm1hdGlvbnMuCj4gPiBJdCdzIHRoZSBtb21lbnQgd2hlbiB0aGUgc3Rh
Y2sgZnJhbWUgc2l6ZSBpcyBmaW5hbCBhbmQgZnVuY3Rpb24gcHJvbG9ndWVzCj4gPiBhbmQgZXBp
bG9ndWVzIGFyZSBhbHJlYWR5IGdlbmVyYXRlZC4KPiA+Cj4gPiBbMV0gaHR0cHM6Ly93d3cub3Bl
bndhbGwuY29tL2xpc3RzL2tlcm5lbC1oYXJkZW5pbmcvMjAxOC8xMS8yMy8yCj4gPgo+ID4gUmVw
b3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZGVyIFBvcG92IDxhbGV4LnBvcG92QGxpbnV4LmNvbT4KPgo+IFRoYW5rcywg
YXBwbGllZCEKCkVlaywgbm8sIHRoaXMgaXMgYnJlYWtpbmcgbXkgYnVpbGQgYmFkbHk6CgoqKiog
V0FSTklORyAqKiogdGhlcmUgYXJlIGFjdGl2ZSBwbHVnaW5zLCBkbyBub3QgcmVwb3J0IHRoaXMg
YXMgYSBidWcKdW5sZXNzIHlvdSBjYW4gcmVwcm9kdWNlIGl0IHdpdGhvdXQgZW5hYmxpbmcgYW55
IHBsdWdpbnMuCkV2ZW50ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgUGx1Z2lucwpQTFVH
SU5fU1RBUlRfVU5JVCAgICAgICAgICAgICAgICB8IHN0YWNrbGVha19wbHVnaW4Ka2VybmVsL2V4
aXQuYzogSW4gZnVuY3Rpb24g4oCYcmVsZWFzZV90YXNr4oCZOgprZXJuZWwvZXhpdC5jOjIyODox
OiBpbnRlcm5hbCBjb21waWxlciBlcnJvcjogU2VnbWVudGF0aW9uIGZhdWx0CiB9CgpGYWlsaW5n
IHdpdGg6CgpnY2MgKFVidW50dSA3LjMuMC0xNnVidW50dTMpIDcuMy4wCgotS2VlcwoKPgo+IC1L
ZWVzCj4KPiA+IC0tLQo+ID4gIHNjcmlwdHMvZ2NjLXBsdWdpbnMvc3RhY2tsZWFrX3BsdWdpbi5j
IHwgOCArKysrKy0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2NjLXBsdWdpbnMvc3RhY2ts
ZWFrX3BsdWdpbi5jIGIvc2NyaXB0cy9nY2MtcGx1Z2lucy9zdGFja2xlYWtfcGx1Z2luLmMKPiA+
IGluZGV4IDJmNDhkYTkuLjZmNDFiMzIgMTAwNjQ0Cj4gPiAtLS0gYS9zY3JpcHRzL2djYy1wbHVn
aW5zL3N0YWNrbGVha19wbHVnaW4uYwo+ID4gKysrIGIvc2NyaXB0cy9nY2MtcGx1Z2lucy9zdGFj
a2xlYWtfcGx1Z2luLmMKPiA+IEBAIC0zNjMsMTAgKzM2MywxMiBAQCBfX3Zpc2libGUgaW50IHBs
dWdpbl9pbml0KHN0cnVjdCBwbHVnaW5fbmFtZV9hcmdzICpwbHVnaW5faW5mbywKPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBU1NfUE9TX0lOU0VS
VF9CRUZPUkUpOwo+ID4KPiA+ICAgICAgICAgLyoKPiA+IC0gICAgICAgICogVGhlIHN0YWNrbGVh
a19jbGVhbnVwIHBhc3Mgc2hvdWxkIGJlIGV4ZWN1dGVkIGFmdGVyIHRoZQo+ID4gLSAgICAgICAg
KiAicmVsb2FkIiBwYXNzLCB3aGVuIHRoZSBzdGFjayBmcmFtZSBzaXplIGlzIGZpbmFsLgo+ID4g
KyAgICAgICAgKiBUaGUgc3RhY2tsZWFrX2NsZWFudXAgcGFzcyBzaG91bGQgYmUgZXhlY3V0ZWQg
YmVmb3JlIHRoZSAibWFjaCIKPiA+ICsgICAgICAgICogcGFzcywgd2hpY2ggcGVyZm9ybXMgdGhl
IG1hY2hpbmUgZGVwZW5kZW50IGNvZGUgdHJhbnNmb3JtYXRpb25zLgo+ID4gKyAgICAgICAgKiBJ
dCdzIHRoZSBtb21lbnQgd2hlbiB0aGUgc3RhY2sgZnJhbWUgc2l6ZSBpcyBhbHJlYWR5IGZpbmFs
IGFuZAo+ID4gKyAgICAgICAgKiBmdW5jdGlvbiBwcm9sb2d1ZXMgYW5kIGVwaWxvZ3VlcyBhcmUg
Z2VuZXJhdGVkLgo+ID4gICAgICAgICAgKi8KPiA+IC0gICAgICAgUEFTU19JTkZPKHN0YWNrbGVh
a19jbGVhbnVwLCAicmVsb2FkIiwgMSwgUEFTU19QT1NfSU5TRVJUX0FGVEVSKTsKPiA+ICsgICAg
ICAgUEFTU19JTkZPKHN0YWNrbGVha19jbGVhbnVwLCAibWFjaCIsIDEsIFBBU1NfUE9TX0lOU0VS
VF9CRUZPUkUpOwo+ID4KPiA+ICAgICAgICAgaWYgKCFwbHVnaW5fZGVmYXVsdF92ZXJzaW9uX2No
ZWNrKHZlcnNpb24sICZnY2NfdmVyc2lvbikpIHsKPiA+ICAgICAgICAgICAgICAgICBlcnJvcihH
XygiaW5jb21wYXRpYmxlIGdjYy9wbHVnaW4gdmVyc2lvbnMiKSk7Cj4gPiAtLQo+ID4gMi43LjQK
PiA+Cj4KPgo+IC0tCj4gS2VlcyBDb29rCgoKCi0tIApLZWVzIENvb2sKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
