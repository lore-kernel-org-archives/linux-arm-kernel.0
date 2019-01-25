Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:48:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECAD2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ko0fW/jM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GNQ8mm6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECAD2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pNkKgbeUwh8gxH4kW2oj8V8OLwgPPaLv4Md6OHqXUso=; b=Ko0fW/jM2lNoC2xhPwCMfRZCX
	//dqtAkbxSzxnqB8a55KGNAN/6LDi5PB5eNTXWmjzUwulGadOPWWTMePzTofeiS4l4huOHGOAfk0k
	hc69UdhISZUhKf08A+ykvdWa7FiU4DRT4BPhTmEyV3wFyYlJ+tfpAVaPtCePKzrNwE9mxkeUwzUzC
	3K+c89OucrJUEC8dZzONktfmsrd+u+fmelunBS1phgOZyAdQRJwlPHEFZi7AwRathNwBwex3ef28o
	yABTXt5Pcbb4hOqw+Ul00rqmeC5NGPTGwBCJ/TB3J+vQoruJXPw+xGEivkHqeHZQfYqpdbo+qVlhc
	WwyGePTMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn6X9-000647-2t; Fri, 25 Jan 2019 18:48:55 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn6X4-00063W-IS
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 18:48:52 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so11427740wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=56SmD82zX9P+WUybKf12hWc7cyLHLAHU6uoETvFH0dA=;
 b=GNQ8mm6pDTTTnZpWSQFIIwAsCgWVx4wKcGYv+CBIJoyMc4+0I8vOaa37Rd0Gp9ZaZZ
 BTIkzwRqsyrypy+YnP9sTFf3IsV0qbcNvuWM6BMXxjyq2stXY1DA7QJv/9llj/K3WOsz
 XJOuEs0hcADjYBu3/MZUHjrCIwZMw7Noy8RZrBGXWvveanFOpoG+3iV7Yb5kFvY03vSx
 XbdTn+1jLOB/3KwAomEu8eJk5cqT1G6kUy+2EorFFAo89fTDx5WWFmTgGlRobdlfog6b
 IEgFzZL8HdTb9J008cuCMCkksg6032sf4OfcWk4RkosF5TMb5lFP6vlpOjQYv7jfZEgA
 2HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=56SmD82zX9P+WUybKf12hWc7cyLHLAHU6uoETvFH0dA=;
 b=tvpmIQCeJDzg+pujWxict2jXuxZYNrr9nPopyWMRY93F+XePU23gGbf4YGw+BSTxpv
 UZV5c/tXY4EJMGVfYyX4IgYjkDr/ft7dFC8vZfkUuaF88jVQU+2wkTrbXWu8tChuPTHz
 F7/gy74vudDcwLIvYb+Qp7mVrihYJA6F+VG5ajVg508cGzk/BNIF3XxfswCAmvDX1ZZC
 v7a49/OHHIl6EVQMGObaLnfIc06y7eA+3XDPJmiBXg4sHvy5sENl9AAbXz60q71Nqhwz
 RNCkgPL9Cxh8jw3iHnJ73BI+cin8i4tw0AvBFdeuyaPPfGBfoOrfDZX/7s4UidSsqrGM
 2l/A==
X-Gm-Message-State: AJcUukdtstc3Ou9cexOF0onKtC97nn4CnpiXdNBRpYFuw9EWw0PPo46P
 7+Ch77gahy3nDY2MYXUvPr1eXA==
X-Google-Smtp-Source: ALg8bN60MEhP2sD3xtF+QaQBFmvp+orQaThzGo0bzstZfqRMqi0BDZ02567ar63O8GUHORGr7PPWCQ==
X-Received: by 2002:adf:e247:: with SMTP id n7mr12050398wri.205.1548442128581; 
 Fri, 25 Jan 2019 10:48:48 -0800 (PST)
Received: from xps ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id g129sm61395554wmf.39.2019.01.25.10.48.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 25 Jan 2019 10:48:47 -0800 (PST)
Date: Fri, 25 Jan 2019 18:48:46 +0000
From: Carlo Caione <ccaione@baylibre.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
Message-ID: <20190125184330.dm3kaoewvbwddacy@xps>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_104850_667104_198AE8FC 
X-CRM114-Status: GOOD (  11.04  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
 abailon@baylibre.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 hkallweit1@gmail.com, shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/01/19 13:06, Russell King - ARM Linux admin wrote:
>On Fri, Jan 25, 2019 at 12:55:10PM +0000, Carlo Caione wrote:
>> SmartEEE, compatible with IEEE802.3az standard, is designed to include
>> legacy MAC without EEE capability into the power saving system. SmartEEE
>> is enabled by default configuration on AR8031 after power-on or hardware
>> reset.
>>
>> Unfortunately this is proved causing issues for certain hw
>> configurations.  We add a quirk to optionally disable SmartEEE.
>
>It may be a good idea to detail what "certain hw configurations" are
>and/or what the "issues" are, so it's easier to find this if/when
>others encounter the same issue.

This fix was upstreamed from the imx downstream kernel so I do not have 
much informations on that but something is reported in the U-Boot fix 
for the same problem at [0] so I'll add more info in the next revision.

Cheers,

[0] https://patchwork.ozlabs.org/patch/1015783/

-- 
Carlo Caione

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
