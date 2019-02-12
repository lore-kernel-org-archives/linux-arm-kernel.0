Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE6DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:00:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84788217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uTPBZNT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84788217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=snWHCOO80kdZi8LAP/OFJoEBLYEdCSXu8GWwZFZwpvI=; b=uTPBZNT0oWx8Nj
	epqCg2mNpkd0nb6CChCehbNU3QH60VwAbrmvkkUBUJ5jKjhYxLlrVxfyyeA+4s+Agy+/qqQmbXHaF
	ZdJ8HAkDAT/epbzJgltdaRnAWMafOgJS8IsGH7Q0M2JYLdeCZ2r+Fw3A4OXDUlAr+Ewz9OEk3vCvl
	G947JQXld950rSuLTeOAxbhdMiocpTMJEyxZ6u0Da67eR9FcubH61qAvB9/zguNAMVA9WfJlib1uV
	SyIcj9qAV/aWWoswi/v+dzKlV0oCD0dOhKyEmtPKVhjV5zcbxvU5/Ey05xZviPYQ8Qlf5+ixsv6lZ
	KJATQ6q88v6rmZY+8iDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbQC-0003bA-H7; Tue, 12 Feb 2019 17:00:36 +0000
Received: from smtp.nue.novell.com ([195.135.221.5])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbQ3-0003Zy-Aj
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:00:31 +0000
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
 by smtp.nue.novell.com with ESMTP (TLS encrypted);
 Tue, 12 Feb 2019 18:00:23 +0100
Received: from suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
 by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted);
 Tue, 12 Feb 2019 17:00:10 +0000
