Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:25:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B82421850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QgaBlkQa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="iHjlnvH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B82421850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8IbJ2a8bmfqtpyJDFJMsEtlzdw9t9rwsIM9gapVmZl0=; b=QgaBlkQaVEqiLV
	04uudOU+5m5/exkwwBRvUZxmIh1iXr/4ZoeF8FDW73UV6u0E9hpu+bylExHsc4Y9PLzbAcRBDOnC8
	qqwjmr8Uvl1znq6oRMpC1VRl38VVjtwUWBALCURa36cQ9VhjoS6Z2CGwWjxtfUbHvqOSETG6tWx1X
	PSSwuQSaXBV4nFzWpvkbHxCBim5uPKde/QXfdxIcayl79fS8FDb2jnHUtY09znOnfcJUchMWFrNub
	7cwaTyyX0O2TTBGbGqfQrjqdFf7jdmXIiYXGwfuLOE9PGVlWf2jGGJ8rYy+wS2k03YaTcXFYzoN0U
	m072WYH8D9iJcKKJ+MKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZY6C-0004ZB-M9; Wed, 19 Dec 2018 09:25:04 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZY68-0004E6-Gn
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:25:01 +0000
Received: by mail-it1-x143.google.com with SMTP id h65so8422543ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kOYJwKxQ0pGsj3DpVVNDVwNG3VaOkHgQH3xL3tx3odE=;
 b=iHjlnvH5p8to2RGQWe+2S61K2RyFxMveoU/sAAxWBmx3RefbM2gk+0ZphN2rypGfoI
 rXZqyp2CQy5qsaOHsmI3YxrskF3IZRwdWCmpuZmt7Bmuk3FB/vwXVl8ruYZRZQ4emsdo
 AmSTy4gMKZZVO/MQVKTf2fcd5peFim2EMxmQJOpY7qaMsmUXtoKEq7wEWr9sYMTxAfLp
 okVJBvgJBC6yWu9vkPAMjQfqCIeVTekcGZFMk4aMrXAM3Y0I9REuPjV8E5NV5hpVdoTZ
 B05CdV7kbowl9eJDe2fp/tLbshm56PZKvfjsvwWf6vYEg4XYnQ6nqZionUR8VhTgdKzs
 2oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kOYJwKxQ0pGsj3DpVVNDVwNG3VaOkHgQH3xL3tx3odE=;
 b=o8xTAwFS+uMWWlTKBEZSm+DOEWjnEGmEVUn+KUjzgX1Hcr2oPyCHi2drNDQDAQXYGc
 G357BNLVqlOhJG4kQcNT6nb576OnNmReFFzpe1zyspnT+V02tdR3pj+vH0Fb0bzLxSsi
 kbpjvO5cIB41WEEgE6B1letdgsHGMBfaqPjvEL2wjcnsOpY7AJ8sc2nS3I5E56WvlrVe
 JxIX7IbVdzcKFnwfCRRBQ70FcyEwrWQp5xG7ieuixn8ED6XziahX0bKzzNl+75dmuNuB
 miZSfw76VJikRm6Gh9rteXz7IKKdmFv8jRubPUWZJmpplXh6g9x5Ct8eVbeX4IZGEfm5
 86bw==
X-Gm-Message-State: AA+aEWYkNqacUA4GofotN3KWggCChjiL1PCTYInCU/io4PlmBUkDyBFY
 fu85nUjYgEc8au3iqApnPiwiUw0KB9dZw1jNYXS8MQ==
X-Google-Smtp-Source: AFSGD/XrOGYvEw8xJTZUxRdfvI7yAZzRcezzJ/Vj9WZ6mxlDp0h67kSBHC1jDAtQKFsc9SIWGdlCSKjbUMwJee0+BL4=
X-Received: by 2002:a02:7696:: with SMTP id
 z144mr18385618jab.102.1545211489228; 
 Wed, 19 Dec 2018 01:24:49 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181216.124120.731491122771817496.davem@davemloft.net>
 <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
 <20181217083735.4c6599b3@windsurf> <20181219110546.63f68f4b@xhacker.debian>
