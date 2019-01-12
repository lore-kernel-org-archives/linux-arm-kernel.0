Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:34:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA712084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FvBWpwxR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VGXBr1Bk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VGXBr1Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA712084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BU33sqiio/bi5iTyXxHa+GjUv2uWnKKy3JIW9mLi/Sk=; b=FvBWpwxRn5DBZ3732kBp49d2Z
	prJO4UYbsz9mwteZrakz881tyJgI/P/4aUZcaUlT/eujLj0JdBpMFPx/5dy9yDFsez2oUNfPEn2t1
	yG0vo9gzxzvXlD7hh+HuV7shR8c27BXSdXtWERvE3LFbyFdayXPrePKXIztUiKEcIaEffvHWpdULM
	4ezFOg+vscRNlxzNffo5ZHfjSG1kO8oM1kQe/WzgBPC0y2idlGedioH+XnLJ6DnQRP6wtu8J/3A+N
	63bQyfJ74sXbQAkCoza4ElyIB7wIj7oEff65uyAtBRBGvy53XDq3K1WadOWDTWHuXwCqRJF+/lIUw
	OBK9SqXsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIUG-0002rK-WA; Sat, 12 Jan 2019 12:34:05 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIUA-0002qq-Ro
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 12:34:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E6EEE608BA; Sat, 12 Jan 2019 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547296437;
 bh=UP6SmaM4s/BZebnOzN4AAK5/EIXeewLol5TPNYVa6S4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VGXBr1Bkx7S+yif7A+gns/7vHGW7wDMLBLraYlU47EiCe3Jau4L60dDp9lLUhMcBt
 qxnPrMhdrVBOmqql6I+ba+duJQZhcHMiMJfPxFoL/yGJu7Q67XOV3t8n8FE4B71jUr
 upHJy3i3UeBj0Dg2WwN8RVGV5jHpaGYTCQUfFKfI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 by smtp.codeaurora.org (Postfix) with ESMTP id 324C7601B4;
 Sat, 12 Jan 2019 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547296437;
 bh=UP6SmaM4s/BZebnOzN4AAK5/EIXeewLol5TPNYVa6S4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VGXBr1Bkx7S+yif7A+gns/7vHGW7wDMLBLraYlU47EiCe3Jau4L60dDp9lLUhMcBt
 qxnPrMhdrVBOmqql6I+ba+duJQZhcHMiMJfPxFoL/yGJu7Q67XOV3t8n8FE4B71jUr
 upHJy3i3UeBj0Dg2WwN8RVGV5jHpaGYTCQUfFKfI=
MIME-Version: 1.0
Date: Sat, 12 Jan 2019 18:03:57 +0530
From: saiprakash.ranjan@codeaurora.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/3] coresight: etm4x: Add support to enable ETMv4.2
In-Reply-To: <20190111185242.GB22691@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <4cb23e3bc414f3a1cac555d27b93e7e8cfeb68c9.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111185242.GB22691@xps15>
Message-ID: <2039d8fcb6c09efeeb5df3f373a4d6dd@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_043358_919806_1F8D4F75 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

> I think it would be better to simply mask out the minor version number 
> bits in
> function etm4_arch_supported().  That way we can add more intelligence 
> in there
> in the future if we have to and we don't have to touch the calling code 
> again.
> 

Thanks for the review. Yes it seems good, I will make this change in 
next version of the patch.

  - Sai

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
