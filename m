Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6F92177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PeFrQgLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6F92177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NB2U9r+lROqLK/tuORI6iBxoiHrNIQllvJT2prNQhQc=; b=PeFrQgLlmxKTHe
	pQysfJcowIhkPwPRPVJ1o9QkqJiVQP9rtnCiRS4unrizNChTeDAHJ9ng+4y2cYg26Ceqxhr1Idex9
	GjKQuDeK4nAkUCae665zEd1eRXXF46zbP/0oOl7ogdBtVulAIthcmGLNWM4fFhL04mbhG6J1tJl3j
	ydTNEWiGKDpT7tbE6zhOe35+F5vaJkDfHb6vz87hCPvFOu1U2FAPGQUz3GehG53h7e1yX1f/1uDOx
	I9J2kKozbYH+S+GY23M1bjPNMbi5XV+bvojxMcwrV/82YcijYufKXHW/pjm1bsd5uv14K5uc7cvxQ
	qYBkFfButvgCZJHsYX6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtkl-0008N0-2y; Fri, 11 Jan 2019 10:09:27 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtkf-0008M4-PP; Fri, 11 Jan 2019 10:09:23 +0000
Received: by mail-wr1-f68.google.com with SMTP id s12so14550052wrt.4;
 Fri, 11 Jan 2019 02:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8Cm8N29ZZkzJ+aKri/826wyw0qgzRNXjm7btz3NeNmg=;
 b=pS5BGE8fupknsd/NFIOYzItDZzav/aEsCD2iWXfbJMYdec+9IREbeHT7+D/GQTG9Dr
 pQoecCOCFUBirPw429H/R2BTexWbICnue8g3DLwV76mJQbDX1NSOzdkraZ5WafZPrMYz
 72YxambHpfU1uK+ZB0TXU2rgoqnlwEDProLmLwwF8DLwhEovfwA0i8mXFF/FEYDM+Dmi
 g1wULRPDcbdI2B6aV62wVHsjG7B/JX0nxtBW71mi7SIy4q4Lnrj3rj3r6tBXpcr9Mcaf
 zrsJNqRas6AYTZbCkOLO3GEsdXRvYZIslphlwX1YFP/i1bxNkHgVgky71NAM1QDitk3M
 pJCg==
X-Gm-Message-State: AJcUukf1SmtAcYLWtCaah8o/KkRkE8JB63iwT7xj7KvZGAX7To7LjgIF
 AYNBCZRTJy8F2cwFe3srrpc=
X-Google-Smtp-Source: ALg8bN6AB6zkuRUT+PP+3FWuMC+fPfh7qIn6BzfbzwCKgjTlffKWlLwG1wHbRoeVKPqGugCz7zH1ng==
X-Received: by 2002:adf:e247:: with SMTP id n7mr12149671wri.205.1547201358361; 
 Fri, 11 Jan 2019 02:09:18 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id k15sm98544710wru.8.2019.01.11.02.09.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 02:09:17 -0800 (PST)
Date: Fri, 11 Jan 2019 11:09:15 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 1/2] pinctrl: meson: meson8b: add the eth_rxd2 and
 eth_rxd3 pins
Message-ID: <20190111100915.GA1716@ingrassia.epigenesys.com>
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-2-martin.blumenstingl@googlemail.com>
 <7hzhs8ovag.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7hzhs8ovag.fsf@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_020922_353485_1925C9ED 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: linux-arm-kernel@lists.infradead.org, jianxin.pan@amlogic.com,
 linus.luessing@c0d3.blue
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

sorry to bother you.

On Thu, Jan 10, 2019 at 05:08:39PM -0800, Kevin Hilman wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Gigabit Ethernet requires the Ethernet TXD0..3 and RXD0..3 data lines.
> > Add the missing eth_rxd2 and eth_rxd3 definitions so we don't have to
> > rely on the bootloader to set them up correctly.
> >
> > The vendor u-boot sources for Odroid-C1 use the following Ethernet
> > pinmux configuration:
> >   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_6, 0x3f4f);
> >   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_7, 0xf00000);
> > This translates to the following pin groups in the mainline kernel:
> > - register 6 bit  0: eth_rxd1 (DIF_0_P)
> > - register 6 bit  1: eth_rxd0 (DIF_0_N)
> > - register 6 bit  2: eth_rx_dv (DIF_1_P)
> > - register 6 bit  3: eth_rx_clk (DIF_1_N)
> > - register 6 bit  6: eth_tx_en (DIF_3_P)
> > - register 6 bit  8: eth_ref_clk (DIF_3_N)
> > - register 6 bit  9: eth_mdc (DIF_4_P)
> > - register 6 bit 10: eth_mdio_en (DIF_4_N)
> > - register 6 bit 11: eth_tx_clk (GPIOH_9)
> > - register 6 bit 12: eth_txd2 (GPIOH_8)
> > - register 6 bit 13: eth_txd3 (GPIOH_7)
> > - register 7 bit 20: eth_txd0_0 (GPIOH_6)
> > - register 7 bit 21: eth_txd1_0 (GPIOH_5)
> > - register 7 bit 22: eth_rxd3 (DIF_2_P)
> > - register 7 bit 23: eth_rxd2 (DIF_2_N)
> >
> > All functions except eth_rxd2 and eth_rxd3 are already supported by the
> > pinctrl-meson8b driver.
> >
> > Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>

For both patches of this series I gave:
Tested-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Reviewed-by: Emiliano Ingrassia <ingrassia@epigenesys.com>

They were in the answer to the cover letter of this series.
I note that they were not included in the commit message of the first patch.

Did I miss something or did something wrong?
Please, let me know.

Thank you,

Emiliano

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
