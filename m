Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDF4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569A12146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YNFDliZR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0DR26Qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569A12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v3CbUfHGz7oiUeNVL37GMswHNQ2PZ+Os+cx44hX5Ke0=; b=YNFDliZRkTV65j
	r9ByTQcCjvCTDL+JMfFPQYYv/l+Xqj3HfQ81m0k+kUGwoNHdWPX2qbmB6b0K3C5E1wXCN+PK0qKZT
	xyCv37zsvHo0NopXQGQPhBlIylWJTcq/rtYYBxUTcclw6i8u4lTa1538RqpfN5qgT5xcal9YhSog3
	ERf6yNx0oSiTJgJkvruVuW4KqADEF1rnJdgEnU4qYyFDjQ16jQdLqEn2gtz3/FZHCwziwN7hpXw0l
	W3N3aLh8MtmPZgVM2HT6JYJ0OOLu2dp95NeWXg8B57k0PabbuJF9OtO5DH16dhOdyR9WNFHpE5mqr
	y069XKgmCONqfuvh6VVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoL9-00047I-2O; Thu, 06 Dec 2018 07:44:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoL3-00046z-Td
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:44:53 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E0EB120892;
 Thu,  6 Dec 2018 07:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544082278;
 bh=dB8hzIlwbz0EZYXbf+9iDe7aWcqcdIzCaLqK36CLY9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B0DR26QsV2Nw6nojLUCMA2WQ1zNTr0afL3JluiuHbG1prr0ySI9Sl7PSBIWcdqgUE
 0LiRvE3JvHHpO7SBVbjBFNuQazGyZDzaPY9Is4evv0Ae+2SH4kLP+vIE3lM0c92LjG
 MGXe4Mt7sV6E4EgsOWlOAMhPAmKKiJZBp3vx0LUk=
Date: Thu, 6 Dec 2018 15:43:58 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: marcofrk@gmail.com
Subject: Re: [PATCH v2 1/3] ARM: dts: imx53-voipac-dmm-668: Fix memory node
 duplication
Message-ID: <20181206074356.GK3987@dragon>
References: <20181205181003.30404-1-marcofrk@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205181003.30404-1-marcofrk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_234450_043826_EF967A9B 
X-CRM114-Status: UNSURE (   9.19  )
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
Cc: robh@kernel.org, Marco Franchi <marco.franchi@nxp.com>, festevam@gmail.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 04:10:01PM -0200, marcofrk@gmail.com wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> imx53-voipac-dmm-668 has two memory nodes, but the correct representation
> would be to use a single one with two reg entries - one for each RAM chip
> select, so fix it accordingly.
> 
> Reported-by: Marco Franchi <marco.franchi@nxp.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied all, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
