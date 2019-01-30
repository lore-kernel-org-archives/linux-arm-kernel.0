Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C38C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:25:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED0D2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZoiMM5n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5/HHtNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED0D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=202IZ/chYJND8fDInV5LVJCcriJ8ZLpGKEnCjMUyUxQ=; b=rZoiMM5nbG+2W5
	keKgY7M4cUbBWZZV5Kge34gZKZwPF3b4SDdfFHL5QE1e51VQ7Qv2SIgMs0Dnz7Qo3+1TrybiuIN4b
	Gj+eWUPcfnAhyEs3QSaWgz+W83GCOyyhCVWBdvYeVUxBUTt5AygFDkayXHK9r0s3b5i/wIFTx9TEZ
	5yVbeXiLRGlzvQdLjmmPVZChdlqLtc7zQJkFr8HI8b4vXRlS1UydjGFmJXaurCF3pdjJ6h2uZ1QpE
	9toduXTjoVCrE8ELC3tF7gv2PvsJMk52RoFZ1csP1Rg4yHllOAi6CS0Hm9cVLrIyU1SQh16UjLuUg
	ig9Cn2DyODc/IsLFXt8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govUG-0006cK-9E; Wed, 30 Jan 2019 19:25:28 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govUA-0006Eo-73
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:25:26 +0000
Received: by mail-ot1-x341.google.com with SMTP id w25so581928otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=96iiPDeok9K2rv1DwVnwRtdc0wG4e/rAGRRYcQqK5Ac=;
 b=J5/HHtNY47RUOQXxZwnK8gYtocwCYICO1QbeGqQg5ibWXX+dm2rHgjTVnPeqrk//ZN
 qRWd4t0C/Vvjnx9vdkui1zLeHWDonmx24dRSLhfQJ/cscD1CjTvAJlTQ/CED5dTLmjcM
 79jOjJrt7x8k/FYlHSHX0FC1FgSZOQDY6a/XbYJCpyHX94NFQuhCaUq+w7OEglTewnO3
 g4+2Dqp46hdr0qT69xmXjyGFf5VMjT627bi7nrISxDRJipEvy/QkvpZTWF2OivP6sB4H
 UC+wihIEAaovfQhEZTeeY6QFKweAn0w5nxHWtVFwV9Z/r9ixIAeXI1u7TJAoSno7M3AT
 uqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=96iiPDeok9K2rv1DwVnwRtdc0wG4e/rAGRRYcQqK5Ac=;
 b=CH7neSQz7UHSjRZqqcugU2+y+/MzQy2ZL/Rv1L0Uqb0HU3VEkaDk9wTkOqayHY57EK
 7Ze4pNW0S+dJuqNomxXZf4sPOKKvhrGovD2RjyuVBEEeGykWdAI8h1dWshu+8SKB2rNZ
 +DJZSroEdkS64AoOyhJ6xvLdbmdnf7KoVFEm17oMepg+h5MBDAuKT/pffP6I7yg/4Vni
 c3ekpOPGM2hIqE0JHlnAAHYhkWeahcvG+KnLR7ymzNYoUrjaR8iHqfopmAaeSjlHFXfO
 fF0TE03D3zMbj7nHSDwSkv2fALDzlyj9H5veYruSViGtiNmusfeFc0hCYnzxpBPCjR7S
 XNRg==
X-Gm-Message-State: AHQUAuYYJwS2D/D3rcbV0Oqsh6dqMz/X+Hm7+KGmla/u0MWBKQP7p3rN
 SJLftOVMZE9x3OPbcTpcRcjqLggahupWU75v/mTkiwYTuHw=
X-Google-Smtp-Source: AHgI3IZX+KD+Of+PLERmkx5jDHY1OQ/2dvoI8d8ivGkeBALDK2V01iRDmwjBNF2gPPme0GVwUSwOY30BCf8tVfOvYk8=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr1653970otp.225.1548876320925; 
 Wed, 30 Jan 2019 11:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20190130120511.11555-1-ccaione@baylibre.com>
 <20190130120511.11555-3-ccaione@baylibre.com>
In-Reply-To: <20190130120511.11555-3-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jan 2019 17:25:09 -0200
Message-ID: <CAOMZO5D_WyGCiGgBFkP3hvGHX-66o1wEGKkxCKwknVPCuvgS4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: imx8mq-evk: Enable the QuadSPI
 controller
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_112522_355468_0FE58A05 
X-CRM114-Status: UNSURE (   9.16  )
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
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:05 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Enable the Freescale/NXP QuadSPI controller with a proper pinctrl set on
> the i.MX8MQ EVK board.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
