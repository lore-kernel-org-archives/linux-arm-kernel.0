Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA1C282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:33:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E08520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aWmNuGZa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV9jlAn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E08520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vxj18aW5nT7tqZIe+sf5YiwMnGumzSemC8AmhLoCGsM=; b=aWmNuGZagshuKw
	QfQsvmjxXcwBCyxAyRlpsOe3uCp/nduyfnyMdRbKr2K1q02hPfmy7fx1i41Wi34wJxcCl0ZqJDeYr
	0XiQ70KNKKPJ4UD8Wj832LhMsr8bs6Lt9WddbDsMsfrQ1BroBYynLSm2RJOc/A80bnpFmZXHORlyF
	rn/RE3gPuaGN1gmcwc88uklAOeJ3uXJadZUHDuroXlbm7U51A87JUozkIKFZmWXadTsxeiZ/4sgFb
	o5p3ncQcR0fRnk9r48twbG0AhPQOoNlW2SPSv7p2lVoO+4M4iZq30U4zxfhZBCFdp6yXj+TA/oAUy
	+u3JrKxOsotx602SINmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWtj-0001gy-8o; Mon, 21 Jan 2019 10:33:43 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWte-0001dP-Pp
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:33:40 +0000
Received: by mail-ot1-x341.google.com with SMTP id s13so20131165otq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 02:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MdEhnWJkCHWRNmblm2LB3908LN3Tl4HvTULto94/Z4A=;
 b=qV9jlAn8duyMT4YMfujODNu0NCHXuvvt4xRPRUqYnkVug+Nmx4nr525SFhFmkLajOX
 U8DtskhtzfHs+svP35gcd/ul50GrPsk9cP+zsdq0/aYLAalxcudvx2So8LG1xGj7LMhF
 8oqiB7ja81fIEKPHLf2EmMoJRCfKQkfq6BIopeVPwQplCPMzhLmn4ucxAsLHjVs6Ny9x
 khE/gXylNXcAr5UKXNQBg0xmnoOsUYy1aFmLV3EtObSRlnyo6PoJ2mQale5rI9u5/amK
 KjgP5nOP2JbN0mgysMWrp+AfLZs/cR2WAHD4IfET+hp6FESPZUVmZt2MrTllpYMqvuIU
 MDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MdEhnWJkCHWRNmblm2LB3908LN3Tl4HvTULto94/Z4A=;
 b=mD3acfWjlGDvCcFHvbScMGWY3xVym96XeqOiIXo8gt1MGcD38glQN7yHnyb/tJivgG
 SUOs3UG2ZH6Rne7WOQsFhYIGGTG4jj1QRzQQkVmofmAR1I7TRfEdcRNuStuCQ4SSnsvC
 HVsoXg4xvpdAKQnfmVxAEbAnc3x8hKqHVK2NPtsunGy7eCb6KtO3YPIIFv/+ytW+qvug
 UQsz+UD5USSTA/uRMxcFyJwyWfalO+VE6bNNq1Usn8PKbi28R6VHIleaAO3XGcnjfRes
 fJLQ6rz4HG4MgEUm6CALe3e9ilkiBMxczCB4Og+f8JZv0DNxO9oOrNOUDdWrcUnB8SYK
 hSqw==
X-Gm-Message-State: AJcUuke8xrnUIl2wC54u45odCbAGGAHszEETCx7hSatA5ioepLzgKobX
 2k74mRL/gikGUrBCXuLJFUnercvCEjjrmFjAXqY=
X-Google-Smtp-Source: ALg8bN7WdAzUCUMd2hhS2kKW1WSYdT5D+150b4ozxU224ZZBm8H+z4Wlj9Q7gTOs/Pc4JM9lGEVGWjdcNFrgzuejO3c=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr18558997otl.196.1548066817545; 
 Mon, 21 Jan 2019 02:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20190121095705.27452-1-martyn.welch@collabora.com>
 <20190121095705.27452-2-martyn.welch@collabora.com>
In-Reply-To: <20190121095705.27452-2-martyn.welch@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Jan 2019 08:33:31 -0200
Message-ID: <CAOMZO5ADc2-U3AR0eepf619qD1i6-oGrn8p1yb0m3HfWtTPscQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6: Add support for Phytec phyBOARD
 i.MX6UL Segin
To: Martyn Welch <martyn.welch@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_023338_889750_5E9C4F83 
X-CRM114-Status: GOOD (  11.12  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 =?UTF-8?Q?Stefan_Riedm=C3=BCller?= <s.riedmueller@phytec.de>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Christian Hemp <c.hemp@phytec.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 7:57 AM Martyn Welch <martyn.welch@collabora.com> wrote:
>
> The Phytec phyBOARD Segin is i.MX6 based SBC, available with either an
> i.MX6UL or i.MX6ULL SOM and various add-on boards.
>
> The following adds support for the "Full Featured" version of the Segin,
> which is provided with the i.MX6UL SOM and the PEB-EVAL-01 evaluation
> module.
>
> Its hardware specifications are:
>
>  * 512MB DDR3 memory
>  * 512MB NAND flash
>  * Dual 10/100 Ethernet
>  * USB Host and USB OTG
>  * RS232
>  * MicroSD external storage
>  * Audio, RS232, I2C, SPI, CAN headers
>  * Further I/O options via A/V and Expansion headers
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
