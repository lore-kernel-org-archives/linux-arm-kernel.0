Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50113C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:36:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201FD206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W/LiaqBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201FD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BMhfmMXJz0H4wkG8pqX8jOs8R+SgsFIGBpaUFRKQqOo=; b=W/LiaqBAyDaxfD
	rTHRgsrg+rH7UJMp1w2+Yb8bnnOA4ZfKHqcqXHAtA9JozXXOG4/KUZqBxLWEc7p0b4RW2njZ6tdaE
	VWZIbG5R61udzzcHU0BV5CL6W0v8J/nZfLJ4u93SX9lspYl0RaRAo1iNlAVjmUXjjnJUfCyBi10YZ
	XOB8HE/Qn3rfrIwCbIQsYW2udiDXbuLfiuXjO5nu483v2jZxEqt1UUtOxRaf+JLapwCqLr/zxS0IR
	HDV7qGeYVkrqXrtvb/NnCReG07QSklFP3lSRRLLQ+HWXe0JRFo+T152TMQyqpG+GPKO9FVd4sH7SD
	zDs4ImO9GLs+CuifyDmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdK5-00044U-8e; Thu, 10 Jan 2019 16:36:49 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdK1-000440-VF
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:36:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4945820A08; Thu, 10 Jan 2019 17:36:43 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr
 [109.213.145.18])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0B28220898;
 Thu, 10 Jan 2019 17:36:33 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 0/6] Add CPU clock support for Armada 7K/8K
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
 <87a7k8o5d5.fsf@FE-laptop>
 <154713766177.15366.14948014236046606980@swboyd.mtv.corp.google.com>
Date: Thu, 10 Jan 2019 17:36:33 +0100
In-Reply-To: <154713766177.15366.14948014236046606980@swboyd.mtv.corp.google.com>
 (Stephen Boyd's message of "Thu, 10 Jan 2019 08:27:41 -0800")
Message-ID: <875zuwo4fi.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_083646_152484_5622084B 
X-CRM114-Status: GOOD (  18.07  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKIAogT24gamV1LiwgamFudi4gMTAgMjAxOSwgU3RlcGhlbiBCb3lkIDxzYm95
ZEBrZXJuZWwub3JnPiB3cm90ZToKCj4gUXVvdGluZyBHcmVnb3J5IENMRU1FTlQgKDIwMTktMDEt
MTAgMDg6MTY6MjIpCj4+IEhpIFN0ZXBoZW4sCj4+ICAKPj4gIE9uIGRpbS4sIGTDqWMuIDE2IDIw
MTgsIEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPiB3cm90ZToK
Pj4gCj4+ID4gSGVsbG8sCj4+ID4KPj4gPiBUaGlzIGlzIHRoZSB0aGlyZCB2ZXJzaW9uIG9mIGEg
c2VyaWVzIGFsbG93aW5nIHRvIG1hbmFnZSB0aGUgY3B1Cj4+ID4gY2xvY2sgZm9yIEFybWFkYSA3
Sy84Sy4gRm9yIHRoZXNlIFNvQ3MsIHRoZSBDUFVzIHNoYXJlIHRoZSBzYW1lIGNsb2NrCj4+ID4g
YnkgY2x1c3Rlciwgc28gYWN0dWFsbHkgdGhlIGNsb2NrIG1hbmFnZW1lbnQgaXMgZG9uZSBhdCBj
bHVzdGVyIGxldmVsLgo+PiA+Cj4+ID4gQXMgZm9yIHRoZSBvdGhlciBBcm1hZGEgN0svOEsgY2xv
Y2tzIGl0IGlzIHBvc3NpYmxlIHRvIGhhdmUgbXVsdGlwbGUKPj4gPiBBUCBzbyBoZXJlIGFnYWlu
IHdlIG5lZWQgdG8gaGF2ZSB1bmlxdWUgbmFtZTogdGhlIHB1cnBvc2Ugb2YgdGhlIHNlY29uZAo+
PiA+IHBhdGNoIGlzIHRvIHNoYXJlIGEgY29tbW9uIGNvZGUgd2hpY2ggd2lsbCBiZSB1c2VkIGlu
IDMgZHJpdmVycy4KPj4gPgo+PiA+IFRoZSBsYXN0IDIgcGF0Y2ggZW5hYmxlIHRoZSBkcml2ZXIg
YXQgZHQgYW5kIHBsYXRmb3JtIGxldmVsIGFuZCB3aWxsCj4+ID4gYmUgYXBwbGllZCB0aHJvdWdo
IHRoZSBtdmVidSBzdWJzeXN0ZW0uCj4+IAo+PiBXaGF0IGlzIHRoZSBzdGF0dXMgb2YgdGhpcyBz
ZXJpZXM/Cj4+IAo+PiBUaGUgb25seSBjb21tZW50cyBJIGhhZCB3YXMgZnJvbSBSb2IgYWJvdXQg
dGhlIGJpbmRpbmcgYW5kIEkgYW5zd2VyZWQKPj4gdGhlbSAzIHdlZWtzIGFnby4gRG8geW91IGhh
dmUgYW55IG90aGVyIGNvbW1lbnRzPyBEbyB5b3UgZXhwZWN0IGEgcmViYXNlCj4+IG9mIHRoaXMg
c2VyaWVzIG9uIHY1LjAtcmMxPwo+PiAKPgo+IEknbSB3YWl0aW5nIGZvciBSb2IuIEkgdGhpbmsg
dGhlIGJpbmRpbmcgaXMgbm90IHByb3BlciBzbyBwcmVzdW1hYmx5IHlvdQo+IHdpbGwgZmlndXJl
IG91dCB3aGF0IFJvYiB3YW50cyBhbmQgdGhlbiBjaGFuZ2UgdGhlIGNvZGUgYWNjb3JkaW5nbHkg
YW5kCj4gcmVzZW5kPwoKQWN0dWFsbHkgdGhlIGJpbmRpbmcgZGVzY3JpYmVzIHByb3Blcmx5IHRo
ZSBoYXJkd2FyZSB3ZSBoYXZlIGFuZCB0aGF0CndoYXQgSSBhbnN3ZXJlZCB0byBSb2IuCgpHcmVn
b3J5CgotLSAKR3JlZ29yeSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJu
ZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
