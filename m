Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65298C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3B121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dHJ8tkQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3B121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L/RfzxYf972PErRDhTQiiqGmUCJP95yuNtUwe1gZzIs=; b=dHJ8tkQ+cf2xX7
	0Bap5E0yt6h5M6+KauKpUDJChJsJE2BeC/5zPn+bvhu53UwSTrpbo40IfCmqTkCnaLwDbQMKepP54
	A1K4vXQHE1HTJbgPUMoXhLTn6c+Zy00q8n0tbOFKrVdyj6yDb6POovuNd2t33V4u8UNT31Ovwppgn
	kaGhdUIis1qHTJ2aUqgY8TXAdUefVW6z397kYMot3rM9Tuvv0h4BJ9iJBe4L1ICHbrcTwN8sl0HZP
	oI2JMlf/dJ+fNj0JmBFhX/xJVpWLvNDnLtI5I0vYoudUgX/epBO0wtvKf6oegCm4jsh93UWP9Eaw3
	qCw+urhcIZ7/mOn+JsAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga1Jo-0000Jo-4h; Thu, 20 Dec 2018 16:37:04 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga1Jl-0000Ig-MG
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 16:37:02 +0000
Received: by mail-qk1-f195.google.com with SMTP id o125so1356566qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 08:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hhWZ40mjnDjSNil82Gh7Oaa45EcoXgQnyH4Tvgg+uzI=;
 b=KX4xASvFJb1SYqvNE+2fK2GGIhh3U/NfZR2fUkKDOdbzAvpEfBmYhYSKfzN80e4By9
 Xv57C64ZH5nPyEhOVcoaP3WCW6yhvTWFZ3GK9dTUxYjnqQRLtDoEtkcDo7uQVTzljqTK
 +hlsbh7Glpl2Nm4npQB6bVsg0ms0OWZClnEHfJQ6TXsDYSYg/2NA8mQ9TotEQgf3rUdG
 H5QujF4uoVVPfANiH5fxi7H4FtxqL7plAHxiuhXY1uayk69DJwsCluOxk2dwk4Przvmw
 uyZZlzdw09LiX4umJ5trPSywfoQHCLlONDxCJ4AM6gYejRW8uL5yJ9TmD3W6clryqzey
 lrsA==
X-Gm-Message-State: AA+aEWaWwlz5Km4GsqgQGC1OrHX6GThnxb7djyVnwpJ/osBAvQqPTWiL
 e78tL76VeaPvH4cuYJxEneq+Fe21t4tMZsB1spU=
X-Google-Smtp-Source: AFSGD/VU5Gjyelqh1kUFpYNWv3fG6G/JX+Wq39OG/9/r4dJdwQqJ+kvpT0XL0qK5bpU0bq4cJ8FJL81xbE/RAh9Y34U=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr23823298qkm.343.1545323810748; 
 Thu, 20 Dec 2018 08:36:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544705534.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1544705534.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 17:36:33 +0100
Message-ID: <CAK8P3a3b=H88epScZ14Rk-Q9kni_OmueOtohUo7L7N_+P8uYpg@mail.gmail.com>
Subject: Re: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v4.20
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_083701_721367_3C57D3FE 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 12:57 PM Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these second round of Renesas ARM based SoC fixes for v4.20.
>
> This pull request is based on the previous round of
> such requests, tagged as renesas-fixes-for-v4.20,
> which you have already accepted.

Pulled into fixes, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
