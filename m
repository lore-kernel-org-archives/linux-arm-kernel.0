Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61248C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:06:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7C4217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V6Gg18TI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEP7BjWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7C4217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=anzQqfONDttVfTVdv+eln0R/Hl+JRF423q9URVw7Lpg=; b=V6Gg18TI19uXKA
	LcHVGBykWzNmCGao9YIhbsXJrYxRGYGqjAtsZHGwhjzULpeUNtZtNtkTqVLCQ2oQ2DBcGcRemTGpy
	tKTJopEKh0y1FpthK52icilqiNI3sZrxTMY9DPdY6pLn3gT/F0YxCOD/seaZbGU5UhYuI+Ojml2rv
	E993Mqsq7v1s+eCxhb0rzS/T27YBEhiUgZXEkVBVav39EftaUgsITkoPQTzytQOC/dDwHxSG2INWA
	TejfuqpwlrsdvMZaJt3GTaS0u/BdnU+MEII0m88sFlS/WFbYsSEL6i7sw2HV01G53in43neemju30
	9NKYU3l+OI1oTxgLYsrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbCp1-0003XC-N8; Sun, 23 Dec 2018 23:06:11 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbCoy-0003WX-AA
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 23:06:09 +0000
Received: by mail-oi1-x243.google.com with SMTP id r62so8969771oie.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 23 Dec 2018 15:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wu7S+WM0YPmdL8lvpWnbeMNCbKbfah1/LJOFQFMwzho=;
 b=rEP7BjWUVpvLhTpRVl/sV0FFstNOXwpXz/ab8QRH8Pncl8VsOMcTBMPuhF7Lim7l/8
 UhYTczzlE+T1jogqjZGV0rLnJN9+qZfpbqgPBKqhddzTLkFOgBZIcHGGneub9kJn2WDW
 +fwU4uDdkD5CGTUBNqMfLG1+oYXSI9aBhqoL46usP1Cd4K3meM1nzzsBKAPR+mSyPqGT
 i80S/CRAfkVP7brIlNaIRAbrkHausuPDsSxa84wsgW3xbUo+j8baQyqLALu2wxC6MuaH
 u+V7wRD8cmRHQ02Kc+jZVXquOFh9M1W4WUy/itXzXz7vuYPU1CZfUbnyaU4RneGza2K1
 zKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wu7S+WM0YPmdL8lvpWnbeMNCbKbfah1/LJOFQFMwzho=;
 b=S4UL1sztzBbig/tSam5IQCsfby3Mn5j8+NgcmJksoFdL++O4VDKJPbS0PeYF1+zX/E
 ThFjFhjQgEukmzmHtgoi3tJJhkWtJIR4UnggvwsiWy9Ai3nQ2N5E8MCkmbvxHhp93nwh
 GPHekyYX4yj3+CiUj5U8oldBqrdv4V00kJ/ND5KUKPmWjL/4F7LEkljzARTysKhgeq8e
 fbBydhpSRj2aa8fEf4Q+5wUD0pLjRGZb0J41FkvH44vXncomti9lPXYO8eL7n0PSxcgu
 m+h5bsa0qlwBKJlzzKF4l3+cnVTqwl25b98KwdUo7zMXp/tM/5yvldbmkrmqBNMWYagb
 cI4Q==
X-Gm-Message-State: AA+aEWZCsiq99m7JP2jgjwB9WHgeq8ZkwhXRHZWykuEMMw9geja8w1Da
 1Ypro8vTG7AgWBM8oatYFSv1ZZYCQvomMcagi/M=
X-Google-Smtp-Source: ALg8bN7vKcFgBrAFROt91cywyCoqOF+7X+qpAknGMTrTTcMl3YKFOwf+w0SGHICkCNKvSzWXCfi4t9GiJOmDnaT86Bc=
X-Received: by 2002:aca:3092:: with SMTP id w140mr6960076oiw.237.1545606356899; 
 Sun, 23 Dec 2018 15:05:56 -0800 (PST)
MIME-Version: 1.0
References: <1545581665-15446-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545581665-15446-1-git-send-email-aisheng.dong@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 23 Dec 2018 21:05:59 -0200
Message-ID: <CAOMZO5A9kL=seU5+tc5sobwNuAL4JHm_7n=Kf7-zon2FjyBGSQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] clk: imx8qxp: make the name of clock ID generic
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_150608_379745_D5385F95 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 2:20 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
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

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
