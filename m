Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:23:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9EB20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UqqDnmyU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Tt1MYvL5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLLXNe0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9EB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:Subject:In-Reply-To:Date:
	MIME-Version:To:From:Message-Id:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l/+DKycs0ofylNUXSL2ryvwEjSMl1WQSBQvU03XgcSs=; b=UqqDnmyUUJQ7hR
	PRgA3e+QFzL3ngzFnVuG1fUanZxfrmGtpIvZGkcnM/zjT5xkA9ZwVNcNOV9zhEVTB58F6sIhwETP8
	g0MPfGCYVOAmC/C/XheNfLGBpNTVHhqcE37+TQN/EG2ioLDV4a/THxOpUabyX/2quQL4p4h/mQTkr
	XLJZLZ1wsumW6CCl6a0diC2q4FlYcdrX2q8yQzt6VUyIPB9UexK+07UtR3e43wkB8yMe+o1vhaCxm
	NT+sny69Lz586UC4xgKivkWd0iH7gh11CjuoUaiMEM3B1PeEqs2yVJ8uq3X6ecsLLYOrDmn8vm1ST
	lXKkHviqs6idNPNEHqxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt43X-0007Bc-Kw; Mon, 11 Feb 2019 05:22:59 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt43T-0007Av-QZ
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 05:22:57 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 2B41D204B9;
 Mon, 11 Feb 2019 00:22:50 -0500 (EST)
Received: from web3 ([10.202.2.213])
 by compute4.internal (MEProxy); Mon, 11 Feb 2019 00:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 message-id:from:to:cc:mime-version:content-transfer-encoding
 :content-type:date:in-reply-to:subject:references; s=fm2; bh=XEv
 m6ZA+fGIUi8Lya1ekc4etlnANUbCvCdTjSErcXOM=; b=Tt1MYvL5gYpIBofVPfU
 cpVkNIH0lG6ak8cBvAOp+m2XCIdf6Q63H8J0qw0dHGVgtHItCqS0w0tVTieXJBaW
 LBKJGQBoSZ3DaCULNqKtRiKhcivTjHTS1zH4qNnRcCKivMnsGcAxs01cCxUL/hzR
 dZDNjHlb488CAOP7nGD/DV05YwWfw16DkQcl+3Cjz8sFI1RvYgXEOXAf8IIiz7JO
 4avuk/f35OVXjyVmmKRIAXUaQTvjJqmDS7qIuhRU3xfdGusFW8b2OCwzF1A/DzbU
 5f0odvcKVAvoDwatSIXW8qiyNAaoUAlSe+GT70gL73UBBF7G8WyjoK7JGkL96rNb
 6ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=XEvm6ZA+fGIUi8Lya1ekc4etlnANUbCvCdTjSErcX
 OM=; b=mLLXNe0LhEWIjGyvs91BK8O9FRM7wESxmZR2uwszxh4+BUx0jo4Mz4VqK
 4RfkDLJystsW7xOhmvPwZoqpjqlEz7UD6hN7sTAxIKTPBG8mQEOapoVAThlHHC1C
 1CGHUoXbyO672wqKBH3vbN1OaLLIBNUbYN7yn/cvekkNOGxNZ1p11aVxfeJhS8MB
 P0spLaGN69mB+BVYOq8JNwnti7/kYa2VQRSXvPMdfy80SLau+nNCdSDdIKGHU9pv
 sW+ClOgI5Csfn5dvMNw3Br1gFDdD25ND+N/VwTXvLvStD5+YsKn1MXXtFBFIlduJ
 Bk2sfvE+8qDb7vGafE7tn98HXvsjw==
X-ME-Sender: <xms:pwZhXJT-Wt9ozd2lC87w_CxlGyPiF5DR2h8LUpd-6PNn1A-VSscDQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrleejgdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffhvfgggfgtof
 ffjgfufhesthhqredtredtjeenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceo
 rghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
 gurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qAZhXJwdFkYuEL7KhCbEK4GHpsun36oAtFMV9XsRISm2FH-ibVyxmA>
 <xmx:qAZhXD3RvrfeedrXyvhSbUiaP9AooGEJvwcEfacp0W_qcOV9QdMb4A>
 <xmx:qAZhXP7yl08KySqHULpDy3HsSmwuseWYJxUgqEPfJFscRONCjwn8fw>
 <xmx:qgZhXN47dZJ_lYI6YXtCC5tsFNoriU5azvn6er8JrLmc95fCoraeig>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
 id D75CB9E009; Mon, 11 Feb 2019 00:22:47 -0500 (EST)
Message-Id: <1549862567.1175306.1655243744.11AFF30D@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
To: Vijay Khemka <vijaykhemka@fb.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface - ajax-950b8783
Date: Mon, 11 Feb 2019 15:52:47 +1030
In-Reply-To: <13C13AE8-63A4-4002-9E0D-70276C529448@fb.com>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
 <20190124081544.GA1649@kroah.com>
 <13C13AE8-63A4-4002-9E0D-70276C529448@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_212256_062469_1473D03F 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyNSBKYW4gMjAxOSwgYXQgMDU6NTksIFZpamF5IEtoZW1rYSB3cm90ZToKPiAKPiAK
