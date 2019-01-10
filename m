Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF8D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZdoUTLDu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unfn1h+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF8D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XArRQlNbqzDB8eC+CzRd9Bx3kOQCrjRcbCwPzesIpJo=; b=ZdoUTLDuqHbCg0
	W77sTjqY6Ksj1FA1IKZcWofuJJvO4VHFaQOqNqDBsL9S5vZetjLkMebBh4AW1V602sx6J6wFmyRyO
	Z11mgta7rs0aHp9PI0RwQRCec/qpr3gvn8oTXo7BDOLaQW4wCEIOYRYwI/OvgigXR272FkDU79mQA
	uyuTWTQOTlR1lJe9KfG5q7r11tfNtBqjC0QMl2yqpXpG58c+xKGOyGIpU1r0ZBY1EQ41pElXiRm1b
	xAnGqLeVhMk8OoCCjSD5Q34NYcC9KmF08spvRc197iw1QlXwz1YWpfuRfYWjrYGzzqAl0aYXPs7a0
	eHZurdO6m2BiPSec0YHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdE4-00015K-CZ; Thu, 10 Jan 2019 16:30:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdBH-0005kt-NE
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:28:39 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1D13206B7;
 Thu, 10 Jan 2019 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547137662;
 bh=ykAYMQOPxZZiywiLGtd498PLtk1Q4okjxDToieygCNI=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=Unfn1h+NSs/0Ho3cvjuVbOVGPi99921FAjNKfQGN8jgrS7JITLppCH839IeVzyloC
 EvES+lCSxzR6wULPaZakNJlN8jB8Z9BX5ey8KcPoOm9jZBbQPW9DuVrjKhuZj/CuIV
 q10218Sih3kma+mxVuGsH+EUnq5nQiHAkjWDWSYA=
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/6] Add CPU clock support for Armada 7K/8K
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Stephen Boyd <sboyd@codeaurora.org>
In-Reply-To: <87a7k8o5d5.fsf@FE-laptop>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
 <87a7k8o5d5.fsf@FE-laptop>
Message-ID: <154713766177.15366.14948014236046606980@swboyd.mtv.corp.google.com>
Date: Thu, 10 Jan 2019 08:27:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082744_350434_725049A1 
X-CRM114-Status: GOOD (  15.99  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>, Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquèl Raynal <miquel.raynal@bootlin.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBHcmVnb3J5IENMRU1FTlQgKDIwMTktMDEtMTAgMDg6MTY6MjIpCj4gSGkgU3RlcGhl
biwKPiAgCj4gIE9uIGRpbS4sIGTDqWMuIDE2IDIwMTgsIEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29y
eS5jbGVtZW50QGJvb3RsaW4uY29tPiB3cm90ZToKPiAKPiA+IEhlbGxvLAo+ID4KPiA+IFRoaXMg
aXMgdGhlIHRoaXJkIHZlcnNpb24gb2YgYSBzZXJpZXMgYWxsb3dpbmcgdG8gbWFuYWdlIHRoZSBj
cHUKPiA+IGNsb2NrIGZvciBBcm1hZGEgN0svOEsuIEZvciB0aGVzZSBTb0NzLCB0aGUgQ1BVcyBz
aGFyZSB0aGUgc2FtZSBjbG9jawo+ID4gYnkgY2x1c3Rlciwgc28gYWN0dWFsbHkgdGhlIGNsb2Nr
IG1hbmFnZW1lbnQgaXMgZG9uZSBhdCBjbHVzdGVyIGxldmVsLgo+ID4KPiA+IEFzIGZvciB0aGUg
b3RoZXIgQXJtYWRhIDdLLzhLIGNsb2NrcyBpdCBpcyBwb3NzaWJsZSB0byBoYXZlIG11bHRpcGxl
Cj4gPiBBUCBzbyBoZXJlIGFnYWluIHdlIG5lZWQgdG8gaGF2ZSB1bmlxdWUgbmFtZTogdGhlIHB1
cnBvc2Ugb2YgdGhlIHNlY29uZAo+ID4gcGF0Y2ggaXMgdG8gc2hhcmUgYSBjb21tb24gY29kZSB3
aGljaCB3aWxsIGJlIHVzZWQgaW4gMyBkcml2ZXJzLgo+ID4KPiA+IFRoZSBsYXN0IDIgcGF0Y2gg
ZW5hYmxlIHRoZSBkcml2ZXIgYXQgZHQgYW5kIHBsYXRmb3JtIGxldmVsIGFuZCB3aWxsCj4gPiBi
ZSBhcHBsaWVkIHRocm91Z2ggdGhlIG12ZWJ1IHN1YnN5c3RlbS4KPiAKPiBXaGF0IGlzIHRoZSBz
dGF0dXMgb2YgdGhpcyBzZXJpZXM/Cj4gCj4gVGhlIG9ubHkgY29tbWVudHMgSSBoYWQgd2FzIGZy
b20gUm9iIGFib3V0IHRoZSBiaW5kaW5nIGFuZCBJIGFuc3dlcmVkCj4gdGhlbSAzIHdlZWtzIGFn
by4gRG8geW91IGhhdmUgYW55IG90aGVyIGNvbW1lbnRzPyBEbyB5b3UgZXhwZWN0IGEgcmViYXNl
Cj4gb2YgdGhpcyBzZXJpZXMgb24gdjUuMC1yYzE/Cj4gCgpJJ20gd2FpdGluZyBmb3IgUm9iLiBJ
IHRoaW5rIHRoZSBiaW5kaW5nIGlzIG5vdCBwcm9wZXIgc28gcHJlc3VtYWJseSB5b3UKd2lsbCBm
aWd1cmUgb3V0IHdoYXQgUm9iIHdhbnRzIGFuZCB0aGVuIGNoYW5nZSB0aGUgY29kZSBhY2NvcmRp
bmdseSBhbmQKcmVzZW5kPwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
