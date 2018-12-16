Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E92206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HcIIcZsN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="WdTdzif/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E92206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oFSWj1XP8aDo0LA/LZ6ZPilFvFXSvZEofg7Np7pn67w=; b=HcIIcZsNytueLN
	xk5isQSpXQPq4NeEy9TVxpr1u2KTAcoyrrhUrK4ioapeyZyUu4uPcl+ptDAIUxztLvixkMsHcgpJb
	4Sxsw2cAa+WOTqj7ifiwJxkVdFmCeTh5RcS/H2K0pW/wS+rqZA94dfILg53e+ZLGvBVCcjQl8SKB4
	3oCu68c9YoMf5UEbc1b1lT6sB+dr6BcmF9I0f2A/bgshu6ipKJ8P0LXQx3t/FoPTbvRn9MU6kl+cF
	2084WNsXwH28J7Ik4Jx6tLposd75nq51NE98j4d7hM6TYwGhe4XTEQ9+1Tj9KKHnnT58SC3otbHwU
	nRnTxJiglsYHieRyeQGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYfnn-0006j2-3v; Sun, 16 Dec 2018 23:26:27 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYfnj-0006i6-T0
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 23:26:25 +0000
Received: by mail-it1-x142.google.com with SMTP id g76so16421687itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EavIckkG0CsdZ2qkKlOGygOr08ukf3mcJXqDqLICEd4=;
 b=WdTdzif/YexPRKiaKDnPlS4T4i3EluuXHZFPCe2j9u1tQkqdu10uiA6jPMZX/hGMfP
 MfW9zQvRVOcMGFPZoD5WVInFOdO7swQJz1wy/zc99saqDe6I61PrvywZKsTpsXMwCz+w
 q5NXv5sLljdfMG01bo8NL6MpKnAVSMNtSGM9DZ7l1B2R+cfjS/AEtugL6poytNS2lf44
 drMTK/sYpXyE3emmuUPDwujX4698sVGzGFp96/as/HPdvqpeXirTUk8CS5V6r7mZbPQS
 74eap8VfuRcwZYTrsevzGAV9e00ZQaYAS+8gEQ6mqhsEWlZV75zkj8Kw/5lDU5SELs4Z
 cVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EavIckkG0CsdZ2qkKlOGygOr08ukf3mcJXqDqLICEd4=;
 b=sM80hBaIP0EzOWBOed6ugYEbS8mqE5uvCA+DZzW5jhaNf3+aq5N8lomZDb+lm+8PZA
 7t2CBYXnbhRlosAghn/JwhWTIeuGXfBfn66ZD9OZMSLbAR5URinIJkhv4MWe8GmEGzBp
 xzVnQTWp9kNsgUW7eSEBu+ZBDruyfvWn4dp60hLu+f06UHegjzkkDDmcOgB7gIrjy5vo
 mrsZ01PBI8aAiiIVMQOe2pluls2+UWzjRxSNw1/qepyPJ5SlpSEf/qaMNnx+bQVQquwK
 EVHb57C//Mo5ECJLw17SpHmg3iZTij/4WUaDTXFYwTwJjF6xovSzFwyMoqjZCk5ghYzK
 NzAQ==
X-Gm-Message-State: AA+aEWYqtMwUYHA/svX16SA/a118YAbKqjOT5Hq7ECTpba+m4FUxUD9r
 iO+2dr8rPbcMTaVu7NTnLj74sKtv/An0q/xay8kdKw==
X-Google-Smtp-Source: AFSGD/UuyntCCCLhhZ0Q/o4kOf6pEK5gGUo1uRrUP70J/W2Wn/ox2CFs9pr2l63fPZHAJhPVGHt0V9k0XeKM1+y4OuQ=
X-Received: by 2002:a02:5ec9:: with SMTP id
 h192mr10118712jab.112.1545002772089; 
 Sun, 16 Dec 2018 15:26:12 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181216.124120.731491122771817496.davem@davemloft.net>
