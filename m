Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:29:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2D721720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nnGx6uwQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt0r7B0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D721720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/gbLniLJrE8NWc6l8/AtuboxEHbL//Uz12vriT2P+Wg=; b=nnGx6uwQDBOGLQ
	Elv2sxq8jtFHg1xAPY9UOlBTUR7H7x6KOhbJEjz+R55Fmm+gEsX4HjKgN+f9bYD5DKe4pq8qOYzmJ
	2LZIV1ax8GdGh7DLX2SBferLiWKMA+x21CYP4nfWhDZffCSzrTaGlv1aipLot3sjaAe2GhgwJM0xy
	kLDZh4g9SE+BratZXFIPnhlNM0FBcsPR5Jd1e+T1D5f2uvxpky1J6R5dXKnh0xn8V1JN7NM8/Hdml
	tXzOAfkjNELsSA7JEDi9VfyN7QBtxEs49F/Wmg/sEdsPaiRE4LAlXZco4VbCrZ39E1DCoAZjGngu3
	3ldG4K4bP5nz498Z7CeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdzVU-00066f-2O; Mon, 31 Dec 2018 15:29:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdzVR-00065w-4E
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 15:29:30 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 450502133F;
 Mon, 31 Dec 2018 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546270166;
 bh=ep05JDV0jUZt3JPGp9M2KlJH4vaZEgl8Hdop8Y4VudM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mt0r7B0iq02qpZwkWngDX5Luz/oENZKBhgEcBqkTHCTQcRyFPofeZML5H1E9YBOqQ
 tdH+hVzbPtNVeaIHfgLU9Iy3EtQ5aCx4FerbGPIi16vBMMlfHLuxi9M5ZBGDpk/YWr
 K8GJ97dJjnBde51sDxnTnWd20bkbwedHDdoB/dmk=
Date: Mon, 31 Dec 2018 09:29:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Message-ID: <20181231152918.GE159477@google.com>
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
 <20181230010625.GC159477@google.com> <m336qegfzv.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m336qegfzv.fsf@t19.piap.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_072929_187698_3EC583C2 
