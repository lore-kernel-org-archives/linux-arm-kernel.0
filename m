Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D421DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:07:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40052080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZQ/JPkro";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC/RqzGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40052080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YYLWo9E7MZZv4sCCrlwmZqR+bmCjDzgmR9ZYnosWez0=; b=ZQ/JPkroo1AcNy
	+ONFA2Xkj5QMxG9a9/5BMiZGEVhLHn+QkGD/Xqeaiqzr9omIpgMpxM958gVn1mf+vCcTEglpMRrQk
	5i+MuqfG4waFVlNWkl60W+O7+NY/5nJhswvObwa/QneQKXa6YDJqDK9IFcnCFVPS8HqN5Be0FNjmI
	F2/yXzwwyaiIxXkoBCBrw2gtlyducQkCTXxxK4r42gN5k4lGQKYCr+a1iMI4gngBIiECyYBCr8YDa
	+eTMkAIq+XLwH/UJg63Dzkd1NGopmNRpzbe5ZGPt4jPf0RAZx4e8jsi7TngswvYqIL4lxkKiyO0+2
	R5g/YnWZHKX708KJXDbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwzJX-0002kq-JQ; Fri, 22 Feb 2019 01:07:43 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwzJU-0002kV-SP
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 01:07:42 +0000
Received: by mail-ot1-x341.google.com with SMTP id 32so480527ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 17:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=03UzzOJG6Qx0sa4ywpYSrI8fbPyjh8fLo5nF69UtJIU=;
 b=aC/RqzGmUSmWUbtY6ygP0yZYwbJ8WqqI6RBPmuEcCoOLz9DHHCJfjLy+StxkR/RwXY
 hpNVDBK1Qd1fSkZAR/8rwbIr1IsOVUolT/b9P4Icgxx6mt8vFGnwoNbEQyC37M1GfGAN
 E7THMALFx3QW7mynxmYZnXi0FpmeFOn6aRx3O0zNMGTRbIWnXICPGDgF/fd9BCKBHHXD
 yi1sxKsDn7peyFfd8wm7pCsIqe5mq4JmUEy8La67YGrjCSBCVoTnP4wUmG4lNWBQfJjM
 dHANOdPJqaCOBMOYyphWO4r9UMzAk69dkguH6cPrvsuz/XRA3N8TEiskSoxtcUEoad1e
 KVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=03UzzOJG6Qx0sa4ywpYSrI8fbPyjh8fLo5nF69UtJIU=;
 b=OHZEs+lxBQi4VYvBqRPchAW7G+YtDS58TjFDWIWrV9eH77KzSsR6Db7KCfwdEYmzi/
 dQS4bUxpceuWxexSCprZbiyP65oX01PdEva6/SEEz/NuxVH5TxEVWH9nmHhh8opYhC3b
 PjqyFqsw4HQG908zRhKSyuYQky22ehotn1I/mgZDF/3C/HjIu+mJXMlLQdg5avovSmhe
 +u7QGe7OTNwcg6bADfFJn4U8Oep6+RnjHOTosBuipL9LameyqI9/JSVWyiZNt5xNA9M2
 jUxpnyPdhHdewLDgYRh0+1Xt8h+9HKcE6ETXxJmI/K+sdK9T6Wdoof7ZoGMxokobBPFM
 TPdQ==
X-Gm-Message-State: AHQUAuYxhpJWkt+sjIp3rzAc7HonVTPqBQqS7S6fUpmhG5O9JMkULUcL
 yw31ZPYzN/1Ulkn/XlgkMUBDyildVuJc41G1rrk=
X-Google-Smtp-Source: AHgI3Ia0mG+atwRQe1U/Ata/5jKFzwscHzMgga9btyDH5U+jbki/3d5Qa9D63l3eWmDG/rFJSrrGvJL0ChCjZmLSce4=
X-Received: by 2002:a05:6830:14d6:: with SMTP id
 t22mr1003101otq.255.1550797659539; 
 Thu, 21 Feb 2019 17:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20190131002056.12024-1-festevam@gmail.com>
 <155078140414.77512.3157214123340597508@swboyd.mtv.corp.google.com>
In-Reply-To: <155078140414.77512.3157214123340597508@swboyd.mtv.corp.google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Feb 2019 22:07:28 -0300
Message-ID: <CAOMZO5Cu=+8bbbW9k0soihpr_xHDeivijQAn7aL1VHPSdy_faw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Add support for the CLKO1 clock
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_170740_945571_D254DA7D 
X-CRM114-Status: GOOD (  17.98  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Carlo Caione <ccaione@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Bai Ping <ping.bai@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On Thu, Feb 21, 2019 at 5:36 PM Stephen Boyd <sboyd@kernel.org> wrote:

> Applied to clk-next but I had to fix the whole DT binding number because
> I don't know what this patch is based on. In fact, please get everyone
> involved at NXP and whoever else is working on i.MX clk drivers to
> coordinate somehow. I just spent 20 minutes working through the set of
> imx patches in my inbox and I see approximately 6 different authors all
> sending out a few clks at a time for the same drivers with zero
> information about what the patches are based on or what order they're
> supposed to be applied in.

Sorry for the trouble!

> If someone wants to collect all the patches and indicate on the list
> they've picked them up and will be sending them as a pull request that's
> fine. Otherwise, I recommend working together to post a coherent patch
> series that adds the things that everyone wants or working from a stable
> baseline like an rc tag and letting me figure out how to do the merging.
> Either way, it looks like if I ever get a patch for imx clk drivers that
> doesn't have a cover letter or is just adding a few clks here and there
> I'll have to assume it's the same story as always and just toss them
> into a clk-imx branch without a topic.

Yes, let's try to make this better.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
