Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66794C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D3C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fI61JiI2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifVUN87b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D3C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sxHANmtxtetJa3KijfzS44StjCYpqDulJMbNpEz+DXY=; b=fI61JiI2A11rrG
	nY0IajMx1LJ23fThYK+eESlxSghtQBUYftT52qC/qGS1a8teSfCI95wIpc9By4m7W9kqUJBWvIo+G
	kivuFXoxUbEwXH9I41Vy4Gn/G3mhwtAxub/TlqPPpj59ly2MD6K4jR06l34xrsH5uCgAV+Y6hDtrP
	NVNSuKF0iD+17HcKj2boIopSWw2iS6fKmQCVBemAwjEzSfsXgWk0K9DPHtOwogGjYJ9FJnmMzXcSk
	EC/zsFxRA/aJ8x98l68kosWqLI1QVYwH9JFCWXjuWcgenkX7ByaOn/g/gFvx99or28plR1oLLYsPb
	EJ7xTDigLSmLehpiMsZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZI5-0001o1-2l; Wed, 05 Dec 2018 15:40:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZ8V-0003ub-5z
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:31:02 +0000
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6148D2084C
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544023840;
 bh=Vsbo1dyLOaWiWonEUpt6ga3aOF03WjtNf9DLcakSbv4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ifVUN87bE6IRCGEQvR7cXprLCBnaoDGU0+l2iJIH7eF6/by0eclMxQhkSRjZRsse9
 EQ8jyvA1qdpsAQUXt3Qhd0u9EQaQ3q5Ev8on5noDeRmRBDbe2/xbNeqkx/uLm2ktqo
 IqsekQYSp9lXFNxI9bS1DLVCv/CetdFEaqT4Pnx4=
Received: by mail-qt1-f170.google.com with SMTP id d18so22652602qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 07:30:40 -0800 (PST)
X-Gm-Message-State: AA+aEWYi6Mx5iLYUInBVT+I13AhIBUOayawo1B3hvykj/+saNRXKlaT3
 rqDPi/zzHjd8uIIXe49Q9fadj5TH2WvSBakm8w==
X-Google-Smtp-Source: AFSGD/VNLwWbjsOCAwCprsOd7Nj+Pta5A5E9qGemT7XUKNGuRLlNF0ttOIgaPd1reBZdJck1ZVuVJu4s8fj39Oljpz8=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr22949570qta.38.1544023839643; 
 Wed, 05 Dec 2018 07:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
 <20181203235455.GA5851@bogus> <20181205110009.GQ30658@n2100.armlinux.org.uk>
In-Reply-To: <20181205110009.GQ30658@n2100.armlinux.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 09:30:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXMDqQVQJoq0sXn0VEA1iFpcsK+Hjsxwt-7aWNreAkPw@mail.gmail.com>
Message-ID: <CAL_JsqJXMDqQVQJoq0sXn0VEA1iFpcsK+Hjsxwt-7aWNreAkPw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
To: Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_073051_757518_0C08C94A 
X-CRM114-Status: GOOD (  14.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 netdev <netdev@vger.kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 5:00 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Mon, Dec 03, 2018 at 05:54:55PM -0600, Rob Herring wrote:
> > On Mon, Nov 12, 2018 at 12:31:02PM +0000, Russell King wrote:
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > Needs a better subject and a commit msg.
>
> Hmm, not sure why it didn't contain:
>
> "dt-bindings: net: mvneta: add phys property
>
> Add an optional phys property to the mvneta binding documentation for
> the common phy.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>"
>
> as the commit message.  With the correct commit message, are you happy
> with it?

Yes.

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
