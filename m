Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DF3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:10:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFB6206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XcnxE2l/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zolf57rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFB6206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bdsPOxFqPSAPBhweKa5YaNHSdG+qs9J2t7nY2Uj+jco=; b=XcnxE2l/x5H8/v
	hnu5BDVjrDWaz+E+SvCi4J8HvqGG+Kh1VrQOcSqmjxBg/KyBzm/Se44AzQILW8wuQqqMgdCbEn9zv
	JxxM7s5czZuRJ2qFxJcjuZFbwCwMxv3F+041kV72I7B+Ttz+v0M2PPaahRBo+6iVAkws1T0f10XNC
	TnJCVqe9tN2eGoRwAHOcpxcFklFzJtkMbhhuXjvot8iu8GJLqOpTv0cCRjyqfihJvH3pLydnrhDAo
	INk7aYpAW1iSoxqvmGZguEz3iFzSJbEliBrmEeY65RhzAYb2t+ZvvWeCDdep+rCtUCHDm2W9qVkjQ
	SqX/lVZIXhyf+3DocNDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvpu-0007MR-ES; Tue, 08 Jan 2019 18:10:46 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvps-0007Lo-53
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 18:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T3iTnh57kzVxJcAuvKz5aP7nA3Q+rhPL2pjgwxTnGUY=; b=zolf57rz5cIHdRApPILVcKLMBK
 1cfTjGAjFHlmSzLIKageUjqC+IhT1EclSgFXKqqIeCLjx1MfztCl+2zWuiUq3DJag3mIANGKYOQuU
 YwqDWaMsqwCW4D8TzYE9vEc79cO13xUoMmP74NODijrze1PSnBzhGeWyA3of5BMkQCe2PrStiYHpF
 fOOY6BRperP9mCZdHVm0Ly2MAT/W8b+Ak0FAvomdraQonTE5Ah2cuk1B82bfeXyWBcmAS2/yA+ma3
 HkX2As0gllPspUUIiOdbgPq9w23MH808BVtzGXawTWoj/fNOTGFeBVJFsi0DJFweEYlLUeIT+rdct
 6LgYtp0w==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvhM-0002qp-9v
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 18:01:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02538A78;
 Tue,  8 Jan 2019 10:01:54 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBDEE3F5AF;
 Tue,  8 Jan 2019 10:01:51 -0800 (PST)
Date: Tue, 8 Jan 2019 18:01:49 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190108180149.GC5840@e103592.cambridge.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190108153957.GA5840@e103592.cambridge.arm.com>
 <8cae8016-d2c7-3c86-9832-f4278d42ea21@arm.com>
 <20190108164510.GB5840@e103592.cambridge.arm.com>
 <64a0dc42-0398-95ac-2c28-88797f969cef@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <64a0dc42-0398-95ac-2c28-88797f969cef@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_130156_501900_9A794794 
