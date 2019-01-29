Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47884C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C36218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVrTuEA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C36218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wCujvvmI5ptsN5vjlufMEPGiyWzISzPdBo2k/L8d6mg=; b=PVrTuEA4aqYga5
	7W5TkO2R20soIxSUHEuaO+BAJuxBZ+bjfT8U8c/iPdvHM7BPuwWCpe1prTVJ006HGuPOdby6MviBo
	QIDMxKzVktbe4x+ARDPKznyb0nlcykAEgzCJpEBpBYTYahCB8V7gWVwH++qpqTQme3nz7+TRhytfv
	2Hz1LXlKRvmusjP6mo5D8uqvbdOYWoUrqvEWzbAYh/T64jKW3QD4wb8yy5+wOjbkCZrmV3rGMxB/L
	1OcABkURoqpwP7dAN09m6RMugovztMJZRmv6/umJOnbKl55Ee5rlEikDDZ9NM6vGEFUr2NJqmIPl/
	e+95fjENv1MzzvmKCeYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRqa-0004Vf-E5; Tue, 29 Jan 2019 11:46:32 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRqM-0004UQ-TN
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:46:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC95DEBD;
 Tue, 29 Jan 2019 03:46:16 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40C843F589;
 Tue, 29 Jan 2019 03:46:15 -0800 (PST)
Date: Tue, 29 Jan 2019 11:46:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: Kernel boot regression with PAuth and aarch64-softmmu -cpu max
 and el2 enabled
