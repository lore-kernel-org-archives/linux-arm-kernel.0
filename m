Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A062C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF27A2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GzuwrLGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF27A2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=o0Pt9oyYWkR4+5XY91Yv5vB1PFz16c7J03V1yzWPNYY=; b=GzuwrLGZvGLjLqjSUi43zMBK9Y
	mxPY82ckrjIlCzUN/ryxdtFDR+d1TNaz6oReyL6naKLhMrYXaE0Ly+GgOYdJTH7qdraeBly8tACi2
	7RPdfe09tYA9Sqoxm7qZGtblaGcrf5pdXS+SunMvUYTDc+U8IUukADDVLSlYdjcZcLaMbO9GTs5SE
	wk9J9L7auB0hWqoYopmBLyQOd/JKvqaYQUfHw9tI2vXzVC8UNUOV9a5v7bqnvD5NwVL2VnNRaSqwe
	43zpDiirM4cnhqY6ycUlmvnX7I0msl5Wk+P3zySEIp4WTT1avcAvl+LqfEOAHfZXrED+W89y/MHCh
	D4yXzflg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaD8Q-0008C1-59; Fri, 21 Dec 2018 05:14:06 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaD8M-0008AS-07
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 05:14:04 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id DD593440072;
 Fri, 21 Dec 2018 07:13:43 +0200 (IST)
References: <20181217153706.25873-1-marek.behun@nic.cz>
 <20181217153706.25873-2-marek.behun@nic.cz> <20181220214447.GA18008@bogus>
 <20181220230821.3f21163a@nic.cz>
User-agent: mu4e 1.0; emacs 25.2.2
From: Baruch Siach <baruch@tkos.co.il>
To: Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH v1 2/3] dt-bindings: mailbox: Document
 armada-37xx-rwtm-mailbox binding
In-reply-to: <20181220230821.3f21163a@nic.cz>
Date: Fri, 21 Dec 2018 07:13:43 +0200
Message-ID: <8736qr8nso.fsf@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_211402_306791_87DE66C4 
X-CRM114-Status: UNSURE (   6.81  )
X-CRM114-Notice: Please train this message.
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marek,

Marek Behun writes:
>> > +- compatible :	must be "marvell,armada-37xx-rwtm-mailbox"  
>> 
>> Don't use wildcards in compatible strings.
>
> You mean that "mailbox" shouldn't be there?

You should use '3700' instead of '37xx'.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
