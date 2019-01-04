Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:35:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E302070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Da8lh/ea";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx/X/wnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E302070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wPjdfeeC9ujKxbogLrmWLlEut7DPk6SvVijWEqTu0TM=; b=Da8lh/eaTzpfeM
	TfP84BOJ743F7+S/uVbNNuwkgNHZnxW8txz1sQwUGaKwUCzaXgAvnu2fxeoN63moTXoJ47RT4T3Nq
	alCED+fqN3JVacodhtPVCyODyDo4Clm7Z9ncnB210Uc5V4EjRqb6mGXPaCYr/y2tcZo70L8Nlh7nZ
	Rv647HwLeVePRB4GKabkr3fMZ3pJ05goHCJpsPu3+/4vyPMa9P/SyJ1XmggJhzI1wxPFEeAZju8/t
	r2cjn2/86HJGZQKmR2+xW339ju/Ca0CJ47Cv49dV7A/e1dOJt+fwA0IOpFf+otJT7cCmDsub0IiGQ
	JFEGOINf+AY2rN7I964g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfQZM-00082p-7p; Fri, 04 Jan 2019 14:35:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfQZJ-00082O-Bi
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 14:35:26 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3193D2070C;
 Fri,  4 Jan 2019 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546612524;
 bh=m2OXGPKIOx/RxVDkAg/ve0NZOqXHe8oCZ3dOZiulKYo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gx/X/wnJ+TefjwjSPOb/S3HY+RJ+MYg5VoZrNAZY9ZSWAV6W77uagDkMhgdgoAMLD
 LSH8Vdlq2tYG1NuBqZnu39pzjtKJKpjDd/cC1LMkPNbMOpUqhq+5G20OBwwBnYDei5
 vwOl4oWrOhQZT59iPkG2Zn8QjvxmucoOYWA9zl+w=
Date: Fri, 4 Jan 2019 20:03:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] dmaengine: stm32-mdma: Add a check on read_u32_array
Message-ID: <20190104143346.GC13372@vkoul-mobl.Dlink>
References: <20181228192641.9713-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228192641.9713-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_063525_413246_6BE532CD 
X-CRM114-Status: UNSURE (   8.66  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28-12-18, 13:26, Aditya Pakki wrote:
> In stm32_mdma_probe, after reading the property "st,ahb-addr-masks", the
> second call is not checked for failure. This time of check to time of use
> case of "count" error is sent upstream.

Applied, thanks

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
