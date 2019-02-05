Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:47:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B68F2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oXIVhwZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B68F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oWVWFjsK0hlZE6Q5WywYsxkbfjsLDCYNS3HWholmWeM=; b=oXIVhwZPFT4j67
	QxWqaOIp76My5LEuvVjbwc7wd+gDhDHMpCnDurzOWjhRBZrKZuDPWC4/7Gn7glcZeutgwTi2UMVpk
	36pHu7+A5Umfl4ccwSNtP5Ic4QXbYW1OvWXBUcqhjRhfJvOJMLulOqNZpqIFjqpIpD4Wvlm9hVtJx
	/0CMAb+8nu69s2ZhUXv56Q3J9HW7NwWjqZxEEw2M+yyVXSkDhiQV36YEEAuYbyFvYS91kTpzYMA3g
	H1IVnopgIYqNonmoP2VXv2CK/3e3+3xOvpzq0GZ5kmuuPfBX9GuaQLZtpOWSvvwhsPk59Ll2IU+Pm
	oMPo8kg8uOR+H011j+9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6gn-0000yP-TI; Tue, 05 Feb 2019 19:47:25 +0000
Received: from mail-ua1-f65.google.com ([209.85.222.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6gk-0000xr-6j
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 19:47:23 +0000
Received: by mail-ua1-f65.google.com with SMTP id c24so1533186uak.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 11:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jkby/H6tNkRAJTZszFG+XhaWMXQ3nonSEMUVMchyhDk=;
 b=JgXZwJvZ5xcTsn8idxVOM953CPsd7m6EI0dNTcA9GaolMigIBs3k/sJkslJJWK2O8W
 7T8BAblzSxZpaCpQMnZSI8iCWA6mEq5u6sVAwF1HLCHsvfZDTsPItJct7Q0o1FYRFnDT
 pGeuv6q/sn9Zs14HH9mc2p9uc1BKjIcBiFAGso7SMxKNv/sw4Wqd/FZAE2hs6+HM3EY9
 KMs1zEBcp0cOkBhMcvHRsUJvmh4aduBzj3jiEWsBL5P99UFO6la4Nu68ojAOONFfd/F9
 LH0q+ue+13fbGdiWLRAsHxsLs6PdMUnyI6FmcNdWosMgkpICjQk1BRneCpSbPpon1yiW
 rjRg==
X-Gm-Message-State: AHQUAuaUYE1K4bWTL0P+fnpBnYL7w8kERNeFBGx09sMxZaRqtjTS9LE1
 0Q9wxw5Bw6GuDBdZ/hfn2weLE9yJxBtOk2LPMQ0=
X-Google-Smtp-Source: AHgI3IbEPhAHN/GL6PoxlEabyBPX43m9Iknzey5XLI2FRTQmzEA5Q/gV4/B04otzMBmUBMIBCDcNxtxOh6ZKvVhMehY=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr2485471ual.20.1549396040219; 
 Tue, 05 Feb 2019 11:47:20 -0800 (PST)
MIME-Version: 1.0
References: <20190204203747.7376-1-tony@atomide.com>
 <CAMuHMdXFF938VWh5F8016nJs4mE4m-xbU1kuqZuX1BFdtFejgw@mail.gmail.com>
 <20190205105801.3eysznz63x3na4ui@verge.net.au>
 <20190205161153.GR5720@atomide.com>
In-Reply-To: <20190205161153.GR5720@atomide.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Feb 2019 20:47:08 +0100
Message-ID: <CAMuHMdWMu=K9KA4qyDZ_toMwvWajdf5cqrYryh4ozDtaT1D7qA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Update for dropped options
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_114722_253310_DADA394A 
X-CRM114-Status: GOOD (  22.22  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@verge.net.au>,
 Olof Johansson <olof@lixom.net>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

On Tue, Feb 5, 2019 at 5:11 PM Tony Lindgren <tony@atomide.com> wrote:
> * Simon Horman <horms@verge.net.au> [190205 10:58]:
> > On Tue, Feb 05, 2019 at 09:07:38AM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> > > > These are automatically selected with make multi_v7_defconfig,
> > > > except for SH_DMAE which is selected only by sound/soc/sh/Kconfig.
> > > >
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Cc: Olof Johansson <olof@lixom.net>
> > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > Cc: Simon Horman <horms+renesas@verge.net.au>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >
> > > Thanks, this matches similar changes to shmobile_defconfig in commit
> > > 4162325afd0d553c ("ARM: shmobile: defconfig: Refresh for v5.0-rc1")
> > > in next.
> > >
> > > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > >
> > > I didn't update multi_v7_defconfig to avoid conflicts.
> > > IMHO the arm-soc maintainers should handle the refresh of the common
> > > config on a regular basis[*].
> > >
> > > [*] When is the right time? I'd say it should be the last commit just
> > >     before the release of rc1 (so all arm-soc submaintainers' trees will
> > >     have the new base in their for-next branches for the next merge
> > >     window), but that may be difficult to implement.
> > >
> > > What do you think? Thanks!
>
> Yeah I agree we should do it on regular basis just before -rc1
> for multi_v7_defconfig.
>
> The reasoning being that make savedefconfig is pretty much useless
> otherwise for generating defconfig patches and the chances of
> pointless merge conflicts and errors keep increasing until
> something breaks :)

That's why I never copy blindly a saved defconfig over multi_v7_defconfig,
but diff the saved defconfig before/after, and apply that patch to
multi_v7_defconfig....

> I can attempt to do a late branch of the dropped and moved options
> refreshed against arm-soc defconfig branch if that helps.

That's up to the arm-soc maintainers, I think.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
