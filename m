Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF07C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:20:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFB1218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K4sATZCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFB1218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LVAD7cp80XD0Dw3sxrTC3RscXf/56E5MUM7+5fzSZHc=; b=K4sATZCop+uufU
	55ERKFKXDv65RL5Df7SMRQj8b95M45cBYmgmvW87IeJmrKd6wmRqVRRQcY7NflwxhLQQ9aHrLYH43
	q7jglPhD7IHZ7tNHH6GdvQM+PhX6B6b9TC5KR2+CpoJk9nXvEfg2GPajsgTXEMvGH5HRAIqpkvkge
	yzZo+AuQDDkbNxcvh8esel7oYvIIvDP2pqRRf5ZpxIx9AuyQ6CIYx36PKfcCFanQmVfGeX71AnSt/
	saV9BW2+6MjC5Pub1/Npj9a9fToMtyLNVdRoiHgB173kvv0vRE3dgUTMIlkVp4BDWWJseqG2zOjnm
	4w3487A2p6Xr7Ommeq5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomzA-0004GK-VZ; Wed, 30 Jan 2019 10:20:48 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomz7-0004Fo-MU
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:20:47 +0000
Received: by mail-qk1-f194.google.com with SMTP id o125so13347056qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=01sDoeSyPN9Dr/pgOoxa5as6EaWX2e/vz1MNElb203E=;
 b=goDcMV6aPy78hBfG+VNt9UUgIXh3L0FmyOP7WZsUbkr/xR1uCBSFcFaB8h39RcSmoM
 HCWIjjy1Aq7sRilAZJnlztwdtfdHXElRDvPAe6mCqjBYYEttmTTE/xR47JgLVI+Ctm0D
 6uzOPudMZsnhcauNTt8VXitUOelui26yKc59m61ZsRUzGUV7Jl7iCmjQ8FZy1xMCJ571
 WQUN2/NdB+Y7v4nE1msDW0fcYbhqzWt6ue+Rfnr9/dG0c4f+Lx40WAXTNRv9QsClMGFb
 03yJm2jHEqvpmR98VT0fRJ3Xu4Yyx/zq4tmdSn4mJPnuo5Jq+rYgsk2+g8u+mtk/R6z6
 vqhA==
X-Gm-Message-State: AJcUukeV1wRwATKs7tY7H4JMRnpRXcFT8xclLn6cOiPquKC0gQd1FLdL
 CKfu1N6Nd7mnLWDa5GMgfF5Tgg6nHS9bNmgtZz8=
X-Google-Smtp-Source: ALg8bN79ilAD2BiJ8pR/N8f/XguLV9+jYg3Xmc0TtIltcOzi1dt5fWtLV8sQXnKjkKC/Q7gyAu828tfzKa0E/SIzEFk=
X-Received: by 2002:a37:ad04:: with SMTP id f4mr22240487qkm.291.1548843644810; 
 Wed, 30 Jan 2019 02:20:44 -0800 (PST)
MIME-Version: 1.0
References: <87imyfw0ph.fsf@belgarion.home>
In-Reply-To: <87imyfw0ph.fsf@belgarion.home>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:20:27 +0100
Message-ID: <CAK8P3a3wu_3ADgo7yKp5pjB9DJz3NzUECGPwaNLr5Bqhyhc5Pg@mail.gmail.com>
Subject: Re: [GIT PULL] pxa fixes for 5.0
To: Robert Jarzmik <robert.jarzmik@free.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022045_733572_5C19416B 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <zonque@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 9:58 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> Hello Arnd, Kevin, Olof,
>
> Please consider this pull request for pxa fixes for 4.20.
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/rjarzmik/linux.git tags/pxa-fixes-5.0
>
> for you to fetch changes up to ba16adeb346387eb2d1ada69003588be96f098fa:
>
>   ARM: pxa: ssp: unneeded to free devm_ allocated data (2019-01-23 21:32:01 +0100)
>
> ----------------------------------------------------------------
> This is the pxa fixes set for v4.20 cycle:
>  - only a single devm allocated pointer free fix, which was never
>    triggered runtime but code analysis found.
>

Pulled into arm/fixes, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
