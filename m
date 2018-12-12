Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661FF20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JxqQLusS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YRXHCqt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661FF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q7V9WA9yCu52QV/TYFsPxxJ68DcmOOG3AZSY1d4Qdok=; b=JxqQLusS+F+n3V
	B+9ojCTIsmFpCM82ECFz0QLxDUpGnQXKiGXUY64XUe7F3pD5TeUJ+sNhMaGp5z0rNUSurDBVLmgXb
	/19V8jSfsXwzxZylsaZcRvbIT21V+w47+GAHh1SP1udIvlv0qdz8x9TDFIY5ho40Ua4OL8IDOdDMw
	26OM27yXkg3ZuZikYqkBSjOd8jsxTLyKkuqzPM0E+Zb6TPJOOVL47KL7EVFuUXVgRHOxgYLsRpXL7
	7J58/tptRAaohMg8NsN8HF71nK9qcwOm+5qgzmv0bL/sz770w+JRUwg8CFLSZAqYEL0vaTUP1zOYc
	m5CSpDsCZRJEx/gWxNBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3Wo-0004l2-5Y; Wed, 12 Dec 2018 12:22:14 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3Wj-0004kL-5u
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QO2JM4MYZA+nkwLljM6pW27hqshE3VKx6B0LchrKw+o=; b=YRXHCqt3VvaLj0iVNnWN1Wo1F
 iY1hScb3D/ei5T1wEGJ/EvYf0/vleI/l/EKF+WyUnvz+3+hNmJCRDbZtKzmmexy03l4ULXMsmoAR/
 kZj4stNhH31Aogg6rJ/vSiExMzowFX47kGfatCWwHOvVhoNKcDzK9VwaX/seFcqIftGZo=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44608)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gX3WM-0004c7-TI; Wed, 12 Dec 2018 12:21:47 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gX3WK-00060n-By; Wed, 12 Dec 2018 12:21:44 +0000
Date: Wed, 12 Dec 2018 12:21:42 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: JackieLiu <liuyun01@kylinos.cn>
Subject: Re: Built a neon version copy_page/clear_page is correct?
Message-ID: <20181212122142.GM30658@n2100.armlinux.org.uk>
References: <BE9C50D9-738C-4EAD-9BBC-5D1CE6BC077E@kylinos.cn>
 <CAKv+Gu-OWVd_oq-Zb49Kgsswr99oZ5pUOoTN5pkYPFmRDDWoOA@mail.gmail.com>
 <370722B9-5CAE-4420-9126-3DF805BC115B@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <370722B9-5CAE-4420-9126-3DF805BC115B@kylinos.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_042209_218159_3E1AD3DF 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andrew Pinski <apinski@cavium.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMTIsIDIwMTggYXQgMDM6MzI6MTdQTSArMDgwMCwgSmFja2llTGl1IHdyb3Rl
Ogo+IFllcy4gSSBoYXZlIGEgYm90dGxlbmVjaywgbWF5YmUgaXTigJlzIG5vdCBjb3B5X3BhZ2Xi
gJlzLiBidXQKPiBkdXJpbmcgdGhlIGRlYnVnZ2luZyBwcm9jZXNzLCB0aGlzIGZ1bmN0aW9uIGhh
cyBhIHZlcnkgaGlnaAo+IENQVSB1dGlsaXphdGlvbi4gCj4gCj4gVGhlIHRlc3QgcHJvZ3JhbSBp
cyBVbml4QmVuY2jigJlzIHNyYy9zcGF3bi5jLCB3aXRoIGEgd2hpbGUgdG8gCj4gZm9yayBwcm9j
ZXNzLiBUaGUgb25seSB2YXJpYWJsZSBmb3IgdGVzdCBpcyBQQUdFX1NJWkUsIG9uZSBpcwo+IDRr
IFBBR0VfU0laRSwgbmV4dCBpcyA2NGsgUEFHRV9TSVpFLgo+IAo+IHJlc3VsdCBmb3IgInBlcmYg
dG9wIjoKPiA0ayAgfCAgMTMlIENQVSAgY29weV9wYWdlIAo+IDY0ayB8ICA0OCUgQ1BVICBjb3B5
X3BhZ2UKPiAKPiBUaGlzIGlzIHdoeSBJIHdhbnQgdG8gb3B0aW1pemUgdGhpcyBmdW5jdGlvbi4g
TWF5YmUgYm90dGxlbmVjawo+IGlzIG5vdCBoZXJlPwoKSSBkb24ndCBzZWUgYW55dGhpbmcgb3V0
IG9mIHRoZSBvcmRpbmFyeSBvciB1bmV4cGVjdGVkIGhlcmUuICBJbgpjb21wYXJpc29uIHRvIHRo
ZSByZXN0IG9mIHRoZSB3b3JrIGJlaW5nIGRvbmUgYXQgYW5kIGFmdGVyIGZvcmsoKSwKdGhlIG1v
c3QgZXhwZW5zaXZlIGJpdCBfd2lsbF8gYmUgY29weWluZyBkYXRhIGFyb3VuZCwgc28gb2YgY291
cnNlCnRoaXMgY29tZXMgb3V0IGhpZ2ggaW4gdGhlIHN0YXRpc3RpY3MuCgpIb3dldmVyLCBVbml4
QmVuY2gncyBzcGF3biBwcm9ncmFtIGlzIGEgc3lzdGVtIGJlbmNobWFyayB0aGF0IGFsbG93cwp5
b3UgdG8gY29tcGFyZSBzcGVjaWZpYyBkZXRhaWxzIG9mIG9uZSBpbXBsZW1lbnRhdGlvbiB3aXRo
IGFub3RoZXIgLQppdCBpcyBub3Qgc3VwcG9zZWQgdG8gYmUgdXNlZCB0byBvcHRpbWlzZSBhIHN5
c3RlbS4gIFdoeT8gIEl0J3Mgbm90CmEgcmVhbGlzdGljIHdvcmtsb2FkLgoKTW9zdCBwcm9ncmFt
cyBlaXRoZXIgY3JlYXRlIHRocmVhZHMgKHdoaWNoIGFyZSBjbG9uZXMgb2YgYW5vdGhlcgp0aHJl
YWQsIGFuZCBzaGFyZSBwYWdlcykgb3IgdGhleSBmb3JrKCkgYW5kIHRoZW4gc2hvcnRseSBsYXRl
ciBleGVjdmUoKQphbm90aGVyIHByb2dyYW0uICBJbiBib3RoIGNhc2VzLCB0aGVyZSBpcyB2ZXJ5
IGxpdHRsZSBwYWdlIGNvcHlpbmcuCgotLSAKUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwOi8vd3d3
LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8KRlRUQyBicm9hZGJhbmQgZm9yIDAu
OG1pbGUgbGluZSBpbiBzdWJ1cmJpYTogc3luYyBhdCAxMi4xTWJwcyBkb3duIDYyMmticHMgdXAK
QWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5uZXQ6IDExLjlNYnBzIGRvd24gNTAwa2JwcyB1cAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
