Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B47CC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594BF2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ae5ImM+8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ky0dS2ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594BF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WpQPNFzoko309WgBAOXV5BhtsAAq0an1WyyAftimbB4=; b=ae5ImM+8/eQKCU
	B8/IqDDfl/FWwCGDZeTNpaYwey1M9YonW/TDJFbKf38BPVWHnPNL88f8pNsCGmzLQH+mhnO6n82LZ
	SBWwWnKYaeiVgxGVpr2Rz2I/NGAUKv+yZrsZx3utb8OeMcFPIulxnDBXrNKuFwbk5TBHvG5aMnHL8
	XzsWfvc58nA0MBzYW13Ut/9OD564kX75VMmY+bNdXWNu5G1NxQXS2+mxhmuwZKBYpWlP5rCG7di28
	Y7n3vbDEjSNIDVxMr7ik2wnvFI5MRJFpCVR3A8gmRySmnJBTHywsaKwhn8d/Ne9HLd1X6pW81+ola
	h/ZBtxR21i0mQyYcO5fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkfX-0006Ch-Fo; Tue, 11 Dec 2018 16:13:59 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkeG-0004Pn-Cq
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:42 +0000
Received: by mail-lf1-x141.google.com with SMTP id z13so11175090lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=46fwj8YcReytyr8AzNJalj0w3E7iTBrGitUtFeTjOPE=;
 b=Ky0dS2eppraBn2KnpC1qjPAh/AjlhYGQLxxeTYeneUGny5x9lZXhrwS4A/fkg/rt98
 Rlb9wRkB71JB40Fo+mNE49f2g/I6TSgnptNM+ajWyeapn4JHGJ8GrxCLW+3kdlqNpIfJ
 mNhQ3iVTgvqPe3EPJlGX8MhKMtMxb3bCAsomMGSWl/1fByFbgHhU7DCH0XBm3MejCT0k
 evuimCJU+Mi3W1UsCY2Ph6EiiOJjfuxcsQElBf/JvZSETouFvxIbW6dpZlSTPPJml3Ga
 AEwhb7cAPWF8c4s9xYTA8dtuECwtHODeQKTOohTgXMP3WPhrfkT243H/mJ3vswDWL26V
 11wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=46fwj8YcReytyr8AzNJalj0w3E7iTBrGitUtFeTjOPE=;
 b=f2sI80Mtihzfijo0dCZGvzOxQ+KmYJ9jMm7cJWjEBQZSU66dIc9W2emoLHv0Gxd7tU
 O45ensADHy/Y8vSx/SnEWW7dXFXlweKdA/E14ZBekBsKXA9sjlsniT5Qsu0nCmGTOwrW
 hKmQpDL/x5z1A011dhkDazq1bISwuRIIuxAKCJNA7Z0pFZ2xPP33wQ5vOi+CQTHyDnd+
 XrZ1Qioe1Qjdp0MD2o4BNTdWT/jFbh+1czHw6fJA7BlIk48yp0u9RhVwSqd0F/8IvMu4
 ZeumnelDDelGHHDeEr8GfmMEEOjO4kjhsacwc7/49mmY3ZXGP6mxp5ZWyo7vnDNNM603
 g0WA==
X-Gm-Message-State: AA+aEWYWXswzsLcN8SDijOjZNRrLzzaAmJecl47Eqv0UeetPdNHKfJEd
 wtBU8WXnKmeQTWHNoSImgByx+g==
X-Google-Smtp-Source: AFSGD/UgLMwKeoI+dl+LQVnzZ6eERlBXMBNc0a0heIbI8e5mFeq7mPyxDmmCYjO4afhdcvUs62pnNg==
X-Received: by 2002:a19:200b:: with SMTP id g11mr9348983lfg.58.1544544748652; 
 Tue, 11 Dec 2018 08:12:28 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id k21-v6sm2748410ljc.15.2018.12.11.08.12.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:27 -0800 (PST)
Date: Tue, 11 Dec 2018 08:04:46 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.21
Message-ID: <20181211160446.oby2mmxv22wkwcva@localhost>
References: <cover.1544124873.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544124873.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081240_491258_0C9BB14E 
X-CRM114-Status: GOOD (  16.40  )
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

On Thu, Dec 06, 2018 at 01:59:10PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT bindings updates for v4.21.
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.21
> 
> for you to fetch changes up to 74791d15fd7c405511e3cc097c2f043171ecbdb0:
> 
>   dt-bindings: arm: renesas: Move 'renesas,prr' binding to its own doc (2018-12-06 11:33:22 -0800)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Bindings Updates for v4.21
> 
> * Move 'renesas,prr' binding to its own document
>   - Prepration for converting board-level bindings to json-schema
> 
> * Document iW-RainboW-G20D-Qseven-RZG1N board and iWave RZ/G1N SOM

Merged into next/dt. thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
