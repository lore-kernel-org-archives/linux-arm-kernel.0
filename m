Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D63EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BB7218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CfxgjKdd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXDYrYGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BB7218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LeqlkkbGTubgEiXh7sMDdpIj417297KPF9IO3XrBC88=; b=CfxgjKddu2TQzg
	iFHSkIrY1E8aFBXzW0H5/3cA5wSbTauSGkpqqg4oP0FqeivifOdHedlX5h6gsUloOqSQJ32GQhoKl
	ZQC0j4mafO6lj7Ta1308F5hftRjqPsXUp6A8f0w8DedV648XIcS6786mHmTFeMsDvYrdhuPNPSYSJ
	rebxrs9NHEWd06C5ivo49j+ZWCueEya7QjLOXEmXaCy6tkAScEVVeIvLHd55L+8Q994KLosKD6TL/
	GA4T90buVpnHn4Fm0ezzaoUS3MY0g/6MKPA8VIBP7LAporZ12cSmKJwxMwYpe1SuHOk7oJtqAmppw
	tVp+1je69bERtNldH+hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyoFg-0006AB-BN; Wed, 27 Feb 2019 01:43:16 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyoFc-0005zI-IS
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 01:43:14 +0000
Received: by mail-ot1-x343.google.com with SMTP id t7so12948488otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 17:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ePahqNB+NAIQktminfToWaR6W6q1o8dl+pknU+Oug8=;
 b=bXDYrYGlVlnwVA0Uw3rnfWSp/TCkYI5Y6IfmAJ0TdyhbyuVco2uOy64+IYGufqSEXy
 nuIXA/vM8bmleJpQao/cvOAPx+t29A8n7SmNGukKSs22u1zuUeJ4d9idJBWI4nDpk2sY
 +zQjhGoCRmLcT9Rwm3HdB6WHMeA735PEBgdtSZd2yZv+9GALI8nWWCaK0MrdXA5C13e/
 /dwnqZtvJa4cWXyXUz5lt0SyJroMc3FDvAHTMzrSfjsDwUN+HC3LdDMVAes0eLEiBa6v
 Rc/D1OnbhPIkCpB8of1Sx1sxVeM2W3q13gFUpxcq8NRA0t4GHDZhM3aZAXTZsavRFbhk
 r6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ePahqNB+NAIQktminfToWaR6W6q1o8dl+pknU+Oug8=;
 b=iQZg4kVGMc7x8wAqAQn6yZJaytFQYpkf6JjB9FiSGVOq/b2K4VxfoEGupR185ymggz
 BclX5sJU39T72+v+ez28lrq6EvPTg7ZJw7fml4SK6e9wcrBX7VIDCFd6ueJxW1hD69cl
 Dj+ZYDrBRlcaiQXSzCHAo2LJAjs09zyU84Qld1JgfMfiXSiKx7FQSH/lWvSIKYCt+h8E
 3tNdwDFCt4gGhZmZK8qru9s57iPi/8dTbHIieEuRL7no8pu17L4N5+ZUOlSYUBlQwRan
 Te0o8fnR7GDhKWLtY9m5R/KTD9IlhfIxpZDlw/QDVaTSNckNDVEzhHAzy3ryfvffip/6
 N8xQ==
X-Gm-Message-State: AHQUAuY67lXDMr2pnNqdBFeltZo+7XGCKlPg0axF1vdCCUnFv2rMm0uw
 x42SNjrMlMwFCxaFuNgF4MmjJFd+CxEx24uBlQQ=
X-Google-Smtp-Source: APXvYqzKVLSr+oXMH1RsvLJ9BPOZZxFkxDhAmIsLK0hM34vcBg/7oAWVWWnmOQ7nHhyuOx4L1aeCTFXw01ZhwC8TN/4=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr615500otn.203.1551231791522;
 Tue, 26 Feb 2019 17:43:11 -0800 (PST)
MIME-Version: 1.0
References: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
 <1551230622-30660-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551230622-30660-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Feb 2019 22:42:59 -0300
Message-ID: <CAOMZO5AddhSfB0Efuy-Z5GjvpXMwyBGHB8H6YTWcztXzCOWVyA@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 2/2] arm64: dts: freescale: imx8mq: add clock
 for GPIO node
To: Anson Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_174312_708283_536B7975 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "agx@sigxcpu.org" <agx@sigxcpu.org>, Abel Vesa <abel.vesa@nxp.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 10:29 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> i.MX8MQ has clock gate for each GPIO bank, add clock info
> to GPIO node for clock management.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
