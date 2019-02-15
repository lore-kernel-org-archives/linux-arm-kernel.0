Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DB8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022012192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kw83mkh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022012192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wu1rztpEOzvY9b5hcheUVaHF1/ZSOEgOhTwpj7nruCw=; b=kw83mkh4wH5KYi
	kkgEcdVujKycnVrg2Y6L3MEkxEeFhEeJxy1QNiw45Pz/dLzOasT9q7RkhtH1meyJky/MDg+Kva0st
	AT5hRrbbvQUa6/1XKP1LqbBO29Jj6yuMy7n2eEtk656LP9H6SfSpxkcktaqjeuGlAvmeoEELt8OkN
	evq++3VVA3Pb47umeFhpgHBCai4le8kHuL0Tsj9K1oGPkZcanrNqmZEoqbWKuf7WO94F9Jm5h91C7
	niR4ynMuzZzJN0PFOA0KLCdSxPvyTZsji4O7uaK6je+0iP5QKXp4PYht0o9UkeVKvcBrcH4ZgFIKc
	GB/B/8QjLT/DoWwyOf3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueEB-0006TE-Vl; Fri, 15 Feb 2019 14:12:31 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueDf-0005n6-Bs; Fri, 15 Feb 2019 14:12:01 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 4CDDFFB02;
 Fri, 15 Feb 2019 15:11:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BYd1oskSEwld; Fri, 15 Feb 2019 15:11:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 4566848DC0; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bastien Nocera <hadess@hadess.net>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/3] dt-bindings: input: Refer to touchscreen.txt for
 goodix ts
Date: Fri, 15 Feb 2019 15:11:52 +0100
Message-Id: <99085b90c327193f6bdb9b0a505daa6a9848e1c6.1550239328.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
References: <cover.1550239328.git.agx@sigxcpu.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_061159_562972_D905C9BA 
X-CRM114-Status: GOOD (  10.80  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UmVmZXIgdG8gdG91Y2hzY3JlZW4udHh0IGZvciBnZW5lcmljIHRvdWNoIHByb3BlcnRpZXMuIFRo
aXMgYXZvaWRzCmR1cGxpY2F0aW9uIGFuZCB3ZSdyZSB1c2luZyB0aGUgZ2VuZXJpYyBjb2RlIHRv
IHBhcnNlIHRoZXNlIGluIHRoZQpkcml2ZXIuIFdoaWxlIGF0IHRoYXQgYWRkIHRvdWNoc2NyZWVu
LXNpemUte3gseX0gd2hpY2ggYXJlIHJlc3BlY3RlZCBieQp0aGUgZHJpdmVyIGFzIHdlbGwuCgpT
aWduZWQtb2ZmLWJ5OiBHdWlkbyBHw7xudGhlciA8YWd4QHNpZ3hjcHUub3JnPgotLS0KIC4uLi9i
aW5kaW5ncy9pbnB1dC90b3VjaHNjcmVlbi9nb29kaXgudHh0ICAgICAgICAgICB8IDEzICsrKysr
KysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3Rv
dWNoc2NyZWVuL2dvb2RpeC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LnR4dAppbmRleCA1N2QzZDg4NzBhMDkuLjhjZjBiNGQz
OGE3ZSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0
L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQKQEAgLTE5LDExICsxOSwxNCBAQCBP
cHRpb25hbCBwcm9wZXJ0aWVzOgogIC0gaXJxLWdwaW9zCQk6IEdQSU8gcGluIHVzZWQgZm9yIElS
US4gVGhlIGRyaXZlciB1c2VzIHRoZQogCQkJICBpbnRlcnJ1cHQgZ3BpbyBwaW4gYXMgb3V0cHV0
IHRvIHJlc2V0IHRoZSBkZXZpY2UuCiAgLSByZXNldC1ncGlvcwkJOiBHUElPIHBpbiB1c2VkIGZv
ciByZXNldAotCi0gLSB0b3VjaHNjcmVlbi1pbnZlcnRlZC14ICA6IFggYXhpcyBpcyBpbnZlcnRl
ZCAoYm9vbGVhbikKLSAtIHRvdWNoc2NyZWVuLWludmVydGVkLXkgIDogWSBheGlzIGlzIGludmVy
dGVkIChib29sZWFuKQotIC0gdG91Y2hzY3JlZW4tc3dhcHBlZC14LXkgOiBYIGFuZCBZIGF4aXMg
YXJlIHN3YXBwZWQgKGJvb2xlYW4pCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzd2Fw
cGluZyBpcyBkb25lIGFmdGVyIGludmVydGluZyB0aGUgYXhpcykKKyAtIHRvdWNoc2NyZWVuLWlu
dmVydGVkLXgKKyAtIHRvdWNoc2NyZWVuLWludmVydGVkLXkKKyAtIHRvdWNoc2NyZWVuLXNpemUt
eAorIC0gdG91Y2hzY3JlZW4tc2l6ZS15CisgLSB0b3VjaHNjcmVlbi1zd2FwcGVkLXgteQorCitU
aGUgdG91Y2hzY3JlZW4tKiBwcm9wZXJ0aWVzIGFyZSBkb2N1bWVudGVkIGluIHRvdWNoc2NyZWVu
LnR4dCBpbiB0aGlzCitkaXJlY3RvcnkuCiAKIEV4YW1wbGU6CiAKLS0gCjIuMjAuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
