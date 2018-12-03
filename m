Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF9C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766A120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cfnuqs9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766A120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Rwo1uqDX0Q/4HlTS39Id46Y2icGKX9bbuTmHFFbxo0=; b=cfnuqs9dCwVuFR
	4isDzo49ljJBrEaIEyvCc9Lwp0B5GN7jEmRzPTK0PH6p5LIoEWZdaaO5kI+5/KjQQnExR3fXxPALm
	uVud8SQ4dpZ/fiuB2lHSFqW+A49X4OkrDMoXRX1OL9CjAsAt4Llw+3uuSJaxs0vvBHROFO4ZS6iKJ
	h2yJx4snIbDJAUB6MIIYWRYRTh3aJav6rd2ZEAz++GicufUlMY+rvDSHmvb8i43lSQg4NUt8Oq9WT
	25smVPCngu8bREzra+0t/qx4UkvAA0Vx/dAefEx1SV/iTwkclFQWh2yQ7Q+Ftj2LkgGeEfJ0UVMr2
	Ln/OFSWP/gyIp3oFFrtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlFy-0007iV-7a; Mon, 03 Dec 2018 10:15:14 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlFq-0006QL-N1
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:15:12 +0000
Received: by mail-ed1-f66.google.com with SMTP id b3so10234074ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YEEfeb2bhDBv6eCurl9mR7hSIVGyipoTCFXHjvSDN2M=;
 b=TtXS7hjP0IL9jo9wuGNlFWlsf2k1g8+41G2dvwUsyRtIMaakDMPgnw8cYw5Fw8fgq2
 AYee9RmuRhvqwsd+im/Ic+YGSmvDiZ4XoMSI5JJ0w90TcvMWEMdTTKudkOV2nfcHP6OL
 IZAxebFPVbu4WLPqRjeEvgtadU1TpwvK2wxz1sNpiontTYjSDxpMutiBBlY4ioAAX9Oa
 5wg0lZorS0b0ohHY6Ep+ntZKskvz9ihs81kyAelJW77MoS47XZntXLFrZLiHFNEkNVh3
 ZlAWV7M48BXzcveUuTOn5rjdeyxXLA65HpjWLu8Dtwn5wsjU+/ySfUiCUCQjYh4jJDgm
 03WA==
X-Gm-Message-State: AA+aEWYU8RWg7+ARvRDTR1qAk4YN31qXOdIJ/X+fI+i0HgHM9HRWYlyc
 VGTMTcwOMl1oyhX2FzhBb2WPwm33WGU=
X-Google-Smtp-Source: AFSGD/W03HzJKE901vUNlJggNNec63jVCCC7pnrpIRk4ntbKhLEO/vz+9bupxurTbIkRfsNATZGe0Q==
X-Received: by 2002:a50:b172:: with SMTP id l47mr13877578edd.225.1543832094640; 
 Mon, 03 Dec 2018 02:14:54 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45])
 by smtp.gmail.com with ESMTPSA id n29sm3735913edd.40.2018.12.03.02.14.54
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:14:54 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id v6so11447841wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:14:54 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr12800470wrv.87.1543832093766; 
 Mon, 03 Dec 2018 02:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 18:14:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64B-afrJ=n1td4HsJgtyrr=oxjF3M=pqjuKtp2AU2V0Gw@mail.gmail.com>
Message-ID: <CAGb2v64B-afrJ=n1td4HsJgtyrr=oxjF3M=pqjuKtp2AU2V0Gw@mail.gmail.com>
Subject: Re: [PATCH 0/5] media/sun6i: Allwinner A64 CSI support
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021506_757358_3C43261F 
X-CRM114-Status: GOOD (  14.48  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 6:07 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This series support CSI on Allwinner A64.
>
> The CSI controller seems similar to that of in H3, so fallback
> compatible is used to load the driver.
>
> Unlike other SoC's A64 has set of GPIO Pin gropus SDA, SCK intead
> of dedicated I2C controller, so this series used i2c-gpio bitbanging.
>
> Right now the camera is able to detect, but capture images shows
> sequence of red, blue line. any suggestion please help.

The CSI controller doesn't seem to work properly at the default
clock rate of 600 MHz. Dropping it down to 300 MHz, the default
rate used by the BSP, fixes things.

The BSP also tries to use different clock rates (multiples of 108 MHz)
according to the captured image size. I've not tried this since the
driver no longer exports sub-device controls, and I currently don't
know how to handle that to change the resolution.

Regards
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
