Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC44C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:14:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D232E20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A0DowUqA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xblN9as9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D232E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O/dFTpfdIMExizY/LddIDqaRaZ9jvRwSJ5ZKGAshJIU=; b=A0DowUqAfRvSxC
	wetjPWpkByEiwH6+VPSycyxZaDdRIK8oH0eOBMJy3Ha8D0ykY2jrLkT3GEQohuQxvs+pOHpNmIb0l
	SIm1T0AA+iI3Bc4X72ZuxSG+q8NMW9U5lk43NaGfSc0hdxveWdqgeC+gKJExXxb710uodUwSrsWqC
	r/Wpx4gL66LatYOsi45nQ7dePFxV74TIiYsUz+i9fvrYPk4915N2bwBQ3/hnGN1bpaA92tMLgerCH
	g2jjREnyPIdQxWqPIqvTgvsZoMLqR2uZA/9yaX4rgY5xtMFpr/MT4NDf2lcOdd6R7kQCp5iJqU+2L
	U40xtQl5/8vrgdEjHXQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghstT-0008F2-Kw; Fri, 11 Jan 2019 09:14:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghstP-0008Ei-3E
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:14:20 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D94F720870;
 Fri, 11 Jan 2019 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547198058;
 bh=yI2NegK2AkSzTvDk/Wb3NTiZgE6wVWXmdu2zf7It1dw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xblN9as92RbNZwfkYdM/FJh+XuYZzmlSjpKcqYnytUWC84ZfH1+zSW7l57uIvFPbB
 2ZAc3U6npQT8wIfFEJLf4hM1KvlGxU6JyVCxB5tGbkaxZR/E/8li0j5Hap4MqRWRF6
 vzY1tizYNDwWYuyeY/4KE/mdcCdMNZEoLarj4Tsw=
Date: Fri, 11 Jan 2019 17:14:05 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [RESEND PATCH v2 1/3] arm64: dts: fsl: use a generic node name
 for m25p80 flashes
Message-ID: <20190111091403.GI32649@dragon>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_011419_153996_348EB84F 
X-CRM114-Status: UNSURE (   8.27  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 05:07:46PM +0100, Alexandre Belloni wrote:
> Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied all (not MAINTAINERS patch), thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
