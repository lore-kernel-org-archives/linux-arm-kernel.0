Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F49C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:39:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5D220878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcQawn2V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHNW3Xhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5D220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UqK9ASndog8Uz24z7e27jzekxl89ikQ5dL9cmbcbaMg=; b=gcQawn2VTNGF7r
	mtRinYyPzKv6TazgDGzGH6kJ+t26etiCPPjkYcWuN5xJ1QU/tWyEmtZ89yyQxc3QJSfyOyZvxeZYs
	J0okulaxyfuhpmljAgxEcFHsxsK7hbbLBcvvNpBdIC0x6Pno3fTQydQnXGZRUGtWPOniCiNh3752K
	I7ktZzJbut/ElUBK606bfpgmRqx+Ua95752XtdzV4Ds8mG//pjtykMYXRhWopofRGGAGUd0eq4ClH
	pURv6Kl/IGIxdDk/nN93/SoU/4UbNSAh2GNUSl3rPv2jjn0P27cyujTj24ir9rm9smTv8nJFZ9qY3
	dDa/HXsRJT7LjID/m4hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoGD-0001oz-TC; Thu, 06 Dec 2018 07:39:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoG7-0001oX-QC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:39:47 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6B18020878;
 Thu,  6 Dec 2018 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544081973;
 bh=YZ77yARnuMhDBLlDIK7NU0356FPtpkUSMJHlL2siXQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KHNW3XhrnGlI/fyMz3zyhpjhJ7Eh0I3jAKGZna6uZABn0Zne8yAkWNNPfVwIgx/0y
 dSCYWR+MjmIr60iz9cfSnE0Mgcm0o3awCxE8CtoJznSO3ctqVaT10nko6sGzRZ00TQ
 CkgxcUEHoRPQ8IRxVFVTc12euKyXAf5TSPYrpH3Q=
Date: Thu, 6 Dec 2018 15:38:52 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx7d-nitrogen7: Fix the description of the
 Wifi clock
Message-ID: <20181206073851.GI3987@dragon>
References: <1544007930-16670-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544007930-16670-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233943_867879_CC550151 
X-CRM114-Status: GOOD (  10.27  )
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
Cc: gary.bisson@boundarydevices.com, linux-arm-kernel@lists.infradead.org,
 troy.kisky@boundarydevices.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 09:05:30AM -0200, Fabio Estevam wrote:
> According to bindings/regulator/fixed-regulator.txt the 'clocks' and
> 'clock-names' properties are not valid ones.
> 
> In order to turn on the Wifi clock the correct location for describing
> the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.
> 
> Fixes: 56354959cfec ("ARM: dts: imx: add Boundary Devices Nitrogen7 board")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Troy Kisky <troy.kisky@boundarydevices.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
