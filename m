Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:52:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384DF2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lpW7zGX8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajxlO0fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384DF2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZlZzOQYm4Xo+9MMPZpq8CCGrmK9yi7n66O8v7s+7VDQ=; b=lpW7zGX81FbazY
	r+6SvQkTbR/9DyUGNIBvt2r0Zn/a1RsGfqfQ2SlX0zhuq377gs60hhh4ysplgnbtmESrdyqCqI4TR
	pPRISVGXF+aI541LrxRPjhtbHly8B9Gw1iAf0rftEPBV2w09KQjkFoGw3MePG47z313hOs1M2NH+1
	yXLNQmkRTZSNPzEGj7sEj8pRwrBOPEuC5enEW/zsB0EckdKkoPy5H/cyAEun5hjHz6rREfIJ3u4jw
	VW7mQtncpIUovzM7g85p86LO5hEiCm57e5uX9t9/Y/DvsjBSQL0EA4ZJcyKofRlI/PCn/xVpI6kku
	5O7qEPRUvMXD7aD/DKow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPtu-00078A-6s; Fri, 04 Jan 2019 13:52:38 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPtr-00077L-FH
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:52:37 +0000
Received: by mail-ed1-x531.google.com with SMTP id o10so31794697edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2ep5TUwXKNyInpMcpvSVipIR0a+OfcdvALZkZTc4mwE=;
 b=ajxlO0finsb4JKhrTS/16ipmxAJaJbq7H5tRymJ1CD2iNw7JwiIhDwb+CHlnU6rhBi
 +bhcXpXPbogeCZGNt1I8gQibpoLWQWi6WaZZX610gKaEseOd5VYHifZ0EATND2DbrxdH
 gEMkcwHXI6gcwx5V7hjK75Uh8YjIigQHviTNN5je7t4ptl5pm8dTQULjbyqKI6JaiMZs
 9UvheNP+vaUpIWKSTzo9HHhIle5KlfmO5a5YD9dj0utw8R3BLh3oLUxbDoASgOevVufm
 S9oibCTj/48zgQ1D3V9y7GQNQtCSSQQvSYo9IF/KbZjUVjmvvZW+amU+ccPQrybzz2n1
 j37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2ep5TUwXKNyInpMcpvSVipIR0a+OfcdvALZkZTc4mwE=;
 b=j7vJOganrKmt8D+ssPcBYWE3aQuSeUh2yIdE28Zot2jEGne+c3aarllFcHPLNos0IX
 rJWF7azeWLnK7o6BVSGKXUCusVucafA5fS6zn+2zwesuRPB1PZsxoYE/mfj4H0xR+nXI
 q7eLEh5LuVx4hNBwIV0X9phszbfHrzjZErrF/zPm7aZWqxcTPBUGWoi96cb1ZxQPkLfl
 yjrkQX9mJ9jhWl9Mc8aeJ2mqyOPTwrELwzWzZcY5+DjfjuQLhj8iQ8wNrX/x0a3rFoZa
 O24c+l7GdmtIiZgGKhburgoca1gJT0TEuqwxLM5LR35bijhb90YCCvjKCpsNOvvo6DlX
 IjKA==
X-Gm-Message-State: AA+aEWZtsg+JGQvtPIwbncSt1qp0EWEifXrqa5c79k0oLTzM4FniYiDF
 TN0TYY5OWQCnBFUgD/fMQ7s=
X-Google-Smtp-Source: AFSGD/XzSA9+PFFHJ8Dkd+CEscRo+nzCnweJf4SjfcAAAk1c9oDdLmQRqNhuNjd+pEEpTMBeIsKd3A==
X-Received: by 2002:a17:906:b1b:: with SMTP id
 u27-v6mr38763863ejg.67.1546609952757; 
 Fri, 04 Jan 2019 05:52:32 -0800 (PST)
Received: from localhost (ip1f11350a.dynamic.kabel-deutschland.de.
 [31.17.53.10])
 by smtp.gmail.com with ESMTPSA id c30sm25186266edc.70.2019.01.04.05.52.31
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 05:52:31 -0800 (PST)
Date: Fri, 4 Jan 2019 14:52:31 +0100
From: Oliver Graute <oliver.graute@gmail.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCHv2] ARM: dts: Add support for Variscite DART-6UL board
Message-ID: <20190104135231.GB31930@ripley>
References: <1546608371-31472-1-git-send-email-oliver2000@gmx.net>
 <413a63ce-618e-4edc-ab1a-cd3071543a84@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <413a63ce-618e-4edc-ab1a-cd3071543a84@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_055235_535201_8E4D6377 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: s.hauer@pengutronix.de, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04/01/19, Neil Armstrong wrote:
> Hi Olivier,
> 
> On 04/01/2019 14:26, Oliver Graute wrote:
> > From: Oliver Graute <oliver.graute@gmail.com>
> > 
> > This patch adds support for the Variscite DART-6UL SoM
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> > ---
> > changes since PATCHv1:
> > 
> >  - reworked this patch according to Fabios comments
> > 
> >  Questions:
> > 
> >  - its unclear for me howto handle the LCD timings
> >  - unclear howto split things into base board and SoM the best way
> >  - do someone have the same Variscite base board with other SoM here?
> 
> Seems you missed my reply in your V1.

sry i'll take a look

> Please have a look how I added support for the iMX6QDL variant,
> separation betweem SoM and Board should be similar, the kits are very
> close.

thx for this hint, I take a look to imx6qdl-var-dart.dtsi

> PS: And please add a cover letter to your patchset next time !

ok

Best regards,

Oliver

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
