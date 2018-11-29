Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D36C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E1720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AO6hQOzB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIuagbWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E1720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=raGSdmjbzUI8fcxsU82mMipvqIi2jgjhEFRUkVYLsCo=; b=AO6hQOzB4w6WLe
	M2IVBZgVqeVYS9NRyV3X5HfBTgeCL90PIVZTJbVu1vzrYaHAwZ7EaL0dPfe+zs4qfnIquwwA4n9M2
	l2l3yK92oHWkOTpOB3m9o33sWHti/s1kaeuXVPAfO2joyrNrYCJq9/koKfC2qJXIDBKpnTJfAfGTK
	0EeGaoyWBP9USn5XpArEzQA1ZHc5YF1x2+LzkmfpU8MoQiWhZDrbXE8akouKmMc3m45UiLSEVV+NP
	gc2Pew/2JTW8rEUKbRdphaKgVROM538Ub5JgGv42Gmy55zFbglCnJxQqCfYpUdedsnFy63imF15IP
	p261aLU1inApyNG5attQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSP7o-0005KA-49; Thu, 29 Nov 2018 16:25:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSP7k-00045C-J8
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:25:10 +0000
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D0E002146D
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543508697;
 bh=1NOrH/JT+xlpDX0hpIzJAJf4JR+ERcHMsXSxqYpdk5U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GIuagbWdr/cRM2d0s9l9GTNLvMVWLQgu+m/i0nGGH3Z0U/Xk0xCn2W0JaVytw7oFw
 7XsCUFbyePQWnCL0Sa48FoXUAj3culn/+1NKx4lZhgXsCsiR6WYI0faY7NwL8TKWRr
 23KM9OZBL1CsozNgG0JltbYV3R5oQAnaSnlbLPmY=
Received: by mail-qk1-f181.google.com with SMTP id y16so1390269qki.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 08:24:56 -0800 (PST)
X-Gm-Message-State: AA+aEWYk33DvmA1nm03sWmjskJHpduC6qcW50CDLWilCkJKkgSBwVaoV
 lI7qaL4GKBKbMDPZ0MfA2MRJ05HUINZQKyQNKA==
X-Google-Smtp-Source: AFSGD/VlojifRl4ltoMphjzFMU8WILRPY1wu2t7Li7N3jmYnQsCDZaT/gimHxAXgsG54d1xtuLAGP7ZxpeN99ys9FII=
X-Received: by 2002:a37:5686:: with SMTP id k128mr1827131qkb.29.1543508696015; 
 Thu, 29 Nov 2018 08:24:56 -0800 (PST)
MIME-Version: 1.0
References: <1537269535-26081-1-git-send-email-sudeep.holla@arm.com>
 <20180923133007.7dj7dvnstqmjnftq@localhost>
In-Reply-To: <20180923133007.7dj7dvnstqmjnftq@localhost>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Nov 2018 10:24:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+oo3tdsL6pH2WmdNJJD=gwYaZ5mc8uVjdd1dMq6_bWvQ@mail.gmail.com>
Message-ID: <CAL_Jsq+oo3tdsL6pH2WmdNJJD=gwYaZ5mc8uVjdd1dMq6_bWvQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: vexpress: update for v4.20
To: Olof Johansson <olof@lixom.net>, Sudeep Holla <sudeep.holla@arm.com>, 
 ARM-SoC Maintainers <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_082508_707006_955E2401 
X-CRM114-Status: GOOD (  19.40  )
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
 Liviu Dudau <liviu.dudau@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Sep 23, 2018 at 9:00 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Tue, Sep 18, 2018 at 12:18:54PM +0100, Sudeep Holla wrote:
> > Hi ARM-SoC team,
> >
> > I am also sending the patch along with this PR in case you want to avoid
> > single patch merge. Please pull the tag or the patch.
>
> Thanks! Merged the branch since I was already in that mode. :)
>
> >
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-updates-4.20
> >
> > for you to fetch changes up to 1435696556e46a7dc22a4b2fb1a9a68ae75591c2:
> >
> >   ARM: dts: vexpress/TC2: Update entries to match latest coresight bindings (2018-09-11 18:25:07 +0100)
> >
> > ----------------------------------------------------------------
> > ARMv7 Vexpress updates for v4.20
> >
> > Single patch to use updated coresight graph bindings thereby removing
> > loads of dtc warnings
>
> Merged, thanks!

It appears this got dropped somehow. I was going thru DT warnings and
this is the only thing remaining to enable "graph_port" warnings by
default.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