X-CRM114-Status: GOOD (  18.37  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
 Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Robin Leblon <robin.leblon@ncentric.com>,
 Koen Vandeputte <koen.vandeputte@ncentric.com>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMzEsIDIwMTggYXQgMTE6MTQ6MjhBTSArMDEwMCwgS3J6eXN6dG9mIEhhxYJh
c2Egd3JvdGU6Cj4gQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cml0ZXM6Cj4g
Cj4gPiA4MDJiN2MwNmFkYzcgcmVwbGFjZWQgY25zM3h4eF9wY2lfd3JpdGVfY29uZmlnKCksIHdo
aWNoIGFsd2F5cyB1c2VkCj4gPiBfX3Jhd193cml0ZWwoKSBzbyBpdCBvbmx5IGRpZCAzMi1iaXQg
YWNjZXNzZXMsIHdpdGgKPiA+IHBjaV9nZW5lcmljX2NvbmZpZ193cml0ZSgpLCB3aGljaCB1c2Vz
IHdyaXRlYi93cml0ZXcvd3JpdGVsKCkKPiA+IGRlcGVuZGluZyBvbiB0aGUgc2l6ZS4KPiA+Cj4g
PiA4MDJiN2MwNmFkYzcgYWxzbyBjb252ZXJ0ZWQgY25zM3h4eF9wY2lfcmVhZF9jb25maWcoKSBm
cm9tIGFsd2F5cwo+ID4gdXNpbmcgX19yYXdfcmVhZGwoKSAoYSAzMi1iaXQgYWNjZXNzKSB0byB1
c2luZwo+ID4gcGNpX2dlbmVyaWNfY29uZmlnX3JlYWQzMigpLCB3aGljaCBhbHNvIGFsd2F5cyBk
b2VzIGEgMzItYml0IGFjY2Vzcy4KPiA+Cj4gPiBUaGlzIG1ha2VzIG1lIHRoaW5rIHRoZSBjbngz
eHh4IGhhcmR3YXJlIGlzIG9ubHkgY2FwYWJsZSBvZiAzMi1iaXQKPiA+IGFjY2Vzc2VzLCBhbmQg
dGhpcyBwYXRjaCBzaG91bGQgY2hhbmdlIHRoZSBkcml2ZXIgdG8gdXNlCj4gPiBwY2lfZ2VuZXJp
Y19jb25maWdfd3JpdGUzMigpIGluc3RlYWQgb2YgcGNpX2dlbmVyaWNfY29uZmlnX3dyaXRlKCkg
aW4KPiA+IGFkZGl0aW9uIHRvIHRoZSBtYXBwaW5nIGZpeCBhYm92ZS4KPiAKPiBIYXNuJ3QgaXQg
YWxyZWFkeSBiZWVuIHZlcmlmaWVkIHRoYXQgdGhlIENOUzN4eHggY2FuIGRvIDgtYml0IGFjY2Vz
c2VzCj4gKGFuZCBwcm9iYWJseSAxNi1iaXQgb25lcyBhcyB3ZWxsKSwgYW5kIHRoYXQgdGhlIGRv
Y3MgZG9uJ3QgbWVudGlvbiBhbnkKPiBzdWNoIGxpbWl0YXRpb24/CgpRdWl0ZSBwb3NzaWJseS4g
IEknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgaGFyZHdhcmUgb3IgZG9jcyBzbyBjYW4ndApjb21t
ZW50IHBlcnNvbmFsbHkuCgo4MDJiN2MwNmFkYzcgcmVpbXBsZW1lbnRlZCBjbnMzeHh4X3BjaV9y
ZWFkX2NvbmZpZygpIHVzaW5nCnBjaV9nZW5lcmljX2NvbmZpZ19yZWFkMzIoKSwgd2hpY2ggcHJl
c2VydmVkIHRoZSBwcm9wZXJ0eSBvZiBvbmx5CmRvaW5nIDMyLWJpdCByZWFkcy4gIEl0IHJlcGxh
Y2VkIGNuczN4eHhfcGNpX3dyaXRlX2NvbmZpZygpIHdpdGgKcGNpX2dlbmVyaWNfY29uZmlnX3dy
aXRlKCksIHNvIGl0IGNoYW5nZWQgd3JpdGVzIGZyb20gYWx3YXlzIGJlaW5nIDMyCmJpdHMgdG8g
YmVpbmcgdGhlIGFjdHVhbCBzaXplLiAgSSB0aGluayB0aGlzIHdhcyBhbiBlcnJvciBpbiB0aGUK
b3JpZ2luYWwgY29tbWl0LCBzaW5jZSB0aGUgY2hhbmdlbG9nIGRvZXNuJ3QgbWVudGlvbiB0aGlz
IGNoYW5nZTsgaW4KZmFjdCwgdGhlIGNoYW5nZWxvZyBzYXlzIGl0IGNoYW5nZXMgX19yYXdfd3Jp
dGVsIHRvIHdyaXRlbC4KClRoZSBjaGFuZ2UgZnJvbSAzMi1iaXQgdG8gYWN0dWFsIHNpemUgYWNj
ZXNzZXMgd291bGQgbG9naWNhbGx5IGJlIGEKc2VwYXJhdGUgY29tbWl0IGZyb20gY2hhbmdpbmcg
dG8gdXNlIHRoZSBnZW5lcmljIGFjY2Vzc29ycy4KCkFzc3VtaW5nIHRoZSBoYXJkd2FyZSBkb2Vz
IHN1cHBvcnQgc21hbGxlciBhY2Nlc3NlcywgSSdkIHByb3Bvc2UgdHdvCnBhdGNoZXM6CgogIDEp
IFRoZSBjdXJyZW50IG9uZSB0aGF0IGNvcnJlY3RzIHRoZSBhZGRyZXNzIGFsaWdubWVudCBlcnJv
ciwgYW5kCiAgMikgQSBuZXcgb25lIHRoYXQgY29udmVydHMgY25zM3h4eF9wY2lfcmVhZF9jb25m
aWcoKSB0byB1c2UKICAgICBwY2lfZ2VuZXJpY19jb25maWdfcmVhZCgpIGluc3RlYWQgb2YgcGNp
X2dlbmVyaWNfY29uZmlnX3JlYWQzMigpLgoKSWRlYWxseSB0aGUgY2hhbmdlbG9nIGZvciB0aGUg
c2Vjb25kIHBhdGNoIHdvdWxkIHJlZmVyIHRvIHRoZQp2ZXJpZmljYXRpb24gdGhhdCB0aGUgaGFy
ZHdhcmUgaXMgY2FwYWJsZSBvZiA4LSBhbmQgMTYtYml0IGFjY2Vzc2VzLgoKQmpvcm4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
