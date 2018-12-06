Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F53EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:03:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370EF20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="omDpC9eL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLFtWDqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370EF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zk/vSNuufHt+cpi1pVQija+Jc8x319BVeHI3P5WYMGc=; b=omDpC9eLfD087h
	Cys6jZ3PkeyH04jEIJc8JRCqEb9lH7l1rL3pknbonjG1rg7YeKfvFY6zynqaTcmQAsO5Sm/ztvY4W
	z4N9mmrzLjwCaD1nHzpbiK/qTcyKiNK+U6QDoXN0Y21Pr2BpYLoFLUPSSetBuv5KQ6ceb8bgvVUl2
	VgFlDCHxxS3i/Nh9liV4S6xFm/I7ppMFeXPdWj36Nf4pJsKqQGP8neUQxd5ssedI8PIiIoWHeVz4R
	GOJ5Ab7G0NotmNyToCKyFwfYHg1NuMPjTmWeIPoBXMas7cfbPudsKEz45klVnFCdCM1dnFforl407
	RoAOhSFMY3vnPBkzJGEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUi4m-0007Va-LM; Thu, 06 Dec 2018 01:03:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUi4g-0007Ui-U4
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:03:34 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4E39B20879;
 Thu,  6 Dec 2018 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544058199;
 bh=fp6YQJQ+2ktuQldreucjw5Y0QwE7iamNV2fcco2bcB4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qLFtWDqgEMvhudW4QrpwNhEv5WEDqGgNt9pHUoZEjhTtahWeCImttY7LXbUL7nc8q
 4ALDXK7jjSqK2hTuKbwRq2y3qSlkEdhDStkimPO/gT09f2k7lHLCw+IyNDaYrAV04s
 mvr2WmNdQN4uI9lAxbMUF6G4RL44x1MbCsyb5Mkc=
Date: Thu, 6 Dec 2018 09:02:38 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v11 4/7] arm: dts: ls1021a: add qdma device tree nodes
Message-ID: <20181206010237.GP3987@dragon>
References: <20181030023604.34027-1-peng.ma@nxp.com>
 <20181030023604.34027-4-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181030023604.34027-4-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_170330_985733_CD598C4F 
X-CRM114-Status: UNSURE (   7.50  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, zw@zh-kernel.org,
 vkoul@kernel.org, robh+dt@kernel.org, dmaengine@vger.kernel.org,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Oct 30, 2018 at 10:36:01AM +0800, Peng Ma wrote:
> add the qDMA device tree nodes for LS1021A devices.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