In-Reply-To: <20181219110546.63f68f4b@xhacker.debian>
From: Marcin Wojtas <mw@semihalf.com>
Date: Wed, 19 Dec 2018 10:24:37 +0100
Message-ID: <CAPv3WKctKtFVbb8Ltyj9gaB8bJEaTG4pxMeMFJbZKGYeo2_n+w@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_012500_598375_8A8D9CF5 
X-CRM114-Status: GOOD (  17.74  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev <netdev@vger.kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "nadavh@marvell.com" <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, Stefan Chulski <stefanc@marvell.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmlzaGVuZywKCsWbci4sIDE5IGdydSAyMDE4IG8gMDQ6MTEgSmlzaGVuZyBaaGFuZyA8Smlz
aGVuZy5aaGFuZ0BzeW5hcHRpY3MuY29tPiBuYXBpc2HFgihhKToKPgo+Cj4gT24gTW9uLCAxNyBE
ZWMgMjAxOCAwODozNzozNSArMDEwMCBUaG9tYXMgUGV0YXp6b25pIHdyb3RlOgo+Cj4gPiBIZWxs
byBNYXJjaW4sCj4gPgo+ID4gT24gTW9uLCAxNyBEZWMgMjAxOCAwMDoyNTo1OCArMDEwMCwgTWFy
Y2luIFdvanRhcyB3cm90ZToKPiA+Cj4gPiA+IFRoYW5rcy4gSW5kZWVkLCB0aGUgcGF0Y2ggaXMg
dmFsaWQgYXMgYSBmaXggZm9yIGN1cnJlbnQgdmVyc2lvbiBvZiBTVwo+ID4gPiBCTS4gSG93ZXZl
ciwgYmVjYXVzZSB0aGlzIGNvbmNlcHQgaXMgYnJva2VuLCBJIHdpbGwgcmV3b3JrIGl0IGFuZAo+
ID4gPiBzdWJtaXQgcGF0Y2gvcGF0Y2hlcyBzb21lIHRpbWUgZWFybHkgMjAxOS4KPiA+Cj4gPiBJ
IGtub3cgc29tZSBwZW9wbGUgYXJlIHdvcmtpbmcgb24gWERQIHN1cHBvcnQgaW4gbXZuZXRhLCBh
bmQgdGhpcyB3b3JrCj4gPiBhbHNvIG5lZWRzIHRvIGNoYW5nZSBwYXJ0cyBvZiB0aGUgbWVtb3J5
IGFsbG9jYXRpb24gc3RyYXRlZ3kgaW4gdGhpcwo+ID4gZHJpdmVyLiBJJ2Qgc3VnZ2VzdCB0byBn
ZXQgaW4gdG91Y2ggd2l0aCB0aG9zZSBmb2xrcy4gQW50b2luZSBjYW4gZ2l2ZQo+ID4geW91IHRo
ZSBjb250YWN0IGRldGFpbHMsIEkgZG9uJ3QgaGF2ZSB0aGVtIG9mZi1oYW5kLiBPciBwZXJoYXBz
IHRoZXkKPiA+IHdpbGwgc2VlIHRoaXMgZS1tYWlsIDotKQo+Cj4gR3JlYXQuIFNvIHRoZSBwcm9i
bGVtIG9mIGN1cnJlbnQgbWVtb3J5IGFsbG9jYXRpb24gaXMgc2VlbiwgZ2xhZCB0bwo+IGtub3cg
cmV3b3JraW5nIGlzIGdvaW5nIG9uLgo+Cj4gQmVzaWRlcyB0aGUgbWVtb3J5IHdhc3RlLCB0aGVy
ZSdzIGFub3RoZXIgaXNzdWUgd2l0aCBjb21taXQgN2U0N2ZkODRiNTZiCj4gaXQgYWx3YXlzIGFs
bG9jYXRlcyBwYWdlLCBzbyB0aGUgcnggaXMgbWFwcGVkIHdpdGggZG1hcF9tYXBfcGFnZSgpLCBi
dXQKPiB0aGUgdW5tYXAgcm91dGluZSBpc24ndCB1cGRhdGVkLCB0aGVyZSdzIG1pc21hdGNoIGhl
cmUuCj4KCkluZGVlZCwgZGVzcGl0ZSB0aGUgdXBjb21pbmcgcmV3b3JrLCB3aGljaCB3aWxsIGJl
IG1vcmUgY29tcGxleCwgaG93CmFib3V0IEkgc3VibWl0IGEgcXVpY2sgcGF0Y2ggZm9yIHRoaXM/
CgpCZXN0IHJlZ2FyZHMsCk1hcmNpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
