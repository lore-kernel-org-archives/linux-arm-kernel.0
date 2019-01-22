Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AB5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:33:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34DD21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ezl2iD+A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OulJnrcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34DD21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ErML4ABYDmYexT0tRmdKVzNzgm2k+7RM3Tppxyd/2i8=; b=ezl2iD+ACSKeEH
	NnpoRZG6G6BB3H+avOcWd3b9VziqNkVgg9KFO3AjXZh6lvVcH3bl2b6fKPpVktJ0veg2RkE7+O1zx
	w1xmFvUCeph2SbIUmyjhUrJQCXgr9BPIUGh+10cqb9K2m0cC6rc67JZlDXnGawEsWjsMdvcmULYxp
	RKQIwf+vE95PteFl7A0xey9Fj0gyeHdgacGn0FLn53nZqI4QsVBtSeVVeDcntDeJhYEL7yCg7EIvx
	ecO0Hxa52CXG0I++r/y/xyyd5G4Lb4OEWl0zQOPOYDUJ6VGLVkvS2g7WswZUxvehQYeZI7WkfCrKO
	I8YFFNU6yueei7vGhW1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glogL-0005eQ-Vr; Tue, 22 Jan 2019 05:33:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glogJ-0005e6-1r
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 05:33:04 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0600520861;
 Tue, 22 Jan 2019 05:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548135182;
 bh=QvrJ5ME28jfdXtWn4H3bM8SCpSPS9qd47OEn4hVR/4I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OulJnrcp9bP05VgpGIm6Zm081/srUpIkA0bJ+rnTMJC3zc+cO6PW+Ty7wky2fucVb
 uSA8LVndcpK+KerUPhqk/thaTxYOBZW0x9KnFLKeh5nwomyAeIbb/S1QwLvPY82wN1
 Wj1q0Rbuq4TLrIhLbL/RpAJc/hYSM9zuHN2wGzk0=
Date: Tue, 22 Jan 2019 13:32:21 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] ARM: dts: imx6*-apalis/-colibri: mark I2C recovery GPIOs
 as open drain
Message-ID: <20190122053220.GE19233@dragon>
References: <20190118133113.19484-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118133113.19484-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_213303_114678_70C15E3B 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: kernel@pengutronix.de, marcel.ziswiler@toradex.com, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, max.krummenacher@toradex.com,
 fabio.estevam@nxp.com, dev@pschenker.ch, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 02:31:13PM +0100, Stefan Agner wrote:
> Since commit d2d0ad2aec4a ("i2c: imx: use open drain for recovery
> GPIO") GPIO lib expects this GPIO to be configured as open drain.
> Make sure we define this GPIO as open drain in the device tree.
> This gets rid of the following warning:
>   gpio-81 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
> 
> Note that currently the i.MX pinctrl driver does not support
> enabling open drain directly, so this patch has no effect in
> practice. Open drain is enabled by the fixed pinmux entry.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
