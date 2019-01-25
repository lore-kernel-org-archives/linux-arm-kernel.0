Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC4C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:39:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AECF2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JB7nm1KJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBjHO7ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AECF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8MYEWjxqzsA68R/5acBRo3O0oSkzEKt8rTP3oUlQaE4=; b=JB7nm1KJT4X29n
	WsOUCowVeG11wQHltlrVg2ULTm2LtZioKvvnjSa/SRNY1+FyUQE80GHHpK5YP2t79b2x6AiPAFyx0
	QGH7ubvAunyGUwdYd3M6gaLNzXMiJWpNG8/6A5eyiBmiR3n2NMjOYP+LVEdYVp9IWa0KavX/Va7xm
	okdEQt3eaEZPMQykG7Ahgd2RnEFiU3m04CFK7yFCaCPygPxykmTbTs9qpaho6XDkyT/hQna5m8W/z
	/dBMOdZlebMh9D+58Mq0Z74XVO7izRjvPOv6n2HQZCWneAqQl7+wMCV3Pt34gzy4RXLZqP/uK9nFh
	Vq7r7fk9uuaftlx8YMgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0lv-0007AD-Hk; Fri, 25 Jan 2019 12:39:47 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0lZ-0006x8-Os
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:39:44 +0000
Received: by mail-ot1-x342.google.com with SMTP id s5so8354386oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/D23tcREqTI59vVcjF8MzranSJDZ4MLQjWQtjXgDGUU=;
 b=NBjHO7ft3ZPqnKsHSTZN16KbS+edEmXMc2sKKbfMOV5AbwSrl+hru5KyHymGXQXNPe
 LHCnn/ht0N4p7q4EBwLT7KQFy5yyL6/ISJtJtqaeSCLchMcobI5Vr3HU7ElZDhFVBlN/
 /qRMXYmNgpbeOfpn/AZvmKFYZkq55vCRpHFRuFZ427eZs2R79qu8k412DQvUht/5CbCm
 W5UYzAoYxwLKZ8oWAi1NtXnYNqUa1nSAxycJ4WiiGuuOka2MRJxtP18sLQqXiPEsm3Ki
 WsJITKhi76VcID0ZW0L94+zaW13SCtxMsVQkfITQs6z+5AzbhlZrKdzK8rL8+zjTEAO/
 Re7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/D23tcREqTI59vVcjF8MzranSJDZ4MLQjWQtjXgDGUU=;
 b=LtIqr15iPuWbTqn3sNma0mFiHCHep8EiJmzEIdFeEyhzNTr1bBmv4SmkwtoRhnWSuh
 r44wLu9oDzdjbkaCMBQT/JVw6URzpxRQ/V+4GLOPbds9m6DobUrUHIe6kwnxJNYITKwR
 xdgURRLb2EBnUimIyLaueKp+O61hf+iTlWMTtiF7gRKJWCCF5GbYis9ouvCJvAbDsB5d
 vcfjaT/X94qs5XLZD1ckKEaN3tpDlmrb7blpJgIz/QhkVxyF+2KyVLong2bovCk+EwaU
 J1QHOaGhEHB24lTI/2A5yxlmtVvPGXcjcO56dVdfFkTJdc8AXw9ICa5qqWkRFSYkRr6o
 ZhFQ==
X-Gm-Message-State: AJcUukduTHldobscy37OW6dnFEup+JiXqY64CTtub39moMDaUPXv6MIC
 ojYbw1WqSCaOICE37c4IauO1KNODcLOybsCmG9M=
X-Google-Smtp-Source: ALg8bN4r8iDOO4MinRS4X3qM/mAagNOCNkTAejtIG3HbqhVrhsuTsD9f1SF+Kk1GiCTbk/VcdHdisT/+5Is4iq3up9o=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr8240215otp.225.1548419964577; 
 Fri, 25 Jan 2019 04:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20190122165546.11712-1-ccaione@baylibre.com>
In-Reply-To: <20190122165546.11712-1-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Jan 2019 10:39:23 -0200
Message-ID: <CAOMZO5CLdyP6ZHLqOrcDSq4CV3vjt1aYsesyCf7hb-8e0BuNvg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Fix boot from eMMC
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_043926_577119_E21CF706 
X-CRM114-Status: GOOD (  11.66  )
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
 abailon@baylibre.com, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

On Tue, Jan 22, 2019 at 2:57 PM Carlo Caione <ccaione@baylibre.com> wrote:
>
> The boot from eMMC is currently broken on the NXP i.MX8MQ EVK board.
> When trying to boot from eMMC it fails with:
>
> ...
> [    1.271938] mmc1: Tuning failed, falling back to fixed sampling clock
> [    1.287429] print_req_error: I/O error, dev mmcblk1, sector 1 flags 0
> [    1.306833] mmc1: Tuning failed, falling back to fixed sampling clock
> [    1.322325] print_req_error: I/O error, dev mmcblk1, sector 2 flags 0
> [    1.329559] Buffer I/O error on dev mmcblk1, logical block 0, async page read
> [    1.336714]  mmcblk1: unable to read partition table
> ...
>
> The problem is the result of a partial misconfiguration of the pins and
> the missing assigned clock rate.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Thanks for the fix.

It would be nice to add a Fixes tag so that it can reach 5.0-rc.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
