Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37FDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:49:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B5C2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hVB3q7CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B5C2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UzS90uwrkZEGt6XykP/XEPUxUgCpvh3oHCF3uxHrzbU=; b=hVB3q7CD9uE2JA
	apxewZ7DN60gy00KMox8KjVZsOKfZI7/mjjowXSXk7VApJNnxSfyXF3g3GOelqIA9Auvf7eJw/A27
	p//gNn5Ig3z83NV24WtTNdh99z89vBO0TYexvcBP2HlN/UYwcZX4xUkBGcD2CrYzgyMru1Ky3JPxp
	snVK5+R/3qaEynTCrRm6IYj3vgFmb2j4utLkJQC6VCxO+2qbsP3xQuFe2AknxiAxPKUGDbYYkMyTn
	UKX3kaX94gIzPXhmNMuZB7cRiXStPgBCdK084Lvq7N+DmE5YUhMzk2SGcyi1p/01v44rcewksIq4z
	vODwtQEjgMfT4oQzKtLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvm73-0005QF-QH; Mon, 18 Feb 2019 16:49:49 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvm70-0005Pj-E0; Mon, 18 Feb 2019 16:49:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DC5BBAD98;
 Mon, 18 Feb 2019 16:49:44 +0000 (UTC)
Subject: Re: [GIT PULL] Actions ARM64 DT updates for v5.1
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, arm@kernel.org
References: <20190218135042.GA13218@mani>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <8b26d033-a75c-2819-1554-458a55647a61@suse.de>
Date: Mon, 18 Feb 2019 17:49:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190218135042.GA13218@mani>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_084946_617629_3CB4254A 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: linux-actions@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gMTguMDIuMTkgdW0gMTQ6NTAgc2NocmllYiBNYW5pdmFubmFuIFNhZGhhc2l2YW06Cj4gSGkg
QXJuZCwgT2xvZiwKPiAKPiBQbGVhc2UgY29uc2lkZXIgcHVsbGluZyB0aGUgZGVsYXllZCBBY3Rp
b25zIEFSTTY0IERUIHVwZGF0ZXMgZm9yIHY1LjEuCj4gU2luY2UgQW5kcmVhcyBpcyBidXN5LCBJ
J20gZG9pbmcgdGhlIFBSIHRoaXMgdGltZSAod2l0aCBoaXMgYWdyZWVtZW50KS4KCkFjay4KClRo
YW5rcywKQW5kcmVhcwoKPiAKPiBUaGFua3MsCj4gTWFuaQo+IAo+IC0tLQo+IFRoZSBmb2xsb3dp
bmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYmZlZmZkMTU1MjgzNzcyYmJlNzhjNmEwNWRlYzdjMDEy
OGVlNTAwYzoKPiAKPiAgIExpbnV4IDUuMC1yYzEgKDIwMTktMDEtMDYgMTc6MDg6MjAgLTA4MDAp
Cj4gCj4gYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6Cj4gCj4gICBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWFuaS9saW51eC1hY3Rp
b25zLmdpdCB0YWdzL2FjdGlvbnMtYXJtNjQtZHQtZm9yLXY1LjEKPiAKPiBmb3IgeW91IHRvIGZl
dGNoIGNoYW5nZXMgdXAgdG8gOTE3NWE4MTE2ZjQ1MmE1MTVjZWE3MzRjNmZlZGVlNjc4OGU2YmMz
MzoKPiAKPiAgIGFybTY0OiBkdHM6IGFjdGlvbnM6IHM3MDAtY3ViaWVib2FyZDc6IEVuYWJsZSBJ
MkMwIGFuZCBJMkMxICgyMDE5LTAyLTE2IDExOjMyOjQ2ICswNTMwKQo+IAo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBB
Y3Rpb25zIEFSTTY0IERUIGNoYW5nZXMgZm9yIHY1LjE6Cj4gCj4gLSBBZGQgaW50ZXJydXB0IHBy
b3BlcnRpZXMgdG8gUzkwMCBwaW5jdHJsIG5vZGUKPiAtIEFkZCBSZXNldCBjb250cm9sbGVyIHN1
cHBvcnQgZm9yIFM3MDAKPiAtIEFkZCBSZXNldCBjb250cm9sbGVyIHN1cHBvcnQgZm9yIFM5MDAK
PiAtIEFkZCBwaW5jdHJsIHN1cHBvcnQgZm9yIFM3MDAKPiAtIEFkZCBJMkMgc3VwcG9ydCBmb3Ig
UzcwMAo+IC0gRW5hYmxlIEkyQzAgYW5kIEkyQzEgZm9yIHM3MDAtY3ViaWVib2FyZDcKPiAKPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gTWFuaXZhbm5hbiBTYWRoYXNpdmFtICgzKToKPiAgICAgICBhcm02NDogZHRzOiBh
Y3Rpb25zOiBBZGQgaW50ZXJydXB0IHByb3BlcnRpZXMgdG8gcGluY3RybCBub2RlIGZvciBTOTAw
Cj4gICAgICAgYXJtNjQ6IGR0czogYWN0aW9uczogQWRkIFJlc2V0IENvbnRyb2xsZXIgc3VwcG9y
dCBmb3IgUzcwMCBTb0MKPiAgICAgICBhcm02NDogZHRzOiBhY3Rpb25zOiBBZGQgUmVzZXQgQ29u
dHJvbGxlciBzdXBwb3J0IGZvciBTOTAwIFNvQwo+IAo+IFBhcnRoaWJhbiBOYWxsYXRoYW1iaSAo
Mik6Cj4gICAgICAgYXJtNjQ6IGR0czogYWN0aW9uczogczcwMDogQWRkIEkyQyBjb250cm9sbGVy
IG5vZGVzCj4gICAgICAgYXJtNjQ6IGR0czogYWN0aW9uczogczcwMC1jdWJpZWJvYXJkNzogRW5h
YmxlIEkyQzAgYW5kIEkyQzEKPiAKPiBTYXJhdmFuYW4gU2VrYXIgKDEpOgo+ICAgICAgIGFybTY0
OiBkdHM6IGFjdGlvbnM6IEFkZCBwaW5jdHJsIG5vZGUgZm9yIEFjdGlvbnMgU2VtaSBTNzAwCj4g
Cj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvYWN0aW9ucy9zNzAwLWN1YmllYm9hcmQ3LmR0cyB8IDUz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvYWN0aW9ucy9zNzAwLmR0c2kgICAgICAgICAgICB8IDU4ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgYXJjaC9hcm02NC9ib290L2R0cy9hY3Rpb25zL3M5MDAuZHRzaSAgICAgICAgICAgIHwgMTAg
KysrKysrKysrKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDEyMSBpbnNlcnRpb25zKCspCj4gCgoKLS0g
ClNVU0UgTGludXggR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55
CkdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUgU21pdGhhcmQsIEdyYWhhbSBOb3J0b24KSFJC
IDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
