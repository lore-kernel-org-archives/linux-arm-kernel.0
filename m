Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DF5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AEB20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QWcQU0ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AEB20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lKX5epBKhX2jGNu0J3/RwfjBjzF4qtbAH7dnZGAdXQ0=; b=QWcQU0kuaaVkf/
	wd+OYwv/Epuiw9FPk4mDhW1D5k5efHp4FZXDO/inD2WVREDisvwp6+w91TFYRZh7Q5zs0YVbAOFLY
	ijW/XxW7YyjsKuV8lqJLmYVBqgvmU/12T+9/pT9pGdiCyyG5hdy71xqwaS+0/grMxl8qVd2w+Y7GX
	Jds+AD5oPMQLzidC/MrPh4nfnJ0xBVun7XdCqrorEdd4v0OOLTcGJI+vdVqktFA/yZdjYSSL6Rvc/
	gsT8uEi/QqS8mQl1qgyQydGBRGoyDzZtokBVOEZj0Z+xjMkihJlh4f2EjEFHHvjGsU5ONepYCPQWW
	o1cVO7hlOwf3M65ROpvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqY8-000436-QK; Mon, 03 Dec 2018 15:54:20 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqY6-0003iq-03
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:54:19 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id C8A2813F87E;
 Mon,  3 Dec 2018 16:53:48 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
To: Jeffrey Hugo <jhugo@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <de223e7a-3b60-0566-997f-b607bbc15007@codeaurora.org>
 <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8b697e3b-6cb5-41ea-cd56-94c54082c58b@free.fr>
Date: Mon, 3 Dec 2018 16:53:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_075418_185941_0331A675 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDMvMTIvMjAxOCAxNjo0NywgSmVmZnJleSBIdWdvIHdyb3RlOgoKPiBPbiAxMi8zLzIwMTgg
ODoyNyBBTSwgSmVmZnJleSBIdWdvIHdyb3RlOgo+IAo+PiBPbiAxMi8zLzIwMTggODoxOCBBTSwg
TWFyYyBHb256YWxleiB3cm90ZToKPj4KPj4+ICvCoMKgwqDCoMKgwqDCoCB1ZnNwaHk6IHBoeUAx
ZGE3MDAwIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAicWNvbSxz
ZG04NDUtcW1wLXVmcy1waHkiOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4
MWRhNzAwMCAweDE4Yz47Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxs
cyA9IDwxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDE+Owo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFuZ2VzOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY2xvY2stbmFtZXMgPQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
cmVmX2Nsa19zcmMiLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicmVmX2Ns
ayIsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZWZfYXV4X2NsayI7Cj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA8JnJwbWNjIDA+LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCA8JmdjYyBHQ0NfVUZTX0NMS1JFRl9DTEs+LAo+IAo+IEFsc28sICJHQ0NfVUZTX0NMS1JF
Rl9DTEsiIGlzIG5vdCBkZWZpbmVkIGluIAo+IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svcWNv
bSxnY2MtbXNtODk5OC5oIHdoaWNoIGlzIHByb2JhYmx5IHRoZSBjYXVzZSAKPiBvZiB5b3VyIC0y
IGVycm9yIGxpc3RlZCBhYm92ZS4KCklmIGl0IHdlcmUgdW5kZWZpbmVkLCBkdGMgd291bGQgaGF2
ZSBraWNrZWQgbWUgaW4gdGhlIG5hZHMgOi0pCgokIGdpdCBncmVwIEdDQ19VRlNfQ0xLUkVGX0NM
SyBpbmNsdWRlCmluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svcWNvbSxnY2MtbXNtODk5Ni5oOiNk
ZWZpbmUgR0NDX1VGU19DTEtSRUZfQ0xLICAgICAgICAyMTUKaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bG9jay9xY29tLGdjYy1tc204OTk4Lmg6I2RlZmluZSBHQ0NfVUZTX0NMS1JFRl9DTEsgICAgICAg
IDE2OAppbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3Fjb20sZ2NjLXNkbTY2MC5oOiNkZWZpbmUg
R0NDX1VGU19DTEtSRUZfQ0xLICAgICAgICAgIDgxCgpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGh5L3Fjb20tcW1wLXBoeS50eHQgc3BlbGxzIGl0IG91dDoKRm9yICJxY29tLHNk
bTg0NS1xbXAtdWZzLXBoeSIsIGNsb2NrLW5hbWVzIG11c3QgY29udGFpbiAicmVmIiwgInJlZl9h
dXgiLgoKUmVnYXJkcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
