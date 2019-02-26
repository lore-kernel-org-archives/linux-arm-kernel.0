Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0661DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:13:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6679217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a19aXt8h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSTYHXsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6679217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j8vGLQEWK/mLdwOpTPPoYZPa4+ixGWK1gRmLIzVMxZI=; b=a19aXt8hNoWFac
	U53QWThqNHgDiKLEDaH0g8R2qCG9RkmtE1GpuhWJwFU8gLtUVHUJhY2sEB+E8Zrk9LkdBficXYsce
	QFcjbvuoeoLwFGBnHKENg9xw87D069hnWOqyJSvzvEfMUaQX5XeS/K+mXdNIOH6u4L+h36lrv+QoU
	iV3aTfJgtB3OhR2HDevt5QAnmsnQFlLxa6/VeLMi99tqJec6liDPsbJ/Hw5xY4/3TpquOwC7Kaq/v
	ar0fAH9K9WcEOws7APTOvKnSMHtMgJBY4Zceu1H+4XzzMLNZ7u4VldAcpkDOFSMT14N80S5eINYw/
	qBvD/zdVfzWeSHBaDE1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gySF9-00010M-HV; Tue, 26 Feb 2019 02:13:15 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gySF5-000102-VX
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 02:13:13 +0000
Received: by mail-ot1-x343.google.com with SMTP id z19so9829885otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 18:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7e6ZktkM7WrXXhl3RBwv4opKRMIcFUAg4hyp3759RPw=;
 b=DSTYHXsYsyuIZ1Kldyv0ACC31xUqj3F1AqibQ/3SYXtxN3CvPm+xLZJMpfhoxToxAV
 Zyx01+VfJh6cOqkJNl8ByqKSS1nP+lgLG5sMKy9uerTii5OVFhq25vtUQ1Y0XSBSan6j
 A3O5DBvHRIsFRgzgsNmz+KGkRvkVrkKQRGp/cFEB/mtFH+RdVcw7jtGbihB4Oi7ePmDx
 aYoDooGL2/y3er1BG7Xl97KqUfyM0a/dvtXXANo0PNylZhr/pI5b4CHmGa7Xdr4lM3VX
 lYxKBXHz2Vl0gtjBfshqvqIUiOJxFWWA+BMD3fYOmhnUg0kmHLP6lWpPMY3c1I8XBV1C
 wV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7e6ZktkM7WrXXhl3RBwv4opKRMIcFUAg4hyp3759RPw=;
 b=gLcwM5YBLXrA21tIBYGBPbKJj19fiBkR/TMzM3OQmUfZRKjeQ/JxPX8WeSR/F2EC2h
 zAjwhWJtPeKCt/hHGmt5gEU5pJTm0jTFZzlZpc/G+Ig8R8b+y9kOghkn3Xp78z2xxpI+
 fX3n2TKkflFCZqUqbHc2UdUcYDiu7KEH+HAy2IeWaiGHDUyAJZZFt8O6dm1rAW2PLuvN
 dv2WL9XosvPLWhknmlGqREZuHEe5tVSdiop+9zOJuKz15ZO8prSP3bMJ3YB/yNqCIyUN
 49ivuqXEV0LAFlP9awD1v80ZOrftTJfWTWDRclba6T22Y3UGctVPrI3M56qAG5QQUxmT
 vPNQ==
X-Gm-Message-State: AHQUAuZW+R4/650lKZPlo/mZE0Seh0luYD3a4km6Yi2jMPY2mLbEEEEI
 tpw9mKUMihcLn/+//1zbDK9OajoFF7bL9xkfeas=
X-Google-Smtp-Source: AHgI3IbFhSiZ0fzTUM2prXVwl1gxHP2jSEMOoLWDRWK/eomTfprYXYn77hmRgV9Tr0nJPBZ36KXVd43ZlRfmP3inRyE=
X-Received: by 2002:a05:6830:14d6:: with SMTP id
 t22mr14291832otq.255.1551147189313; 
 Mon, 25 Feb 2019 18:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
 <20190226020623.18324-1-okuno.kohji@jp.panasonic.com>
In-Reply-To: <20190226020623.18324-1-okuno.kohji@jp.panasonic.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Feb 2019 23:12:57 -0300
Message-ID: <CAOMZO5BzMuWa16d3NOtOFgdBNOCL3YGsYW2s0eGxbnnx8+wdJA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx6q: cpuidle: fix bug that CPU might not wake
 up at expected time
To: Kohji Okuno <okuno.kohji@jp.panasonic.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_181312_012048_388643B2 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kohji,

On Mon, Feb 25, 2019 at 11:08 PM Kohji Okuno
<okuno.kohji@jp.panasonic.com> wrote:

> +       if (++num_idle_cpus == num_online_cpus()) {
>                 imx6_set_lpm(WAIT_UNCLOCKED);

You should remove the braces for a single statement inside the if block.

> -               cpu_do_idle();
> -               imx6_set_lpm(WAIT_CLOCKED);
> -               spin_unlock(&master_lock);
> -               goto done;
>         }
> +       spin_unlock(&cpuidle_lock);
>
> -idle:
>         cpu_do_idle();
> -done:
> -       atomic_dec(&master);
> +
> +       spin_lock(&cpuidle_lock);
> +       if (num_idle_cpus-- == num_online_cpus()) {
> +               imx6_set_lpm(WAIT_CLOCKED);
> +       }

Same here.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
