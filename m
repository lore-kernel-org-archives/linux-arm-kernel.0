Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8868DC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:16:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420F9218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cpo7U0be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420F9218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E3PosYgoXEv48LWsKsecMECyr0eM/rMjh2StwW2Km/8=; b=cpo7U0beaNt3yf
	coXqlutFuHPswnQPsN0KlValzJx6GuLYNsQKBUHppi57NWCtmnQWGPzbiWjVXXdp4x98/lt82RNF0
	4jW/IAbTx5ZqpFH2Q43K6DDAsXunI0ZRxdop1+x06Y92TPZ9AhvlKkfNlLNs0+RRzzVB5NuLpY70M
	zX/rVXf/WRPGYxaICkcWIh5fUetaG5WHPd/sovlu15RK8G3ciyKfSDOzverbcJy+h+u5Sc82D3wHM
	RHyf55Y+zJER7gaspMVae6RPY0BtKLUednxsRM/KsrSQ5a82RL1bUTpBYQC2L/AnPb6erd0wtb+vk
	td55KEzIeAECtc5BPmPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmc3F-0003qh-AC; Thu, 24 Jan 2019 10:16:01 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmc3C-0003qF-Nb
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:16:00 +0000
Received: by mail-ed1-f67.google.com with SMTP id h50so4109662ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IMeU3UY2XAM0kzq1Z8Gn2QEdtJTiaE/AbGjYG0aznDQ=;
 b=obxMPGo/eRvKGxOAhDhnUQNtYP7WbONbUC1i+2Sj3ZXFtb4PlbD6dWIEpc9VoPCNAw
 mlrGIg+1K8eXUYGi4oOsQ61eLzd4ingX34WyuvutPo4BGIbiIRhJfJLEv+iCODA7cuZf
 T3vB756gGk5i5ctJ1TTiCXNeCwIHNZnTJj1XMPQa86Kz9Q+QrRX4PtcD/DiZkLe5ejKJ
 V4MoHEzUSLHWmmtaVhcHRc1mtO/sxb8vMAFhlO+iqRp2E+EL9djsYOPQ0e6zpAfWNCOH
 2dYzX7J3egzzG/reZONmIHhnBnWNE3QO/2ZdAq2nBFiZtkghmoilVcOBc83uQXpb568/
 gp1w==
X-Gm-Message-State: AJcUukeSOglzFjFh7BW0icc4eNKP59Mba40kbVYL3GsS1qfbVdPVBpp5
 kqcchjboFeTg6EojYjNwU8n/8heaEW0=
X-Google-Smtp-Source: ALg8bN5JvxdeyhLGKqgpoVLvrzwkxemaoo6yD/3ReTjlmqotq0RQAgB8ROT1MzvMDbNFQ6CwiSwd+A==
X-Received: by 2002:a50:d002:: with SMTP id j2mr6002013edf.123.1548324956909; 
 Thu, 24 Jan 2019 02:15:56 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com.
 [209.85.128.51])
 by smtp.gmail.com with ESMTPSA id w31sm11006481edw.82.2019.01.24.02.15.56
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 02:15:56 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id m22so2378105wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:15:56 -0800 (PST)
X-Received: by 2002:a1c:578e:: with SMTP id l136mr1933083wmb.124.1548324956114; 
 Thu, 24 Jan 2019 02:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-4-wens@csie.org>
 <CAMty3ZBFVStHNbYaBxT+Rmy6+g4jtm0cFKk8BL5BDid3c5VW-Q@mail.gmail.com>
In-Reply-To: <CAMty3ZBFVStHNbYaBxT+Rmy6+g4jtm0cFKk8BL5BDid3c5VW-Q@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 24 Jan 2019 18:15:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67oLffVXYAHHcHEo6_rNddqpFwCGq2DzgFW_zkfbpf12g@mail.gmail.com>
Message-ID: <CAGb2v67oLffVXYAHHcHEo6_rNddqpFwCGq2DzgFW_zkfbpf12g@mail.gmail.com>
Subject: Re: [PATCH 3/6] ARM: dts: sunxi: h3/h5: Drop A31 fallback compatible
 for CSI controller
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_021558_762509_47B58AB8 
X-CRM114-Status: GOOD (  14.80  )
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
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 5:44 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > The CSI controller found on the H3 (and H5) is a reduced version of the
> > one found on the A31. It only has 1 channel, instead of 4 channels for
> > time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> > "fallback" to a compatible that implements more features than it
> > supports.
> >
> > Drop the A31 fallback compatible.
> >
> > Fixes: f89120b6f554 ("ARM: dts: sun8i: Add the H3/H5 CSI controller")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

Merged for 5.1, as the accompanying driver changes were also merged for 5.1

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
