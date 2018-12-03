Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4221C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F3520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kT1HVHVv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="qeEJP+lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F3520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gitIDrKNrwzz+dbWvUHndeyfUCkhpE2ZvoofCFcpbJo=; b=kT1HVHVv7C0lpP
	j/74kyPI7UHaxsQzJIW+Ab/8Rd7+9oaiOXLPiGajjxE9RUhQNcYt5Lbq6qFmV2LRdfVKG2Y5nMuKq
	3tdGQH+QmfYbV80yym90nk2zYMZjyV7dkhoMcrR1iHOGwV1j5TStwPOa06vOI+LFkgF7hgUcKt6/B
	q5yHW2EWlHP2NowpcoyIZE6uJeDMyqF4Svs6wal/nO7VMDcKemFZH89o1zNBUv9aGSx8vENcTAGld
	VZoMh1lE2577JBxEUBz1aAIhQ33QbUoLFh8ObiGmd/pgsQPgOGmmc2UiiVzmEZlRLNoLUW1J4srZB
	++EfMihEME7mog8KnkpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvcr-0004Ec-0v; Mon, 03 Dec 2018 21:19:33 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvb8-00025z-Ug
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:18:26 +0000
Received: by mail-lj1-x244.google.com with SMTP id u6-v6so12821519ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BWNvtFREqKO5h0PBtM9WFktcdaPahaYoSe1bApCMMw4=;
 b=qeEJP+lBzPo3Cyi0/nb3pgbZ28GtfpLF6dQ7PRsbWMH94BLZi9CNDbjGWJwDYCGS9e
 SsBubJZNeOAA6TnzDBX4M1LKfiE3kLtX7qXdr43sfYvTz3Nc4GX+VRZFyRaQPKlQ/8E7
 VZxlD1l23t2OiRT4TI0SQjHFhmI4rrbGPvrahfOIvBYu4Z795jyEcsLYb5CtffVK+nQQ
 5yG7mzlWYfouF1wE6DTU9fGCrPrqmWFzDuMGtN2D9AS1sMVTvirrV/2u/U7cM53WClQG
 lLGX8twuJNXtebP1xVNGy7sqsCmFubvgAfNFTj0he9ZUfb0/iJQ0znsTlFyvpmUG9ZG4
 x0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BWNvtFREqKO5h0PBtM9WFktcdaPahaYoSe1bApCMMw4=;
 b=aPtTICt/GfB43d/BrHNYgAYgL01kiR0TUTikuJTylKmgDvWqblpDOfhXDcQybgBOB9
 mFwTzPBXMxO3a4lIU4IIlWHpA1YHGDxJTbRZofBRaVAtos44kckVJwQYChNe3CSjNwdi
 bJkWXZn96HWJ69uFP8V81sA6wwttVNBFPdq97BcpOcqO9+6pUWz3fONYvY4pkjhsrITf
 igPbPYPma3+cXmvvH0ZsSX+3z09k3A51hK1sKxAktXhsU5gDkaNlGBlBfJbJnTr+O4Yj
 YKNskJbedlJlneJKcqaPWxra8rfp5sMHvvHYnUCNoZ0ENt0EH1k92jSFLlxaa0BFKQKM
 uuUA==
X-Gm-Message-State: AA+aEWZ1dNTw9IGjnXSjLAGGPrS8SrzLD3DrzXugmMSP//tOHkJbHRJh
 1eSxJMUhh4WNjn4klZgfeaoHgQ==
X-Google-Smtp-Source: AFSGD/XkeKNZUipMsdSk5JG7eMNM4vQ3yXwHOPdmyt7tsQNDR8ZT30J7Ft0u/WoVcVMhNbJegUsTjA==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr6068792ljd.137.1543871851089; 
 Mon, 03 Dec 2018 13:17:31 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id x24-v6sm2957111ljc.54.2018.12.03.13.17.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:29 -0800 (PST)
Date: Mon, 3 Dec 2018 13:08:57 -0800
From: Olof Johansson <olof@lixom.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [GIT PULL 3/4] Broadcom maintainers changes for 4.21
Message-ID: <20181203210857.3mdhyrmsjpyfzuiq@localhost>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
 <20181201203942.13376-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181201203942.13376-3-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131747_594521_FE061340 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: arnd@arndb.de, khilman@kernel.org, Jon Mason <jon.mason@broadcom.com>,
 arm@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 01, 2018 at 12:39:41PM -0800, Florian Fainelli wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/maintainers
> 
> for you to fetch changes up to 7900f06c3feedbe74d79f28a0d062dbf11fd10bf:
> 
>   MAINTAINERS: Remove self from Broadcom SoCs (2018-11-05 10:41:44 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs MAINTAINERS file
> updates for 4.21, please pull the following:
> 
> - Jon Mason has moved to a different company, remove him from the
>   Northstar Plus entry

I applied this directly in fixes and sent it in for 4.20-rc5, so this patch is
no longer needed. Didn't pull this branch since it was the only thing on it.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
