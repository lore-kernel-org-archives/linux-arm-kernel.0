Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DEAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:31:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780612145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MRS49wc6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="18QPLp7l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="io5fPjdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780612145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hoLH/Rxh8KEFEnaeHYacexVofbF174wg7OjgxD5FhjE=; b=MRS49wc6ugT+jG
	IGEtmJHMMLq/PVU5eAONRDfUSYQBmtBJ8+B1IEwzVOcAWJJL1JxJNA/NgPFlC3mR2jaiyFcQYnZ7V
	CwavxsycyQdc4fR6WRxlDElr5cfHlBnvF9bOR7VDqHNpwbLcz03M5069q3oLsOPRa0Dwz0zOii4ko
	XgDorPu+AcBUJxADXSaCcHjkyw9j5TNzydBwW/kFAIjJqpEjQrqNFmbn1BAMG4XLewAdYPzliYuii
	QypaV05AYs5+/G2z3m2aB9Il/9ix/MP1GtGmrmspsf2incowbSYyRKzhDNfxJbIpOiNcYWsLxiuaK
	M+ahAMizYRpkfmt8lhEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gStBu-0003Qf-Af; Sat, 01 Dec 2018 00:31:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gStBs-0003QZ-7C
 for linux-arm-kernel@bombadil.infradead.org; Sat, 01 Dec 2018 00:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9xwLei33GYUrBTLhw95kxnuWqsxvF8efawakrJ8RoIE=; b=18QPLp7lcG87itgWGi8WvJ16I
 VV2hZ8sHyxZA32xAUXBtC6C/C7tZBLQr+JEcMdjEyvxowbSq6l9sB9lZOrTe3Ext8zyjDDFPUSzZh
 3EqYat7eZTCRP/EQV0NeAN+kURnPWWdneeudRJZWLrF8KyN/VvmLF5KZXIszl11rAVxi8x+EcFYEd
 m58VVE2vsAZA2d4LxmPtc89YaFIf1WUFaV509v62OH8M93/dJ6xCyMtSzBPRHfogHCZZas3XlC6cF
 O0UG3xSHaQ5QGVkdgKeqzdfbkM2kgHWKoVGkaTiE/ud+G0BYvlIdSVUNWs/L54Y6Az+y1FZzKPTBn
 UzIk9c8DA==;
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsfI-0008A6-T7
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:45 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so6471317ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9xwLei33GYUrBTLhw95kxnuWqsxvF8efawakrJ8RoIE=;
 b=io5fPjdKrgVp/+sz5h6ARgRLRM8CSQvonLwYJS1VlaQurnpNMex1PbY06P0EOHzGFI
 bbebF9iS074AqANsAFQ0/V4l18tf4netsWjg8HrbY4cGHUGNGCq1CoYToqpfyS22vD5S
 OGnJ4IOTYDLCdRuMVV/elHUt8DaThSzQJ3CvvSJyskzYI8Q7o9rbtFWwoeZROVVaVbhI
 fRizZn4PUzFyBPOK4q26rmxHFSeDMHfsNgQrftZXkhBPeY09oudNfi7JFhVftSEdSNyx
 sMl+YlScGKgv1BHLugorKKcRTTin94IIozL00IDYnm7qXh8EiRux90CFePkIi0Vg2mEK
 XOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9xwLei33GYUrBTLhw95kxnuWqsxvF8efawakrJ8RoIE=;
 b=aE1pC8EWQZlKl9ZvtYKt+LR+rXgthlQH17VvQg4dyHZtAR5pjrCzEvAzJLsx3MFpbC
 /GZEjUvC4NqaZgW4SPmwzC5HEP0FmCVlvA+vHOjnQ6QLr60jO0o6A6DNX+gjgsV3Vdy8
 9KtQ23DjW4BRZMXEamUdAtkWZSQd2HNVY11dSYGsP3DoqIVqstT+TXVuXW/EYbyW7kGi
 jFNeThpAoCDTvkhUFUdDTCsIzYd2Y9VTzZo7b2FiPSZ96xIgIpXRtefcRqWzfMZI+FvN
 QaacUJTrk6D7hjKFGofC/MWF5WjPn9W1fQ7S4wFem7F82MVvEJ4sUmpZuymOMPLJ0bHA
 ZlZQ==
X-Gm-Message-State: AA+aEWZG+dQeCu3W46Bntd5frwRMGqFNeRcKPA2z0hsetCbttnX0fppl
 LCNiTsrbyWysqJDiEeAKG/C3ztjTcV5I5Q==
X-Google-Smtp-Source: AFSGD/V/VTObIl+Q0FeWaO4kzbYbHRYgFkF9dv4/AFvQB1BEACKFhJYApvv94kZm2Bi9191exU6/sg==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr4952958ljh.59.1543622252407; 
 Fri, 30 Nov 2018 15:57:32 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r27-v6sm1054034lja.65.2018.11.30.15.57.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:31 -0800 (PST)
Date: Fri, 30 Nov 2018 15:51:55 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 4/4] defconfig changes for omaps for v4.21
Message-ID: <20181130235155.bb5hmxmhmzzxlpsb@localhost>
References: <pull-1543521343-338334@atomide.com>
 <pull-1543521343-338334@atomide.com-4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1543521343-338334@atomide.com-4>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_185744_987096_A5FC35C4 
X-CRM114-Status: GOOD (  23.26  )
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

On Thu, Nov 29, 2018 at 11:57:43AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/defconfig-signed
> 
> for you to fetch changes up to f98d45145e6a48b91e0cae12fae7a5367486e91e:
> 
>   ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default (2018-11-08 08:54:40 -0800)
> 
> ----------------------------------------------------------------
> Defconfig changes for omaps for v4.21 merge window
> 
> We're finally changing omaps to use 8250_OMAP instead of SERIAL_OMAP
> for multi_v7_defconfig. This will make things much easier for distros,
> and the kernel already warns about the kernel console getting
> redirected with CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP defaulting to y.
> 
> People using /etc/inittab still need to s/ttyO/ttyS/ if using the
> out-of-box multi_v7_defconfig, and that did not seem to be an issue
> when we moved omap2plus_defconfig to use 8250_OMAP earlier.
> 
> The other change is to enable CONFIG_SND_SOC_TLV320AIC23_I2C as a
> loadable module that I forgot to send a pull request for earlier.
> 
> ----------------------------------------------------------------
> Adam Ford (1):
>       ARM: omap2plus_defconfig: Add tlv320aic23 as module
> 
> Tony Lindgren (2):
>       Merge branch 'omap-for-v4.20/defconfig' into omap-for-v4.21/defconfig
>       ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
