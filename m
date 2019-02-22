Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF18C2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MLqh+BnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF18C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Q+2K7RLBCKJEK83+TmrtA2vLh+xA40i34MBRPgrf1A=; b=MLqh+BnK4MZn/H
	B/yZAtO7ErHuXP9RGpg72Pd9SlXV59fBRKxlAp+/x+owEL/KAJ4p9Aw3cFX1D4CjgkWciJIvEGhi5
	CYK9zaThUdC6GS6XxWmHKBSvo7+8g8ckojFRWl85vat787iAuZ8BEql/vA0R2bSADViFtpnL889UR
	Zhe4qqkdYmf/VnEbcRrhXv0fW1Vdqvym/4myj25CIXg3g9JMf+5Viu+Vw4T/tLud6N2rQbLxS2uHP
	aWVMHMcYLmaeiiQK8529+zZAxjldA6QOT85qsPrHiRBzhIuzC+eqKKW6Qt6eYUD5hZm9kQjuyHV2z
	gFcV/aSpFpHxEiwqo8Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBrl-0007DY-Lk; Fri, 22 Feb 2019 14:31:53 +0000
Received: from mail-qt1-f172.google.com ([209.85.160.172])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBrf-00077A-R1
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:31:51 +0000
Received: by mail-qt1-f172.google.com with SMTP id y4so2627661qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 06:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cI6a9lbEz8rlHTaW3L6GSaNR7SL+sPYpfoNsVPEQNKo=;
 b=lhRG/EudDiQmcqIbshleqOB7hkrhLcHFFjQSY+GQD/vzD1hp01wfy7wtjbu7r64KlM
 rcTo/fQRSssdZHJnM4BSTy5XoJ71AwbopJj7S8SDb/jlWOYJwMgtrfaa7oX0YEvimeSb
 WDoRYhnRnFSnawQsagZZJegAtcoUv7KR1EUmoplhfyfcViGQazr+rr+UzIwMAA/Z3bBI
 HcRCyBjvxGLdQn1u0gEmJzTL8P6X07fKb8LuMbzaK0nH8KG2yxWiafwft9iPuqQdUxUM
 QdA1QQoEyt9SqSTk/c2PlX01CYbA5xHW3g+5OG6AUom8cGAhHQhyY84QFapWhrZkiqVQ
 tfOg==
X-Gm-Message-State: AHQUAuYKcrEDvwnRBy7AvP7keV24sn+e+nthzAnvbqwC4OHn2Jgwhxcl
 yIL1oi9ZlMdJFpDc8IGBohOtQA6A3GVt1/2X4ao=
X-Google-Smtp-Source: AHgI3IZO7cMZ3uovDQKtDWnGnyp9vvPuN03hKmuEr75T0n266gawf2+r8kItjZq1ygquSF9MSHnhMiwznAseRSflUNk=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr3374614qvd.161.1550845905186; 
 Fri, 22 Feb 2019 06:31:45 -0800 (PST)
MIME-Version: 1.0
References: <87a7io176c.fsf@FE-laptop>
In-Reply-To: <87a7io176c.fsf@FE-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 15:31:28 +0100
Message-ID: <CAK8P3a3jwGfUng0xXgfF9Ckm3Ai=4zynWAhmqxvk5bZyUxF3fQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mvebu: fixes for v5.0 (#2)
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_063148_060853_406B5522 
X-CRM114-Status: UNSURE (   7.76  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 10:52 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> ----------------------------------------------------------------
> mvebu fixes for 5.0 (part 2)
>
> Fix PHY reset signal on clearfog gt 8K (Armada 8040 based)
> Fix NAND description on Armada XP boards which was broken since a few
> release

Pulled into arm/fixes, thanks!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
