Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A98C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:47:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1399D2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pLqWeYX9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/gLR7lF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1399D2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bbBgTNGcVjhZIKRJvNgj4m4KWkE1Vq8Zsblh9KajE10=; b=pLqWeYX9pOwK1P
	zmOxT+gIsoZZ2PteQQlnuSROsWPlJ9wwWpQgyTBFhcOBKViw26e0rtsYZ80rs8uzxXtppAm5G9ibX
	FXjwU7rCDzvOzI4AHt6ZZOLTGpAAIkf+uTEz7jcdTQc6D9uJlgYnRr/QQ7zB/qbWwpPRNhjldaxw4
	DmG+YO+AvNrZ9cJYFxytB7qylTbb3AoLXhGu2oG60u+yg+/cjAxql2R4L4joKoDKfhMpspr1EBo5E
	DwzD/V8eLB4JpAAntTO+qv+6uUbrpLNzE2VrJNdTzC7p74TXzDdcXgQOFkPvw9UFutYf60NJ3qlJs
	nXpAIY6sRRWuPUoMqSdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0UV-0005bt-LL; Wed, 27 Feb 2019 14:47:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0US-0005bY-MI
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 14:47:21 +0000
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A8366217F9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551278839;
 bh=xBKLKkha3fIOLrJq2ruP0e0YDcePEX0pL/Rf8UGo9gE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=t/gLR7lF5TRiUs/WZ5jMxevW4zY2CgxY4MNcjSsMI5JSX7MO8tllJ2parRhW10X2W
 ADbLSsnzw9WH4XSqvBbaqZ3tWVs/WuNgP+9/sAnMOEshSvLncOdbix9nSlOkGU38mn
 /4fIcY2S63QCHDtJaa2kJ6ARrZpCtrj9i5nmha3k=
Received: by mail-qk1-f180.google.com with SMTP id m9so9972513qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 06:47:19 -0800 (PST)
X-Gm-Message-State: APjAAAVqAXHVuNfAjUQm/gSuG1PKMi8a98Fa1k+8tae+y6TgFuReQOfP
 MJoV5G7fWHF2P39oRV+uNuQ2+QlPWlpHF556zg==
X-Google-Smtp-Source: APXvYqzda2Sw50spJHbBAFqS3wYj5i9U0/bTlVbJ7hYT80eh1S8U4ytd+wVjaxTnknI3bNU4QwUoIfWrWMXK4nDhjdo=
X-Received: by 2002:a05:620a:123b:: with SMTP id
 v27mr2325850qkj.29.1551278838828; 
 Wed, 27 Feb 2019 06:47:18 -0800 (PST)
MIME-Version: 1.0
References: <1551243145-10635-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1551243145-10635-1-git-send-email-sugaya.taichi@socionext.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 27 Feb 2019 08:47:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvKMCmV3aq4LX_n2xsMEUfSK41--VVU+aQqtqv4F5U=g@mail.gmail.com>
Message-ID: <CAL_JsqJvKMCmV3aq4LX_n2xsMEUfSK41--VVU+aQqtqv4F5U=g@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] dt-bindings: Add documentation for Milbeaut SoCs
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_064720_749441_6C21464D 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 10:51 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds a DT binding documentation for the M10V and its evaluation
> board.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/arm/socionext/milbeaut.yaml           | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
