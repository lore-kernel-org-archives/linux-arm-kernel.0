Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:34:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E7821773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lhiJdeFP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxuWjM/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E7821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CAkYx3DzNBWHOLbRcqqlOvJHIW56nvMEVlY7ooGqKaw=; b=lhiJdeFPxJU/al
	HMPi8X7HEP3EfYqRMwzlUHG6VYFFVJ8DvAB8ZgNJGoNtO+M6kqNr/XwSYljkaLyk/dCPzrEenAwL1
	UZkfxrBngXBV61jLWfWDLfVLk0JGMX97xNGgx231epQiK3qZWl9HQi0loE0lUqeH3PMTyI7Wv9mwq
	q6Gmvc8j9sOOcd2RNkW4x4ToNcxT31Cod3/RlF84lvoVLKID6y+5IIdbJIUbwQnnipdW+qfPJX7ce
	8kRPJ96ZH6PrO4DekMe0ChXfpV2cz1RKr/N56zLP1o9ta/0WRjz8GCiqXu7U/VwRh8+uX1I5xMNFm
	SngmQYvMqDg2cpSDn2Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtJDo-0008Ez-9T; Mon, 11 Feb 2019 21:34:36 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtJDk-0008EZ-EP
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 21:34:33 +0000
Received: by mail-ot1-x343.google.com with SMTP id g1so658849otj.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 13:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QHCvldYD0BzLfpY4nxhOH+w+R+Gn3IuDB620WQL49ls=;
 b=AxuWjM/7pHcN0Rif+J9myATOkYNB6dH+89qIsVs2wJoWNyaUA42ZQUttMd1khzeifb
 K9v+qLMEBIduS3rNFuL0aaJ0YzcI8C8joWy/zGDaus2GQWG67sHd10bkgvdNCblzSRdQ
 ztHsTCZnuVw7rU01blHWIrZria1+agMFDgsUllpttPQudgj/9VMXbCKk0HKF6NnS79uL
 7VUjcSxu6ZbXs+xi/FixmIt7JhAsdRFbYalaFVf38iTevvmBe2y57xVAnpbiLsgJFF8f
 hoP1d6oZLZq3Sc9//mDfyAbvhd36xoSNBP4l8wemGm6LjsmYos3i9h21W9F7T+yqb0f3
 McGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QHCvldYD0BzLfpY4nxhOH+w+R+Gn3IuDB620WQL49ls=;
 b=aiibaV6/Pbg2jRVhWHSGXZLarUptWtsPeiFKbHvAYDNRPInZKxA8EbmG2HjHzMY2ok
 w6FraB0BS1bMQpVtCYn0HQ7gk7uL2Quy9Puelc0MLW2t2pSEWqwU+aQpAJ5KljGWW/kL
 hNcf/oJIIC4kwOOpcBxZz6E8L1v5843reHHPsHSGAxwmZzqfRxknqvfQsLOBhix8Mc1V
 WHq7h8FiJYSug+F5VmgohpUKYbi1y5tY1uzhl/T+EYOEIUokuSbIjWPLZWS9ji6KjS4q
 gg3sHUfMYEEtXePzAeo4EXpR6NbGgXyThBnpZ26ArXvDPVqfWKLv5NP3Sw0JimWvyaXA
 AawA==
X-Gm-Message-State: AHQUAua5IOqWvqUCO8Z4VXZhr/D8j2ZeoABRUd7RyxuhcWanKLZuR5Eb
 8VD+XOVVC/4geIQWsqciFL1J+75xJTDZgnKn6k4=
X-Google-Smtp-Source: AHgI3IaPWx04d6vXqqvrebKNmFPbU/FKyoqA7w5QwzEfG31LFlUoQ9T2OhxUIBzYmlmrx77oKXqtWypfi6pFriQRNbA=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr348098otj.228.1549920871129;
 Mon, 11 Feb 2019 13:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com>
In-Reply-To: <1549916056.3075.102.camel@impinj.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Feb 2019 19:34:19 -0200
Message-ID: <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
To: Trent Piepho <tpiepho@impinj.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_133432_489982_7E793743 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Trent,

On Mon, Feb 11, 2019 at 6:44 PM Trent Piepho <tpiepho@impinj.com> wrote:

> I've had more time to test.
>
> Without DMA, I can reload my FPGA hundreds of times and get days of
> uptime using linux-next.
>
> With DMA, loading is unreliable.  The higher the SPI speed, the less
> reliable it is.  Unfortunately, it's hard to duplicate the problem with
> a small amount of data, and with a large amount of data I can't examine
> it in depth enough to determine if the problem is related to SPI bus
> timing or IMX sDMA sending the wrong bytes to the spi controller.
>
> Using DMA with SPI causes kernel panics.  Not always immediately, but
> after using DMA it's a smaller of minutes before something crashes.
> The backtraces are all over the place and don't usually point back into
> SPI.  It does seem like they usually hit something has allocated or is
> allocating DMA memory.

Did you test with an external SDMA firmware or with the ROM SDMA firmware?

Just trying to understand if the SDMA firmware plays a role on this
behavior or not.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
