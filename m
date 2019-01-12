Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9596AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684362086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K4rQecTY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7CBm2ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684362086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jGNr92NnWAxMFTHloqK3AVXfyzOG5MEclb18WP/tfh8=; b=K4rQecTYxEmlgM
	uMTovUXieL9/Dlva3AV17/2DG1hkQJRQV+LdqczRmMVSe5d8JM3Iaha9L1uMVdrytZCxRSTjqigke
	A1fuvNpRU1Pkgsh3q3eawHIgRMQFpdBsqT+OzHwOwpOPj9hR2UwiDydRqr8GoqCE61AUL0+tZ66bK
	+XyabugnMjbqNUc+7AB8MwuP977eH/V8TQdoNWurp/LUdYpgUQ3GFaDycTQOWM/BrgqmLHeaRZAnk
	fpOA7M2S9wGPi/zcOeb5hvdGqnx9z7WL3UVyuNLi5qSQQ+l1TdtEQYBX0A3c5U5bo18/kLHKNMqQx
	aOgomzZm6TNZyWHnkHeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giNS6-0006oQ-07; Sat, 12 Jan 2019 17:52:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giNS2-0006o4-L0
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 17:52:08 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 05F352084C;
 Sat, 12 Jan 2019 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547315525;
 bh=TnMhz+UqgUAfFY6OLg+QUEnCJtRgLzYWTLzSaOiksRM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=j7CBm2maHqmDQP6zImqWDL0wQ0wOCcpmA7fNwFSiX58bhAq23sNUQaRCBoXrwTxKw
 FwIxeNEyRdq7dWAJzoTk1mYkwNi8mnX6A6wYyqFMoHnum3Uovg4cMlYCDERvzMXmf/
 acQEJbEctDhbde95xgQ2jlBir8kdoOfHixn80heA=
Date: Sat, 12 Jan 2019 17:51:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: New IIO/counter driver
Message-ID: <20190112175159.3dac7a70@archlinux>
In-Reply-To: <8b2bb569-a6e0-25ec-740d-48083b30fe60@st.com>
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
 <20190108004632.GA3247@icarus>
 <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
 <8b2bb569-a6e0-25ec-740d-48083b30fe60@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_095206_722523_5E4033CB 
