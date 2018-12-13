Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72573C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:17:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3DB20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="knqBkW8L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZX/Mi9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3DB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nEr/Ug/+J13/0U9OfVyYYais3C39nNY5ope/JWEQf0U=; b=knqBkW8L2iYfYx
	TsmVcStxsC+qZg/FrINvxhbAaz79ibPhAKVv0W8lBuC1LR7gYlwBAKBXftrlkBh07POP2FZvDk2PK
	znmiDnAAib2uBHL5t/3cHgxWPYY7TMbnNeEEDpv5GquaLcFz3YPwmUeFhKDz7xEtMYW7cfbfWk+4v
	rEUntpYTSQ8X/d0sLbur2F1eqp/yNLi24pjbw21fSjAndoPDuNvebXEWEB7aCX7MLmo1BFlKPFP1T
	AUnbsXR38g3OAP4APrJJ/i6TChA78RZuneXncZyzZeXYcSVk0sAlZGnBmFU/bYFF993vLpMQ4cTbN
	gIlgSszxFZGautMSGvrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLEz-0003Fn-Rd; Thu, 13 Dec 2018 07:17:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLBt-00075D-GQ
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 07:14:10 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 033BE20870;
 Thu, 13 Dec 2018 07:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544685218;
 bh=V8PF8Wddhw67CbmGdc+D5xS+weD1o9Xq8Dali0gz59I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BZX/Mi9/Qxxf7gUs2ZOtGMH1hzPJ/NEUDB7fEjq8uHEYzfDpXWRRnB0EOY1sVrZuL
 XxerhWVMj2cPAePaIq0/C41DlgC3JQQQQUyIBAK411G5bnJ1gRBaeyGi4wGynkvpr4
 bkdXiyT/vy6uv7vRRNDBI5cS6ig3nguUqDvDrOF4=
Date: Thu, 13 Dec 2018 15:12:41 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on
 i.MX8M
Message-ID: <20181213071240.GA12458@dragon>
References: <1544666918-10783-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544666918-10783-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_231350_095017_EE76D16F 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 12:08:38AM -0200, Fabio Estevam wrote:
> eukrea-tlv320.c machine driver runs on non-DT platforms
> and include <asm/mach-types.h> header file in order to be able
> to use some machine_is_eukrea_xxx() macros.
> 
> Building it for ARM64 causes the following build error:
> 
> sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
> 
> Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
> driver when ARM64 is selected.
> 
> This is needed in preparation for the i.MX8M support.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
