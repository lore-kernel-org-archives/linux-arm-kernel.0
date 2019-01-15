Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31308C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:53:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D6320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dAWScl9k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWyPdO/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D6320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=axmXoWWQB4uILds/07I07Ovs3z83DNgXpVsZcXF92RU=; b=dAWScl9k2d/OxA
	ToiWQ3NgSly6kZUuMr1ea1nWZvvJMzuU3RVYRxwF6Z87jRZH+fR6xWIJ53wWW21lHGy7vGyYodubw
	LcuEvZiPFfENqiQXWfztMlX1OS8gicNIrjAt0ikX4t1lV5qEf9PqIJLjVJHji3aJK6kZ2AFVdwkLW
	XONO/NVKxKzTLYMDR2oxO1UiXj2D/Erg3SUXRbO5VhcP2DOXIW/v5nVE56eS9bHg/96LxuQb4yiwx
	CfTsCbBJ9WkzXgH5tDfFiy0pvBtMsEiBTU4akRthOoPH+nPfkbXW77sHmMhd7D74X6JKm3rS7S9VE
	K/fSFsGdoC7S6SLm/hAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQ61-0000nq-Ke; Tue, 15 Jan 2019 14:53:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQ5z-0000nV-8u
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:53:40 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1AC220657;
 Tue, 15 Jan 2019 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547564018;
 bh=8hw2q3wULoyePhsT5YvN842RYIrGQbGHlFhAiyaOVxE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cWyPdO/wl1Y4tGLtgRbLsEfLOxCtb6IXhN0L/yDe7LkKZhEHC81nGwUdVhzO0N08m
 4Z3t84I/4MER8/mRHlaWtnPQQYR5BT03WXzvu/ic0NBbdV+awD4b72rOrU4uJiRmB9
 PP9JF+JUMr1VMe1xLrxaejW739DorEh1bhzyILn0=
Date: Tue, 15 Jan 2019 22:53:12 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6ull: Fix i.MX6ULL/ULZ ocotp compatible
Message-ID: <20190115145309.GA13895@dragon>
References: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
 <1544536273-17909-4-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544536273-17909-4-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_065339_336060_8F2CABF7 
X-CRM114-Status: UNSURE (   9.80  )
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
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-imx@nxp.com,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 02:51:13PM +0100, Stefan Wahren wrote:
> Since imx6ulz.dtsi includes imx6ull.dtsi, we only need to fix the compatible
> string here to achieve the correct OTP size for both SoCs.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
