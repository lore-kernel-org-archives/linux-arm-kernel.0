Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C313C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:59:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D84920645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vvud4/DK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D84920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qdAhRAofnckzCTrCdJPHxcOXNCm2bpDsEaSoEhwMb6c=; b=Vvud4/DK2bQuQg
	mBxarj9+iE6DOUVfLqlj0/QWnh9dR9iOrjC5xp+VYZvq/yAXwGnv05IU0p3UhXMrueg51RFa07+hl
	Lle8PdtT26ejqGk4nWNOXtVTd7iE9ku5jRHd4/XwHIgbCsvqmlbBWX5WSO804qNx+eP2YjN2zdR93
	F6M30ZqvG6STgTG95rrgOon9Dz3YDFTEVpUfPr+X1mo1ycBQ5poDDNtmucxEa6dJgnP5bJuv0r3Mq
	CZeSn7t+LtbeFfrlczsUhN14oFpkDOpOGR4y3YD6AZcEvmwW8Q4ZQz0Hs4zVNVTUUqb/sH4S0MB6A
	M38uxEbZNEEvAId0SvHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0jo-00014T-3v; Thu, 20 Dec 2018 15:59:52 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0jc-0000qC-4J
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:59:42 +0000
Received: by mail-qt1-f195.google.com with SMTP id k12so2318459qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aIg/5zAK8tjNV2wkM6gTk/QZO3NS47XZ7LXwbETevks=;
 b=AYGnBJjVSyhGHkPWC5sP9k7hlLaCMLKqMPQJl/5g+kVdE10bIeTuT4QheDK4B0pH0N
 QvAanrbM/gA1xtSIDFVeYTyLI6dm4Vn2gZK/d5o7RQHO6oMxAk+WEl7+QiuYy2ZyeD/K
 KoF5GqLjPZlGjwnH5AB2H6Q7/tY8OBeG3WBj7k/OVA40acdKpCA6FEViyuSjAanNGcX9
 aCdLji+/CbdJ5W+AWeelNIk97qnA/w4z4mV69KBCmsUba7+1qGGTyWwJouRjWshj3G/J
 T7tTcQHIe4umW2ug6/iD3JLmtJY8upntXDca3fQjCNctHj9sN9sPPAmGx+m+nbiXJz89
 EDfQ==
X-Gm-Message-State: AA+aEWaBb34QmHOpsyhZoujxGmP3UocssEaQl2FSUXoyaQ36sBvjKWLa
 rHnNUjuIgf4z0Svah34MuW1murWeH3LyAqwI45E=
X-Google-Smtp-Source: AFSGD/XMe3S+3SydPpPPDFz75aZuNLj2qaoGZJLim4UzuKZyEM4mGjIABRkQb64/1F1KCHl+ZyUgjeLPel8i/QiXvC8=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr26083946qvk.40.1545321568977; 
 Thu, 20 Dec 2018 07:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20181219095847.GA6281@wens.csie.org>
In-Reply-To: <20181219095847.GA6281@wens.csie.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:59:12 +0100
Message-ID: <CAK8P3a296Ar8mKPzjoZeWBr5dH-QApuAo55qq9131hHwqDti4Q@mail.gmail.com>
Subject: Re: [GIT PULL] Allwinner arm64 DT changes for 4.21 - round 2
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_075940_456333_6BC25239 
X-CRM114-Status: UNSURE (   9.57  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 10:58 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi Arnd, Olof,
>
> This is a late pull request for 4.21. There's only one patch, as shown
> in the tag's body. Like the arm32 DT PR, the patch from a series that
> had been posted over a month ago, and the driver bits were merged today.
> We'd like to have it included for 4.21.

Pulled into next/dt, thanks!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
