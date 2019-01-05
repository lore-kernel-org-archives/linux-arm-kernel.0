Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A09C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:37:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6513F21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i1gS89Q3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGLgjRI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6513F21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UVYDi4rqPBWadSgR9+odIZwPfRwuI69+2T0IP8MezH4=; b=i1gS89Q33X/2yG
	BjVeqBfEc4PU+3awl8kR0LqyWcpxCs6tWMS/BIURCSIhKIyGApfm5R1Bs/4S06UfibnsAYc1Ajvgy
	f9e+uO+zmWORMIIvCNZ3vcjLt6dAbIh6UiB36vERV7iuZh5YnOX9ldeL9vlE/29tPcbfmyDnPynYD
	AHH/aSxfC19rvpwRPjc0HFHRlOJTcs6sPPT7eFWP0O1uPoBr+j86aNkZSk7UoQF8V4nW101plF1J8
	06GjXcB3XpcoRCSGgCvTmvNNR2ychistOdgmyDpVeNll+NyEjKN+UI8XdOppf3Cu9ZAEwr1pbBLWa
	ogYbzsafImX+e/39tBTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfcmY-0004vJ-CC; Sat, 05 Jan 2019 03:37:54 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfcmV-0004uZ-06
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 03:37:52 +0000
Received: by mail-pl1-x641.google.com with SMTP id p8so18252035plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 19:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=U/VyUyzTj/Ns+LNXLQBk9Rd6U8O/FkeaSfUH8ZvZpNI=;
 b=bGLgjRI5ZAb0Zw9jhKlEy4R4cyFc60RhxdnN4SztDzozjLku2nGtGTj4ZvSwWX6o5l
 sG7Ui0/DsgGQd3zyYZgPrjap+tivhj4GfCZM4J8urBRt6KzoMdaFQZIc8/hLWdlRBeyA
 K8TxQrkHBnJwxbQv4BrQKV5NugVRByOefYv/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=U/VyUyzTj/Ns+LNXLQBk9Rd6U8O/FkeaSfUH8ZvZpNI=;
 b=KCp0UQ9fmuE/E3ZdwpnSzddWZf6zihbUpBa43esHo2Ov36YAuXw4/3HA+5FWfYZiLe
 0lk49LmjSkya4+0fFa0Jm+6XITivrrRoSlr7LRzSK435cu/DXlLsrR5utYeZjY0zoSIg
 rZGE/Ifq/j1rV6fmHsnNhfUUrX0/8rPTpZBzCZU7hMegfSrjFeSQKwykwAjAbwGdI9A4
 0rIZznP/isnsm7u/Lnz8XcmwRMP9MRthALEHEvMTSPgf96slIZPjKetUFBcXEpSTAEXe
 IOk+jZtNySuCvwz9mN4pGsQmIHbq10WrdtAKVO9c/HeN9HAfwIExrvQIZKFsEugh2WR6
 1B5w==
X-Gm-Message-State: AJcUukdeVjwwy3GxzY1HewiW2urGjkPmyLDB4jtKBDPVzNcuN1b9i1Qn
 JK9lhWWWPGQD16RqJVEP+10k
X-Google-Smtp-Source: ALg8bN7RkvRnvHUC2VHG0Kfbm9d0Mh66AklAtvp41flEH/tYy1U98D2roVlbIkaFRsgjE+6oT3d30Q==
X-Received: by 2002:a17:902:b40d:: with SMTP id
 x13mr54211052plr.237.1546659468862; 
 Fri, 04 Jan 2019 19:37:48 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id 125sm111944623pfx.159.2019.01.04.19.37.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 19:37:48 -0800 (PST)
Date: Sat, 5 Jan 2019 09:07:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 0/8 v2] k3dma patches to add support for hi3660/HiKey960
Message-ID: <20190105033738.GA2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_193751_061775_8E286849 
X-CRM114-Status: GOOD (  18.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Guodong Xu <guodong.xu@linaro.org>, Ryan Grachek <ryan@edited.us>,
 Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi John,

On Fri, Jan 04, 2019 at 12:56:20PM -0800, John Stultz wrote:
> This patch series is based on recent work by Tanglei Han, and
> adds support for hi3660 SoCs as found on the HiKey960 board,

Not sure about the description/subject here! This patchset adds support
for ASP DMAC found in HI3660 SoCs, Peripheral DMAC is already supported.

Thanks,
Mani

> along with a few patches I've been carrying.
> 
> Review and feedback would be greatly appreciated!
> 
> thanks
> -john
> 
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Ryan Grachek <ryan@edited.us>
> CC: devicetree@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> John Stultz (3):
>   Documentation: bindings: k3dma: Add binding for dma-avail-chan
>   arm64: dts: hi3660: Add dma to uart nodes
>   arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-avail-chan
> 
> Li Yu (2):
>   dma: k3dma: Delete axi_config
>   dma: k3dma: Add support to dma_avail_chan
> 
> Youlin Wang (3):
>   Documentation: bindings: k3dma: Extend the k3dma driver binding to
>     support hisi-asp
>   dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
>   arm64: dts: hi3660: Add hisi asp dma device
> 
>  Documentation/devicetree/bindings/dma/k3dma.txt |  7 ++-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 22 ++++++++-
>  drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
>  3 files changed, 78 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