In-Reply-To: <20181216.124120.731491122771817496.davem@davemloft.net>
From: Marcin Wojtas <mw@semihalf.com>
Date: Mon, 17 Dec 2018 00:25:58 +0100
Message-ID: <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To: David Miller <davem@davemloft.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_152623_932529_7697C842 
X-CRM114-Status: GOOD (  17.28  )
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
Cc: Grzegorz Jaszczyk <jaz@semihalf.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev <netdev@vger.kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, nadavh@marvell.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Stefan Chulski <stefanc@marvell.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRGF2aWQsCgpuaWVkei4sIDE2IGdydSAyMDE4IG8gMjE6NDEgRGF2aWQgTWlsbGVyIDxkYXZl
bUBkYXZlbWxvZnQubmV0PiBuYXBpc2HFgihhKToKPgo+IEZyb206IE1hcmNpbiBXb2p0YXMgPG13
QHNlbWloYWxmLmNvbT4KPiBEYXRlOiBUdWUsIDExIERlYyAyMDE4IDEzOjU2OjQ5ICswMTAwCj4K
PiA+IFJlY2VudCBjaGFuZ2VzIGluIHRoZSBtdm5ldGEgZHJpdmVyIHJld29ya2VkIGFsbG9jYXRp
b24KPiA+IGFuZCBoYW5kbGluZyBvZiB0aGUgaW5ncmVzcyBidWZmZXJzIHRvIHVzZSBlbnRpcmUg
cGFnZXMuCj4gPiBBcGFydCBmcm9tIHRoYXQgaW4gU1cgQk0gc2NlbmFyaW8gdGhlIEhXIG11c3Qg
YmUgaW5mb3JtZWQKPiA+IHZpYSBQUlhEUVMgYWJvdXQgdGhlIGJpZ2dlc3QgcG9zc2libGUgaW5j
b21pbmcgYnVmZmVyCj4gPiB0aGF0IGNhbiBiZSBwcm9wYWdhdGVkIGJ5IFJYIGRlc2NyaXB0b3Jz
Lgo+ID4KPiA+IFRoZSBCdWZmZXJTaXplIGZpZWxkIHdhcyBmaWxsZWQgYWNjb3JkaW5nIHRvIHRo
ZSBNVFUtZGVwZW5kZW50Cj4gPiBwa3Rfc2l6ZSB2YWx1ZS4gTGF0ZXIgY2hhbmdlIHRvIFBBR0Vf
U0laRSBicm9rZSBSWCBvcGVyYXRpb24KPiA+IHdoZW4gdXNpbiA2NEsgcGFnZXMsIGFzIHRoZSBm
aWVsZCBpcyBzaW1wbHkgdG9vIHNtYWxsLgo+ID4KPiA+IFRoaXMgcGF0Y2ggY29uZGl0aW9uYWxs
eSBsaW1pdHMgdGhlIHZhbHVlIHBhc3NlZCB0byB0aGUgQnVmZmVyU2l6ZQo+ID4gb2YgdGhlIFBS
WERRUyByZWdpc3RlciwgZGVwZW5kaW5nIG9uIHRoZSBQQUdFX1NJWkUgdXNlZC4KPiA+IE9uIHRo
ZSBvY2Nhc2lvbiByZW1vdmUgbm93IHVudXNlZCBmcmFnX3NpemUgZmllbGQgb2YgdGhlIG12bmV0
YV9wb3J0Cj4gPiBzdHJ1Y3R1cmUuCj4gPgo+ID4gRml4ZXM6IDU2MmUyZjQ2N2U3MSAoIm5ldDog
bXZuZXRhOiBJbXByb3ZlIHRoZSBidWZmZXIgYWxsb2NhdGlvbiBtZXRob2QgZm9yIFNXQk0iKQo+
ID4gU2lnbmVkLW9mZi1ieTogTWFyY2luIFdvanRhcyA8bXdAc2VtaWhhbGYuY29tPgo+Cj4gVGhl
IGRpc2N1c3Npb24gZGllZCBvbiB0aGlzLCBidXQgdGhlIGJ1ZyBzaG91bGQgYmUgZml4ZWQuCj4K
PiBTbyBpbiB0aGUgc2hvcnQgdGVybSBJIGFtIGFwcGx5aW5nIHRoaXMgYW5kIHF1ZXVlaW5nIGl0
IHVwIGZvciB2NC4xOQo+IC1zdGFibGUuCj4KPiBUaGFua3MuCgpUaGFua3MuIEluZGVlZCwgdGhl
IHBhdGNoIGlzIHZhbGlkIGFzIGEgZml4IGZvciBjdXJyZW50IHZlcnNpb24gb2YgU1cKQk0uIEhv
d2V2ZXIsIGJlY2F1c2UgdGhpcyBjb25jZXB0IGlzIGJyb2tlbiwgSSB3aWxsIHJld29yayBpdCBh
bmQKc3VibWl0IHBhdGNoL3BhdGNoZXMgc29tZSB0aW1lIGVhcmx5IDIwMTkuCgpCZXN0IHJlZ2Fy
ZHMsCk1hcmNpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
