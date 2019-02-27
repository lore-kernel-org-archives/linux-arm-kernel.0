Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:06:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B99218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GhslE/cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B99218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yfrss3D/xGb7vpQiKjtYFmd4empPeqWa87PCPK16Uuw=; b=GhslE/cH9OzFJj
	y82MVTesyRVtPN9PLxUhcWcPxBLwmqeV5qvCDiDQ5cMiy1Ip6hbALxqBm/3f+K1uRMvekWXxDJb8v
	sE+pMehNPl3kBg1Yjad2jfsISPjjYL+4U28wejXST8EagFBzWuLYoXOxII8OeMNefqclMI/Eh9FZ7
	TC8YRjTvyY3Gt47qIqHJMJJYSQhqUBE1Hz0Nrso/7DEDvDDorDyzTDNWssoAdAD0XsAPiayefQhDg
	wPhu6EFu3ZmILgg3ha96651w6K2i/y6q64pxF7UUXOClb171N83rjLt4ArBxz67b8f1iwj40My443
	HuX0lDFpJCSL4SsOv3rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyvA1-0000IE-Qf; Wed, 27 Feb 2019 09:05:53 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyv9y-0000Hp-SI
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 09:05:52 +0000
Received: by mail-oi1-f194.google.com with SMTP id i8so12824013oib.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 01:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KdHJNaWYai0FQfvlQr1TRfeUbZz8NBu3hbq0ZcPfkEA=;
 b=tX+42W9tAEkCsqp44r4AMeus3FHvIxSKIR2mVv5uBWQqZqkGlm317ZwtKOpu850to2
 GvWB7M4ao1+ezm1lRMZpclS3hP/ui6JkDMwtF9M7K183i2fqJPNyOHqaXF08RblLnUkS
 +JNWTjLB2SF/7H6grXz39EPWQlorYimJbxwbq0FiGa7hdO4xJUwwq4nXepbTfqqmchD2
 YELjhKXxOXNOAIvIaPWIkCNAdzEaNgmId0oj2CPS/bjZMgQdmpHNSV5+y+yjRZER3LsI
 6AwPW5kx4+x+LPyo06lnpOs7u8SCSlP+s1cCsDvRAxJMed8lUWSr0ZHp3iDSiDd5Ao85
 X7VA==
X-Gm-Message-State: APjAAAUGb80I2maYlfs05JrLZaKBPqYe+EinT6KcKrLqGoymqi3Flf3L
 ffDlH6SeRt+DQhwyPZqY4SXmEn2Md6L5RmymTXE=
X-Google-Smtp-Source: APXvYqyLv9rqUDRdKTsyisdhaXWP5ZqEiHVsR3Z3lj5gCyF2c9V8ko/cs5Xvb41I7dj5XH2ZEL61/zHNSowpFPoj6/0=
X-Received: by 2002:aca:cc06:: with SMTP id c6mr266890oig.168.1551258349302;
 Wed, 27 Feb 2019 01:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
 <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch>
 <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com>
 <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
In-Reply-To: <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
From: Harini Katakam <harinik@xilinx.com>
Date: Wed, 27 Feb 2019 14:35:38 +0530
Message-ID: <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To: Michal Simek <michal.simek@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_010550_915583_41BF6C88 
X-CRM114-Status: GOOD (  26.27  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew, Paul,

On Wed, Feb 27, 2019 at 2:15 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 21. 02. 19 12:03, Michal Simek wrote:
> > On 21. 02. 19 11:24, Paul Kocialkowski wrote:
> >> Hi,
> >>
> >> On Wed, 2019-02-20 at 07:58 +0100, Michal Simek wrote:
> >>> Hi,
> >>>
> >>> On 19. 02. 19 18:25, Andrew Lunn wrote:
> >>>>> Thanks for the suggestion! So I had a closer look at that driver to try
> >>>>> and see what could go wrong and it looks like I found a few things
> >>>>> there.
> >>>>
> >>>> Hi Paul
> >>>>
> >>>> Yes, this driver has issues. If i remember correctly, it got merged
> >>>> while i was on vacation. I pointed out a few issues, but the authors
> >>>> never responded. Feel free to fix it up.
> >>>

Sorry for this - I've synced up with the author and got the comments from the
time this driver was upstreamed. I'll try to address those and Paul's
suggestions
going forward.

> >>> Will be good to know who was that person.
> >>>
> >>> I can't do much this week with this because responsible person for this
> >>> driver is out of office this week. That's why please give us some time
> >>> to get back to this.
> >>
> >> Understood. I think we need to start a discussion about how the general
> >> design of this driver can be improved.
> >>
> >> In particular, I wonder if it could work better to make this driver a
> >> PHY driver that just redirects all its ops to the actual PHY driver,
> >> except for read_status where it should also add some code.

Thanks, I'm looking into this option and also a way to expose the correct
interface mode setting as you mentioned below. I'll get back before the
end of the week. Please do let me know if you have any further suggestions.

Regards,
Harini

> >
> > I didn't take a look at Linux driver but it should work in a way that it
> > checks description (more below) and then wait for attached phy to do its
> > work and on the way back just setup this bridge based on that.
> >
> >> Maybe we could also manage to expose a RGMII PHY mode to the actual PHY
> >> this way. Currently, the PHY mode has to be set to GMII for the MAC to
> >> be configured correctly, but the PHY also gets this information while
> >> it should be told that RGMII is in use. This doesn't seem to play a big
> >> role in PHY configuration though, but it's still inadequate.
> >>
> >> What do you think?
<snip>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
