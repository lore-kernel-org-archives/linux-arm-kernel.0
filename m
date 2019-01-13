Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9FCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0DA2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="juavIZk3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="O3RSe09O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0DA2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pAgJljJThmZBi38VBQ4gtqz2/THDqvviw7EwT8KBkWc=; b=juavIZk3dZhsdZ
	C4jW9Mf0symSShJW3+3cCO2O6BE/WDVAfIaOiBVXWERSwPtHY1D2vzlmlOIzD1aNcBQc1EGR/VWgv
	ipiLNgUKuEO2rcsEh2QU2ByRQxUkXNO/oAtTZ3IQwq12anfn+YkuHOVWDUmjPaUkfWQCa0LY+QWBo
	K2EAIDGqGiQMAsZ6HVtbpzoe/m1wnPtWkbUrIKw2DUhJdTM5YjPzNjkhVj7i51naHyugDi6lAtrqn
	rZyWL22/1orYYAWjCIDTrgvxC6If7ZYHW57nrkLBjeMEPlz9ercEZspU8dg8fMq2+6gJoqom864dG
	8ZAUs4+yEXXHh6NiQOmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giYz9-0003kr-8L; Sun, 13 Jan 2019 06:11:03 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giYys-0003Yq-4f
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 06:10:47 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so16272993lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 22:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/kRPs5LqgdzmQ9znT+M1ht3yniBXMbgvLe/e8Y16bA4=;
 b=O3RSe09OrdiQV+1kGFh3IufObEgZM2WP3Qt+FQzIm2gwRMQxUyXVReaHie+LFlsd0e
 2sobDyTn61ne4qJE7zIdhTZ3SjS70/yu0NIsILLS+Y8TwIUeToibB8nDMqB4wH1DK0FB
 cru95hoFdmF4aOPSaJJlcSTHcGfebQhC7kWCQ3DsJdElVX58rPCXndj4NNeQ3T4bp77Z
 /jcLx9IaoxVC6AtjkRmKsS654Vk9Oz95WTaIpha2m2yny0SZAUNy9KnKTkuP3U2UQKuF
 MZomik7nWE2hAZGG6VKhheSgdoLUwhhYeU21Uo2kUYk+fso9+YJgmWRAlHzqCsc1yX3R
 WTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/kRPs5LqgdzmQ9znT+M1ht3yniBXMbgvLe/e8Y16bA4=;
 b=BPy6bn5m2cQzWT3LUCdVAvmSMEfxXcOByx8PbmzgRFSs5F9LBuVM1vWo270vI6vpjs
 5aP2pCSh8aGJqy5dfLpWVBgaTGBA4jISMoxmiBYNqqnt+2TIK3yTGRP5hYAKoEw+zG15
 q1Q162xD9RmIKtSRV9qOTmsoem0MZ83VYtsiTBciER0l6AsWa2F75l5KaJCxN5TwK34z
 Vm+HIZgffGjOFnwFGI4nc2EqzO+fIxl1X0asyUXMwqp1nJmFRnFwZCef02Pse02qjGPX
 bCza8jOGyriEXGqi497/rNzu5GqregfmgZzLO/F6dv4Ud9KNfIkBLfGrBG4QE0TTT4w/
 8w1w==
X-Gm-Message-State: AJcUukc6Dp4ee8XgMr1sPkjEgCS11uGHqinskv8W+kEfi9K55ZgxM28k
 UEuM8YNyFFczTlzqs8PiPAWDKQ==
X-Google-Smtp-Source: ALg8bN5zjsOgQR3YfWoFPVF+LTbe9UvgaHDkgiqVtz2eSEFCd0W16YQUS22HrXH0skbCVp1S8wr/QQ==
X-Received: by 2002:a2e:7e04:: with SMTP id
 z4-v6mr11747588ljc.97.1547359841777; 
 Sat, 12 Jan 2019 22:10:41 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id h21sm15788860lfk.41.2019.01.12.22.10.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 22:10:40 -0800 (PST)
Date: Sat, 12 Jan 2019 22:00:09 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Fixes for v5.0
Message-ID: <20190113060009.5fb4zwcjxapltjzq@localhost>
References: <cover.1547115367.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1547115367.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_221046_236744_967B5390 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 11:18:15AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC fixes for v5.0.
> 
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v5.0
> 
> for you to fetch changes up to a64597227d0de5610407fcc95dc835745a53f5d0:
> 
>   soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B} (2019-01-07 14:51:51 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v5.0
> 
> Renesas SoCs:
> * Fix build regressions caused by move of Kconfig symbols
> 
> RZ/G2E (r8a774c0) SoC:
> * Correct initialization order of 3DG-{A,B} in SYSC driver

Merged to fixes. Thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
