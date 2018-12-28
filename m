Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D986CC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:47:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0BC21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mJu1EbTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0BC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WDGT1cyKkThZn7DoYizPCG6+jtc0YYrbGnSwquprbn0=; b=mJu1EbTIRQw8UO
	ODQlo9bqPQTF/G6bTsS6V+yRfM+aKTulRA4bhWa/NLvoCUIFPpBTyG/6P9Mov5+3C0a/U5a4pqucr
	Ele+cXdX2Qvm+VeXEZG5WjVuLptshN/E/KzF1qvEZaPpYFE4I1QUAsp20UIs+L5zj5DeWz2qtRoV9
	YujDHKnlMo4TAbJhcGkQ9tkEgev0rMWjvgZ+v18Pq+Ypy+Xx1pmaqELDGdCZTa8ixcVB7qkeQEXBR
	yTG/Rp8xPUuP2OznxLpPkNUzG9uE1uXGiW/9K01WBIToeClVElkH992tVud0A6qzpVtErcFex/koI
	fX3JSL7LWyRgiKWi985Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcuLm-00036C-Dq; Fri, 28 Dec 2018 15:47:02 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuLi-00034s-HH; Fri, 28 Dec 2018 15:47:00 +0000
Received: from oxbsltgw03.schlund.de ([212.227.220.147]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEFnP-1gTJQL0KWL-00AH1s; Fri, 28 Dec 2018 16:46:40 +0100
Date: Fri, 28 Dec 2018 16:46:39 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh@kernel.org>
Message-ID: <812144724.382117.1546011999351@email.ionos.de>
In-Reply-To: <894cfae3-43f4-f201-9b54-41114ce8107e@i2se.com>
References: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
 <1542805904-6446-2-git-send-email-stefan.wahren@i2se.com>
 <20181206234941.GA6340@bogus>
 <894cfae3-43f4-f201-9b54-41114ce8107e@i2se.com>
Subject: Re: [PATCH 1/5] dt-bindings: nvmem: add binding for Raspberry Pi OTP
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:SigFFqEEedZFuREHGKFBTUzknmcHoVWodplMihNkhrkBtwbYAg3
 TbtyBBgVQ56Pamzrr2xEh5ZOhDXczNEImmaOwx/AhRbo0WzHKglB4gplFk5O5Q6kuMnJ9PX
 GANxW6lkNQNfMNm3ubAMqLW0mIUxp3fFeNr9PFuZcudsIKHCZB46OuXwAXwk+jted3K1jhy
 K67B3bF/28K+WTFHIeX6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q1qgHHoh2cI=:LDTZMNgQNUKljEYAuDsfz+
 aWmcFMcwAYIjXXQzI4A1g36oEFFCQOaZ/1ErQE02shDAOUzuKsi3/BR61b2D1wfO9B6/TOx9q
 o1gBEWW87UDqQNRcuNjrL78B2D63UMMdU3jJZcccfXCRHqxB+v0nJAncCYvrR7Wy9CfHhS5+l
 VunwRzTgZfWZjunMrSyIbphHLMJTQTcxbG/9r9A9Nv5chVjdiQ01asUmM8xsWO/sQpZzOP+m/
 m8elGmJ3DunSPVopgXj4mjsPnKt7mjkxoHN3eLawaaUpC3XQ7jsXR0kwaYlpROQy0udyUFyUW
 x8lkE9G9ukKAjvWDf0DuqfQQ7sxKjFcH0YnTOSYXBPklFZ23pGp1+2URBFUIRF8CDTYyDoMGB
 w2FZjIJdHDXTwaX3PNodFg4BQylKy9dwgbkv8YAdrcm4jtrZL9DMmVsAxyzyI3TMEguJFFDm5
 BQDLxfrQVT/x2DNE0vH4zY3Gg+geJ4N2ENZPJHwua5F4bTl9C9hHrGCKp7B3QxR3cgYbUmwqt
 tfsbA7Ihmz8/iW3l8h7kp3Gb3P4ZhF4DWmyC0q6MNmgMI9pQ+lv4UOoJ0L8tuf81xgkGVxqkd
 dpD6yipeX+kBdZpLp4GBuXt7n4BwEFqqBrLOJUM48Mqhnjy5zOefLEDTSgZlx41+W7hMSTuCg
 6+CxFaacPeUiQSVYUEo2r3cWcxlbI/gyK8Ae5oaiQyUB6PJ8i4ZhfTaJLwDqwd67NRIVzNKXo
 qt2nhx0dQxgtnBCz2tCJ1R9WpS4MuVrtvQOVYQU+h5Hl9hPCdrX5apKp+cA=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_074658_879383_76EFB650 
X-CRM114-Status: GOOD (  21.81  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Eric Anholt <eric@anholt.net>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAoKPiBTdGVmYW4gV2FocmVuIDxzdGVmYW4ud2FocmVuQGkyc2UuY29tPiBoYXQgYW0g
Ny4gRGV6ZW1iZXIgMjAxOCB1bSAwOToxMCBnZXNjaHJpZWJlbjoKPiAKPiAKPiBIaSBSb2IsCj4g
Cj4gQW0gMDcuMTIuMTggdW0gMDA6NDkgc2NocmllYiBSb2IgSGVycmluZzoKPiA+IE9uIFdlZCwg
Tm92IDIxLCAyMDE4IGF0IDAyOjExOjQwUE0gKzAxMDAsIFN0ZWZhbiBXYWhyZW4gd3JvdGU6Cj4g
Pj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmcgZm9yIFJhc3BiZXJyeSBQ
aSBjdXN0b21lciBPVFAKPiA+PiBkcml2ZXIuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gV2FocmVuIDxzdGVmYW4ud2FocmVuQGkyc2UuY29tPgo+ID4+IC0tLQo+ID4+ICAuLi4vbnZt
ZW0vcmFzcGJlcnJ5cGksYmNtMjgzNS1jdXN0b21lci1vdHAudHh0ICAgICB8IDIyICsrKysrKysr
KysrKysrKysrKysrKysKPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPiA+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
dm1lbS9yYXNwYmVycnlwaSxiY20yODM1LWN1c3RvbWVyLW90cC50eHQKPiA+Pgo+ID4+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vcmFzcGJlcnJ5
cGksYmNtMjgzNS1jdXN0b21lci1vdHAudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL252bWVtL3Jhc3BiZXJyeXBpLGJjbTI4MzUtY3VzdG9tZXItb3RwLnR4dAo+ID4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPj4gaW5kZXggMDAwMDAwMC4uMDQxZmYxNwo+ID4+IC0tLSAv
ZGV2L251bGwKPiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZt
ZW0vcmFzcGJlcnJ5cGksYmNtMjgzNS1jdXN0b21lci1vdHAudHh0Cj4gPj4gQEAgLTAsMCArMSwy
MiBAQAo+ID4+ICtDdXN0b21lciBPVFAgTWVtb3J5IGZvciBSYXNwYmVycnkgUGkKPiA+PiArCj4g
Pj4gK1RoZSBWQzQgZmlybXdhcmUgZXhwb3NlcyBhIG1haWxib3ggaW50ZXJmYWNlIHRoYXQgYWxs
b3dzIHRoZSBBUk0gY29yZQo+ID4+ICt0byBhY2Nlc3MgdGhlIGN1c3RvbWVyIHBhcnQgb2YgdGhl
IE9UUCBtZW1vcnkuCj4gPj4gKwo+ID4+ICtUaGUgT1RQIG5vZGUgbXVzdCBiZSBhIGNoaWxkIG5v
ZGUgb2YgdGhlIFJhc3BiZXJyeSBQaSBmaXJtd2FyZSBub2RlLgo+ID4+ICsKPiA+PiArUmVxdWly
ZWQgcHJvcGVydGllcyA6Cj4gPj4gKy0gY29tcGF0aWJsZSAgICAgOiBTaG91bGQgYmUgInJhc3Bi
ZXJyeXBpLGJjbTI4MzUtY3VzdG9tZXItb3RwIgo+ID4gV2h5IGRvIHdlIG5lZWQgdGhpcyBjaGls
ZCBub2RlPyBDYW4ndCB0aGUgcGFyZW50IGluc3RhbnRpYXRlIHRoaXM/Cj4gPgo+ID4gQXJlIHRo
ZXJlIE9UUCBmaWVsZHMgeW91IHdhbnQgdG8gZXhwb3NlIGluIERUPwo+IAo+IHRoZSBjdXN0b21l
ciBwYXJ0IG9mIHRoZSBPVFAgaXMgcmVzZXJ2ZWQgKGluaXRpYWxpemVkIHdpdGggemVybykgZm9y
Cj4gdXNlciB3aG8gd2FudHMgdG8gdXNlIHRoZSBSYXNwYmVycnkgUGkgKG1vc3RseSB0aGUgQ29t
cHV0ZSBNb2R1bGUpIGluCj4gdGhlaXIgY3VzdG9tIGRlc2lnbnMuIFNvIGkgY2Fubm90IHByb3Zp
ZGUgYW55IG52bWVtIGNlbGxzIHlldCBiZWNhdXNlIGl0Cj4gaXMgdXAgdG8gdGhlIHVzZXIgdG8g
ZGVmaW5lIHRoZW0gKGUuZy4gaGFyZHdhcmUgcmVsYXRlZCB2YWx1ZXMgbGlrZQo+IHNlcmlhbCBu
dW1iZXJzLCBNQUMgYWRkcmVzc2VzIGZvciBhZGRpdGlvbmFsIG5ldHdvcmsgaW50ZXJmYWNlcyBv
cgo+IGNhbGlicmF0aW9uIHZhbHVlcykuIEJ1dCB5ZXMgaSBjb25zaWRlciB0aGUgYmluZGluZyBh
bmQgdGhlIGFiaWxpdHkgdG8KPiBkZWZpbmUgbnZtZW0gY2VsbHMgdmlhIGRldmljZXRyZWUgYXMg
YSBncmVhdCBmZWF0dXJlLgo+IAo+IEN1cnJlbnRseSB0aGUgRm91bmRhdGlvbiBzdWdnZXN0cyB0
byB1c2UgdGhlIG1haWxib3ggaW50ZXJmYWNlIGZyb20KPiB1c2Vyc3BhY2UgWzFdLCBidXQgaSBw
cmVmZXIgYSBtb3JlIGNvbW1vbiB3YXkgbGlrZSBudm1lbS4KPiAKPiBbMV0gLcKgCj4gaHR0cHM6
Ly93d3cucmFzcGJlcnJ5cGkub3JnL2RvY3VtZW50YXRpb24vaGFyZHdhcmUvaW5kdXN0cmlhbC9S
RUFETUUubWQKPgoKZGlkIGl0IGFuc3dlciB5b3VyIHF1ZXN0aW9ucz8KClN0ZWZhbgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