X-CRM114-Status: GOOD (  22.97  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Benjamin GAIGNARD <benjamin.gaignard@st.com>, linux-iio@vger.kernel.org,
 Patrick Havelange <patrick.havelange@essensium.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCA4IEphbiAyMDE5IDEyOjAxOjU3ICswMTAwCkZhYnJpY2UgR2FzbmllciA8ZmFicmlj
ZS5nYXNuaWVyQHN0LmNvbT4gd3JvdGU6Cgo+IE9uIDEvOC8xOSAxMTo1NyBBTSwgQmVuamFtaW4g
R2FpZ25hcmQgd3JvdGU6Cj4gPiBMZSBtYXIuIDggamFudi4gMjAxOSDDoCAwMTo0NiwgV2lsbGlh
bSBCcmVhdGhpdHQgR3JheQo+ID4gPHZpbGhlbG0uZ3JheUBnbWFpbC5jb20+IGEgw6ljcml0IDog
IAo+ID4+Cj4gPj4gT24gTW9uLCBKYW4gMDcsIDIwMTkgYXQgMDI6NDU6MzdQTSArMDEwMCwgUGF0
cmljayBIYXZlbGFuZ2Ugd3JvdGU6ICAKPiA+Pj4gSGVsbG8sCj4gPj4+Cj4gPj4+IEknbSBpbiB0
aGUgcHJvY2VzcyBvZiBhZGRpbmcgYSBuZXcgSUlPL2NvdW50ZXIgZHJpdmVyLCBob3dldmVyIEkg
YWxzbyBzYXcKPiA+Pj4gdGhhdCB0aGVyZSB3YXMgYSB3b3JrIGluIHByb2dyZXNzIHRvIGhhdmUg
YSBzZXBhcmF0ZSBjb3VudGVyIHN1YnN5c3RlbSAoCj4gPj4+IGh0dHBzOi8vbWFyYy5pbmZvLz9s
PWxpbnV4LWlpbyZtPTE1Mzk3NDE2NzcyNzIwNiApLiBCdXQgaXQgc2VlbXMgdGhlcmUgaXMKPiA+
Pj4gbm8gcmVjZW50IHByb2dyZXNzIG9uIGl0Lgo+ID4+PiBXaGF0IGlzIHRoZSBzdGF0ZSBvZiB0
aG9zZSBwYXRjaGVzID8gSXMgaXQgc3RpbGwgaW50ZXJlc3RpbmcgdG8gZGV2ZWxvcCB0aGUKPiA+
Pj4gZHJpdmVyIGFzIGFuIElJTy9jb3VudGVyICwgb3Igc2hvdWxkIEkgdXNlIGFscmVhZHkgdGhh
dCBuZXcgc3Vic3lzdGVtID8KPiA+Pj4KPiA+Pj4gQmVzdCBSZWdhcmRzLAo+ID4+Pgo+ID4+PiBQ
YXRyaWNrIEhhdmVsYW5nZS4gIAo+ID4+Cj4gPj4gSGVsbG8sCj4gPj4KPiA+PiBJIGFtIHN0aWxs
IG9wZW4gdG8gbWVyZ2luZyB0aGlzIHBhdGNoc2V0IGFuZCBtYWludGFpbmluZyB0aGUgQ291bnRl
cgo+ID4+IHN1YnN5c3RlbS4gSG93ZXZlciwgSSB0b29rIHRoZSBsYWNrIG9mIHJlc3BvbnNlIGZv
ciBteSBsYXRlc3QKPiA+PiBzdWJtaXNzaW9uIHRvIGluZGljYXRlIGEgbG9zcyBvZiBpbnRlcmVz
dCBpbiB0aGlzIHBhdGNoc2V0J3MgYXBwcm9hY2guCj4gPj4gSWYgdGhlcmUgYXJlIHN0aWxsIHBl
b3BsZSB3aG8gd2FudCB0aGlzLCBJIGNhbiByZWJhc2UgYW5kIHJlc2VuZCB0aGlzCj4gPj4gcGF0
Y2hzZXQgZm9yIHN1Ym1pc3Npb247IHRoZSBwYXN0IGZldyB2ZXJzaW9ucyBoYXZlIHByaW1hcmls
eSBiZWVuIGNvZGUKPiA+PiBjbGFyaXR5IGFuZCBkb2N1bWVudGF0aW9uIGNoYW5nZXMgc28gSSBi
ZWxpZXZlIHRoZSBjb3JlIGRlc2lnbiBpdHNlbGYgaXMKPiA+PiBzb21ld2hhdCBzdGFibGUgbm93
Lgo+ID4+Cj4gPj4gSnVzdCBsZXQgbWUga25vdyBob3cgYmVzdCB0byBwcm9jZWVkIGFuZCBJIHNo
YWxsIGJlIGhhcHB5IHRvIG9ibGlnZSAtLQo+ID4+IHdoZXRoZXIgdG8gY29udGludWUgbWFpbnRh
aW5pbmcgdGhpcyBwYXRjaHNldCBvciB0byBkcm9wIHRoaXMgZGVzaWduIGluCj4gPj4gZmF2b3Ig
b2YgaW1wcm92aW5nIHRoZSBleGlzdGluZyBJSU8gQ291bnRlciBjb2RlIGluIHRoZSBrZXJuZWwu
Cj4gPj4KPiA+PiBJJ2xsIENDIHRob3NlIGZyb20gdGhlIHBhdGNoc2V0IHN1Ym1pc3Npb24gdG8g
a2VlcCB0aGVtIGluIHRoZSBsb29wLiAgCj4gPiAKPiA+IEkgY29uZmlybSB0aGF0IEkgc3RpbGwg
aW50ZXJlc3RlZCB0byBnZXQgdGhvc2UgcGF0Y2hlcyBtZXJnZWQuCj4gPiAKPiA+IFJlZ2FyZHMs
Cj4gPiBCZW5qYW1pbiAgCj4gSGksCj4gCj4gU2FtZSBmb3IgbWUsCkluIGEgbW9yZSBhYnN0cmFj
dCBmYXNoaW9uIChJIGRvbid0IGhhdmUgYW55IGhhcmR3YXJlIG9mIHRoaXMgdHlwZSEpCkknbSBz
dGlsbCBrZWVuIGZvciB0aGUgY291bnRlciBzdWJzeXN0ZW0gdG8gZ28gaW4uICBIb3BlZnVsbHks
IGlmCkdyZWcgb3IgYW55b25lIGVsc2Ugd2FudHMgdG8gdGFrZSBhIGRldGFpbGVkIGxvb2sgdGhl
eSB3aWxsIGhhdmUgdGltZQp0aGlzIGN5Y2xlIHRvIGRvIHNvLgoKSSB3YXMgcHJldHR5IGhhcHB5
IHdpdGggdGhlIGxhc3QgdmVyc2lvbiBJIHJlYWQgdGhyb3VnaC4gIFRoZXJlIHdpbGwKYWx3YXlz
IGJlIHRoaW5ncyB0byBpbXByb3ZlZCwgYnV0IGFzIGxvbmcgYSB3ZSBhcmUgaGFwcHkgd2l0aAp0
aGUgdXNlcnNwYWNlIGludGVmYWNlLCB0aGUgbGl0dGxlIHRoaW5ncyBjYW4gaGFwcGVuIGxhdGVy
LgoKSm9uYXRoYW4KCj4gCj4gUmVnYXJkcywKPiBGYWJyaWNlCj4gPj4KPiA+PiBTaW5jZXJlbHks
Cj4gPj4KPiA+PiBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5Cj4gPj4KPiA+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4+IGxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0Cj4gPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4g
Pj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsICAKPiA+IAo+ID4gCj4gPiAgIAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