PiDvu79PbiAxLzI0LzE5LCAxMjoxNiBBTSwgIkdyZWcgS3JvYWgtSGFydG1hbiIgPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPiAKPiAgICAgT24gV2VkLCBKYW4gMjMsIDIwMTkg
YXQgMDM6MDY6MzRQTSAtMDgwMCwgVmlqYXkgS2hlbWthIHdyb3RlOgo+ICAgICA+IENvcnJlY3Rl
ZCBzb21lIG9mIHJldHVybiB2YWx1ZXMgd2l0aCBhcHByb3ByaWF0ZSBtZWFuaW5ncy4KPiAgICAg
PiAKPiAgICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNv
bT4KPiAgICAgPiAtLS0KPiAgICAgPiAgZHJpdmVycy9taXNjL2FzcGVlZC1scGMtY3RybC5jIHwg
MTUgKysrKysrKy0tLS0tLS0tCj4gICAgID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pCj4gICAgID4gCj4gICAgID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWlzYy9hc3BlZWQtbHBjLWN0cmwuYyBiL2RyaXZlcnMvbWlzYy9hc3BlZWQtCj4gbHBjLWN0cmwu
Ywo+ICAgICA+IGluZGV4IDMzMjIxMGUwNmU5OC4uOTdhZTM0MTEwOWQ1IDEwMDY0NAo+ICAgICA+
IC0tLSBhL2RyaXZlcnMvbWlzYy9hc3BlZWQtbHBjLWN0cmwuYwo+ICAgICA+ICsrKyBiL2RyaXZl
cnMvbWlzYy9hc3BlZWQtbHBjLWN0cmwuYwo+ICAgICA+IEBAIC02OCw3ICs2OCw2IEBAIHN0YXRp
YyBsb25nIGFzcGVlZF9scGNfY3RybF9pb2N0bChzdHJ1Y3QgZmlsZSAKPiAqZmlsZSwgdW5zaWdu
ZWQgaW50IGNtZCwKPiAgICAgPiAgCQl1bnNpZ25lZCBsb25nIHBhcmFtKQo+ICAgICA+ICB7Cj4g
ICAgID4gIAlzdHJ1Y3QgYXNwZWVkX2xwY19jdHJsICpscGNfY3RybCA9IGZpbGVfYXNwZWVkX2xw
Y19jdHJsKGZpbGUpOwo+ICAgICA+IC0Jc3RydWN0IGRldmljZSAqZGV2ID0gZmlsZS0+cHJpdmF0
ZV9kYXRhOwo+ICAgICA+ICAJdm9pZCBfX3VzZXIgKnAgPSAodm9pZCBfX3VzZXIgKilwYXJhbTsK
PiAgICAgPiAgCXN0cnVjdCBhc3BlZWRfbHBjX2N0cmxfbWFwcGluZyBtYXA7Cj4gICAgID4gIAl1
MzIgYWRkcjsKPiAgICAgPiBAQCAtOTMsOCArOTIsOCBAQCBzdGF0aWMgbG9uZyBhc3BlZWRfbHBj
X2N0cmxfaW9jdGwoc3RydWN0IGZpbGUgCj4gKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCj4gICAg
ID4gIAo+ICAgICA+ICAJCS8qIElmIG1lbW9yeS1yZWdpb24gaXMgbm90IGRlc2NyaWJlZCBpbiBk
ZXZpY2UgdHJlZSAqLwo+ICAgICA+ICAJCWlmICghbHBjX2N0cmwtPm1lbV9zaXplKSB7Cj4gICAg
ID4gLQkJCWRldl9lcnIoZGV2LCAiRGlkbid0IGZpbmQgcmVzZXJ2ZWQgbWVtb3J5XG4iKTsKPiAg
ICAgPiAtCQkJcmV0dXJuIC1FSU5WQUw7Cj4gICAgID4gKwkJCXByX2VycigiYXNwZWVkX2xwY19j
dHJsOiBpb2N0bDogRGlkbid0IGZpbmQgcmVzZXJ2ZWQgbWVtb3J5XG4iKTsKPiAgICAgCj4gICAg
IFdoeSBkaWQgeW91IGNoYW5nZSBmcm9tIGRldl9lcnIoKSB0byBwcl9lcnIoKT8gIFlvdSBqdXN0
IGxvc3QgYSBsb3Qgb2YKPiAgICAgaW5mb3JtYXRpb24gdGhhdCB0aGUgdXNlciBwcmV2aW91c2x5
IHdhcyBnZXR0aW5nIGZyb20gZGV2X2VycigpIDooCj4gCj4gSSBkaWQgdGhpcyBhcyBwZXIgcmV2
aWV3IGNvbW1lbnQgZnJvbSBBbmRyZXcgSmVmZmVyeSwgYXMgd2UgZG9uJ3Qgd2FudCAKPiB0byBw
dXQgdGhpcyBlcnJvciBmb3IgZHJpdmVyLiBJdCBoYXMgdG8gYmUgaGFuZGxlZCBieSB1c2Vyc3Bh
Y2UuIEJ1dCBJIAo+IGFtIHN0aWxsIHJlcG9ydGluZyBzb21lIGVycm9yIGhlcmUuCgpTb3JyeT8g
V2hhdCBJIHdhcyB0cnlpbmcgdG8gc3VnZ2VzdCB3YXMgcmVtb3ZpbmcgdGhlIGxvZ2dpbmcgYWx0
b2dldGhlciBhbmQKanVzdCByZXR1cm5pbmcgdGhlIGVycm9yIGNvZGUuIE5vdCBzaW1wbHkgY2hh
bmdpbmcgaG93IHRoZSBsb2dnaW5nIGlzIGRvbmUuCgpBbmRyZXcKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
