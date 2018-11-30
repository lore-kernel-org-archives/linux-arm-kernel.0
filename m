Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC86C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5127020867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MQku9azR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="LNpwn3Pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5127020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qxSZ3lRiVsoo8QY4Pg796sZu5+CM7+39xM40XVhyw2s=; b=MQku9azRm0Pjb/
	vLKRNE455b4VLYzFkN/9yPZUcaRcnEU10hgIRpACTC60nwJrdsgAJAQRNF5hAG43ozuFINBE4o2fl
	mO04DfkoWWlNhg/2hUEvcdwGboiO/fPlwsiJ5xy7yqmGGqtXiPCub5myWyyuPNJXkjdonFG5BOl/3
	Dx5l78sYTIfMJTc9bUUtoYIdpzwVAMFPls5hXJ4slgxPqSmDAT7aKjd4aWfuwJTTwh/5M5y1T8JIK
	1PqzB4IoQFdzKFxb/gqGJkHyrXMA50vbKR47/aAtJa6L2Wjx6jDVPCyH9Pz6XdNwheNbCGkzH4jIp
	s8P0XHzXVbTjirWBv4Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsj5-0007Y2-FZ; Sat, 01 Dec 2018 00:01:39 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsfE-0002bc-1h
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:58:00 +0000
Received: by mail-lf1-x141.google.com with SMTP id a16so5336114lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uf7vhLUejQGrYQWtIpVmTeCy4yYRp+8/fIruf1Fty/0=;
 b=LNpwn3Pp/Il3YP8GQeyvsTlFHgycPKTnqkhUfTvUJr7IazTdEnmMQlja7OvLuscPv/
 3AnIxUy5ALHoA3WJmM/DHniSn/pjiGGIUJigt8Jfd8I90PMkmGbJORjdyEkP2Xv1riKx
 gox9rlCK2J9IwSs6deYwZXIe71uo3Qzs9FqHt5A90m1245ClvP4vdLHauB6aVrJhOvhW
 2Paa3yvbwdnlIaJiEhsiFJuNJ+X6oeNMGV90Bi0fssOfgmktLP1gLOUVKvyvMGkOCyZC
 nOHsGhszfQ94mruRDyoEdCN44U3aTcujNSLapi5oEnr3fKuKmvvsGUwr0vPcdbV+2Pup
 1TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uf7vhLUejQGrYQWtIpVmTeCy4yYRp+8/fIruf1Fty/0=;
 b=qYK0Pm9FIevfXEWECp2nbyWvLrBlBqoo/CCBokCz5zeK4yW6qON+EYUTiQP2ZLyQcG
 AAFlDVGRRQ6g9ILRJld0zOUkYDxyEVRa4WZkHvrcrMoEMux1M7+fW74awiefquUolPpi
 gDMJRwoUNRMKRFOdLF9VmItj7z2XFFZpvMIAFxKtEYSdoLZrkq61/g2BaZygRY1f/kZv
 jhRFzHthdO03NjZZey0qJtrTk0poV/mo+FJRUkIasqWExDBNgCalNj5/GygMqoRJ29k5
 wXLqqyiCmoTG10Yn/BGQ49wxZcmWASvteV6N/64i6arjKpQlYaxZBvYIighzog3m6QkA
 w4WQ==
X-Gm-Message-State: AA+aEWYXpRJEU9NXiVsrkK0ZHnHamhJMlzJcmFkn3N1t1ssbh/WYbelV
 TJCKwHI5uNnUQUoAN3orePTvJw==
X-Google-Smtp-Source: AFSGD/W4h7MewvHdvJfsbWF2brncC21G6XAQucPrISYJ+HzHK5nw+OGK/PEIgxdxKxUGpgfEE6Kjmg==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr4782522lfa.40.1543622248389; 
 Fri, 30 Nov 2018 15:57:28 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id y1-v6sm1026782ljh.39.2018.11.30.15.57.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:26 -0800 (PST)
Date: Fri, 30 Nov 2018 15:50:35 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/4] driver changes for omaps for v4.21
Message-ID: <20181130235035.piuilqycenxmjagw@localhost>
References: <pull-1543521343-338334@atomide.com>
 <pull-1543521343-338334@atomide.com-2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1543521343-338334@atomide.com-2>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155740_575091_21AD1853 
X-CRM114-Status: GOOD (  15.87  )
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 11:57:41AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/driver-signed
> 
> for you to fetch changes up to 3be5e10daf1fc063ec5cff3cd785c4a59814af0b:
> 
>   Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver (2018-11-29 11:39:23 -0800)
> 
> ----------------------------------------------------------------
> Driver changes for omaps for v4.21 merge window
> 
> Few SoC related driver changes to add PRCM as the wake-up source
> for wkup_m3_ipc driver, and to improve ti-sysc driver for dra7
> mcasp and device detection when debug is enabled.
> 
> There is also a non-critical fix for ti-sysc to fix handling of
> the optional clocks but this can wait for the merge window no problem.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
