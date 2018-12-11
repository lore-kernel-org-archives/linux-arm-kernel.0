Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9016520645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TA+q9Gnh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DklaQWsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9016520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mFQ2QKf5cLzpEkwdcYOSz6nj9pV5pI/m1SbVRyHAgTE=; b=TA+q9GnhaZAH8P
	jX1jI07kBalbLAzdNrEn3457PyL2LX6LfEBstuzMnJUkH6lrX3hmtxTeIfR36YVI4FkWb7OUD3iDl
	JZ9o/rIYT2exfommuYHonJFNM9Ok8bVLJYHevzZR6nPb64g1S6cyTR7QamjUv+In7NATjlRyr30t/
	WdlOooZYdxRAgYARB3AJ1ovBASgxu5DA9C1+3VfcHEQXdS0UdC+a4jcnfOB/QKBJz8WfOBCHJEEq1
	9kVMv+QZZ8AMS7jJ0Bwbm6lB9C+EkgKmHp835wueCZfAjRGVsy9CTMfB1oEhSchEnN7aJK9gbtZ1/
	EpuWesLbCY3pcMVh5OBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWXts-0000me-VW; Tue, 11 Dec 2018 02:35:56 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWXtq-0000ly-0x
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:35:55 +0000
Received: by mail-oi1-x242.google.com with SMTP id u18so10798915oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 18:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n+MnN6nD+B0Rfx4i+q4qaPU9a6u2WteCCNm8zZr9odE=;
 b=DklaQWsWqFV8bXotY87h6IiV/++tc+jvVv2UXwXUWj8dbGsFHMsO6iDVGgkd6jhFN7
 sSoE/777y2QONIcZp1tt7xi3fovUTPAQFGwdZJHG8Q9z5oPNb1kmAAFj2na0Zf71JMT/
 Imj0Z1AaNbaCe+qsO6Ddl7L8qr8B3FrLadVM22QiNihOnHzowbln/c+6e+bin5fgkbfE
 Wd/iI5hYFztL73wm5RbPlZ9QSuPHVJEMhlAFG8xUTZ4D1k11bjo76PGli8P10trKIyI1
 cMyDOvuwupBcHopiWrD7HWpU8ZxtMH4qyoexUXneKoUrtPS4iNAX2Ap9vc6xdw1V2rpb
 l3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n+MnN6nD+B0Rfx4i+q4qaPU9a6u2WteCCNm8zZr9odE=;
 b=Hhf3/3T0VbamRUTbsOQk4LWRId7Jx/NKeXM5JP+VRztJYcgp714muZN2wM+crwLIPY
 Yv5c5jMkhzfEOtz5aPu3teU+f9PFihzelLtkU5J/FsfsyCEpeHlzo4nOyT2xFAlZcreS
 9q7Ucjdp5sDnD7bNx4GEbJA/nqnkyC7OgUK0vVhn+x8PGDE9koA+8gK7bbL8B/1GDHfp
 2zTYyiUMWuL+07O33Jq8g42lhkyGcr6XO9aCYftrRqKg8d/Wrczve01gIJKJf3DDsi8u
 AF7ok++R3MSZOjWiPl8JCUYRbkA5GK80TGVwn+qLhfb1aUSCMSiel/aJ5H+0ZMY5CvxB
 qj5Q==
X-Gm-Message-State: AA+aEWbezGImXGGL0MuZ3NbEMlC4iX7FPT5Ytok1xj1MssVdU9zAqLPw
 ymGHG9i486Kf93NXunoImANDVQhxyPkfDlgtpFY=
X-Google-Smtp-Source: AFSGD/XCxtJkvajZieeSQvY5P1poY53Hqka0/arl7vDEDBPy1Lu4jo9FeguUSe1p7/p7SXnhRrSFGSPtOJBIFl10qHw=
X-Received: by 2002:aca:6155:: with SMTP id v82mr309311oib.259.1544495742803; 
 Mon, 10 Dec 2018 18:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20181204110741.6943-1-hohatzel@jusst.de>
 <20181204110741.6943-5-hohatzel@jusst.de>
 <20181206031520.GE3987@dragon> <58a84012-73b8-1679-0c5b-981fd2a0acd6@jusst.de>
 <CAOMZO5At5oSv0MCpsuYj4nEd26Y4h9hj-shadq3477fNz8A+HA@mail.gmail.com>
 <20181211020613.GR3987@dragon>
In-Reply-To: <20181211020613.GR3987@dragon>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Dec 2018 00:35:36 -0200
Message-ID: <CAOMZO5ADmamd6rsUKKPmYPE9wfaRQmSUc7r4m+cYKxCKwsRLhA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: imx7d: sbc imx7: add uart5
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_183554_087388_D52B970F 
X-CRM114-Status: UNSURE (   8.82  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, jscheel@jusst.de,
 NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 hohatzel@jusst.de,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

On Tue, Dec 11, 2018 at 12:07 AM Shawn Guo <shawnguo@kernel.org> wrote:

> Okay, but would it be better to set the default parent clock in soc
> level of dtsi, since the configuration doesn't seem to be board
> specific?

Yes, I think this is a good idea.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
