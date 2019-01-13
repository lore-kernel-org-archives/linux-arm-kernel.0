Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C2DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:57:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A6120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Um2/f7K6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtJdPHGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A6120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0uSteob55pk7fJ1AbQZdHShJXYxG7ijVzHcQ+HMgkhU=; b=Um2/f7K6mWyVZk
	Kl8Q9CEt9JcF9BcJR4Ih/wAc/C/CkFmimitFHNJBMaRbwI/NeOyg2KR9IrXHNbkgDRYpkgyvw15V1
	SL/gaVetk58QTrWBx/8dXu7rQTLB9ZFtGcvmR7rjCy3yK0E+3BFwHgKyEMo72r6pQBvy3Yh3eJRaX
	50BJX91JyAkXyA70e9kav6LSZ+0K2VeKv+Xv9z8LnwsD5vtF81/g7+9T0QTfl8I0cYuVSCjxNVBsE
	0gNuSBlLgjcd91/dO1UGYJrGSV2JxtKj26vbNww4S/FgZHGk0iiIY2OXB1pWdcEpmIYA8NbWs20bC
	dkPLPo78ZlhDyltknCaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giVxW-0005Ou-Mm; Sun, 13 Jan 2019 02:57:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giVxT-0005Ob-Hg
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 02:57:09 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 078F52086C;
 Sun, 13 Jan 2019 02:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547348227;
 bh=rkThKaPOzadWzMex50MwwnD49tREW8fZRGDyInivnic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dtJdPHGjI0nSVtMH119K5sFHks7TTSi2tUeAB+MW9j5MhTe7rzRK1gXnjMcE+hfAD
 /sJF/ot5TgcILt9Mhj9RIPDxnPWf8PHcTO9A5KBQEmpsT0V71kBgcv0XVk7yIkDuL2
 LT6rLhLLWnyAD3GQkIc35DwJrvbel8fMfn/ZQ9kM=
Date: Sun, 13 Jan 2019 10:56:52 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] ARM: imx: don't build ssi-fiq if not required
Message-ID: <20190113025650.GF11426@dragon>
References: <20190103143631.29284-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103143631.29284-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_185707_599511_BBFA6D69 
X-CRM114-Status: UNSURE (   8.62  )
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
Cc: arnd@arndb.de, s.hauer@pengutronix.de, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 03:36:31PM +0100, Stefan Agner wrote:
> The symbols provided by ssi-fiq are used in sound/soc/fsl/imx-pcm-fiq.c
> only. Build ssi-fiq.o/ssi-fiq-ksym.o only if SND_SOC_IMX_PCM_FIQ is
> enabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
