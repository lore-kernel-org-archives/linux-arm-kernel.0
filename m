Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F14C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDCA20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iiLQ1xBy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AavGdixL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDCA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvrbWNX4f5FD3p2hEsUERLA3hKay9vmdMaekZYvm6II=; b=iiLQ1xByPJQbv7
	e06cxGF+CYu4Nn2Fvv6TuHU/WmwDf2i4bqVK6VIktSCbjsi2I+lHAoHNYZVGsuXa5a0No/H85MuQp
	yPESjWU/ZJ4FcaBcMS69z06Y2jtOHfcEWA8tzolSmnDOou4d4H3l5+Xu/wkdSkJFpo7S0SIJhAR0P
	COxBGfRla3cIlfFJhfrQf6aC9n2EPxPhUuVZJSb0DM3fbSZ1TpLdXVEwAKJ77ezi1e3XAlaWyUnNJ
	dLN8fypu7zvHt535zYTC4J+IpH0NLZ5328Ke7/M+m1CMzJsQZvqcf9LRY6Puki4rkWyAQgjhZo08c
	8upEWIw97tUiCQ0Hu0xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJyH-0004Nm-5q; Mon, 10 Dec 2018 11:43:33 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJyD-0004Kn-Vc
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:43:31 +0000
Received: by mail-ot1-x343.google.com with SMTP id f18so10041533otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wPimlCqLe/ATcnFyDRkUb5D8rBaCkM66+LNcTc3H/CI=;
 b=AavGdixL8RcRO52O8+anWBgohv79jAnzwY+AGCjOnPONyP1oB1wLMFrSiEJyMzef4R
 V+rlz0k98kZCRzkNm4tJqUvXT2D7QoeVwZ+naKi60Bhh+DA97cq0l3F8aYgJwHwb/Tf4
 owLLhP3ff5JIDIb4JGuz6R+z9WpMh2T0sWvyjHWy0nXu2vY8BjFeyE+XhhTdPwier+M6
 u2xn0rUl8mp6FS1np9LBD3cSy0amJ7V3M+53f2enkw2ByOqS/Kqb5lvM/TZM7Z+d4EhO
 aN9F6aHTzcfhQXoduwHDawe1RT65xOVhBwAGc0ViGSGVsXqmcnVkr/Z+BJjApvabvN1D
 uOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wPimlCqLe/ATcnFyDRkUb5D8rBaCkM66+LNcTc3H/CI=;
 b=KMuSMKdcVuEyVazQph9XqNmsZSttGmIeOlwN1ep1w9grWCxIxd2NVf5bwPqONhqt8j
 ZGshdVIwNBf7F+mr2KGcJs9rigV5+eLu4DbOvyRguQGpIsELlME2NEKMCvsxhe1nnkUl
 zxg1efyGFFXt/YPlonyv9DHPka0+LzEOwFl6uERR0zdm6CXG5h1IP3Y97Tc7KuB+bXtD
 b8no3tMMBUo/e1rlGoTv6aXgXwPjb5JrBD8mShimS3h+tdroO5ddqEVO5OhblVc2LElH
 CCtu0q+0wM5lDoYnxw8ZbvRfpOotV3fH6U+F0aoUv9v2N3pClSEMDOmBbYkZ3kwAxCet
 k3ZQ==
X-Gm-Message-State: AA+aEWZkFMuwb6+JnLqxvYMQTWAdTpgHeT2RQELPG0TlDeGzB8aPlvG+
 Uz3blh6tzztQHvvuHzBULCODOnsI8LAzXHXeY7s=
X-Google-Smtp-Source: AFSGD/UX1SH0ddZVSPXTlznKA/cua093ZHnYcn+Kn0yEtfeU8ViYI1os/IJ4P3JELEajZIPc8lgtcyEvshyw6kyEnMs=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr8660297oty.203.1544442198477;
 Mon, 10 Dec 2018 03:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20181204110741.6943-1-hohatzel@jusst.de>
 <20181204110741.6943-5-hohatzel@jusst.de>
 <20181206031520.GE3987@dragon> <58a84012-73b8-1679-0c5b-981fd2a0acd6@jusst.de>
In-Reply-To: <58a84012-73b8-1679-0c5b-981fd2a0acd6@jusst.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 10 Dec 2018 09:43:12 -0200
Message-ID: <CAOMZO5At5oSv0MCpsuYj4nEd26Y4h9hj-shadq3477fNz8A+HA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: imx7d: sbc imx7: add uart5
To: hohatzel@jusst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_034330_017277_EBF2BAA2 
X-CRM114-Status: GOOD (  11.57  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, jscheel@jusst.de,
 NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Hans,

On Mon, Dec 10, 2018 at 8:52 AM Hans Ole Hatzel <hohatzel@jusst.de> wrote:

> imx7d-pico.dts does this the same way. Is that good enough of a reason?
> If so, should it be included in the commit message?

The UART clock parent initialization has been removed from the imx7d
clock driver since commit (in linux-next):

commit ea662d2f804ad13c3c92c75c7dc1abad30e31c31
Author: Anson Huang <anson.huang@nxp.com>
Date:   Fri Oct 19 01:05:36 2018 +0000

    clk: imx7d: remove UART1 clock setting

    There are clock assignments in all i.MX7D dtb files for UART1,
    below is the example in imx7d-sdb.dts, so setting UART1 clock
    in clock driver is NOT necessary, actually, module clocks setting
    should be done in module driver.

    &uart1 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_uart1>;
        assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
        assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
        status = "okay";
    };

    Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
    Signed-off-by: Stephen Boyd <sboyd@kernel.org>

So the UART clock parent should be set in the device tree.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
