Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391CEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050D220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L4F8CVAc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vwqSr7T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050D220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sh8SPiFft0Ivl3eY5aNtMJ15DTUOD0IRD009ua/o6wk=; b=L4F8CVAcl1VQDL
	XD/n10B5fliS00Av5pCWp3+LB69V0acUXTnxagtbsOc/HWhD9FEi59SP848h3W6U3GLLPie/Tzhkx
	Kal7hJjmrCYfN8AhkScheGXjbVxFehnJCYkMLNwVLnc7gXuKrFjO6mXxoSaWCCYrKFrJmDK2fVSl/
	mKTcmOvSZ4gDJrpWHvyTOgHiivppyrGEDY/6762qgnYpPLi4YRBoS6RWOAyKV9iFam2JXL0ahH82J
	h72DaIVHbGoSIuK3t+YoQeuq5iSoEel5SsKR6/vK4nvTHo26IuAp9DlVw3obo5DkzkOqfxmaf+9Oh
	pS/MqRpnfEasAvzWNOtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvbK-0002TZ-6k; Mon, 03 Dec 2018 21:17:58 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvaf-0001kc-Kb
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:18 +0000
Received: by mail-lf1-x142.google.com with SMTP id u18so10301336lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QkfT95mg/1cSwkGFVSOtAuPkF+d4KB99daTJhVVOTDs=;
 b=vwqSr7T9XiA1pyEuSEXP2Ci3LFhDWPUlKOqNoZPC1yfAAfLMPGNxP0mVoJjxSr9UJ0
 sScSVY2Cbo5cA5y2Yb2BYT/F4hqtZ3BGNQVcNCFlT+oLrpDTdem0BMBuLP29wbnd8aA+
 KJhwUbyqd/aQ4MLca4fltf9mKyoMTX7VsQkHFfvIhGYsfSqAVcWn4ARjZ+i71H/j9Rnu
 u2NlxOPTPqUMkKuvkq8XbOny/00VDGp2EKyrUsx7lvF1UQ3zrwi2VCkr/9YrHecce+Mg
 re9gD8YYvZJ9Mj1Wn60fLtw1Yhaa4u+EtN7mQYwhFJrrblxQgHvZNoFvRMGGUhDsKJfH
 OJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QkfT95mg/1cSwkGFVSOtAuPkF+d4KB99daTJhVVOTDs=;
 b=c38XpA73rb33ShSdDRHilaDHhzteYFu3OZt/z1HIjAobhZRxokh4JQzw4ln+t1nS/c
 Th998cmwtgFUsZWmCSJ68peW7Li3tCGBPLuIRutLC8OdWBFa91oYnPzzP9lr+Kn60ZNG
 zO2F2pS1TB1QcyzldjkkMJNwY4xRfOysdRJAwJYDKUmtq6SYNyR7S8CWY14ZsN/AN8ij
 rC1vVGqt58IM5jy//3wOF5sIagduglrHLGCnNcLcfu5ndmhT+R7RcZf5QncobMQZxCSP
 c+e5lQ6GbBry/FAzFuNT/9mH8C1JgzxHumyBovcH5beY3hj9KYKSBA1MsY+lNglxL+V6
 TBIA==
X-Gm-Message-State: AA+aEWbD46dHj8Pl+pxcMn8wZgwmIin31utLZ9vf1JUoeb+AllpPe6K9
 5dK++wUNlTcN/izZQFUWajWTbHm0OCOtYA==
X-Google-Smtp-Source: AFSGD/XuGd6RbEBfcdPm//jyo11YUSNBkleRjJ+7HP3W+NHshLNuzVgzPCJa3r842gI15aXy+AKf9w==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr9815816lfk.151.1543871825737; 
 Mon, 03 Dec 2018 13:17:05 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id y24-v6sm2668451ljd.20.2018.12.03.13.17.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:04 -0800 (PST)
Date: Mon, 3 Dec 2018 12:57:23 -0800
From: Olof Johansson <olof@lixom.net>
To: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [GIT PULL] STM32 DT changes for v4.21 #1
Message-ID: <20181203205723.3cpirmlvalo2i2cj@localhost>
References: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131717_677447_90F39378 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, arm-soc <arm@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 12:18:17PM +0100, Alexandre Torgue wrote:
> Hi Arnd, Olof and Kevin,
> 
> Please consider this first round of STM32 DT updates for v4.21.
> 
> Thanks.
> Alex
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> stm32-dt-for-v4.21-1
> 
> for you to fetch changes up to 8914b63bab3c43a529316ba2858137bc57b74fa1:
> 
>   ARM: dts: stm32: add thermal sensor support on STM32MP157c (2018-12-03
> 10:43:26 +0100)

I think you might have missed pushing the tag to the remote?


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
