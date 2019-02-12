Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69369222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iAMu1bUt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksKNFZtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69369222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A9tFn1en4gVT/+/Q8D7uj5bed/+aSzOlf+clbo22UnE=; b=iAMu1bUtIwM7tr
	kYi7gDqnD7yl1J4cVQMKvndtvCFeQ37BPM0u7OTWiLqvpsdbGfKmEeM9MmpatLbcleIbgOmsKgoI0
	wrqHa2oYcsEhr3evVF4MdEJmsjvMLcp7CYQJIT+33kczpWnYyt0N3GM8fdgWXP0nqPjpKo7H/GlyX
	6NC6OhfUJInNDIC2Bl2g6gObftUChRfil6QF2cp3NSC6S/t6wsgB6isJv/hVd5b8faTCTDHZI7nzz
	By2fxg8QhMjNkYlt3LpcJ8E7kYIG5lAyBANIuUl+lMO1QBWgaRloTjVQqgFx8Gk4J94zhoT+B3wPw
	p6ieAOiD9V541sbojBbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfEE-0000F3-Um; Tue, 12 Feb 2019 21:04:30 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfEB-0000Db-8u
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 21:04:29 +0000
Received: by mail-ot1-x341.google.com with SMTP id u16so174034otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 13:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KDx4mB7VgyzDjlrM3YCKPphPWcYZ26SzKyKJB0YtKU8=;
 b=ksKNFZtjtTMtGF3JHcfuKvUM1Gd/A57g0NRtRr2DGPYTsPezGY6LXLEEjYtKZYxG7g
 YuhKcw/pQJc9c9/jFRbWCCOkGBwC/LWUVAKOQN9zUCOFdGzyWPLyAhf8KymVSksuVbt8
 sFMNOJe5QEt4eU01hvhtxZZCoKgstL2jb7y/FRxj2QC+sj+Q+rKfQM/KilzGbCV7znf6
 69MT1ZBuoCaK4xWZr6CSosYU1riCMgkqOiV/X5qBMPToy4r5tlHoUlIXYUf99nizShwJ
 wH6FsFaZX2TfCUvbKenNPVbg1a9Kg6g/t+DAgkv8AxpU8sB1xbDGNcKmkdvleDWYbfFZ
 d9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KDx4mB7VgyzDjlrM3YCKPphPWcYZ26SzKyKJB0YtKU8=;
 b=Khs5L6VJlQ+8jSMfuwPW0kmalkQO9lB3392leZafPSY2py4P0FuKr4r9rfLskEsjy2
 2+4JOyVQMk1QsARfxBYjDnIOkR7Dd0yF31tKHmZp9EQY1z+LnWdFHlTw/Nn1SBkhYyKy
 QibzffYaSUhdEmKNWZof9jSfCqqZBCg5BNqG2EtOdIMKDGz65OtZbWng2/X4WJPpI5uU
 gWW26/wp1iuCKeV8ampusW1aWLz9Kfa11/bJkqUh6RNBv1jx34FnaagG+HgG+T7aNcY/
 rTEKC16Q2QCT06cwnubrHtyMlq3Eb2GUru+CCBl9Vfy5u7aVfDFZjd5is5B4CW3ejAkH
 MvTA==
X-Gm-Message-State: AHQUAuYYpVY9w7ijAe7bzcFUwKE7b3u1C58IwXoz8FUdcM1zNkHL7l4V
 Z61mHXN5A3hP1+JFwh1xsJx6QCa9euaSz2+4D7E=
X-Google-Smtp-Source: AHgI3IapP+J+T80MtqIDng0tGgcPXgr043W/xlSv8bt2QuDH9spfnVwTIAAO4NtGWMNKgIoCXOK8ZFaj1hIekw1y1t8=
X-Received: by 2002:a9d:282:: with SMTP id 2mr5735277otl.287.1550005465224;
 Tue, 12 Feb 2019 13:04:25 -0800 (PST)
MIME-Version: 1.0
References: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
 <1550005119-25750-2-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550005119-25750-2-git-send-email-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Feb 2019 19:04:13 -0200
Message-ID: <CAOMZO5AtXz8Gyh6yBzVWWiKfSVVtSAArd52LbW=a3kszZ27iOQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] arm64: dts: imx8qxp: added ddr performance monitor
 nodes
To: Frank Li <frank.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_130427_334950_18A32871 
X-CRM114-Status: GOOD (  10.49  )
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
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 6:59 PM Frank Li <frank.li@nxp.com> wrote:

> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4c3dd95..243d7b3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -79,6 +79,13 @@
>                 interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> +       ddr_pmu0: ddr_pmu@5c020000 {

It seems you ignored the commend I made in the previous version.

Here it goes again:

Underscores should not be used in node names. You could use
pmu@5c020000 instead.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
