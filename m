Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E24C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34BD2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GotragLC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="equ15vhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34BD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=dknwqoEumc6HT6g4qY0qwW3Jkg+Hfuui4YFhn/98/Mk=; b=Got
	ragLCIpkcGUKfvWQYQx9g3atdkRWarA7DOdJL2gerRFk38zvL9311Od/HhBWUOFr2hz3Ak2HVX0b8
	jVJV9raDIJAVSBGb2MY1viKCytNvRN59WLcPF5d4D1lKkhhpRU3ycc+LEbAf1Xp3xIT4cUANJvpGP
	jSTXWGbZZi28zZnC/1T5VPO3Dk5l0tOKGQIA2rcYA/+VEAT4KPyz0dJlrYkUBmBo2NnuQf6YFj7er
	LdXE8ezpfWe8oz1vCuG3yGzUTbbWBOOQo/vBxHbZNC4RO2X6OV+IYoKbFA8SYMar8oKKwhss3530x
	PMZegvu5wDBJZTJMRs78ZWEfq+Nc6Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gksmN-0008Fi-Iu; Sat, 19 Jan 2019 15:43:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkslT-0007Or-BD; Sat, 19 Jan 2019 15:42:42 +0000
Received: from localhost.localdomain (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5393D2084C;
 Sat, 19 Jan 2019 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547912550;
 bh=ndj4QkCwuR+gsljAaqHBms3oFnudcxB+YK8NiojxcQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:From;
 b=equ15vhqc5vVY2CFv15Man2OxQKTReh/Ur49L1NXCXEPzR8ialGsF5LLN+dDn/p8o
 T33z2k7ITKXkTcyf1ghyotnr+/tZHUBx4pI395Q5YlC7N88002+cAVe1gve9iFcP5o
 AUqQD7m/H9I/s1QunWSnH1RdxGXNG3A4I/LvfssM=
From: Boris Brezillon <bbrezillon@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [v7,1/5] mtd: spi-nor: add opcodes for octal Read/Write commands
Date: Sat, 19 Jan 2019 16:42:19 +0100
Message-Id: <20190119154219.3597-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: fcd44b64b1eb0a33f6cc14f21dcb927ffd664af3
In-Reply-To: <1547546584-5254-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_074232_333578_48FCBA91 
X-CRM114-Status: UNSURE (   7.78  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-15 at 10:05:10 UTC, Yogesh Narayan Gaur wrote:
> - Add opcodes for octal I/O commands
>   * Read  : 1-1-8 and 1-8-8 protocol
>   * Write : 1-1-8 and 1-8-8 protocol
>   * opcodes for 4-byte address mode command
> 
> - Entry of macros in _convert_3to4_xxx function
> 
> - Add flag SPI_NOR_OCTAL_READ specifying flash support octal read
>   commands. This flag is required for flashes which didn't provides
>   support for auto detection of Octal mode capabilities i.e. not
>   seems to support newer JESD216C standard.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
