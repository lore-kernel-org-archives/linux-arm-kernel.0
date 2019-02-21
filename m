Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:35:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FD82086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d04GRL5L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD4lBNWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FD82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D7gNqQZm/sV7RVUQ4Js05YSU+HZGqbvpR5yqNRUBUAc=; b=d04GRL5Lc0t9WS
	lP2NlWX194oljrAhuixPSHJLSoCZqxsRV0RB/Y0QY7chbw78ywdh8elu31cm2jmWiesS++xf0Bo+z
	I7v5q68FJzMZfWbFV+BGiVpOKH+gR+q6GQPG6uf6KoHXk7yIa5IXaXuvhbOyNW5OicruBHgOuAIkH
	dNq4V7Fc2I/JJri6CGtXvYWAIpRQXSxBpYEvh9hwGjwosQAGO0Mq93pjrfTFTtm6JReb/F0aGTQqi
	C0BY1CRfOpjYuHcyGx4COY6IOJKNNCmRVoAB+eCyQeNTQjvk7CB+46nH4qLowY5MQU+ihJY9k9QCM
	r0FQd3h1Ev3nnhicgeMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlgv-0003Ub-KJ; Thu, 21 Feb 2019 10:34:57 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlgr-0003RX-2Z
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:34:55 +0000
Received: by mail-oi1-x242.google.com with SMTP id t206so999494oib.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iIAmxPn99UJSLULAPX5kBKtGCz1DGhBud8hKmEjk0Ms=;
 b=FD4lBNWkOZJ2XUwI72no5ez3H6FO1gktI9Blik9Afu4/mjykLj7XnFS23PaSj5gQk6
 P8ipnymsksBVNYcVGo44ibaqa23C+Q3me9mt6u8IzFEIEYsEVHbpAu3mr4U5vsBj6J8o
 fP+xW0LhZKWwF/wyFvWw/BXMH9GR/LfuCgIPXMKwsR4rp0n7F5d2cfUu3i7qZe+CjTon
 S24n/lM14fJvylvTbO53znWQbzoaOiO3HzGy49KmsZSYp6sTLiWtgnTElz64GV/bjqIi
 oBSroZjLQADW7HkYy+vvVwn3GUyHmaiKoH04oFHYoBPans3yNEGrzSo5xvAF+K50rs8j
 j3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iIAmxPn99UJSLULAPX5kBKtGCz1DGhBud8hKmEjk0Ms=;
 b=QL+GBFtC2mzCACjqA+o84N2QhA9F7ZKi2mK/bY9uG87emati/cfZpFX4cbsCxGfUR6
 T/M4qfjNnF7ScneCMouehqXo1GN260E8WKt9eh0i8XUtA83gvUCOKTBT9tGvbfWXPm1D
 o9P5ikbako8gLdRday1lf3/Y0rdemtn7429WBRi9E67yRP/x/eSd7IGift2ip/o5Xweu
 vgnbuZeP4TMt3kWksVBbByGzb0ddE3uEMhuxfhBxgjwKJA6KUwgiolk6OE/3AduBjUgT
 W24TUNpMa5tQyeLyQrB8l7qciQY39UbHqpfLZcB4pH2Uu68ZFR0LcFHg4ZhEkZxAW1I+
 bAaA==
X-Gm-Message-State: AHQUAuZBTxVPhLjQsUKT4jUoCSdVEgg0fp8mCW/MT7o6PTD2vE04dGW0
 qbVRSqhmHWp2084P2jbOdOw865SQ6aKDhD6v/+o=
X-Google-Smtp-Source: AHgI3IbfLEn4k5Fu0qMUeThwo9zg7+FvBKevvZd8j6A+Us2IeWQizYQq6mPXr3/TxqjfrJrJE6DYd8I2/IXoXO/Vjbk=
X-Received: by 2002:aca:4a95:: with SMTP id x143mr9033108oia.18.1550745292035; 
 Thu, 21 Feb 2019 02:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20190130192102.7065-1-festevam@gmail.com>
 <154940574088.169292.15304825462770873584@swboyd.mtv.corp.google.com>
 <CAOMZO5BYr_JXZ-ibb5JBvVtF0=Y-cz+qNsPHd0i-kkrC9Ok4ag@mail.gmail.com>
 <154947421987.74891.17150055410578722741@swboyd.mtv.corp.google.com>
In-Reply-To: <154947421987.74891.17150055410578722741@swboyd.mtv.corp.google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Feb 2019 07:34:43 -0300
Message-ID: <CAOMZO5DgQmxrrC1YzXeB8Rcyzckv9uPQ_C9x5PRv0LC+h+yJBg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Fix the CLKO2 source select list
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_023453_126026_6C8274D9 
X-CRM114-Status: GOOD (  10.56  )
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
Cc: NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Rogerio Pimentel <rogerio.silva@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On Wed, Feb 6, 2019 at 3:30 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Fabio Estevam (2019-02-05 14:35:49)
> > Hi Stephen,
> >
> > On Tue, Feb 5, 2019 at 8:29 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > > Do I need to fast track this into v5.0 final? Or this is a non-critical
> > > fix for something that isn't used right now?
> >
> > This is a non-critical fix and it can wait until v5.1.
> >
>
> Alright, thanks!

Can this go to clk-next?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
