Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:21:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAA720656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KwJorr5C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMQMR0KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAA720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+yCwiwOHw+8kdBxK4+8veNfWunrlSYg3lV4KfV8m79I=; b=KwJorr5CsyOGE+
	Kyau+6JFEjX6C3134fCEK59aGZqBavZfHr4GbRB4cSmmrAV+EFinin84XMRGCKy4rayzv78Og2e8c
	pHsCdJ7sKbupRygtLJ71yRj+d1fI/FbLyRmIGjKvAZ9HlEKVuwCEF8LHxFGt7dLBESMMhmLioAs0N
	yK5Zpuhgs0/f6eRJXYxMDFr3RK5Q2CNIx0idYTG+sZ77glWnYQMZWQZrZQuPVNADnX/TxO4CWwQ9T
	WmI98FOwCQWdpIt7dx0fTnDbtoyfN2ENvQe11PgYEyX4kh5/TYZkJw0y68FpZbSVJqiwOVBdTSCyY
	T732Rg07KRNwb8YdfIbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giqwi-0002gR-SF; Mon, 14 Jan 2019 01:21:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giqwf-0002g3-GG
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 01:21:42 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 95E0820656;
 Mon, 14 Jan 2019 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547428901;
 bh=Yn77mQoiy6e65j7AjATnhAtUoN1846wxOFQa9S++VIo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QMQMR0KZB16sZuViD6xQHbJOhk2dbaAd6evyBdZ80dLHWV/ExKLkmBWiynIm4nx1e
 KtgKBCe0MRS5oESehQJtmey15Y2aBBappZmtQ5yMz4sQK0go01eiowSGWJFYyd2qBf
 6YQoUi85be/Yw043/JaFaxQ5+hZmj46VWV8Io21s=
Date: Mon, 14 Jan 2019 09:21:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V6 3/4] arm64: dts: imx: add imx8qxp mek support
Message-ID: <20190114012122.GC15371@dragon>
References: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
 <1547206279-26169-4-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547206279-26169-4-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_172141_576751_85088B53 
X-CRM114-Status: UNSURE (   8.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:37:33AM +0000, Aisheng Dong wrote:
> i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> graphic and multimedia features. This patch adds imx8qxp mek board
> support.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
