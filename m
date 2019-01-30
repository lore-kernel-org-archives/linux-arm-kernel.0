Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F8C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:58:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1509C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZG9BFtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1509C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yT9dBkUTqN2sWbUstKrkJpByTcdD1FVSB1i65h5jh3w=; b=GZG9BFtxdvw+wX
	DG9tJm9Ln5TMhd6uMq3vh+JTLXj8midi/UsjKOaAk4x9SVZBfJ+DUtLlw6hh5fgwHIz6pXWet+Ar9
	SmvhNFX2hFg6e6zt81nf7k22eUKGhvmTPTa3vOxqNp3NVLTQvpnNMQaoQPJjDJ5KZboh08Gu3q3G1
	Zo//2smEZPxi1expckrrFdTHgwYGCbBT9xTvHac6pgXIpEq6RNDutkNqGaNXj7Jhs14pcmrvlqowQ
	yIF3paPlr2Mf5ex7VyYC+w8OLfpCLLluV52zL5NipJl1NrC8d2CCOAdGV2Nwl5SthlH4oAjbBqqZt
	56wWnh05+aXbcNLJd3bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotC9-0007r2-Uq; Wed, 30 Jan 2019 16:58:37 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotC1-0007oj-Ib
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:58:31 +0000
Received: by mail-qk1-f194.google.com with SMTP id d15so170246qkj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2O1H5zueQkUAKe9jGk3aArUnDjQ0hhorfjE0VxSxgP0=;
 b=dAjrRM2IEv2FNRLoArQ2I1JlpMJupvxyvWEuaGlMw7H2WZmX/TpektHFtbFk0HIQgI
 EFjrafM+XPbuKrQ2eBLy5OtU9znq4CN7UU8mHYmhpRFRIp0b4VhP0o/fm/2kJ90Ba5gh
 etRDv5F6R1Blh3r3VI7Yi4FlXa3FJ1RK3zldIbAVHCb+YlC16pPTXGcLDbO/1Wr2wyRg
 o2XDBG68UcHs39Mn7uwTMGyww7hrNTHYjz+AHAFTM1ERwupFiguvjQpEQiZGORA9DPx5
 o+XAvl9cB/W267Lu4cdalF42Sg8wGJZ7rmz7CQw40KsfzNzB7n8ZBqgK/1XPlVJjSTA1
 3GyQ==
X-Gm-Message-State: AJcUukfzYB+nlQ0EWbiaWVTA9RoXtnyOxpz3SfIYKtYTBjwRnmZMzmFQ
 yvYglxXxjLZC58iTxXK1TM4FxSv795Ob82lsySkaMQ==
X-Google-Smtp-Source: ALg8bN58zk4v4hjSExKzA7jR/zza64iwI8CsCkx+bCRzE+pAbCtzc7uDDBQq9jMDZNBp214rjBtK765GVFcNWqiCsT0=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr27050112qkf.107.1548867507621; 
 Wed, 30 Jan 2019 08:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20190128021635.GA30661@wens.csie.org>
 <20190128022910.GA6772@wens.csie.org>
In-Reply-To: <20190128022910.GA6772@wens.csie.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:58:11 +0100
Message-ID: <CAK8P3a04jePRukd0QmH10+fiXfzysEXqmc8uvrpz+gdQ=Pmsrw@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] Allwinner DT64 Changes for v5.1
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085829_615942_057833A8 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 3:29 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-5.1
>
> for you to fetch changes up to 55ec26d6a4241363fa94f15377ebd8f1116fbfd7:
>
>   arm64: dts: allwinner: a64: Enable A64 timer workaround (2019-01-24 18:23:26 +0800)
>
> ----------------------------------------------------------------
> Allwinner DT64 changes for 5.1
>
> A few small improvements for the A64 this cycle:
>
>   - ARM PMU added
>   - Allwinner ARM architected timer workaround enabled
>     This works around timer value wrapping found in the Allwinner
>     implementation of the ARM architected timer.
>

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
