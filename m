Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:18:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887D02077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CMdVPPQR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyM3e1Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887D02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zqIP3ah70P5QnsWUmD2s8e1A1sQE8SDiy+PYReoXQnY=; b=CMdVPPQRhc05eL
	6C2slBf9GUaG0SKOFtN67r4yNFLAcLDd4g/2uvhguHTxhKtypRkhTXgif9br4Efi9auPaWpF5zebL
	SwIwQh6kK4eUUh0mdRsYnFHir1TO8nWGXPXcaBClIDzi9jgks5/sgU0DMOcBb47INrAVay2MpMBfr
	f2OfCXpqCFlg8/KrHG/1DOglDkT5QeBhFJxOe1ciVmVD5KeLUdW8ymIYuTZyUgoQ+v+MFbf8fbLxm
	EFCKDsjPJv9hHVapBv5qEclTkW2jeW9WYBJvZWEo9msXJ2KVkVmzCa3D3A0P5Aij4bamM0gWsTljR
	qgnk/YRKXXQJEuZtpdiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJiQ-0004FL-ET; Thu, 14 Feb 2019 16:18:22 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJiI-0004DR-3u
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:18:19 +0000
Received: by mail-it1-x142.google.com with SMTP id z9so14490734itc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TlrUo1nz8e5UjEpq94TBOhHzkFofvLch+Eitz9P/X5I=;
 b=qyM3e1Y2NMp9HyAxWyqJlw9SXaIfg+J4UanPqcCWH+9vEXkTi2WJgOA2Iiw6lzdl1V
 WrP27pkxz11JHMRSpOoCZ1/IjqPwJrTfWRJXbkaBzMt6+M7/O8YcKuf22nDUsbngwzzu
 luOFWnLux/m3iRDYKaCulWfqtv9y/o+AOmk379cYEaOV/KwoVnqxlSH1GM652nB6dRFd
 9OPcy4j+YW+fLnbh1l4pOrvy+Rm3tuvRTHm6dZNPsjQwY/ozyss1WfALHyQd4yEMeNdy
 4ka6aIT6hV7+pmX6WgEvH3GzAXw9jcYXYdY4DoBWqVamfIGRLpoaNR4ANtYynLnDwpRB
 QV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TlrUo1nz8e5UjEpq94TBOhHzkFofvLch+Eitz9P/X5I=;
 b=DRorJ62pA2wzesyUiL7uwQ6oeJlhv9NvnDJ7E+EiM8ySXAP8ScmTFqRJMD3ZZdmP9y
 MzPk+96BNdGWWELrORg/u2dgU6S53je41p3ntsNv4csrV0+rjfyhKelOgaGoVzEIRI+c
 A45nGsg2JXOBu9sD0HrAd+If6GGurrnVH/Gnvt9t6UtKuI57UhsSEsk5DZJeZUtl4uW/
 ak8N7mLFNcK9CWEyFjhaXBgqO80ydpSTmLY5LMlmZSGU4fiydMVBHu72Lxv/tO3hDh/C
 VxbEhlX/vrnKIxcgCo3k9F11UzMvu+/MF3ULjHs+jAJ86lR65bYpg9Bv81zQY2RUzsuQ
 IWXw==
X-Gm-Message-State: AHQUAuZ2Td7J8BBCwhk55E+0DN7pm4q2g5W0f64eCbgA+0WusizxRJoj
 G2EjSAgQhW/+DT3fd93PT4Q8DoOnuoVWp58U8g==
X-Google-Smtp-Source: AHgI3IaI3t2OpJb1Us8EHtDJzIQE6azZFuSiFBRGFYvHqGWr/GB8pA9bvL1pwN3seKIIl00V+5bONrK0RbUeUwNUNUA=
X-Received: by 2002:a24:3953:: with SMTP id l80mr2663005ita.108.1550161092706; 
 Thu, 14 Feb 2019 08:18:12 -0800 (PST)
