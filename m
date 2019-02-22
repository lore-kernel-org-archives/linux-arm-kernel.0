Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF40207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pR02gMxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF40207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TO5hGiIMAoG7gm9n01tgbB+wsaNPZvq70CXMTufDVV8=; b=pR02gMxwqwDKDG
	u7pUkREU9ODuoE8OTt6kTMgevz9ZoEImvDUBHvkj7QK6PbGfOIh+cP8SiCvv0W4G0cx/oD00tknuD
	lMByJpfsfnAJhxolemNZlSZ31T1iN0vaQM3gdYaQlYsO67gtUQSLvR64fkAXCR4JeLBzBWwexZY8U
	pipZbjCsApZA7oivuFjgy8liQxy0moDCWtdPApAFtqc3gWMPMjBH6O5z9m9NPx3SwBTyX70q7ThQT
	h52owgRH2xbF5ky+ad//iCTjPzRuUViPmP3olKTm10OK58AoSl4OZa5TGW3Ry5fTygPGAX7hT4djT
	puRtw9ROvrEEK7hCydCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBKN-0000AL-0c; Fri, 22 Feb 2019 13:57:23 +0000
Received: from mail-qk1-f171.google.com ([209.85.222.171])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBKJ-00009L-C7
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 13:57:20 +0000
Received: by mail-qk1-f171.google.com with SMTP id z13so1165778qki.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 05:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rroB+1SzOBLBrbOqBuyT2ElVCGp/LjwOvFuuuM3O6ek=;
 b=cYInzwvoXCF5G6HHb9qjMtvDD82tZzstcP3Ki0oJdXCwsRPDGvnqdBH041rquOc6pw
 4u6p1BB9JUPrT60lCViiyduhz85+Xus79dp7I/aHScUR3I/MAFXZJimIW2mh6kM8ntzL
 6MvUZq/9G1iWzRJOmp1AKWe/3aOfNBAasuF0Ph4WG8GzZOqy8qRelZqH4jyamGco6nuy
 CN4MDbZ9T9qLO96UUCJeHnN+l2kJskku1J3saNQnmrUZ9vUq6Yxfoe4IPqIE4svxwuhq
 nS4e9KqOFEEgKwpCne25Eqo4fhtXRxuji5jG585Xi0H213ijXdgO984ednoxxc+VYmz+
 UfQA==
X-Gm-Message-State: AHQUAubHYwqM2GNqSxmY0Ig7/x8LLeNuzlQxFQINkfEAmmUszlHw1BLb
 4yhRbK4MX6HH05r6K+eHANvCYRow3yDvcuF75b0=
X-Google-Smtp-Source: AHgI3Ib0dHUdk7UmPId8SVrgcB6yQlIq8LMi8By/kBKUPTgOebGlEAkts7zGmk5axFwSGvoQK49NQH5cB3k94binzFo=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr3033153qkh.173.1550843838289; 
 Fri, 22 Feb 2019 05:57:18 -0800 (PST)
MIME-Version: 1.0
References: <87bm3417b1.fsf@FE-laptop>
In-Reply-To: <87bm3417b1.fsf@FE-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 14:57:01 +0100
Message-ID: <CAK8P3a0tEiSdV5VdUtQTy6ppUcxYQtHFqmfrPuK=+xnM16thsg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mvebu: dt for v5.1 (#2)
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_055719_412921_05E3687C 
X-CRM114-Status: UNSURE (   8.48  )
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

On Fri, Feb 22, 2019 at 10:49 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hi,
>
> as request by Arnd, here is the follow-up pull request for dt for mvebu
> for v5.1.
> mvebu dt for 5.1 (part 2)
>
> Follow-up fixing DT warning introduced by previous pull request

Thanks a lot for the fix, pulled into arm/dt.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
