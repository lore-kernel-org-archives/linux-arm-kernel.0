Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:57:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FCB20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uTfdUuPd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obym/N+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FCB20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:To:References:
	In-Reply-To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UGmeAbIiphzXf2vGsJM3KnSH4ag1nDVTYf47F1oP8Ik=; b=uTfdUuPdD+WCoh
	GgV3KWEBNsXGXHELIxTbi33n0o4IKCbr+OsukepsBqW8z4/J9+l/bWje9VIAdVl8v3ycP16kL2nwr
	SOG3GctadAZa8asn6Y0zdqXeFtamxommd3JJIA1zFV3OT9BGMpPripzbN5mCZ9Q8/tB6vQ1OF6RzE
	1QggMozoF3wWYRSRDW59WmlV7XHdklJyYQY0vPTXbt3f4dZf5uz2eolSKM/rLWEQsSUTnRM8Y0qff
	CxST37b3M4OOX60Nit4F/VrPlqjo/Go+pHM7lT3gSrskAneVeQ1xy8O4fBluA4eVs30W/gcVBPShc
	6+ZQxZVWRP+1QjRJ4MNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi6fn-0006pr-Hj; Fri, 11 Jan 2019 23:57:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi6fj-0006pV-QH; Fri, 11 Jan 2019 23:57:09 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B8E520835;
 Fri, 11 Jan 2019 23:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547251027;
 bh=ZCmm1wOKskabQ07CJBIP/K03GW5e9UTCwOj61KfmdTo=;
 h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
 b=Obym/N+xNsvpN9Mxn8SD0the1pElFu6moBJZxngJPiuCgS3rcHeVjAcT0D8y6xLIA
 RUeSdq3ivBZXlnijmAJZioTNdL/yCZEI0iFT4TX9pqbhdtLy00dq2f6Cx8lXoaxdCv
 hslBGGmpW6ULltfmlHH2qb4ryhViHAdEu5k3R/KU=
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] clk: actions: Add configurable PLL delay
User-Agent: alot/0.8
In-Reply-To: <20181231185517.18517-2-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-2-manivannan.sadhasivam@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 mturquette@baylibre.com, robh+dt@kernel.org
Message-ID: <154725102657.169631.13321616473847605014@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 11 Jan 2019 15:57:06 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_155707_871500_505AD905 
X-CRM114-Status: UNSURE (   5.99  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Manivannan Sadhasivam (2018-12-31 10:55:12)
> S500 SoC requires configurable delay for different PLLs. Hence, add
> a separate macro for declaring a PLL with configurable delay and also
> modify the existing OWL_PLL_NO_PARENT macro to use default delay so
> that no need to modify the existing S700/S900 drivers.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

This one looks good to me.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
