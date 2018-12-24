Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50103C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:05:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB2C21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MWxRy/lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB2C21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N5Ni5t9RcxdQ70pS5m5S5SL/7wvhGIsA503s1rh5GnE=; b=MWxRy/lxvevMCe
	fCO53fBvRlYrhngPagEOSwR2w2cIAyApl4Skh216uyXEnl+p3qrPiyW3Goyswsq+77UQcEWn7+Awx
	JI0nObZI7iW8rz4mVbwLMneS5t/aF1IjZDjl6zFfTe8dEyeQEGSLh7R+c7zIqIA4ORDRc8adrlxS3
	LJ3CX0uDad8zhRM3hx7AJ3I4OMFlUE/XWCzt9DvyfTqoGUHHaaHZZV3ji3VcBgOG/zdmSCt0x/zZK
	Pb1HlXzVIvgaLB3+bYUBw8G+YVmqwQJhsLjoL/zUkKvOEte6e2/NpnFkBD3y0JwPQu2JLyWXSNo//
	4H7HBITy5oyxVYuReYMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbTfk-00058D-BT; Mon, 24 Dec 2018 17:05:44 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbTfg-00056g-2m
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 17:05:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7B76E20A46; Mon, 24 Dec 2018 18:05:25 +0100 (CET)
Received: from localhost (alyon-652-1-163-36.w109-212.abo.wanadoo.fr
 [109.212.74.36])
 by mail.bootlin.com (Postfix) with ESMTPSA id 40DD62070E;
 Mon, 24 Dec 2018 18:05:15 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH 1/3] pinctrl: armada-37xx: Correct mpp definitions
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
 <20181221173259.8372-2-gregory.clement@bootlin.com>
 <20181222033213.43642e0f@nic.cz>
Date: Mon, 24 Dec 2018 18:05:15 +0100
In-Reply-To: <20181222033213.43642e0f@nic.cz> (Marek Behun's message of "Sat, 
 22 Dec 2018 03:32:13 +0100")
Message-ID: <87efa6c0tw.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_090540_261626_D4703430 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-gpio@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWFyZWssCiAKIE9uIHNhbS4sIGTDqWMuIDIyIDIwMTgsIE1hcmVrIEJlaHVuIDxtYXJlay5i
ZWh1bkBuaWMuY3o+IHdyb3RlOgoKPiBPbiBGcmksIDIxIERlYyAyMDE4IDE4OjMyOjU3ICswMTAw
Cj4gR3JlZ29yeSBDTEVNRU5UIDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+IHdyb3RlOgo+
Cj4+ICsJUElOX0dSUF9HUElPKCJwY2llMSIsIDMsIDEsIEJJVCg1KSwgInBjaWUiKSwKPj4gKwlQ
SU5fR1JQX0dQSU8oInBjaWUxX2Nsa3JlcSIsIDQsIDEsIEJJVCg5KSwgInBjaWUiKSwKPgo+IElm
IHRoZSBwYWlyIGlzIHNwbGl0IHRvIGNsa3JlcSBhbmQgcmVzZXQsIHNob3VsZG4ndCB0aGUgZmly
c3QgYmUgY2FsbGVkCj4gcGNpZTFfcmVzZXQ/CgpJIGNvbnNpZGVyZWQgdGhpcyBidXQgY2hvc2Ug
dG8ga2VlcCBwY2llMSBpbiBvcmRlciB0byBwcmVzZXJ2ZSBiYWNrd2FyZApjb21wYXRpYmlsaXR5
LgoKSSBhZ3JlZSB0aGF0IGl0IGlzIGRlYmF0YWJsZSwgYmVjYXVzZSB3aXRob3V0IHRoZSBmaXgg
dGhlIG9sZCBkZXZpY2UKdHJlZSBjYW4ndCB3b3JrLiBIb3dldmVyIEkgZmluZCBpdCBiZXR0ZXIg
cHJlc2VydmluZyB0aGUgaW5pdGlhbCBpbnRlbnQKb2YgYW4gZXhpc3RpbmcgZGV2aWNlIHRyZWUu
CgpCeSB0YWxraW5nIGFib3V0IGl0LCBJIHRoaW5rIGFib3V0IGFuIG90aGVyIG9wdGlvbiwga2Vl
cGluZyBwY2llMSBuYW1lCnRvIHNldHVwIHRoZSBwaW5zIDM5IGFuZCA0MCBob3cgaXQgd2FzIGRv
Y3VtZW50ZWQuIEFuZCBpbnRyb2R1Y2luZwpwY2llMV9yZXNldCBhbmQgcGNpZTFfY2xrcmVxIGZv
ciBuZXcgYmluZGluZy4gaG93ZXZlciBJIGRvbid0IGtub3cgaG93Cml0IGNvdWxkIGJlIGhhbmRs
ZSBieSB0aGUgcGluY3RybCBmcmFtZXdvcmsuCgpHcmVnb3J5Cgo+IE1hcmVrCgotLSAKR3JlZ29y
eSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcK
aHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