Message-ID: <20190129114609.GA25983@lakrids.cambridge.arm.com>
References: <87va27n2l8.fsf@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87va27n2l8.fsf@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_034618_962717_E36BFE6B 
X-CRM114-Status: GOOD (  30.93  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "open list:ARM" <qemu-arm@nongnu.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpbYWRkaW5nIEtyaXN0aW5hLCB3aG8gaXMgaW4gY2hhcmdlIG9mIExpbnV4IHBvaW50ZXIg
YXV0aGVudGljYXRpb25dCgpPbiBUdWUsIEphbiAyOSwgMjAxOSBhdCAxMTowODoxOUFNICswMDAw
LCBBbGV4IEJlbm7DqWUgd3JvdGU6Cj4gSGksCj4gCj4gRm9sbG93aW5nIHVwIG9uIHllc3RlcmRh
eSdzIGRpc2N1c3Npb24gb24gSVJDIEkgdGhvdWdodCBJJ2QgYmV0dGVyCj4gcmVwb3J0IG9uIG15
IGZpbmRpbmdzIGluIHRoZSBwZXJtYW5lbnQgcmVjb3JkIHNvIHRoaW5ncyBkb24ndCBnZXQgbG9z
dC4KPiAKPiBBcyBJIHRlbmQgdG8gcGVyaW9kaWNhbGx5IHJlYnVpbGQgbXkgdGVzdCBrZXJuZWxz
IGZyb20gdGhlIGN1cnJlbnQKPiBzdGF0ZSBvZiBsaW51eC5naXQgSSBvY2Nhc2lvbmFsbHkgcnVu
IGludG8gdGhlc2UgdGhpbmdzLiBNeSB0ZXN0Cj4gaW52b2NhdGlvbiBpczoKPiAKPiAgIHFlbXUt
c3lzdGVtLWFhcmNoNjQgLW1hY2hpbmUgdHlwZT12aXJ0LHZpcnR1YWxpemF0aW9uPW9uIFwKPiAg
ICAgICAgICAgICAgICAgICAgICAgLWRpc3BsYXkgbm9uZSAtbSA0MDk2IC1zZXJpYWwgbW9uOnN0
ZGlvIFwKPiAgICAgICAgICAgICAgICAgICAgICAgLWtlcm5lbCAuLi8uLi9rZXJuZWwtdjgtcGxh
aW4uYnVpbGQvYXJjaC9hcm02NC9ib290L0ltYWdlIFwKPiAgICAgICAgICAgICAgICAgICAgICAg
LWFwcGVuZCAnY29uc29sZT10dHlBTUEwIHBhbmljPS0xJyAtbm8tcmVib290IC1jcHUgbWF4Cj4K
PiBUaGUga2VybmVsIGlzIGVzc2VudGlhbGx5IGEgZGVmY29uZmlnIGtlcm5lbCB3aXRoIGEgYnVu
Y2ggb2YgdGhlIFZJUlRJTwo+IGRldmljZSBkcml2ZXJzIGJ1aWx0LWluIGZvciB3aGVuIEkgYWN0
dWFsbHkgYm9vdCBhIG1vcmUgY29tcGxleCBzZXR1cAo+IHdpdGggZGlza3MgYW5kIGRyaXZlcy4g
SG93ZXZlciB0aGlzIGlzIGEgYm9vdCB0ZXN0IHNvIGRvZXNuJ3QgcmVhbGx5Cj4gbWF0dGVyLgo+
IAo+IFRoZSAtbWFjaGluZSB0eXBlPXZpcnQsdmlydHVhbGl6YXRpb249b24gZW5hYmxlcyBvdXIg
dmlydCBtYWNoaW5lIG1vZGVsCj4gd2l0aCBFTDIgdHVybmVkIG9uLiBBcyB0aGVyZSBpcyBubyBC
SU9TIGludm9sdmVkIHRoZSBrZXJuZWwgaXMgaW52b2tlZAo+IGRpcmVjdGx5IGF0IEVMMi4KPiAK
PiBUaGUgLWNwdSBtYXggZW5hYmxlZCBhIGNvcnRleC1hNTcgKyB3aGF0ZXZlciBleHRyYSBmZWF0
dXJlcyB3ZSd2ZQo+IGVuYWJsZWQgaW4gUUVNVSBzbyBmYXIuIEl0IHdvbid0IG1hdGNoIGFueSAi
cmVhbCIgQ1BVIGJ1dCBpdCBzaG91bGQgYmUKPiBhcmNoaXRlY3R1cmFsbHkgY29ycmVjdCBpbiBz
byBmYXIgd2UgaW1wbGVtZW50IHByZXJlcXVpc2l0ZSBmZWF0dXJlcyBmb3IKPiBhbnkgZ2l2ZW4g
ZmVhdHVyZS4gVGhlIGNwdWlkIGZlYXR1cmUgYml0cyBzaG91bGQgYWxzbyBiZSBjb3JyZWN0IGFz
IHdlCj4gdGVzdCB0aGVtIGludGVybmFsbHkgaW4gUUVNVSB0byBlbmFibGUgZmVhdHVyZXMuCgpK
dXN0IHRvIGNoZWNrLCBkb2VzIHRoaXMgZW5hYmxlIFZIRT8KCj4gVGhlIGJyZWFrYWdlIGlzIHRo
ZSBrZXJuZWwgbmV2ZXIgYm9vdHMgKG5vIG91dHB1dCBvbiBzZXJpYWwgcG9ydCkgYW5kIG9uCj4g
YXR0YWNoaW5nIHdpdGggZ2RiIEkgZm91bmQgaXQgc3R1Y2sgaW46Cj4gCj4gICAoZ2RiKSBidAo+
ICAgIzAgIDB4ZmZmZmZmODAxMGE5ZTQ4MCBpbiBvdmVyZmxvd19zdGFjayAoKQo+ICAgQmFja3Ry
YWNlIHN0b3BwZWQ6IG5vdCBlbm91Z2ggcmVnaXN0ZXJzIG9yIG1lbW9yeSBhdmFpbGFibGUgdG8g
dW53aW5kIGZ1cnRoZXIKPiAKPiBJZiBJIHR1cm4gb24gZXhjZXB0aW9uIHRyYWNpbmcgaXQgbG9v
a3MgbGlrZSB3ZSBnbyBpbnRvIGFuIGV4Y2VwdGlvbgo+IGxvb3AuCgpBcyBtZW50aW9uZWQgb24g
SVJDLCB0aGlzIGxvb2tzIHZlcnkgb2RkLCBzaW5jZSBvdmVyZmxvd19zdGFjayBpcyBhIGRhdGEK
cG9pbnRlciwgbm90IGNvZGUuIEkgY2FuJ3QgcHJlc2VudGx5IHNlZSBob3cgd2UgY291bGQgYnJh
bmNoIGhlcmUuCgpJZiB5b3UgcGFzcyB0aGUga2VybmVsICdlYXJseWNvbiBrZWVwX2Jvb3Rjb24n
LCBkbyB5b3UgZ2V0IGFueSBvdXRwdXQ/Cgo+IE9uIHRoZSBRRU1VIHNpZGUgdGhpcyBicmVha2Fn
ZSBjb21lcyBpbiBhdDoKPiAKPiAgIGNvbW1pdCAxY2UzMmU0N2RiNTJlMzUxMTEzMmM3MTA0Nzcw
ZWFlNjVkNDEyMTQ0IChIRUFELCByZWZzL2Jpc2VjdC9iYWQpCj4gICBBdXRob3I6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgo+ICAgRGF0ZTogICBNb24g
SmFuIDIxIDEwOjIzOjEzIDIwMTkgKzAwMDAKPiAKPiAgICAgICB0YXJnZXQvYXJtOiBFbmFibGUg
UEF1dGggZm9yIC1jcHUgbWF4Cj4gCj4gICAgICAgUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwg
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KPiAgICAgICBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KPiAgICAgICBNZXNzYWdl
LWlkOiAyMDE5MDEwODIyMzEyOS41NTcwLTMwLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcK
PiAgICAgICBTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+Cj4gCj4gYW5kIGFzIHlvdSB3b3VsZCBleHBlY3QgdGhlIHN5c3RlbSBib290cyBmaW5l
IHdpdGggLWNwdSBjb3J0ZXgtYTU3Cj4gCj4gT24gdGhlIGtlcm5lbCBzaWRlIGl0IGJyZWFrcyBh
dDoKPiAKPiAgIGNvbW1pdCAwNGNhMzIwNGZhMDlmNWY1NWM4ZjExM2IwMDcyMDA0YTdiMzY0ZmY0
Cj4gICBBdXRob3I6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Cj4gICBEYXRl
OiAgIEZyaSBEZWMgNyAxODozOTozMCAyMDE4ICswMDAwCj4gCj4gICAgICAgYXJtNjQ6IGVuYWJs
ZSBwb2ludGVyIGF1dGhlbnRpY2F0aW9uCj4gCj4gICAgICAgTm93IHRoYXQgYWxsIHRoZSBuZWNl
c3NhcnkgYml0cyBhcmUgaW4gcGxhY2UgZm9yIHVzZXJzcGFjZSwgYWRkIHRoZQo+ICAgICAgIG5l
Y2Vzc2FyeSBLY29uZmlnIGxvZ2ljIHRvIGFsbG93IHRoaXMgdG8gYmUgZW5hYmxlZC4KPiAKPiAg
ICAgICBTaWduZWQtb2ZmLWJ5OiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+
ICAgICAgIFNpZ25lZC1vZmYtYnk6IEtyaXN0aW5hIE1hcnRzZW5rbyA8a3Jpc3RpbmEubWFydHNl
bmtvQGFybS5jb20+Cj4gICAgICAgQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFz
QGFybS5jb20+Cj4gICAgICAgQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgo+
ICAgICAgIFNpZ25lZC1vZmYtYnk6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgo+
IAo+IFNvIHByZWRpY3RhYmx5IHdlIGZhaWxlZCBhdCBlbmFibGluZyBQQXV0aCBzb21ld2hlcmUg
YmV0d2VlbiB0aGUga2VybmVsCj4gYW5kIFFFTVUuCj4gCj4gSSdtIGd1ZXNzaW5nIHRoZSBrZXJu
ZWwgc28gZmFyIGhhcyBiZWVuIHRlc3RlZCBvbiB0aGUgZmFzdCBtb2RlbCB3aXRoIGEKPiBmdWxs
IGNoYWluIG9mIFRGLCBVRUZJIGFuZCBrZXJuZWw/CgpUaGUga2VybmVsIGhhcyBiZWVuIHRlc3Rl
ZCBvbiBhIGZhc3QgbW9kZWwgd2l0aCB0aGUgTGludXggYm9vdHdyYXBwZXI6CgpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tYXJrL2xpbnV4LmdpdC8KCkty
aXN0aW5hLCBjb3VsZCB5b3UgY29uZmlybSB3aGV0aGVyIG9yIG5vdCBpdCdzIGJlZW4gdGVzdGVk
IHdpdGgKQVRGK1VFRkk/Cgo+IEkgdGhpbmsgUmljaGFyZCdzIHRlc3RzIHdlcmUgd2l0aG91dCBF
TDIgZW5hYmxlZC4KPiAKPiBTbyBpbiB0aGUgY2FzZSB0aGF0IHRoZSBrZXJuZWwgYm9vdHMgaW4g
RUwyIGlzIGl0IGV4cGVjdGluZyBhbnlvbmUgZWxzZQo+IHRvIGRlYWwgd2l0aCBQYXV0aCBleGNl
cHRpb25zIG9yIHNob3VsZCBpdCBiZSBhYmxlIHRvIGNvcGUgd2l0aCBhbgo+IGVuYWJsZWQgUGF1
dGggYnV0IG5vIGZpcm13YXJlIHVuZGVybmVhdGggaXQ/CgpTbyBsb25nIGFzIHRoZSBoaWdoZXN0
IGltcGxlbWVudGVkIGV4Y2VwdGlvbiBsZXZlbCBpcyBFTDIsIHRoZSBrZXJuZWwKc2hvdWxkIGhh
bmRsZSB0aGF0IGl0c2VsZi4gRHVyaW5nIGJvb3Qgd2UnbGwgY29uZmlndXJlIEhDUl9FTDIue0FQ
SSxBUEt9CmluIGVsMl9zZXR1cCgpLgoKRnJvbSB0aGF0IHBvaW50IG9ud2FyZHMsIHRoZXJlIHNo
b3VsZCBiZSBubyB0cmFwcyBmb3IgcG9pbnRlcgphdXRoZW50aWNhdGlvbiBmdW5jdGlvbmFsaXR5
IGZyb20gRUwxLCBBRkFJQ1QuCgo+IEVpdGhlciB3ZSd2ZSBnb3Qgc29tZXRoaW5nIHdyb25nIG9y
IHdlJ2xsIG5lZWQgdG8gcmV0aGluayB3aGF0IGZlYXR1cmVzCj4gdGhlIHVzZXIgY2FuIGhhdmUg
ZW5hYmxlZCBieSAtY3B1IG1heCBvbiBhIGRpcmVjdCBrZXJuZWwgYm9vdC4KCkl0J3Mgbm90IGlt
bWVkaWF0ZWx5IGNsZWFyIHRvIG1lIHdoZW4gcHJlY2lzZWx5IHRoaW5ncyBhcmUgZ29pbmcgd3Jv
bmcsCnNvIEkgdGhpbmsgd2UgbmVlZCB0byBuYXJyb3cgdGhhdCBkb3duIGZpcnN0LiBGb3IgZXhh
bXBsZSwgaXQncyBub3QKY2xlYXIgd2hldGhlciBhIHRyYXAgaXMgYmVpbmcgdGFrZW4sIG9yIHNv
bWV0aGluZyBpcyB1bmV4cGVjdGVkbHkKYmVoYXZpbmcgaXMgVU5ERUYuCgpJcyBpdCBwb3NzaWJs
ZSB0byB3YXRjaCB0aGUgZXhjZXB0aW9uIHZlY3RvcnMgdG8gc2VlIGlmL3doZW4gYW4KZXhjZXB0
aW9uIGlzIHRha2VuLCBhbmQgZnJvbSB3aGVyZT8KClRoYW5rcywKTWFyay4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
