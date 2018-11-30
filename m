Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87C120834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="krCEZaSJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="mQXe5/ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87C120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=It0UgA73OGW7fNKbI66PWgfYEcpzU7yBN7bakx1FIvk=; b=krCEZaSJ+HGFeR
	PgvVVkSXYEgih7ML2gAjZ2M0RI7n4H7BJ5/d/cdwaAyITHTX4B4ic2iaxeKLtT9iWgsGwv9UX5M6C
	2XMcfUukwXGtAUcq6OOhSn4ncZxNr7tysXvvSdz1wYhHNHNSSBuSAlWiKqPofNyCjllOFgz5kV1Hp
	X9pQUgCDnersyR6EujaNm7LFru7jkqrvNiNUk7EJz6CSmzPZWs/5vlNKLrfYayL2vu8QgM3t5ZEDf
	4Lk1ExG6oMeZN0zJr1CL7iFYJxlyfk3zqF97chTbWveki3gbbHsmOuvX3CPHAHMjPG9t/YK8AOacq
	o/tyAHtAzC77otLI6nVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSriA-0003wa-C8; Fri, 30 Nov 2018 22:56:38 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSri6-0003v8-Ui
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:36 +0000
Received: by mail-lj1-x243.google.com with SMTP id n18-v6so6393993lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OEdwgKjKb9UMq1bZ+GKiMrgAL0T40q8REdj3qW4dN+s=;
 b=mQXe5/velXWRw50IP7BrDuQuheBkg7SeOgn3jUUpv+vNdNJriKtdqj2KRHIDRBxNyL
 6PjKFGH/UInB/VwziSp2Pq41t8OSwiLbDOr3kzTh4g9ZA/98IU4S/CPKK/LoJQdfxNp6
 WwjTZBcALQn8ncMx+bnH/W780Ersv+KhauioGHABjOj3SNawNC97j14monlymC0Fk0BM
 hXrH/d2zfDvSKZw342KdMmPsfwWIuEjU5dlaGlcu64bdI0QFrKCPbZHtH7nXoWoVVEiY
 MwJKHo/DhBTiq6jYbxph2PLVOR2xNGnPuDOy+i6LOQdfWXW5QOYkpfsuzJL1O1E6WfIr
 yQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OEdwgKjKb9UMq1bZ+GKiMrgAL0T40q8REdj3qW4dN+s=;
 b=hSBENY/HnCe7Gwm7zoi5qsGFU+B+cCzaIMWODVT5s5qK3KiPhXJ++pGlNiL6cryUZm
 M41ok/1gEAb7pdcbDZPLPGzxiZRWvQ1UIO0W5Pn9qxUj7GLAiVg7NyksQ2j1M/M5FchM
 0z9n9MIdDSldz33pp2H+vDDyVb97AXlQLLRaB/WZ4DDd5Dfp188meFe+S78q4WZn7fsz
 MHDocYd8iY+olt5D+OwUqfZw8HVlJ8R74wSmRktDD7ntT2be/neL2406ISUGlqhLWNqw
 rm7anX20lu9edq14Kt5v2Z7Y330SD60r1mu50lyWhInb0NhZTxRqHXqLCaYahDee1RwB
 QQiw==
X-Gm-Message-State: AA+aEWZgWLpn0S9JloT9P++0SMJsRVuN+H8koFCEb8XG5By/IKnPZqFu
 DzeSsiLR3sLRqTVHc+SoKfeb1w==
X-Google-Smtp-Source: AFSGD/VC3yNd4wp9C/HTVTRhRXpPjmC6WNZbOWMCMXjFUG3mCuMbA41qbfmFkhgS5ndvaKmjLoMzaw==
X-Received: by 2002:a2e:9ad0:: with SMTP id
 p16-v6mr5370317ljj.102.1543618581764; 
 Fri, 30 Nov 2018 14:56:21 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id c5-v6sm996289lja.62.2018.11.30.14.56.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:20 -0800 (PST)
Date: Fri, 30 Nov 2018 11:46:11 -0800
From: Olof Johansson <olof@lixom.net>
To: Rob Herring <robh@kernel.org>
Subject: Re: [GIT PULL] ARM: dts: vexpress: update for v4.20
Message-ID: <20181130194611.d6bx5rowordx5sat@localhost>
References: <1537269535-26081-1-git-send-email-sudeep.holla@arm.com>
 <20180923133007.7dj7dvnstqmjnftq@localhost>
 <CAL_Jsq+oo3tdsL6pH2WmdNJJD=gwYaZ5mc8uVjdd1dMq6_bWvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+oo3tdsL6pH2WmdNJJD=gwYaZ5mc8uVjdd1dMq6_bWvQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145634_992873_65A79BBB 
X-CRM114-Status: GOOD (  20.97  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, ARM-SoC Maintainers <arm@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 10:24:44AM -0600, Rob Herring wrote:
> On Sun, Sep 23, 2018 at 9:00 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Tue, Sep 18, 2018 at 12:18:54PM +0100, Sudeep Holla wrote:
> > > Hi ARM-SoC team,
> > >
> > > I am also sending the patch along with this PR in case you want to avoid
> > > single patch merge. Please pull the tag or the patch.
> >
> > Thanks! Merged the branch since I was already in that mode. :)
> >
> > >
> > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > >
> > >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > >
> > > are available in the git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-updates-4.20
> > >
> > > for you to fetch changes up to 1435696556e46a7dc22a4b2fb1a9a68ae75591c2:
> > >
> > >   ARM: dts: vexpress/TC2: Update entries to match latest coresight bindings (2018-09-11 18:25:07 +0100)
> > >
> > > ----------------------------------------------------------------
> > > ARMv7 Vexpress updates for v4.20
> > >
> > > Single patch to use updated coresight graph bindings thereby removing
> > > loads of dtc warnings
> >
> > Merged, thanks!
> 
> It appears this got dropped somehow. I was going thru DT warnings and
> this is the only thing remaining to enable "graph_port" warnings by
> default.

You're right. Merged into next/dt now.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
