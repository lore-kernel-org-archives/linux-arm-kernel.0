Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CD2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:55:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9D9214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WZFG1HCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9D9214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQi2BgPqa9V56CBMvG6lCIWEwLWTveqD4frxFZmadyE=; b=WZFG1HCgJe9KVm
	kwqghAl3zFG3gAR879oJXhbkLqFrPtP6Oqpoxib4NXyT2hdE8t2MlkwILo9H2ojJ1GAF4ftnh5xQC
	VSHEPPsh9AEz+IwabG/8VIh5sJ928T2rEVLbDlWfM97O2716m8luUK50AnKuc9cSHcU+7loVEXMPs
	Jt2Asyt44GoZZlQP2vxfKDA/FU6kGOIGbVwI7XvYakPcr/O+LM4ILAqPbyTvMpy6TuF+4fl0eS4B3
	erxMKyoSQUGSc6jJtksXtjoiz5RgisotEflcTacJieakxGxeCFdjkOpTaaZqRecsmRje6kSaTXMrT
	jNo3OaUm6VKLZIwLI0Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcdcP-0003ZL-Gf; Thu, 27 Dec 2018 21:55:05 +0000
Received: from mail-io1-f68.google.com ([209.85.166.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcdcL-00038x-7y
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 21:55:03 +0000
Received: by mail-io1-f68.google.com with SMTP id t24so15528503ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 13:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qVKjW1jPignFC6PDbZudzDYlcK9KOJ0D+lc5t1OhGkk=;
 b=rqOTdivyO4MEXon623zWOHvePmHhUtfdLUzMJ61nzpqsFv9D/a5R7wG52JIbHU9uVg
 b9sz8W8ZWRPQ83B/C27xjEe0umrsnMbP8Nx1calq7fsbMzZI34Wa8nuS1aqQCTCUiFHR
 mutFNAxPGqispe4JBtDANAAkiuukyFwyQyZsJAo8PLJLZ0Mf2qspbzWBbVGSHgA8nRgh
 OWWCLuqpmkcGoB5aTPk5IPrNGQaLWK655ZhJU0P0czB/bz7cQ0o0kEx2LCmDYUy0y9Nr
 4fXVB40QoXyGJCCW9lFGA2Vj69IstT6fScomtBQdu4tpBjn4lgNG27Z6BcQ7lEdCDAtJ
 Y8zg==
X-Gm-Message-State: AJcUukdItmVFPwZhBD4Gst4jyE45c31U1OpSIZxohTxoqeg45IVz0UP3
 FgO1ZXhV4vvwNxX+Kx7wJw==
X-Google-Smtp-Source: ALg8bN49OFGnMLTGDjsDK+EoPFZBSNCvPAEs+X6v6LWm5j66PJz3T9YclANLW4lO9+T2Gv19Mxbs/w==
X-Received: by 2002:a6b:c386:: with SMTP id
 t128mr17449483iof.304.1545947690494; 
 Thu, 27 Dec 2018 13:54:50 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id s4sm6546133iom.83.2018.12.27.13.54.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Dec 2018 13:54:49 -0800 (PST)
Date: Thu, 27 Dec 2018 15:54:47 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V2 1/1] clk: imx8qxp: make the name of clock ID generic
Message-ID: <20181227215447.GA12514@bogus>
References: <1545581665-15446-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545581665-15446-1-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_135501_366375_54A12F89 
X-CRM114-Status: GOOD (  18.17  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 23 Dec 2018 16:20:02 +0000, Aisheng Dong wrote:
> SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> Let's make the name of clock ID generic to allow other SoCs to reuse
> the common part.
> 
> This patch only changes the clock id name and file name, so no
> functional change.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> According to Stephen's suggestion[1], resend the needed changes
> for 4.21 separately, then we can pick it up and send it as part
> of a follow-on fixes PR during the merge window next week.
> As there's still no users in kernel and the plan is also to avoid
> any using of it, so please help review at an early time.
> v1->v2:
>  * resend Patch [4/5] which needs to change for v4.21.
>  * update headfile name accordingly
> [1] https://patchwork.kernel.org/patch/10737463/
> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c        | 148 +++++++--------
>  drivers/clk/imx/clk-imx8qxp.c             | 154 ++++++++--------
>  include/dt-bindings/clock/imx8-clock.h    | 289 ++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/imx8qxp-clock.h | 289 ------------------------------
>  4 files changed, 440 insertions(+), 440 deletions(-)
>  create mode 100644 include/dt-bindings/clock/imx8-clock.h
>  delete mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
