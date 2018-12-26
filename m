Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AB620C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BuPt2BPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AB620C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9wuxEdTiUq5rpKRWkzSviEfb29Ms0KU4f6q8Tig3wCg=; b=BuPt2BPmkAqUnN
	9+KgdL3NEzBFchHj/fsnVyI2wzjsn1/Vbra4m1JxRo8IVVkHCtc8iOWtlgmzOku+/a4ScdKvjvCeR
	ny3xpS9//dscyI+Zy8fgi1HW8Pc1T85jUHfaxpASkgPBu6N/JJV2mo2jJnhHvWhsXMINWn/RpMPhc
	kSvWgsLVKwWqGwb5meobm+2T9uEd3zw9QPgHBfFz7q4KAL6xVcy94JBDjmbtVh6FcC4ztKixx6w4e
	bMM3VxO5hhTp4agX+U8xiY/hcmB6jXpClQwmpu9xFvWKH0LvybCLiBPgJqqnr9FXaVDznMcyHRTYS
	wbhMrbzE5G2QM39OrqAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcBrZ-0002zL-Fi; Wed, 26 Dec 2018 16:16:53 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcBrV-0002ni-4y
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 16:16:51 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4C634209ED; Wed, 26 Dec 2018 17:16:37 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 196362070E;
 Wed, 26 Dec 2018 17:16:37 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI
 area
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
Date: Wed, 26 Dec 2018 17:16:37 +0100
In-Reply-To: <20181221164503.5128-1-xypron.glpk@gmx.de> (Heinrich Schuchardt's
 message of "Fri, 21 Dec 2018 17:45:03 +0100")
