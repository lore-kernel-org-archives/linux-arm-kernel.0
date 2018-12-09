Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39637C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F26204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gsGghB8H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfafvZLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F26204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cprGdsbokoqdsQcpSO9hwBHOlAf1VQxZ3YK8UX2iqBg=; b=gsGghB8HWpa1Ym
	b+NuHYod8rh6LdkOHczAValHEvCBHtMCSb14WXEMvDboA9sO+Dt6m0f1zfSaO7QHW8VMLs8J14Met
	oPvRbqtccVSeVIGEFEd+VJ9lXnJhSND6CsxVBIjzsWxEFfgGL13qgRoPlJfhoiB4ww8GJBQrY56eA
	R8rdRyN60kcEwF6kFSIqzg7Box9Zv3csDpabjd7pb8dehJba4ny7yJ2F61fNK2FrDPVfhffdbzT7Q
	4nF1TUoJ6K8EHkZ8kJ+s32/BEtaBKssrtYTlMdthGm5XItJOfUYpty2+7u8qgYMgoYQGsgk3SAUaS
	vAKvDkKgxnMjf5LnKX1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVyqr-0001cn-Qt; Sun, 09 Dec 2018 13:10:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVyqp-0001bM-FN
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 13:10:28 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A37E2081C;
 Sun,  9 Dec 2018 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544361017;
 bh=rmOD0wDcgC3N59mERBqnvW/chMO+mzlfiUEafmnlDYY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kfafvZLlj3Ei+zAsmCr2+WU5M/VRhSOL6HQqnIiITPjp8g6B9InenIQ1Eg8KwIlWZ
 00+6xIXpud+pErwQI2UR9iQx5XpH3CF24L/hfiQ/hVV5hakgbf087nubkdDCytLo2i
 i0mjcFCtliWSUfg4Ep/DzdFB8CNz1LHlUYxo/ugQ=
Date: Sun, 9 Dec 2018 21:09:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH v2 0/9] Improvements for i.MX7D PICO SoM and its baseboards
Message-ID: <20181209130923.GF22960@dragon>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_051027_542894_DAC10E78 
X-CRM114-Status: UNSURE (   9.58  )
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
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 08:08:56AM -0200, Otavio Salvador wrote:
> This patchset rework the imx7d-pico SoM, its Pi baseboard
> and add the Hobbit baseboard support as well.
> 
> Changes in v2:
> - replace fsl,uart-has-rtscts with uart-has-rtscts
> 
> Fabio Estevam (8):
>   ARM: dts: imx7d-pico: Do not harcode the memory size
>   ARM: dts: imx7d-pico: Switch to SPDX identifier
>   ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
>   ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
>   ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
>   ARM: dts: imx7d-pico: Extend peripherals support
>   ARM: dts: imx7d-pico-pi: Extend peripherals support
>   ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant
> 
> Otavio Salvador (1):
>   ARM: dts: imx7d-pico: Improve WiFi regulator name

Applied all, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
