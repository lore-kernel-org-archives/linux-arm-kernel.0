Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24187C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:34:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61EE2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K9V0SBM7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGQowJnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61EE2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TKlAwszfZwDhaQvjda/IArGEroJs0TEeFCthzfNPuZM=; b=K9V0SBM75UBFz2
	/huK/b5WYdi3UrGVtbc7SJnBmTGax9JUk8rU0jNOzn4ItUnNmzqEennKGLisgiu8Rd/Nr+T+OCjqS
	VzecEDltCbGYx8K8u4A0fDCIYkK+lZbJYDWZ8vmhWng2amp0LQQUC/05hSwo9HkjVG/BeF/YaeB/0
	x8MI+cRma0BS1vnGD4fwnB8kPAnQfdexRHH5b3pQUr0YFURTOZpE6GKhzO2wENCx54pfeJxNYVHNQ
	rDjgSraM9F4DaLPUV3PnWSi17/ujvIUXkTvmrTuKEnMotWnevsMhEo826nSLyk9WJIteVy5vkx2p0
	WIgQnqJ3MqOeZeqP4c0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldT7-0002Rn-Qc; Mon, 21 Jan 2019 17:34:41 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldT4-0002RV-Fi
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:34:39 +0000
Received: by mail-oi1-x244.google.com with SMTP id u18so15137787oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rjoyojN1CWp5cs3bNupWm/44xBxSSsGxb9jFhWCudQg=;
 b=QGQowJnCQwxrCvR3A2oQV8CJet/N6Ic/uwXdQ8YK/7ds30992qmqxJy2mamNZRL1tj
 HxCgjKGY4nHCcBWbKEQ8rowOtNLImumRc3kbMtHRvYSCZcCORvvyDttu1NSPDAKVgmzX
 KUXVhKnfs2RIj6M3iUc2rFbtEnmWdDdQ9EwFJTTdE+xF7Bo/sg9xB7ga9J39IMCtaOup
 X/xD8sYv3CDUlA3GFR6LRIbXMaCJht2s+yGN3mOK7jr5DRa9jIrLUG9ZyaBF9OB8s6o8
 Za0a3n0HQEIK6no+HljBTv3+aFROBlqXIhsec/vvaliSCfHRQmHgrlGDOGBHk11X0vkK
 I65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rjoyojN1CWp5cs3bNupWm/44xBxSSsGxb9jFhWCudQg=;
 b=h2mbgLZ6uZlMy4W1i8o47QQIdbweuBBMniEnNTgeLFi+j+3iD706U4prWEQXbp4HzE
 Q6E0xoZsJbwqbQJ4mOcvLxJ+CIdPZrolFk7rK+SFCytzaTX2TuMxop/5fQ60cklcMY0s
 qb/VC+R/alCuWn4vf3SmIgTKXzHG6U6XZ1joknbRUZarq2SmCRU5w96OD+3orWNPmUVU
 0XqH0m8d8avk7+SyPWpMcmx+h+Bnk9DVB341lNG4ATUKsoo17RCC6n+aff5zo7elS7pj
 CmJQzSSZ/eIO0gFVhpSxu5lLYKM3Wbyai5NTrQt/xT7yW+fK62louLUZDT6OIoOATcnJ
 ueDg==
X-Gm-Message-State: AJcUukfrTRA+vH58ZO3UfskEFNi5FKkDJIWqLymtZJV+Xy0qRLx/Gp29
 OLayFlD6YZmZKMMMIahodTlTaahnucF0iz5zCpk=
X-Google-Smtp-Source: ALg8bN4EhXhKwYQrwMEM0tBrNj+PGieo89CvzXFOoT/qAe/0vhZZctP2HWSo4FQ7TeK3qIXLSmMGggyfyOskTpC/TiM=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr6449639oig.266.1548092077721; 
 Mon, 21 Jan 2019 09:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <VI1PR0402MB3357FAB48888D99A809F41AEF99F0@VI1PR0402MB3357.eurprd04.prod.outlook.com>
 <AM6PR04MB51581FBD4D21FEFDCAC2B27FE39F0@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
 <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
 <1548091897.2465.10.camel@pengutronix.de>
In-Reply-To: <1548091897.2465.10.camel@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Jan 2019 15:34:32 -0200
Message-ID: <CAOMZO5D3E_pBOXoZXNMiFMofpx4eCU80iWjcXcCQ3cAKsXxEjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_093438_532586_79E616E0 
X-CRM114-Status: UNSURE (   7.21  )
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lucas,

On Mon, Jan 21, 2019 at 3:31 PM Lucas Stach <l.stach@pengutronix.de> wrote:

> If you look closely that's exactly the patch 2/2 from this series.

Oh, that's true :-)

After your patch gets applied I will also make the mx8m pinctrl driver
to be selected.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
