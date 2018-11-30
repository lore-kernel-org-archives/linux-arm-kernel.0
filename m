Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B08C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D53220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Stpx1LN9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1AiZYLCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D53220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OC/e7PJfc1F/LtE8xdGCxeDHW3sEqSRJH6wwAo+QwJ0=; b=Stpx1LN9uNCtQz
	uuZEaEDV5wCWSHRB22z00UsMPGkIsCEQgbRSWUv49gmhZXayUKJRldFKiG7yilJwJ2B7kxUfNIeVc
	cbq9Wf0eq49EitbsB3ShQEmCPMI38CFeUGw6YFl3n+Y2eYLfs5wAu3MzwPBeIKrdZxtsluC+lNEqs
	vvFrmn/rytrpjfwfXSXsBH9U2j64t7ryRm12mU0yciG/D/QesvBij+YQRN8Jy2RopFC4VLcwl18DT
	FCF69VDk0rhh/omm0fqwkaCtTb9SILG1deSoEieu5hVIWqceCj3Xaqb9/fXHeZE+jfuwBo8jUcNdD
	LQOfuCCasZJgV1ISMESg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsgN-0003tv-Ob; Fri, 30 Nov 2018 23:58:51 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsel-0002AZ-DN
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:13 +0000
Received: by mail-lj1-x235.google.com with SMTP id 83-v6so6471510ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XNn/2mwE66GLkVAZrtSNd7+nFmPXccWlyyvS58F34js=;
 b=1AiZYLCmvhP0sJeCCJKHoLAdZQUgHMGzWvhCGwQYdV4mNfQOjLN7oo7J5OxTG0ik/w
 00hK5mhWFgTUW7hWVV31TOqVmAO1amVr5DJnNxf2YUXCKY6Ek2fkim+LCued/dfzR5+8
 slL5kQjpQtOQAXsJC83hWeZyQAEh+CkscXBoZ8GiCYvoagQ/vI/BGyGTFuPN/x+zeYFu
 sPAF2YQZhiy/hmsCNYzGwcJz0cTACCcl1PnHXps7gWK7vtHS/zWH6m+m3mtEtlfNWdqE
 40AkG5q4pdmOcJenJoODyrE6pGMqwW8Q3B2Lpzkkz5xdBdWxN9RwCXlWCp/KwUzWSkaY
 gy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XNn/2mwE66GLkVAZrtSNd7+nFmPXccWlyyvS58F34js=;
 b=jcFGDfFOArZWrDOaz/IzJp1NqSaV212yVElihNIrzSGAbA/tpEYgtWBXqKHDXGd8ug
 vSD5YfVhhO7AyiaUnCphVdNa8cAAFyrduyxcTS4WOOQp45hwTuJlORKffCVhg8kH7MRr
 dh2//tmttK80USqCaqzNPCGGbw3pKBCtIRsAUYiBD1ncEVSt3syFI0rTunU70LNP9jQH
 fEVazo23EzTnuD8khBEWUCs/rpKFW0Nj+wSNY85wGkhJzD4QV1el8pi4PLrc49aYkP1c
 TNdFNxLN4X/9XeI1WDU7qCImM7dOH+OI4MHblJnMiDomPUfRJmodG9o3PxZ2UiSHxDGP
 GCOA==
X-Gm-Message-State: AA+aEWYtqqa0qUcROaivrzptttoRlAZFTk/WbdCtEfRVPsQbccO78emI
 XFbJiwn7s9q7mLvaGx9lSUT/s68CEURe6g==
X-Google-Smtp-Source: AFSGD/V6jXn5m2UBo8m3zBlwUTa+cBPmyT68tkQW12/sgPC2p/BIse0TcB8P54BTCTQcZq7vJJrXNQ==
X-Received: by 2002:a2e:449c:: with SMTP id
 b28-v6mr4908613ljf.47.1543622219005; 
 Fri, 30 Nov 2018 15:56:59 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 1-v6sm999635lju.61.2018.11.30.15.56.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:58 -0800 (PST)
Date: Fri, 30 Nov 2018 15:18:14 -0800
From: Olof Johansson <olof@lixom.net>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] ARM: dts: Amlogic updates for v4.21
Message-ID: <20181130231814.b7lfebjfipcspnhi@localhost>
References: <7hr2f38v8r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7hr2f38v8r.fsf@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155711_743665_629D5915 
X-CRM114-Status: GOOD (  14.58  )
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
Cc: linux-amlogic@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 12:49:24PM -0800, Kevin Hilman wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt
> 
> for you to fetch changes up to 7b141abe4aa137f362d7324de5a49fd3105f570f:
> 
>   ARM: dts: meson: add the clock inputs for the Meson timer (2018-11-28 16:49:03 -0800)
> 
> ----------------------------------------------------------------
> Amlogic 32-bit DT updates for v4.21
> - support more timers on meson8
> - add the stdout-path property on several boards
> 
> ----------------------------------------------------------------
> Jerome Brunet (1):
>       ARM: dts: meson: consistently disable pin bias
> 
> Martin Blumenstingl (7):
>       dt-bindings: timer: meson6_timer: document all interrupts
>       dt-bindings: timer: meson6_timer: document the clock inputs
>       ARM: dts: meson6: atv1200: add the /chosen/stdout-path property
>       ARM: dts: meson8: minix-neo-x8: add the /chosen/stdout-path property
>       ARM: dts: meson8b: mxq: add the /chosen/stdout-path property
>       ARM: dts: meson: add the TIMER B/C/D interrupts
>       ARM: dts: meson: add the clock inputs for the Meson timer

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
