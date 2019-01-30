Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4113C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71963218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eSQJnKs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71963218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kEIWfkDpY14q40lrhdyPputw8z7kOAZ3sv4ovhX+gV8=; b=eSQJnKs6SSqeIJ
	turCwAfGNr+ThhGURpBfum1lWaHeD7eoUrQEGGKNYxakL9FHDyYk/P0FZAZC8mbz1DYDumWLg64TQ
	OXq3UlEbattS4ZBglf7Aoz+oSJO1sLbgyNFwlJN9C4RSk7Fr8U+EDIYYLgvwjUDLDTdjYKzTIk134
	n/awWmO80UTQJufLv7/pQtJ5FxFyMP2PZLU8pA/XIzCuTIo4gajXahUhGeYDrISoaZcv0E62/xbjA
	bVK4P7Qm4pe+xzUQhUDAUNNmqTBxWiLTr3CNYRSt9JzvUqzX2upnRWNB4T/059XAF4u/3TukbqDu7
	9tPdOz/tnUOJHlG0Eitg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxz0-0002kA-EZ; Wed, 30 Jan 2019 22:05:22 +0000
Received: from mail-qt1-f180.google.com ([209.85.160.180])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxyy-0002jZ-0S
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 22:05:21 +0000
Received: by mail-qt1-f180.google.com with SMTP id t13so1388016qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 14:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I4QSQHS/7KbHXRwMS6F8HUmkqqog+j45BTi17g0JHiM=;
 b=iHwlFd5+pECt4m+C0b0VENe3dbawLGDnAg45DquvKXNBTCwpTs0ZyRlgHChXI/EOD9
 HGLdNU5/ysIu5ZdfN/jfHJ6vOGMkpnZaG+EZRKoJsL8ECfy+5AFNjoiCxljzs2ixeXg+
 LZONf7VuzCG2EeyccFtnSKSt29DQRValx38gKrcon5eGEKuKoroJ6orq8uHCw2N/elNO
 kWRaKW0PP4bgpT2xMR9XTyDGnyW1PnRDuhzgdu84K4MCF4Hr0Q/3oV+JeAsyBh5AjBOQ
 daYImMFkJEFTYfFeTIrVECV5wGhtRMMzak1k15qHnljA/W9mxujSYelA8igw7DuHBfsS
 IeMg==
X-Gm-Message-State: AJcUukeWSA9QrcrigWliNkDlFD00zGgwGqITbw0wMnV7f7pcnmetBBy9
 4AtuPmjXzyWd9Abhw4p91qVMW1U0h++ERmouaXk=
X-Google-Smtp-Source: ALg8bN4uail99A6Ivb/kXsSlqjKSPalXtjqS8W7tCIfny3mqqlHGNDZbjwmbdQMBR2n1vi5hSsdrp31hw2e4mRpiBZk=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr32276785qta.152.1548885918833; 
 Wed, 30 Jan 2019 14:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20190111225600.16160-1-leoyang.li@nxp.com>
In-Reply-To: <20190111225600.16160-1-leoyang.li@nxp.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 23:05:01 +0100
Message-ID: <CAK8P3a2H_DFj_yUtBqKVQv0UONN6Njkk613+SW_zeYsg20f0hw@mail.gmail.com>
Subject: Re: [GIT PULL v2] updates to soc/fsl drivers for v5.1
To: Li Yang <leoyang.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_140520_083558_2CC28020 
X-CRM114-Status: UNSURE (   8.68  )
X-CRM114-Notice: Please train this message.
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
Cc: arm-soc <arm@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:56 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Hi arm-soc maintainers,
>
> This is an updated pull request to replace one problematic patch
> regarding to guts driver.  Please ignore the last pull request.
>

Pulled this version now, thanks for the update!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
