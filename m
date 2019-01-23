Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35151C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0502B20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T1Pbg6Vu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWbyEfTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0502B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=inoGuTQROl1dxIxH9zEYImoJTbKw8qxBEsvUAcV/5Ic=; b=T1Pbg6VuRDhhf2
	UrQQ4EwRxATXmOBqN+WCNjtvcMKljR7qQ81naVcnuk56Y4w1q1bcY5R3aXuf8qSmg9A0hVF5vwA5c
	1kfvr0v8UC0u9w1XIR9n1PRemTxBs4NdFCMTTnb4uF+Hq00VrDwGRCVZ0/LPvYwQKmr3l9kAngTrL
	WidhUMLIhPXMdZiMxZriGP9e8eFyRFg8puxS2afI3n1CTsVLt0FJ++5e5I0DRX7pYk8o6a7Ba84rF
	g4i45Kn8x1X8UBOZYE8t2sDGkIJYc7WR0DgA4zMqpO+f5o/1tNNgCLJ+2dhtEuAa+Aaj30ShMdSAq
	QjNfHbTPMswLdsEjH5TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmHHQ-0002Mg-6w; Wed, 23 Jan 2019 12:05:16 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmHHN-0002MN-Lz
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 12:05:14 +0000
Received: by mail-ot1-x344.google.com with SMTP id u16so1660816otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 04:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s9TwJ1j5yEdIFN1A7rT9eyqiW4pldLuvYW0t8/NNdAo=;
 b=YWbyEfTih1s0Fl0lYFJFoH/ijsMJ0+UcS9pImgtlgYIRaUPD33vKhytk7SYD5cMgN5
 AqkOZBIsMXdmqtg3o+KAZFgqFaJfPQpYrXARcQPLA6EPrtbO8ku8cnRJ/669SRLEFpQM
 V3SUcMkIQoF0j3vAh5/epfTBi5ZSSCMYoTiuSwFA1HUrLciKA/8CvN3vKLm2d0/DCb/R
 Qy6MimNPS79rqdzbbC5gIldJIozMpBNXd+kojDWHNECRPINmx83KWp9oZDXHQb3k1KDN
 9RO+zukX+NUxap/odvokJI4BDJtq2uWLR+ZmfGLSM8il9iX58bMnXFRAwuYyjQKPXe4w
 4sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s9TwJ1j5yEdIFN1A7rT9eyqiW4pldLuvYW0t8/NNdAo=;
 b=LfH69XaHRimeiNjrCVUK/9NOCa85zxa6976Hm2ImTTELZCTsceoWbcFdXgBfuoLBMO
 KzsJVEpjk5UHgclAye6pupCb4svsKE+q6Nnucd6he4gnJONz5zItjhei+z76s10jtlhO
 zRhvE0UQoFceBWz/Sso5TJVAAGlkklcktDspuh04agCzxQldpc1xd7xd0D7fJF4VCop2
 5qtGG5xF8e225H6khE5XlJcrLnVy+zz3GyS9C/6/Ld7s+R8C7TUlu0sOBOgdKBFgr0yk
 4kH/0B0F5j93BpqkRv4EHm3D3X0h/6+6b1a20vdVXGriv8+JtNmmJQX2xhlER1wJQs6G
 yCXA==
X-Gm-Message-State: AJcUukdTn59Tf1+toaPTLzpgpwKerAcapt+19rf+koL/2wLNXfTQ8jJ8
 LOE2ARcyePP9GwxX4M6kDb2KVB9+WZmqmMJjJnE=
X-Google-Smtp-Source: ALg8bN5I/iLqRsN3OrLpP0ETcUXnmageQmFJf5kHhHo9uoVbU0a7eGuADpnjcXNqunKxS/cGmzhqwul8NboXIfss5SY=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr1323530otj.228.1548245111137; 
 Wed, 23 Jan 2019 04:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20190122164958.30666-1-aford173@gmail.com>
In-Reply-To: <20190122164958.30666-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Jan 2019 10:05:07 -0200
Message-ID: <CAOMZO5DvotRNhzeDEhz_jPVBmme8ozJ80KhjLH7mBGBd-K3BFg@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
To: Adam Ford <aford173@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_040513_749015_B20F71BF 
X-CRM114-Status: UNSURE (   9.49  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Adam,

On Tue, Jan 22, 2019 at 2:50 PM Adam Ford <aford173@gmail.com> wrote:

> +       tmp102@4a {

temperature-sensor@4a

> +               compatible = "ti,tmp102";
> +               reg = <0x4a>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_tempsense>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       tmp102@49 {

temperature-sensor@49

> +               compatible = "ti,tmp102";
> +               reg = <0x49>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       at24@51 {

eeprom@51

> +               compatible = "atmel,24c64";
> +               pagesize = <32>;
> +               read-only;      /* Manufacturing EEPROM programmed at factory */
> +               reg = <0x51>;
> +       };
> +
> +       at24@52 {

eeprom@52

With these changes you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
