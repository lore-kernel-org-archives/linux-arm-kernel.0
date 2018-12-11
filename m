Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B201C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589252081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F6cTj68c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="CugkIMMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589252081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=atCvx9/WD6CB7RebNUQAl4feCnX30qKzcdnm5Bikr4M=; b=F6cTj68c9Ho9jG
	T3g2A3ALuYmgMn+ZKg7Uk9N/c+LuoFf5oOxDr+2oOcOWs5MZ9Lbg6qA2f7y1sxDSVrXzNw4c+TjLN
	G6ToyYqXAxZwAjSfM+YLa/wCaTVyMmm1Ib9Rik0QcnZgc5Xp/ThYTY3c/jJJ+Sa5J8zV/jQTxBNqa
	eAKinfg0uP8VopULu7+OB5Wjw5W7wY/ojvxlVR5dqaxWly50N2r1fZnnWtQCLqD8NXz6kLF9h4Yqw
	03fj/PDW1P9J0N3rCZYNd2SS8VrgCc1UW2HXmMcd4PXjnJxdmod9WEXztUQmpUSWQWJ5OwMJL/WZA
	VGTI+D/twsX66P9HlLMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWktn-0004DO-NZ; Tue, 11 Dec 2018 16:28:43 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkeC-0004LF-0G
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:37 +0000
Received: by mail-lj1-x233.google.com with SMTP id x85-v6so13497372ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ck/FSZO7jWggSIW7ULqD4HCObC0D0q/0vy+h1RN4vaQ=;
 b=CugkIMMjGtAQ3TLZy2q7iKCoTI+eR69Ljj6rybSHa+yP9gpO7yAUVqQC1+jCXLLq8A
 78zDl3Wd5yGU1jv9jenf64d5DR5hUORzqdrhOK7r0HUI3z5qhpU39WrmKAvdZw2jvvsV
 j/v0AJVsIuxvFbyPrvLdXFrQXSsna+fgnV3e0un+5y1Z9S6sku2K+BxzPfPbybsAFWbg
 Mk3LDhm9WQJqrOBD97H8psDHTHLtqf9T5NprFDA3+mQKwWpZrdA+od4ndnV1aM+ydJzt
 1BRI8Ys+TWSneiW/IjUltPwZwGqIPHWVabryt3XFZLG7PPZ1/WYyikqpSPZqSm4HV/WE
 gBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ck/FSZO7jWggSIW7ULqD4HCObC0D0q/0vy+h1RN4vaQ=;
 b=D3W2dqzFbLuGZwXCR+AAjIkdF0G4Sp+qN7rHjwCr1plLSbDXI1TIwyflHwR/YMnEGX
 P9IOl45TGey41ek/tYs+43iMb4KogOeyslV3dYXqhOKHKtQNeOLAKr5UcJE7m2lINpQW
 SilbBqwMzYSo884Ej9jjWLCQXIPvXv7/YtydVXhoTHbu3QZe49eYnJ1XzJdN22SrFU4M
 3qYLyo2Bro+1eWFry0f5WCh8NysErENSctGFsquQ8YyeLGX5rB6CTpqnu5a3EdDe+Gx+
 0kGCnHwhOjc+e6P2zop/SnRJSQ7QQmp/WqbHvOi95pJ0cvjjOcX0XEkZa9+xXlPjDSjt
 Fnhw==
X-Gm-Message-State: AA+aEWaTTGVgD1jF11QuUVtnAk+Qu2OTvflxuMsev/VSOl+gSnxtKJdE
 I63+3fQInmluE+YXvC34AECnj2m7zEkzmA==
X-Google-Smtp-Source: AFSGD/XdkN9wROgYSGhx1TrTsL4t2EWmnMC5Hi2SA6kh3wpWzx3Obx08u7fkAP/ejqHQp3i94wFA0g==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr9806980ljr.91.1544544743905; 
 Tue, 11 Dec 2018 08:12:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id a18-v6sm2731424ljk.86.2018.12.11.08.12.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:22 -0800 (PST)
Date: Tue, 11 Dec 2018 08:02:16 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.21
Message-ID: <20181211160216.dk3sp6ebyqochg7x@localhost>
References: <cover.1544126426.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544126426.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081236_109828_76F42415 
X-CRM114-Status: GOOD (  18.34  )
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

On Thu, Dec 06, 2018 at 01:57:30PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates
> for v4.21.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.21,
> which you have already pulled.
> 
> 
> The following changes since commit 275e4eb3f21a09b6b8bd4a353b9a01e500240385:
> 
>   arm64: dts: renesas: Add all CPUs in cooling maps (2018-11-26 09:11:44 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.21
> 
> for you to fetch changes up to 4fbd4158fe8967e9296516ebae2cfaf7a1c7a214:
> 
>   arm64: dts: renesas: r8a77995: draak: Add backlight (2018-12-05 11:45:44 -0800)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.21
> 
> * R-Car D3 (r8a77995) SoC based Draak board
>   - Add the backlight device for the LVDS1 output
> 
> * R-Car H3 (r8a7795) ES1.0 SoC
>   - Add missing power domains to IPMMU nodes
> 
> * R-Car M3-N (r8a77965) SoC
>   - Remove non-existent IPMMU-IR

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