X-CRM114-Status: GOOD (  42.70  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMDgsIDIwMTkgYXQgMDU6MTY6NDNQTSArMDAwMCwgTWFyYyBaeW5naWVyIHdy
b3RlOgo+IE9uIDA4LzAxLzIwMTkgMTY6NDUsIERhdmUgTWFydGluIHdyb3RlOgo+ID4gT24gVHVl
LCBKYW4gMDgsIDIwMTkgYXQgMDM6NTE6MThQTSArMDAwMCwgTWFyYyBaeW5naWVyIHdyb3RlOgo+
ID4+IE9uIDA4LzAxLzIwMTkgMTU6NDAsIERhdmUgTWFydGluIHdyb3RlOgo+ID4+PiBPbiBUdWUs
IEphbiAwOCwgMjAxOSBhdCAwMjowNzozMFBNICswMDAwLCBKdWxpZW4gVGhpZXJyeSB3cm90ZToK
PiA+Pj4+IEluc3RlYWQgZGlzYWJsaW5nIGludGVycnVwdHMgYnkgc2V0dGluZyB0aGUgUFNSLkkg
Yml0LCB1c2UgYSBwcmlvcml0eQo+ID4+Pj4gaGlnaGVyIHRoYW4gdGhlIG9uZSB1c2VkIGZvciBp
bnRlcnJ1cHRzIHRvIG1hc2sgdGhlbSB2aWEgUE1SLgo+ID4+Pj4KPiA+Pj4+IFdoZW4gdXNpbmcg
UE1SIHRvIGRpc2FibGUgaW50ZXJydXB0cywgdGhlIHZhbHVlIG9mIFBNUiB3aWxsIGJlIHVzZWQK
PiA+Pj4+IGluc3RlYWQgb2YgUFNSLltEQUlGXSBmb3IgdGhlIGlycWZsYWdzLgo+ID4+Pj4KPiA+
Pj4+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBUaGllcnJ5IDxqdWxpZW4udGhpZXJyeUBhcm0uY29t
Pgo+ID4+Pj4gU3VnZ2VzdGVkLWJ5OiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBs
aW5hcm8ub3JnPgo+ID4+Pj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFy
bS5jb20+Cj4gPj4+PiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+Cj4gPj4+
PiBDYzogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+Cj4gPj4+PiBD
YzogT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPgo+ID4+Pj4gLS0tCj4gPj4+PiAgYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9lZmkuaCAgICAgIHwgIDExICsrKysKPiA+Pj4+ICBhcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL2lycWZsYWdzLmggfCAxMjMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0KPiA+Pj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCsp
LCAyOCBkZWxldGlvbnMoLSkKPiA+Pj4KPiA+Pj4gWy4uLl0KPiA+Pj4KPiA+Pj4+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2lycWZsYWdzLmggYi9hcmNoL2FybTY0L2luY2x1
ZGUvYXNtL2lycWZsYWdzLmgKPiA+Pj4+IGluZGV4IDI0NjkyZWQuLmZhM2IwNmYgMTAwNjQ0Cj4g
Pj4+PiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2lycWZsYWdzLmgKPiA+Pj4+ICsrKyBi
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaAo+ID4+Pj4gQEAgLTE4LDcgKzE4LDkg
QEAKPiA+Pj4KPiA+Pj4gWy4uLl0KPiA+Pj4KPiA+Pj4+ICBzdGF0aWMgaW5saW5lIHZvaWQgYXJj
aF9sb2NhbF9pcnFfZW5hYmxlKHZvaWQpCj4gPj4+PiAgewo+ID4+Pj4gLQlhc20gdm9sYXRpbGUo
Cj4gPj4+PiAtCQkibXNyCWRhaWZjbHIsICMyCQkvLyBhcmNoX2xvY2FsX2lycV9lbmFibGUiCj4g
Pj4+PiAtCQk6Cj4gPj4+PiArCXVuc2lnbmVkIGxvbmcgdW5tYXNrZWQgPSBHSUNfUFJJT19JUlFP
TjsKPiA+Pj4+ICsKPiA+Pj4+ICsJYXNtIHZvbGF0aWxlKEFMVEVSTkFUSVZFKAo+ID4+Pj4gKwkJ
Im1zcglkYWlmY2xyLCAjMgkJLy8gYXJjaF9sb2NhbF9pcnFfZW5hYmxlXG4iCj4gPj4+PiArCQki
bm9wIiwKPiA+Pj4+ICsJCSJtc3JfcyAgIiBfX3N0cmluZ2lmeShTWVNfSUNDX1BNUl9FTDEpICIs
JTBcbiIKPiA+Pj4+ICsJCSJkc2IJc3kiLAo+ID4+Pgo+ID4+PiBJJ20gc3RpbGwgbm90IGNvbnZp
bmNlZCB0aGVzZSBkc2JzIGFyZSBuZWVkZWQuCj4gPj4+Cj4gPj4+IFdpdGhvdXQgdGhlIGRzYiwg
d2UgYXJlIHByb2JhYmx5IG5vdCBndWFyYW50ZWVkIHRvIHRha2UgYSBwZW5kaW5nCj4gPj4+IGlu
dGVycnVwdCBfaW1tZWRpYXRlbHlfIG9uIHVubWFza2luZywgYnV0IEknbSBub3Qgc3VyZSB0aGF0
J3MgYQo+ID4+PiBwcm9ibGVtLgo+ID4+Pgo+ID4+PiBXaGF0IGdvZXMgd3JvbmcgaWYgd2Ugb21p
dCB0aGVtPwo+ID4+Cj4gPj4gVGhlbiB0aGUgR0lDIGRvZXNuJ3Qga25vdyBpdCBjYW4gbm93IGRl
bGl2ZXIgaW50ZXJydXB0cyBvZiBhIGxvd2VyCj4gPj4gcHJpb3JpdHkuIE9ubHkgYSBkc2IgY2Fu
IGd1YXJhbnRlZSB0aGF0IHRoZSBHSUMncyB2aWV3IG9mIFBNUiB3aWxsIGdldAo+ID4+IHVwZGF0
ZWQuCj4gPj4KPiA+PiBTZWUgOS4xLjYgKE9ic2VydmFiaWxpdHkgb2YgdGhlIGVmZmVjdHMgb2Yg
YWNjZXNzZXMgdG8gdGhlIEdJQwo+ID4+IHJlZ2lzdGVycyksIHdoaWNoIHN0YXRlczoKPiA+Pgo+
ID4+IDxxdW90ZT4KPiA+PiBBcmNoaXRlY3R1cmFsIGV4ZWN1dGlvbiBvZiBhIERTQiBpbnN0cnVj
dGlvbiBndWFyYW50ZWVzIHRoYXQKPiA+PiDigJQgVGhlIGxhc3QgdmFsdWUgd3JpdHRlbiB0byBJ
Q0NfUE1SX0VMMSBvciBHSUNDX1BNUiBpcyBvYnNlcnZlZCBieSB0aGUKPiA+PiBhc3NvY2lhdGVk
IFJlZGlzdHJpYnV0b3IuCj4gPj4gPC9xdW90ZT4KPiA+Pgo+ID4+IFNvIHllcywgRFNCIGlzIHJl
cXVpcmVkLgo+ID4gCj4gPiBCdXQgaXQgc2F5cyBuZWl0aGVyIHdoYXQgaXMgbWVhbnMgZm9yIHRo
ZSBQTVIgd3JpdGUgdG8gYmUgIm9ic2VydmVkIGJ5Cj4gPiB0aGUgcmVkaXN0cmlidXRvciIsIG5v
ciB3aGV0aGVyIHRoZSBEU0IgaXMgcmVxdWlyZWQgZm9yIHRoZQo+ID4gcmVkaXN0cmlidXRvciB0
byBvYnNlcnZlIHRoZSB3cml0ZSBhdCBhbGwuCj4gCj4gV2VsbCwgaXQgc2VlbXMgcHJldHR5IGNs
ZWFyIHRvIG1lIHRoYXQgaWYgdGhlIHJlZGlzdHJpYnV0b3IgZG9lc24ndAo+IG9ic2VydmUgdGhl
IFBNUiB2YWx1ZSwgaXQgaXMgdW5saWtlbHkgdG8gY2hhbmdlIGl0cyBpbnRlcnByZXRhdGlvbiBv
Zgo+IGl0wrcgQW5kIGNvbnZlcnNlbHksIHRoZSByZWRpc3RyaWJ1dG9yIGlzIGFsbG93ZWQgdG8g
c2l0IHByZXR0eSBhbmQgbm90Cj4gZ2l2ZSB5b3UgYW55IGludGVycnVwdCB1bnRpbCB5b3UgYXJl
IGFjdHVhbGx5IHRlbGxpbmcgaXQgdGhhdCBzb21ldGhpbmcKPiBoYXMgY2hhbmdlZC4KPiAKPiBJ
IHJlYWxseSB0aGluayB0aGF0IGZvciBvbmNlLCB0aGUgc3BlYyBpcyBwcmV0dHkgdW5hbWJpZ3Vv
dXMgYWJvdXQgd2hhdAo+IGlzIHJlcXVpcmVkLgoKSSB0aGluayB0aGF0IHRoZXJlIGlzIHNvbWUg
c2NvcGUgZm9yIGNsYXJpZmljYXRpb24sIGJ1dCBpdCBzb3VuZHMgbGlrZQp0aGF0IGRvZXNuJ3Qg
aW1wYWN0IHRoaXMgc2VyaWVzLgoKPiA+IChTbywgaXMgYW4gaW1wbGVtZW50YXRpb24KPiA+IGFs
bG93ZWQgdG8gY2FjaGVkIGluIHRoZSBDUFUgaW50ZXJmYWNlIGluZGVmaW5pdGVseSB1bnRpbCBm
b3JjaWJseQo+ID4gZmx1c2hlZCB0byB0aGUgcmVkaXN0cmlidXRvciBieSBhIERTQiwgYW5kIGlu
IGFueSBjYXNlIGNhbiB0aGUgd3JpdGUncwo+ID4gcmVhY2hpbmcgdGhlIGRpc3RyaWJ1dG9yIGlu
IGZpbml0ZSB0aW1lIG9yIG5vdCBoYXZlIGFueSBlZmZlY3QgdGhhdCB3ZQo+ID4gY2FyZSBhYm91
dCBpbiB0aGlzIGNhc2U/KS4KPiAKPiBOb3RoaW5nIGluIHRoZSBzcGVjIHNheXMgdGhhdCB0aGUg
c3lzdGVtIHJlZ2lzdGVyIHdyaXRlIHdpbGwgbWFnaWNhbGx5Cj4gdHJpY2tsZSBkb3duIHRvIHRo
ZSByZWRpc3RyaWJ1dG9yIGluIHRoZSBhYnNlbmNlIG9mIGEgRFNCLgo+IAo+ID4gTXkgcmVhc29u
IGZvciBxdWVyeWluZyB0aGlzIGlzIHRoYXQgdGVtcG9yYXJ5IGxvY2FsIG1hc2tpbmcgb2YgY2xh
c3Nlcwo+ID4gb2YgaW50ZXJydXB0cyBzZWVtcyBhbiBvYnZpb3VzIHVzZSBjYXNlIGZvciB0aGUg
UE1SLCBhbmQgdGhlIERTQgo+ID4gcmVxdWlyZW1lbnQgZmxpZXMgcmF0aGVyIGluIHRoZSBmYWNl
IG9mIHRoaXMuCj4gCj4gQXJlIHlvdSBpbXBseWluZyB0aGF0IHRoZSBHSUMgYXJjaGl0ZWN0dXJl
IHNob3VsZCBoYXZlIGFueSBmb3JtIG9mCj4gc2FuaXR5IGFuZCBiZSB1c2VmdWwgZm9yIGdlbmVy
YWwgcHVycG9zZSBzb2Z0d2FyZT8gVGhpbmsgYWdhaW4hIDstKQo+IAo+IFRoZSBQTVIgYmVoYXZp
b3IgeW91IGFyZSBkZXNjcmliaW5nIG9ubHkgd29ya3MgaW4gYSBzaW5nbGUgZGlyZWN0aW9uCj4g
KGZyb20gbG93IHRvIGhpZ2ggcHJpb3JpdHkpLCBiZWNhdXNlIHRoZSBDUFUgaW50ZXJmYWNlIGhh
cyB0byBwZXJmb3JtCj4gc29tZSBmaWx0ZXJpbmcuIEluIHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24s
IHlvdSBuZWVkIHRoZSBiaWcgaGFtbWVyLgo+IAo+ID4gSGF2ZSB3ZSBzZWVuIGhhcmR3YXJlIHdo
ZXJlIGludGVycnVwdHMgbWF5IHN0YWxsIGZvcmV2ZXIgdXBzdHJlYW0gb2YgdGhlCj4gPiBDUFUg
aW50ZXJmYWNlIGFmdGVyIGEgUE1SIHdyaXRlLCB1bnRpbCBhIGRzYiBpcyBleGVjdXRlZCBieSB0
aGUgQ1BVPwo+IAo+IFllcy4gWW91IGV2ZW4gaGF2ZSB0byBoYXZlIGEgRFNCIHJpZ2h0IGFmdGVy
IGEgcmVhZCBvZiBJQVIgdG8gYXZvaWQKPiBsb29zaW5nIGludGVycnVwdHMuIFRoZSBzaG9ydCBz
dG9yeSBpcyB0aGF0IHRoZXJlIGlzIGhhcmRseSBhbnkKPiBzeW5jaHJvbml6YXRpb24gYmV0d2Vl
biByZWRpc3RyaWJ1dG9yIGFuZCBDUFUgaW50ZXJmYWNlLiBJbXBsZW1lbnRhdGlvbnMKPiBhcmUg
YWxsb3dlZCBhIG1vcmUgY2xvc2VseSBjb3VwbGVkIGRlc2lnbiwgYnV0IHRoYXQncyBub3Qgd2hh
dCB0aGUKPiBhcmNoaXRlY3R1cmUgbWFuZGF0ZXMuCgpXZWxsIEkgZ3Vlc3MgdGhhdCBwcmV0dHkg
bXVjaCB3cmFwcyBpdCB1cCEKCklmIGltcGxlbWVudGF0aW9ucyByZXF1aXJlIGl0LCB0aGVuIHdl
IG9idmlvdXNseSBuZWVkIHRvIGhhdmUgaXQuCgo+ID4gQWxzbywgaXMgaXQgZXZlciBpbXBvcnRh
bnQgaW4gTGludXggdGhhdCBhIHBlbmRpbmcgaW50ZXJydXB0IGJlIHRha2VuCj4gPiBpbW1lZGlh
dGVseSB1cG9uIHVubWFza2luZyAoYW5kIGhvdyBkbyB3ZSBrbm93IHRoYXQgc2FpZCBpbnRlcnJ1
cHQgaXMKPiA+IHBlbmRpbmcpPyAgSWYgbm90LCB3ZSBkb24ndCBjYXJlIHByZWNpc2VseSB3aGVu
IHN1Y2ggaW50ZXJydXB0cyBhcmUKPiA+IHBlbmRlZCB0byB0aGUgUEUsIGp1c3QgdGhhdCBzdWNo
IGFuIGludGVycnVwdCBjYW5ub3QgYmUgdGFrZW4gYmVmb3JlCj4gPiB0aGUgUE1SIHdyaXRlIHRo
YXQgdW5tYXNrcyBpdC4gIEl0IHdvdWxkIGJlIGluc2FuZSBmb3IgdGhlIHNlbGYtCj4gPiBzeW5j
aHJvbml6YXRpb24gb2YgUE1SIHdyaXRlcyB0byBsYWNrIHRoaXMgZ3VhcmFudGVlIChhbmQgYSBE
U0IgYWZ0ZXIKPiA+IHRoZSBQTVIgd3JpdGUgd291bGQgZG8gbm8gZ29vZCBhbnl3YXkgaW4gdGhh
dCBjYXNlKS4KPiAKPiBSVCBmb2xrcyBhcmUgdXN1YWxseSBxdWl0ZSBwaWNreSBvbiB3aGVuIHRo
ZXkgc2VlIHRoZWlyIGludGVycnVwdHMKPiBmaXJpbmcuIEkgY2FuIGFsc28gaW1hZ2luZSB0aGUg
Zm9sbG93aW5nIHNjZW5hcmlvOgo+IAo+IAlzZXRfcG1yKGFsbG93IGFsbCBpbnRlcnJ1cHRzKQo+
IAlXRkkKPiAKPiB3aGVyZSB0aGluZ3Mgc3RvcCByYXRoZXIgYWJydXB0bHkgaWYgdGhpcyBpcyB0
aGUgb25seSBDUFUgaW4gdGhlIHN5c3RlbS4KClRoaXMgaXMgYSByYXRoZXIgc3BlY2lhbCBjYXNl
IChhbmQgdGhpcyBjYXNlIGlzIGluZGVlZCBoYW5kbGVkIHNwZWNpYWxseQpieSB0aGlzIHNlcmll
cykuICBIZXJlIHdlIGRvbid0IG5lZWQgdG8gZXhwZWRpdGUgaW50ZXJydXB0IGRlbGl2ZXJ5LApi
dXQgd2Ugd2FudCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgbG9naWMgdGhhdCB3aWxsIHdha2UgdXMg
YmFjayB1cCBrbm93cwp3aGF0IGl0J3Mgc3VwcG9zZWQgdG8gYmUgZG9pbmcgYmVmb3JlIHdlIHN0
YXJ0IHBvd2VyaW5nIHRoaW5ncyBvZmYuCgpIb3dldmVyLCBJIGNhbiBzZWUgdGhhdCBmb3IgUlQg
cHVycG9zZXMgZXhwbGljaXQgc3luY2hyb25pc2F0aW9uIG9uCmludGVycnVwdCB1bm1hc2tpbmcg
bWF5IHByb3ZpZGVkIGEgbW9yZSBib3VuZGVkIGludGVycnVwdCBibGFja291dCB0aGF0CnNpbXBs
eSB3YWl0aW5nIGZvciBzeW5jaHJvbmlzYXRpb24gdG8gaGFwcGVuIGluIHRoZSBiYWNrZ3JvdW5k
ICh0aG91Z2gKdGhhdCBtaWdodCBoYXZlIGJldHRlciB0aHJvdWdocHV0KS4gIEFueXdheSwgdGhp
cyBpcyBhY2FkZW1pYyBzaW5jZQp3ZSBoYXZlIHRvIGhhdmUgdGhlIHN5bmNoeXJvbmlzYXRpb24g
YW55d2F5LgoKSSB3aWxsIGNvbnNpZGVyIG15c2VsZiBjb3JyZWN0ZWQgYW5kIHN0b3AgdHJvbGxp
bmcuLi4KCkNoZWVycwotLS1EYXZlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
