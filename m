Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B844C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:45:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF06E218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RlBv/8EU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF06E218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=oW+AuRDG7qBp141XsL8LWGIvOiTDGNZWoCfBTKVw+v0=; b=RlB
	v/8EUa39f1r1JIay/luxxgnkVJhnvxZr9WFljLVY0i6k9ajDVsk58Hgla4quyXe6Icmdf+FZj95pH
	oiX/2PctkyJE+Ww7AgQy14m6ipivxMDAFx2dhiZ9DqyMpf3U5URNPAUd+X/J29xf3LO9n29yRhzGL
	vV2Jr33ZbGI/oyyLKPI0WHpsMtRLbvi4hRnyEN0dofD3ahhonMjrWh/ejT4f3VLWNcHtZ9tDRod0o
	9YxrbiYh1v8sjatlRJjA/LDVffI1U4s+Nok1x1s+Dafzdwg8XDjF96co4W/Uj3txxYjsWmIXwgjgR
	n8gfN8FYsln1tJ/99bnPs0AnWahF9Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtIRt-0008Dc-KW; Mon, 11 Feb 2019 20:45:05 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtIRp-0007uw-Dd
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:45:03 +0000
Received: from nc.bastianfamily.de ([79.204.83.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsChr-1h5U5L2zrr-013ueP; Mon, 11
 Feb 2019 21:44:52 +0100
From: Tristan Bastian <tristan-c.bastian@gmx.de>
To: Thierry Reding <thierry.reding@gmail.com>, Thierry Reding
 <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
In-Reply-To: <20190211110919.10388-1-thierry.reding@gmail.com>
Message-ID: <20190211204452.Horde.-B4_UgJoWHc85yxQZVtc9wu@_>
User-Agent: Horde Application Framework 5
Date: Mon, 11 Feb 2019 20:44:52 +0000
MIME-Version: 1.0
X-Provags-ID: V03:K1:WK0KdiJULMy4bA1WhngBCBEgtpaIYcL+y7I+XULTWd3NCk8Krzq
 zG4GVHCfNAogjIjNulVI7lpn/1wUtWdWUQ6kdsVTxj8s3HTLi+mlmO5bbzcecFkAIm+E8UE
 H7SEIG+5XP1A6Oo+6mhxbDnZ+pMWpQ5X3KVQk18Bpu7guztGtwKpYKvNPDsbnOjjby/UTak
 1egc9CQKB/0r9ofsaJeVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oiQI1JcTgSE=:RXoh9mCTZehRG7QcibW6Cf
 UGGl9kHqHt/9O2rXTXvlM92R/BjeAQfgIWkzmUyFFRvqGpWzhVkO1hvo/1uUTwpc6ljwJH/fm
 QpGGQmwCHnP9Gee1gpRhujmnqia49EeHwrM+hBK5FhKOrakIxjI3iTgdCl2yLHySpDzpCEYtD
 fKzN0W7wPsuhZCLWwqIqWcTcGs2Q7nuOTrWkk/TM/z+UOcl2Nfg1hztc49xKkLeGFwGyV6r9N
 jOIHHRpw9iLYlFzNEdnG5dBkuY4g5I9LRFAlEAqrVrUMYElf3EMNz1semkq5bM2AdgtiWbrcV
 9cz6O9/fdlu69/zSPS6E/GyAq1LPZUisNqipqDlmqzqSriLOCLTJiyE0ByHl/WtipAY5Wg46f
 hLDCWsOYRUKRBRqzKJ/C7s4Q9kg7iR2/SFpKsuLA843ZqczCHz6NtU2gm2FWzfbpVyrJV9sn0
 2HFWuSBkp0ExN2YvIxiBgS/RHVEWDqaP6sWL34V1m20F3Rc540X9i//iJHlJaeaG1W3YrF4F6
 3QzDumxWQyxpWbQ3M57cS32aTdsOyf/9K/Uobs9AGwHbRAcOkJLCXr9XcwxSI9N/lKykoT4lI
 n+Opqc7CMgd3X4WRPhe9y/vckXP4itKbeYowmiostXHC2Hzrq5czfI6rkb08R+RGMDsQBCoMs
 E3tqHiC14bZ/l/SFQsO5QV+QMi6nlqS9LSgOTguHVc4c/bfUkUwRi0YNYrcXPx6CY8mf3POJE
 V/RNb8y6qPnxP4FphVowlvXN9Oihclae3SgMhrLz4C0ACUIGW49iwZectA+1Iv25cPMb2oD8m
 5TImUtTuRQVOqk1dEu4J4w02C+0KPH/fFK+UPsdqG2BXceza9S/h4JMggAfMJaY1Ddd6j28mW
 pZafQRHDJvTUBc/2Ftk1upL99zw8iLIXOmXA0YqNjqXoi/iJ2YL0OuRyUPhDwS0plqwVAJNyk
 Zi4MOgQTa2A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_124501_771371_54B74306 
X-CRM114-Status: GOOD (  20.79  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpZXJyeSBSZWRpbmcg4oCTIE1vbiwgMTEuIEZlYnJ1YXJ5IDIwMTkgMTI6MDkKPiBGcm9tOiBU
aGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+IAo+IENvbW1pdCA0ODI5OTc2OTll
ZjAgKCJBUk06IHRlZ3JhOiBGaXggdW5pdF9hZGRyZXNzX3ZzX3JlZyBEVEMgd2FybmluZ3MKPiBm
b3IgL21lbW9yeSIpIGluYWR2ZW50ZW50bHkgYnJva2UgZGV2aWNlIHRyZWUgQUJJIGJ5IGFkZGlu
ZyBhIHVuaXQtCj4gYWRkcmVzcyB0byB0aGUgIi9tZW1vcnkiIG5vZGUgYmVjYXVzZSB0aGUgZGV2
aWNlIHRyZWUgY29tcGlsZXIgZmxhZ2dlZAo+IHRoZSBtaXNzaW5nIHVuaXQtYWRkcmVzcyBhcyBh
IHdhcm5pbmcuCj4gCj4gVGVncmExMjQgQ2hyb21lYm9va3MgKGEuay5hLiBOeWFuKSB1c2UgYSBi
b290bG9hZGVyIHRoYXQgcmVsaWVzIG9uIHRoZQo+IGZ1bGwgbmFtZSBvZiB0aGUgbWVtb3J5IG5v
ZGUgaW4gZGV2aWNlIHRyZWUgYmVpbmcgZXhhY3RseSAiL21lbW9yeSIuIEl0Cj4gY2FuIGJlIGFy
Z3VlZCB3aGV0aGVyIHRoaXMgd2FzIGEgZ29vZCBkZWNpc2lvbiBvciBub3QsIGFuZCBzb21lIG90
aGVyCj4gYm9vdGxvYWRlcnMgKHN1Y2ggYXMgVS1Cb290KSBkbyBhY2NlcHQgYSB1bml0LWFkZHJl
c3MgaW4gdGhlIG5hbWUgb2YgdGhlCj4gbm9kZSwgYnV0IHRoZSBkZXZpY2UgdHJlZSBpcyBhbiBB
QkkgYW5kIHdlIGNhbid0IGJyZWFrIGV4aXN0aW5nIHNldHVwcwo+IGp1c3QgYmVjYXVzZSB0aGUg
ZGV2aWNlIHRyZWUgY29tcGlsZXIgY29uc2lkZXJzIGl0IGJhZCBwcmFjdGljZSB0byBvbWl0Cj4g
dGhlIHVuaXQtYWRkcmVzcyBub3dhZGF5cy4KPiAKPiBUaGlzIHBhcnRpYWxseSByZXZlcnRzIHRo
ZSBvZmZlbmRpbmcgY29tbWl0IGFuZCByZXN0b3JlcyBkZXZpY2UgdHJlZSBBQkkKPiBjb21wYXRp
YmlsaXR5Lgo+IAo+IEZpeGVzOiA0ODI5OTc2OTllZjAgKCJBUk06IHRlZ3JhOiBGaXggdW5pdF9h
ZGRyZXNzX3ZzX3JlZyBEVEMgd2FybmluZ3MgZm9yCj4gL21lbW9yeSIpCj4gUmVwb3J0ZWQtYnk6
IFRyaXN0YW4gQmFzdGlhbiA8dHJpc3Rhbi1jLmJhc3RpYW5AZ214LmRlPgo+IFNpZ25lZC1vZmYt
Ynk6IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBp
biB2MjoKPiAtIHJlbW92ZSBtZW1vcnlAODAwMDAwMDAgbm9kZSBwdWxsZWQgaW4gZnJvbSB0ZWdy
YTEyNC5kdHNpCj4gLSBhZGQgZGV2aWNlX3R5cGUgPSAibWVtb3J5IiBwcm9wZXJ0eQo+IAo+IGFy
Y2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LW55YW4uZHRzaSB8IDE3ICsrKysrKysrKysrKysrKyst
Cj4gMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMjQtbnlhbi5kdHNpCj4gYi9hcmNo
L2FybS9ib290L2R0cy90ZWdyYTEyNC1ueWFuLmR0c2kKPiBpbmRleCBkNWYxMWQ2ZDk4N2UuLmJj
ODViNmExNjZjNyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1ueWFu
LmR0c2kKPiArKysgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1ueWFuLmR0c2kKPiBAQCAt
MTMsMTAgKzEzLDI1IEBACj4gc3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7Cj4gfTsK
PiAKPiAtIG1lbW9yeUA4MDAwMDAwMCB7Cj4gKyAvKgo+ICsgKiBOb3RlIHRoYXQgcmVjZW50IHZl
cnNpb24gb2YgdGhlIGRldmljZSB0cmVlIGNvbXBpbGVyIChzdGFydGluZyB3aXRoCj4gKyAqIHZl
cnNpb24gMS40LjIpIHdhcm4gYWJvdXQgdGhpcyBub2RlIGNvbnRhaW5pbmcgYSByZWcgcHJvcGVy
dHksIGJ1dAo+ICsgKiBtaXNzaW5nIGEgdW5pdC1hZGRyZXNzLiBIb3dldmVyLCB0aGUgYm9vdGxv
YWRlciBvbiB0aGVzZSBDaHJvbWVib29rCj4gKyAqIGRldmljZXMgcmVsaWVzIG9uIHRoZSBmdWxs
IG5hbWUgb2YgdGhpcyBub2RlIHRvIGJlIGV4YWN0bHkgL21lbW9yeS4KPiArICogQWRkaW5nIHRo
ZSB1bml0LWFkZHJlc3MgY2F1c2VzIHRoZSBib290bG9hZGVyIHRvIGNyZWF0ZSBhIC9tZW1vcnkK
PiArICogbm9kZSBhbmQgd3JpdGUgdGhlIG1lbW9yeSBiYW5rIGNvbmZpZ3VyYXRpb24gdG8gdGhh
dCBub2RlLCB3aGljaCBpbgo+ICsgKiB0dXJuIGxlYWRzIHRoZSBrZXJuZWwgdG8gYmVsaWV2ZSB0
aGF0IHRoZSBkZXZpY2UgaGFzIDIgR2lCIG9mCj4gKyAqIG1lbW9yeSBpbnN0ZWFkIG9mIHRoZSBh
bW91bnQgZGV0ZWN0ZWQgYnkgdGhlIGJvb3Rsb2FkZXIuCj4gKyAqCj4gKyAqIFRoZSBuYW1lIG9m
IHRoaXMgbm9kZSBpcyBlZmZlY3RpdmVseSBBQkkgYW5kIG11c3Qgbm90IGJlIGNoYW5nZWQuCj4g
KyAqLwo+ICsgbWVtb3J5IHsKPiArIGRldmljZV90eXBlID0gIm1lbW9yeSI7Cj4gcmVnID0gPDB4
MCAweDgwMDAwMDAwIDB4MCAweDgwMDAwMDAwPjsKPiB9Owo+IAo+ICsgL2RlbGV0ZS1ub2RlLyBt
ZW1vcnlAODAwMDAwMDA7Cj4gKwo+IGhvc3QxeEA1MDAwMDAwMCB7Cj4gaGRtaUA1NDI4MDAwMCB7
Cj4gc3RhdHVzID0gIm9rYXkiOwo+IC0tIAo+IDIuMTkuMQoKVGhhbmtzIFRoaWVycnkKClRyaXN0
YW4KClRlc3RlZC1ieTogVHJpc3RhbiBCYXN0aWFuIDx0cmlzdGFuLWMuYmFzdGlhbkBnbXguZGU+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
