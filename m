Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A3CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7318B2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZhgS9YG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Kn6ucBRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7318B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5dCvjorWOMhxVhYEXMPZMe7gk94urKRDrBal2cpNL8s=; b=cZhgS9YGW9em+y
	kZEjRD6mCYTf3zp/UavMWUTpOZHlBJ/cmy3QhGz/WaCtPbiOUjbnnQmf6YfNSBGSSQx6wL+aRLEzU
	3x5ThOGEBoF7c/vfCyT6/wSnOw9+VKMhO/69NJoC3+8bU5/dXaxqc4yW0/T3SmRWZjX607WHqiLOj
	ch0gbwSawNrnJvC7fbdJOKAPy3py3wAza+z8usLVAN1ocfjjQBbhpscxTa7fp3Xz+DLr5tz3E4i64
	hGBLuVLA75E+evYeq+CAl/wFn/2mh9fF5j9Bh8KBXDJhogrpP0PSdxaoSeWn9y8eksLZiQpXV4Dsb
	RTkKjDaf1gkwVhYDFdhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCql-0001Zn-EZ; Wed, 12 Dec 2018 22:19:27 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoD-00072E-Jo
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:02 +0000
Received: by mail-lj1-x244.google.com with SMTP id u6-v6so24333ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=orbEWziUbS64BSz/Mp/03FgCpKYpUEld21UVBjMEC70=;
 b=Kn6ucBRlxeDV09+GPFqiN+S0HprJH7OJ1/W3fttfdlmFf6n9PFSK69HDdCQ6d02FLg
 IZ8Xk9xjEBco9bnnSQXxoWx4OY9155OArM+ED7hfirwkYg/neJFvuhQOHX46OyglZ2GX
 OgiGhJfq7pxtLJsBdyc+cbiZeGaEBJsn08Qt/CR/Dbx8a+WeVXGyGC65Ow5ycQo16MD3
 ovByFBqP88UUjy3CnTMc2irznYNhfkxyaGoKpLwNdy7jwIrCOwmLYJLdYV7IcgBBNCQU
 MeARMqgxM/3BxaBGq48T7GxpckVzbEsc1lOh1SbtMUmE5LYJslnZeg5Ip+ApcI6qm4z0
 /VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=orbEWziUbS64BSz/Mp/03FgCpKYpUEld21UVBjMEC70=;
 b=XBYqLhxxrRqbn78L7l9T3DlEOZxlRL5jiprl7cWZRVoFAg7TvoNu475vfW27t4Ccq4
 YC1UhvdakLWevvxEky8sV4YFQf4h0l+8rhlHJs3KHqaVgSeQxB0ykV8PjfeTk9ZK2z85
 XkpvVsKxP1c94trIr/iUnfVo1sOKcOt5zzkEs4WyQeTyTwJspX+CrT4AlECw5AAcWfu5
 00aOWOFajrTphDUWXHRe6mroF1ZkOw54Xotcpdcld3lMIxvBBiUZEux7/aVPFCVJ6dS7
 owm//oenGcjOL6i7a2p9HkNnVKVFMIEDsI7nY0eZXSUOa7EtZE8UYdwdkxHN6Ak0lLJ6
 pqHg==
X-Gm-Message-State: AA+aEWbcOjMcffwnpoBV8xYv4eWuAi/9em9+kIpBh2aYbe8YwBX/4KT6
 qqhf1b1suhG+LeVUFUAK9HaDBw==
X-Google-Smtp-Source: AFSGD/W9eKGZKl+x2aNo8/0uw6QLbpLSZyCdkwk4326YP5vX65IShv5DPkPkJFy0obANFut/9ucDJQ==
X-Received: by 2002:a2e:2f15:: with SMTP id
 v21-v6mr13383766ljv.56.1544652997799; 
 Wed, 12 Dec 2018 14:16:37 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id x11sm210lfd.81.2018.12.12.14.16.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:35 -0800 (PST)
Date: Wed, 12 Dec 2018 13:50:28 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v4.21
Message-ID: <20181212215028.q4pcih4htgskg3fq@localhost>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141649_966871_D647372A 
X-CRM114-Status: GOOD (  19.23  )
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

On Thu, Dec 06, 2018 at 01:59:31PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC updates for v4.21.
> 
> 
> Usually I separate SoC changes for ARM and arm64 into separate branches.
> On this occasion I have applied them to a single branch and pull request.
> The reason for this is that moving SoC Konfig symbols for both ARM and
> arm64 creates a dependency and a combined branch is a clean way to resolve
> this.
> 
> If separate branches are required then I propose deferring the movement
> of ARM (but not arm64) SoC Kconfig symbols to v4.22.
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.21
> 
> for you to fetch changes up to 2ed29e15e4b2500ae78de658a18f4482e7ac288b:
> 
>   ARM: shmobile: R-Mobile: Move pm-rmobile to drivers/soc/renesas/ (2018-11-30 11:29:11 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v4.21
> 
> * pm-rmobile driver
>   - Move to drivers/soc/renesas/
>   - Clean up struct rmobile_pm_domain
> * Renesas SoC Kconfig Symbols
>   - Move symbols for ARM and SoCs to drivers/soc/renesas/
>   - Hide ARCH_RZN1 to improve consistency
> * SH-Mobile AG5 (sh73a0) SoC: Remove obsolete inclusion of <asm/smp_twd.h>
> * Restrict TWD and SCU to Renesas ARM based SoCs where they are present
> * Enable GPIOLIB on Renesas arm64 based SoCs to allow GPIO driver selection

Thanks, merged into next/soc now.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
