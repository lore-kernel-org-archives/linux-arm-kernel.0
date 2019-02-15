Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E2CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:21:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BFD21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h4I01LPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BFD21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LIAVNiu7xHbs8cWwEqgZ6qTeiz+ZjTqx54w8LRQvClg=; b=h4I01LPPebi6UR
	6wUTNBbzkoZ0b+ZxsYd1IiY/lgdLeVI0hjXXSZ7Wb4WCtxJCvRkQ6/6+JqnNChbml7+r965iSevQv
	lq+/hxsIpqOSam+/dRyyN2WZsDNthsGB+xCGE4TcS8bIUBYP05kseI/06nW6CehqbB0EJIGvoaAGi
	M7XLPpQnw3QVaV/WzK5QHImbDrDraz/b42x5AOFJ3kO5ucN67YNTzXyMubsdL8H/9NHMeKrBo/g+V
	e7SsC4x2RP4Nb8XncvGaBzlOsswokKNhNid/gSC6jPrbvA7ypL5yzVi+Z6POLo2PVOPxcngIJtTWk
	spyY07k+NKNO9rwFZpgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugEW-0006bI-1M; Fri, 15 Feb 2019 16:21:00 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugES-0006aB-GW; Fri, 15 Feb 2019 16:20:57 +0000
Received: by mail-qk1-f195.google.com with SMTP id y195so5979594qka.12;
 Fri, 15 Feb 2019 08:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C8Fmj5JMp2kvp0k0Xe218CKYt7IQEWNjkjd0X2lTZj0=;
 b=Oe9bAiqhssHi9m0aKrn0Y2isPTrx2x6UYGoXeYsM5utl0rJq52+tzQNm/hLX1YIgIs
 Rjz/NWrrsTksP7DqPamy35tFODZJmX+UaShdMOsdeEc4mwjW1fw2/ITNmnnQrsPT07rz
 K+KHC3yaAFlILUuUGCIs/KuyO8vfb8GS/zPAw8ieLC9jeUfXQAiS59QQirP0Q7ZLW97M
 mHFunAIszIipS8KuigKiAGhz9mP3mzWIINnE2R+3zCeuW2p8/tYIur82Xor4//xvoNAU
 3xLfvLHo88TMGutFwnyIjZsFlRA+R0k7LN76vqowFaypNBYV1/tQKusLJQSHPCA7YyJw
 94pQ==
X-Gm-Message-State: AHQUAuYQki1XoepeNxhkFwl91x7Ya6ZD5RKD9k08iddJXsig91SXkVnM
 +iJ3+TInZBgOxXVKxS0rTRA0QxIV4haVuy7QRWk=
X-Google-Smtp-Source: AHgI3Iael1kp6BpZ+ncp5jNjxOV303l7sPq7hZRMacevJoF3NcSanNfXhOjKL6YQJ4A43Yn4zvzIqCWcAj/mVXFyiF4=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7631765qkh.173.1550247655698; 
 Fri, 15 Feb 2019 08:20:55 -0800 (PST)
MIME-Version: 1.0
References: <7hlg2mdpo1.fsf@baylibre.com>
In-Reply-To: <7hlg2mdpo1.fsf@baylibre.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:20:39 +0100
Message-ID: <CAK8P3a3YYNcbP5ff40QU4CQYu+N0kC9tEqKFAQij6_ZM4P-KVw@mail.gmail.com>
Subject: Re: [GIT PULL] Amlogic: driver updates for v5.1
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_082056_545313_17FA12F8 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: "open list:ARM/Amlogic Meson SoC support"
 <linux-amlogic@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 9:40 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers
>
> for you to fetch changes up to 19e0bde7bf6a18a910e5d633ef606d6ff298c2cb:
>
>   soc: amlogic: clk-measure: add axg and g12a support (2019-02-07 16:50:36 -0800)
>
> ----------------------------------------------------------------
> Amlogic: driver updates for v5.1
> - clock measure: add support for G12a SoC family
> - misc. fixes

Pulled into arm/drivers, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