Message-ID: <87h8f09sbe.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_081649_471919_69414D74 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSGVpbnJpY2gsCiAKIE9uIHZlbi4sIGTDqWMuIDIxIDIwMTgsIEhlaW5yaWNoIFNjaHVjaGFy
ZHQgPHh5cHJvbi5nbHBrQGdteC5kZT4gd3JvdGU6Cgo+IFRoZSBtZW1vcnkgYXJlYSBbMHg0MDAw
MDAwLTB4NDIwMDAwMFsgaXMgb2NjdXBpZWQgYnkgdGhlIFBTQ0kgZmlybXdhcmUuIEFueQo+IGF0
dGVtcHQgdG8gYWNjZXNzIGl0IGZyb20gTGludXggbGVhZHMgdG8gYW4gaW1tZWRpYXRlIGNyYXNo
Lgo+Cj4gU28gbGV0J3MgbWFrZSB0aGUgc2FtZSBtZW1vcnkgcmVzZXJ2YXRpb24gYXMgdGhlIHZl
bmRvciBrZXJuZWwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXBy
b24uZ2xwa0BnbXguZGU+CgpXZSBnb3QgYSBzaW1pbGFyIHBhdGNoIG9uZSBtb250aCBhZ28gYW5k
IFJ1c3NlbGwgS2luZyBwb2ludGVkIHRoYXQgaXQKZGlkbid0IG1hdGNoIHdhaHQgaGUgc2F3IG9u
IGhpcyBNQUNDSElBVE9iaW46Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9s
aW51eC1hcm0ta2VybmVsLzIwMTgtTm92ZW1iZXIvNjEyMzYwLmh0bWwKCm9uIG1pbmUgdW5kZXIg
VS1Cb290IEkgZ290OgoKTWFydmVsbD4+IG1kIDB4NDAwMDAwMAowNDAwMDAwMDogMDAwMDAwMDAg
MDAwMDAwMDcgMDAwMDAwMDUgMDAwMDAwNDAgICAgLi4uLi4uLi4uLi4uQC4uLgowNDAwMDAxMDog
MDAwMDAwMDEgMDAwMDEwMDAgMDAwMDAwMDcgMDAwMDAwMDEgICAgLi4uLi4uLi4uLi4uLi4uLgow
NDAwMDAyMDogMDAwMDAwMDggMDAwMDAwMDAgMDAwMDAwMDkgMDAwMDAwMDAgICAgLi4uLi4uLi4u
Li4uLi4uLgowNDAwMDAzMDogMDAwMDAwMGEgMDAwMDAwMDAgZmZmZmZmZmYgZmZmZmZmZmYgICAg
Li4uLi4uLi4uLi4uLi4uLgowNDAwMDA0MDogZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZm
ZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAwMDA1MDogZmZmZmZmZmYgZmZmZmZmZmYgZmZm
ZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAwMDA2MDogZmZmZmZmZmYgZmZm
ZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAwMDA3MDogZmZm
ZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAw
MDA4MDogZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4u
Li4uLgowNDAwMDA5MDogZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4u
Li4uLi4uLi4uLi4uLgowNDAwMDBhMDogZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZm
ZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAwMDBiMDogZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZm
ZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAwMDBjMDogZmZmZmZmZmYgZmZmZmZm
ZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAwMDBkMDogZmZmZmZm
ZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4uLgowNDAwMDBl
MDogZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4uLi4uLi4uLi4u
LgowNDAwMDBmMDogZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgZmZmZmZmZmYgICAgLi4uLi4u
Li4uLi4uLi4uLgoKSW4gbXkgY2FzZSBJIGhhdmUgYW4gb2xkIEFURiwgaG93ZXZlciB0aGlzIGtp
bmQgb2Ygc2V0dGluZyBzaG91bGQgYmUKZG9uZSBieSB0aGUgYm9vdGxvYWRlci4KCkkgYW0gaW50
ZXJlc3RlZCBieSB5b3VyIGNsYWltIGFib3V0IGNhdXNpbmcgYW4gaW1tZWRpYXRlIGNyYXNoIHdo
ZW4KYWNjZXNzaW5nIHRoaXMgcmVnaW9uLiBIb3cgZGlkIHlvdSB0cmlnZ2VyIGl0PwoKR3JlZ29y
eQoKCj4gLS0tCj4gdjIKPiAJTW92ZSB0aGUgY2hhbmdlIGZyb20gYXJtYWRhLTgwNDAtbWNiaW4u
ZHRzIHRvIGFybWFkYS1hcDgwNi5kdHNpLgo+IAlJIG9ubHkgaGF2ZSBhIE1BQ0NISUFUT2JpbiBm
b3IgdGVzdGluZyBidXQKPiAJaHR0cHM6Ly9naXRodWIuY29tL01hcnZlbGxFbWJlZGRlZFByb2Nl
c3NvcnMvbGludXgtbWFydmVsbAo+IAloYXMgdGhlIHJlc2VydmF0aW9uIGluIHRoYXQgZmlsZS4K
PiAtLS0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNi5kdHNpIHwg
MTEgKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kKPiBpbmRleCA3
ZDk0YzFmYTU5MmEuLmY4ZGFmZWY4M2RiMCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kKPiBAQCAtMjgsNiArMjgsMTcgQEAKPiAgCQltZXRo
b2QgPSAic21jIjsKPiAgCX07Cj4gIAo+ICsJcmVzZXJ2ZWQtbWVtb3J5IHsKPiArCQkjYWRkcmVz
cy1jZWxscyA9IDwyPjsKPiArCQkjc2l6ZS1jZWxscyA9IDwyPjsKPiArCQlyYW5nZXM7Cj4gKwo+
ICsJCXBzY2ktYXJlYUA0MDAwMDAwIHsKPiArCQkJcmVnID0gPDB4MCAweDQwMDAwMDAgMHgwIDB4
MjAwMDAwPjsKPiArCQkJbm8tbWFwOwo+ICsJCX07Cj4gKwl9Owo+ICsKPiAgCWFwODA2IHsKPiAg
CQkjYWRkcmVzcy1jZWxscyA9IDwyPjsKPiAgCQkjc2l6ZS1jZWxscyA9IDwyPjsKPiAtLSAKPiAy
LjE5LjIKPgoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJlZGRlZCBMaW51eCBhbmQg
S2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