Date: Tue, 12 Feb 2019 20:00:59 +0100
From: Mian Yousaf Kaukab <ykaukab@suse.de>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v5 2/2] arm64: dts: lx2160a: add sata node support
Message-ID: <20190212190059.GA9272@suse.de>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125081013.21663-2-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_090027_686479_92B84F99 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: axboe@kernel.dk, mark.rutland@arm.com, andy.tang@nxp.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 linux-ide@vger.kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMDg6MTA6MTNBTSArMDAwMCwgUGVuZyBNYSB3cm90ZToK
PiBBZGQgU0FUQSBkZXZpY2Ugbm9kZXMgZm9yIGZzbC1seDIxNjBhIGFuZCBlbmFibGUgc3VwcG9y
dAo+IGZvciBRRFMgYW5kIFJEQiBib2FyZHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBNYSA8
cGVuZy5tYUBueHAuY29tPgo+IC0tLQo+IGNoYW5nZWQgZm9yIFY1Ogo+IAktIG5vIGNoYW5nZQo+
IAo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzIHwg
ICAxNiArKysrKysrCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBh
LXJkYi5kdHMgfCAgIDE2ICsrKysrKysKPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWx4MjE2MGEuZHRzaSAgICB8ICAgNDQgKysrKysrKysrKysrKysrKysrKysrCj4gIDMgZmls
ZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcWRzLmR0cyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFkcy5kdHMKPiBpbmRl
eCA5OWEyMmFiLi4xYTVhY2Y2IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjBhLXFkcy5kdHMKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzCj4gQEAgLTk1LDYgKzk1LDIyIEBACj4gIAl9Owo+
ICB9Owo+ICAKPiArJnNhdGEwIHsKPiArCXN0YXR1cyA9ICJva2F5IjsKPiArfTsKPiArCj4gKyZz
YXRhMSB7Cj4gKwlzdGF0dXMgPSAib2theSI7Cj4gK307Cj4gKwo+ICsmc2F0YTIgewo+ICsJc3Rh
dHVzID0gIm9rYXkiOwo+ICt9Owo+ICsKPiArJnNhdGEzIHsKPiArCXN0YXR1cyA9ICJva2F5IjsK
PiArfTsKPiArCj4gICZ1YXJ0MCB7Cj4gIAlzdGF0dXMgPSAib2theSI7Cj4gIH07Cj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzCj4gaW5k
ZXggNjQ4MWU1Zi4uNWI2Nzk5ZSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cwo+IEBAIC0xMDIsNiArMTAyLDIyIEBACj4gIAl9
Owo+ICB9Owo+ICAKPiArJnNhdGEwIHsKPiArCXN0YXR1cyA9ICJva2F5IjsKPiArfTsKPiArCj4g
KyZzYXRhMSB7Cj4gKwlzdGF0dXMgPSAib2theSI7Cj4gK307Cj4gKwo+ICsmc2F0YTIgewo+ICsJ
c3RhdHVzID0gIm9rYXkiOwo+ICt9Owo+ICsKPiArJnNhdGEzIHsKPiArCXN0YXR1cyA9ICJva2F5
IjsKPiArfTsKPiArCj4gICZ1YXJ0MCB7Cj4gIAlzdGF0dXMgPSAib2theSI7Cj4gIH07Cj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpCj4gaW5kZXgg
YTc5ZjVjMS4uNTkyMDM0YiAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYwYS5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWx4MjE2MGEuZHRzaQo+IEBAIC02NzEsNiArNjcxLDUwIEBACj4gIAkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7Cj4gIAkJfTsKPiAgCj4gKwkJc2F0YTA6IHNhdGFAMzIwMDAwMCB7Cj4gKwkJ
CWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtYWhjaSI7Cj4gKwkJCXJlZyA9IDwweDAgMHgzMjAw
MDAwIDB4MCAweDEwMDAwPiwKPiArCQkJICAgICAgPDB4NyAweDEwMDUyMCAweDAgMHg0PjsKPiAr
CQkJcmVnLW5hbWVzID0gImFoY2kiLCAic2F0YS1lY2MiOwo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJ
Q19TUEkgMTMzIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2Vu
IDQgMz47Cj4gKwkJCWRtYS1jb2hlcmVudDsKPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiAr
CQl9Owo+ICsKPiArCQlzYXRhMTogc2F0YUAzMjEwMDAwIHsKPiArCQkJY29tcGF0aWJsZSA9ICJm
c2wsbHgyMTYwYS1haGNpIjsKPiArCQkJcmVnID0gPDB4MCAweDMyMTAwMDAgMHgwIDB4MTAwMDA+
LAo+ICsJCQkgICAgICA8MHg3IDB4MTAwNTIwIDB4MCAweDQ+Owo+ICsJCQlyZWctbmFtZXMgPSAi
YWhjaSIsICJzYXRhLWVjYyI7Cj4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMzYgSVJRX1RZ
UEVfTEVWRUxfSElHSD47Cj4gKwkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gNCAzPjsKPiArCQkJZG1h
LWNvaGVyZW50Owo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ICsJCX07Cj4gKwo+ICsJCXNh
dGEyOiBzYXRhQDMyMjAwMDAgewo+ICsJCQljb21wYXRpYmxlID0gImZzbCxseDIxNjBhLWFoY2ki
Owo+ICsJCQlyZWcgPSA8MHgwIDB4MzIyMDAwMCAweDAgMHgxMDAwMD4sCj4gKwkJCSAgICAgIDww
eDcgMHgxMDA1MjAgMHgwIDB4ND47Cj4gKwkJCXJlZy1uYW1lcyA9ICJhaGNpIiwgInNhdGEtZWNj
IjsKPiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDk3IElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+
ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47Cj4gKwkJCWRtYS1jb2hlcmVudDsKPiArCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsKPiArCQl9Owo+ICsKPiArCQlzYXRhMzogc2F0YUAzMjMwMDAw
IHsKPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1haGNpIjsKPiArCQkJcmVnID0gPDB4
MCAweDMyMzAwMDAgMHgwIDB4MTAwMDA+LAo+ICsJCQkgICAgICA8MHg3IDB4MTAwNTIwIDB4MCAw
eDQ+OwpZb3UgYXJlIHVzaW5nIHNhbWUgcmVnIHZhbHVlcyBmb3Igc2F0YS1lY2MgaW4gYWxsIHNh
dGEgaW5zdGFuY2VzLiBEb2VzIHRoaXMKYWN0dWFsbHkgd29yaz8gTm8gZXJyb3JzIHdoZW4gdGhl
IGFoY2lfcW9yaXEgZHJpdmVyIGRvIGlvcmVtYXAgb24gaXQgd2hpbGUKcHJvYmluZyBzZWNvbmQg
aW5zdGFuY2UgYW5kIG9ud2FyZD8KCmZzbC1sczIwOHhhLmR0c2kgaXMgdGhlIG9ubHkgb3RoZXIg
ZmlsZSBoZXJlIHdpdGggbXVsdGlwbGUgc2F0YSBpbnN0YW5jZXMgYW5kCml0IGRvZXNu4oCZdCBj
YXJlIGFib3V0IHNhdGEtZWNjLgoKPiArCQkJcmVnLW5hbWVzID0gImFoY2kiLCAic2F0YS1lY2Mi
Owo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTAwIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+
ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47Cj4gKwkJCWRtYS1jb2hlcmVudDsKPiArCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsKPiArCQl9Owo+ICsKPiAgCQlzbW11OiBpb21tdUA1MDAwMDAw
IHsKPiAgCQkJY29tcGF0aWJsZSA9ICJhcm0sbW11LTUwMCI7Cj4gIAkJCXJlZyA9IDwwIDB4NTAw
MDAwMCAwIDB4ODAwMDAwPjsKCkJSLApZb3VzYWYKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
