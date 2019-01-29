Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1292F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j9tPpIS3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PeMzZcv4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RLiTvBB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1292F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iyEZkz76WbFRdUBnsGHU6UjiVgmbD5ws2tRMLBzpnZw=; b=j9tPpIS3jNdV2jqEJoyooUkEx
	USloD+2hH8uieM3Pb9ca/haqfjBzooX2XP4yFDd37nU8tpp+jKgVrNDlk92aeXbCtJDSYUL/8o6ja
	UlkIsYxPoLh7vc7eh+fMpP03tdg3ZD3TXW12YorwubmNZvDqCZb90k8tTpqxRELOzAmQv6u7y+FQe
	olHwRYxmW2fJFL5AA6bZfu8OgrrUa4fS2c96SXWuprWC11KUpUjrRcc2z1PcJE8eFNGb+0r7u/krT
	vD1ImFriHomsimoYpsR2I/SSg1r+ZtwonlMaaZhKvv2TdIYLo/ljDnq88LlwW4ZoLZqeUMnv+Yz4z
	bL5U//0yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUge-0004Se-RP; Tue, 29 Jan 2019 14:48:28 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUgb-0004S5-Pn
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:48:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 83E1A60987; Tue, 29 Jan 2019 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548773305;
 bh=RYy2yFr8t2PJ/0/wHbPQpf69MFau9NKwCcDNZPKeVg4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=PeMzZcv4hc9OCJ9e5maPqIjwzu4lRc1M1uv4Hk8XGPH0sGrio3vtwbad38A6NbP1i
 qf/TBKgl1yvskekiHXvNNrl/fwvX3155P6Kppjo0+xgnarq0TIlf+ENVXP8yfOi1Bq
 evrbQv8mHlXavQ5J85eBIZV7GhAySEl7EGmRCDvM=
Received: from [192.168.1.100] (unknown [157.49.239.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B39D6072E;
 Tue, 29 Jan 2019 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548773303;
 bh=RYy2yFr8t2PJ/0/wHbPQpf69MFau9NKwCcDNZPKeVg4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RLiTvBB/scwl2+TQF+DsB6oP16m3ZF5vw5OErQilmUDibNzpQYlj5Uht+y8Eud4wC
 G0UidDhV2QTbArQl+bMIj4+AZFaSUIBO21yMNeBltwP+3rAQxF9TDBgBJu/hHOGcYe
 zs7waZe9aL3czqwOURl7v/cctdnXCvzC1j0xOkiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B39D6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
To: Leo Yan <leo.yan@linaro.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190129132528.GA16669@leoy-ThinkPad-X240s>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <5d50103e-bcfd-6704-a431-c17360198348@codeaurora.org>
Date: Tue, 29 Jan 2019 20:18:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129132528.GA16669@leoy-ThinkPad-X240s>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_064825_855448_232F200A 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/29/2019 6:55 PM, Leo Yan wrote:
> 
> Looks good to me and tested on my Hikey board (though I cannot test
> for a device with UCI ID):
> 
> Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>
> 

Thanks Leo.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