MIME-Version: 1.0
References: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 14 Feb 2019 11:18:01 -0500
Message-ID: <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_081814_185972_1CCC364F 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBGZWIgMTQsIDIwMTkgYXQgNToxNCBBTSBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gT24gV2VkLCBGZWIgMTMsIDIwMTkgYXQgMDI6NDk6NDdQ
TSAtMDgwMCwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+Cj4gPiBEbyB3ZSBuZWVkIHRvIGJhY2tw
b3J0IHRoaXMgdGhpbmc/Cj4KPiBQb3NzaWJseSwganVzdCB0byBiZSBzYWZlLgo+Cj4gPiBUaGUg
cHJvYmxlbSBjYW7igJl0IGJlIHRvbyB3aWRlc3ByZWFkIG9yIHdlIHdvdWxkIGhhdmUgaGVhcmQg
b2YgaXQgYmVmb3JlLgo+Cj4gWWVzLCBzbyBmYXIgd2UndmUgYmVlbiBsdWNreS4KPgo+IC0tLQo+
IFN1YmplY3Q6IHNjaGVkL3g4NjogU2F2ZSBbRVJdRkxBR1Mgb24gY29udGV4dCBzd2l0Y2gKPiBG
cm9tOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Cj4gRGF0ZTogVGh1IEZl
YiAxNCAxMDozMDo1MiBDRVQgMjAxOQo+Cj4gRWZmZWN0aXZlbHkgcmV2ZXJ0IGNvbW1pdDoKPgo+
ICAgMmM3NTc3YTc1ODM3ICgic2NoZWQveDg2XzY0OiBEb24ndCBzYXZlIGZsYWdzIG9uIGNvbnRl
eHQgc3dpdGNoIikKPgo+IFNwZWNpZmljYWxseSBiZWNhdXNlIFNNQVAgdXNlcyBGTEFHUy5BQyB3
aGljaCBpbnZhbGlkYXRlcyB0aGUgY2xhaW0KPiB0aGF0IHRoZSBrZXJuZWwgaGFzIGNsZWFuIGZs
YWdzLgo+Cj4gSW4gcGFydGljdWxhcjsgd2hpbGUgcHJlZW1wdGlvbiBmcm9tIGludGVycnVwdCBy
ZXR1cm4gaXMgZmluZSAodGhlCj4gSVJFVCBmcmFtZSBvbiB0aGUgZXhjZXB0aW9uIHN0YWNrIGNv
bnRhaW5zIEZMQUdTKSBpdCBicmVha3MgYW55IGNvZGUKPiB0aGF0IGRvZXMgc3luY2hvbm91cyBz
Y2hlZHVsaW5nLCBpbmNsdWRpbmcgcHJlZW1wdF9lbmFibGUoKS4KPgo+IFRoaXMgaGFzIGJlY29t
ZSBhIHNpZ25pZmljYW50IGlzc3VlIGV2ZXIgc2luY2UgY29tbWl0Ogo+Cj4gICA1YjI0YTdhMmFh
MjAgKCJBZGQgJ3Vuc2FmZScgdXNlciBhY2Nlc3MgZnVuY3Rpb25zIGZvciBiYXRjaGVkIGFjY2Vz
c2VzIikKPgo+IHByb3ZpZGVkIGZvciBtZWFucyBvZiBoYXZpbmcgJ25vcm1hbCcgQyBjb2RlIGJl
dHdlZW4gU1RBQyAvIENMQUMsCj4gZXhwb3NpbmcgdGhlIEZMQUdTLkFDIHN0YXRlLiBTbyBmYXIg
dGhpcyBoYXNuJ3QgbGVkIHRvIHRyb3VibGUsCj4gaG93ZXZlciBmaXggaXQgYmVmb3JlIGl0IGNv
bWVzIGFwYXJ0Lgo+Cj4gRml4ZXM6IDViMjRhN2EyYWEyMCAoIkFkZCAndW5zYWZlJyB1c2VyIGFj
Y2VzcyBmdW5jdGlvbnMgZm9yIGJhdGNoZWQgYWNjZXNzZXMiKQo+IEFja2VkLWJ5OiBBbmR5IEx1
dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+Cj4gUmVwb3J0ZWQtYnk6IEp1bGllbiBUaGll
cnJ5IDxqdWxpZW4udGhpZXJyeUBhcm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFppamxz
dHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPgo+IC0tLQo+ICBhcmNoL3g4Ni9lbnRy
eS9lbnRyeV8zMi5TICAgICAgICB8ICAgIDIgKysKPiAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQu
UyAgICAgICAgfCAgICAyICsrCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3N3aXRjaF90by5oIHwg
ICAgMSArCj4gIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4KPiAtLS0gYS9hcmNo
L3g4Ni9lbnRyeS9lbnRyeV8zMi5TCj4gKysrIGIvYXJjaC94ODYvZW50cnkvZW50cnlfMzIuUwo+
IEBAIC02NTAsNiArNjUwLDcgQEAgRU5UUlkoX19zd2l0Y2hfdG9fYXNtKQo+ICAgICAgICAgcHVz
aGwgICAlZWJ4Cj4gICAgICAgICBwdXNobCAgICVlZGkKPiAgICAgICAgIHB1c2hsICAgJWVzaQo+
ICsgICAgICAgcHVzaGZsCj4KPiAgICAgICAgIC8qIHN3aXRjaCBzdGFjayAqLwo+ICAgICAgICAg
bW92bCAgICAlZXNwLCBUQVNLX3RocmVhZHNwKCVlYXgpCj4gQEAgLTY3Miw2ICs2NzMsNyBAQCBF
TlRSWShfX3N3aXRjaF90b19hc20pCj4gICNlbmRpZgo+Cj4gICAgICAgICAvKiByZXN0b3JlIGNh
bGxlZS1zYXZlZCByZWdpc3RlcnMgKi8KPiArICAgICAgIHBvcGZsCj4gICAgICAgICBwb3BsICAg
ICVlc2kKPiAgICAgICAgIHBvcGwgICAgJWVkaQo+ICAgICAgICAgcG9wbCAgICAlZWJ4Cj4gLS0t
IGEvYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUwo+ICsrKyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5
XzY0LlMKPiBAQCAtMjkxLDYgKzI5MSw3IEBAIEVOVFJZKF9fc3dpdGNoX3RvX2FzbSkKPiAgICAg
ICAgIHB1c2hxICAgJXIxMwo+ICAgICAgICAgcHVzaHEgICAlcjE0Cj4gICAgICAgICBwdXNocSAg
ICVyMTUKPiArICAgICAgIHB1c2hmcQo+Cj4gICAgICAgICAvKiBzd2l0Y2ggc3RhY2sgKi8KPiAg
ICAgICAgIG1vdnEgICAgJXJzcCwgVEFTS190aHJlYWRzcCglcmRpKQo+IEBAIC0zMTMsNiArMzE0
LDcgQEAgRU5UUlkoX19zd2l0Y2hfdG9fYXNtKQo+ICAjZW5kaWYKPgo+ICAgICAgICAgLyogcmVz
dG9yZSBjYWxsZWUtc2F2ZWQgcmVnaXN0ZXJzICovCj4gKyAgICAgICBwb3BmcQo+ICAgICAgICAg
cG9wcSAgICAlcjE1Cj4gICAgICAgICBwb3BxICAgICVyMTQKPiAgICAgICAgIHBvcHEgICAgJXIx
Mwo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N3aXRjaF90by5oCj4gKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmgKPiBAQCAtNDAsNiArNDAsNyBAQCBhc21saW5rYWdl
IHZvaWQgcmV0X2Zyb21fZm9yayh2b2lkKTsKPiAgICogb3JkZXIgb2YgdGhlIGZpZWxkcyBtdXN0
IG1hdGNoIHRoZSBjb2RlIGluIF9fc3dpdGNoX3RvX2FzbSgpLgo+ICAgKi8KPiAgc3RydWN0IGlu
YWN0aXZlX3Rhc2tfZnJhbWUgewo+ICsgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsKPiAgI2lm
ZGVmIENPTkZJR19YODZfNjQKPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgcjE1Owo+ICAgICAgICAg
dW5zaWduZWQgbG9uZyByMTQ7CgpmbGFncyBzaG91bGQgYmUgaW5pdGlhbGl6ZWQgaW4gY29weV90
aHJlYWRfdGxzKCkuICBJIHRoaW5rIHRoZSBuZXcKc3RhY2sgaXMgemVyb2VkIGFscmVhZHksIGJ1
dCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZXhwbGljaXRseSBzZXQgaXQuCgotLQpCcmlhbiBHZXJz
dAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
