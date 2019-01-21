Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4ACC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:30:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAF32084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AGHYl+Io";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l98VZU+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAF32084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xkQ261Yw/DjUV3QjNdyl67HcajruEt1ATDVrrw0Ijvk=; b=AGHYl+IoqjGj9t
	LcOs98sKd7dMelH1sLZ5ZbXUgpmjzkDL6Mi2uUYrJl0Rq6QZKiWnQQps93OUhano+V7nqamOC1ixm
	kQm7FlL7rIQ26lWAeP5ahLGjdWe1xkEu0zzFHJTup82gkmItYW0KKt/PGLBZ8wOfYIi8oIkKXVF/D
	G8AIPbmSyIyVqKl1iWotqnYIHuMCt5GiY2vsmW6sjA4gnAKrLWjGC/geg6cnmPrmHQXPqBXCT2rOZ
	mI0Hhcrv2l21dLBp+6pWma9ZUl3wH+C6P3cpFRZYajbBRV9CJ2+WIruqZEFVYaifG8Dpw8f9JfTPq
	otZb+W3G1BEykCYqKMtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldOk-0001Am-3K; Mon, 21 Jan 2019 17:30:10 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldOg-0000a6-OX
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:30:08 +0000
Received: by mail-oi1-x244.google.com with SMTP id m6so15131140oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WB/Es8nYek42nkh/1Mj4Lr14rj8kBGnNq/LuX5WPz6o=;
 b=l98VZU+Vj4sTrW3I0PucHHvp8ogAs1abzeg8MeD5aAEG3KUDQ7c6Tnx5ZSbSJO86pu
 qkzEeeUt0MmCgUdMDfAXNl60PaVoTqFHI11uIsJWLtOhE9flYvO2xfJYkTubFaC7P7md
 FAGuHvhPXm1PEQ4k+jrVos2Wc9Ifqci/zyn4YrKwsQQLbs20Hy6ATjF0InHD3jjqAW+x
 scTwJJWqCOwcPCPqTXYP7/NkXxi1VDxKAzoYz503s8wjzA4ea1++pY28yhEYEJ+QpPPD
 AqJcd9+rl4eDZ3EKB+7anRX0jsSql9kBAfk8SKQlM0MSzWnAeyma2Qz6/BZjQOxbSWd5
 iVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WB/Es8nYek42nkh/1Mj4Lr14rj8kBGnNq/LuX5WPz6o=;
 b=N1//aF+hum9slCAxQhZST8DfNNyGF+FTMnBlTcDBpKAeQaP3/36QGIkpBuTkJTJQkU
 t/bH0TUsCJQdPxMfJC/5VSQ+e3EfuaowGOxI+1atSfaX+UxelJAbTiFW6u5yFcyJMznY
 DKKZzY6e76qGWN2Xl1m6aUIusX+28wyC97M6vOqZKmyFUgByP8H8+WEc2oisf83UlmiG
 19iK9+MXt87eJ3NaA9BfXnHAwMlW+aMSv3MUwxMe7m11/LKXAAQcdTRtnD1fOmTuzR0a
 o0KsGGSIuH0ZVYWuX+1DKRcN4yApieZamFsGBJBp2QFCSGgSb7lUjAMVSqdCvLd9BJI1
 yw5A==
X-Gm-Message-State: AJcUukeCKBGEzBzoH9T22UhC6WeXI1HzUE5J/Q7Cbpf0hR5IpseKl5+k
 JOH98hOa7rZiuHhjRPV88wS8h2V2p0RbgUh0xHQ=
X-Google-Smtp-Source: ALg8bN5ktfaEXr9t7o5Pp5AuSy33o4C8vG7FHra8EuqEWvbORbiTB4ln90PRLrTPaJ8bYTXg5KfEL/beV93gdmKmYXo=
X-Received: by 2002:aca:6155:: with SMTP id v82mr6382964oib.259.1548091805344; 
 Mon, 21 Jan 2019 09:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <VI1PR0402MB3357FAB48888D99A809F41AEF99F0@VI1PR0402MB3357.eurprd04.prod.outlook.com>
 <AM6PR04MB51581FBD4D21FEFDCAC2B27FE39F0@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
In-Reply-To: <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Jan 2019 15:30:00 -0200
Message-ID: <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_093006_832990_60A4BDC5 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On Mon, Jan 21, 2019 at 3:25 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:

> Hi Fabio,
>
> Your patch helps.

Thanks for testing. I will send it as a formal patch.

> Now the console works. Anyhow, it seems that now there
> is a problem with the network card.
>
> [    0.831454] mdio_bus 30be0000.ethernet-1:00: error -2 loading PHY driver module for ID 0x004dd074
> [    0.840796] fec 30be0000.ethernet: Dropping the link to regulator.0
> [    0.847212] fec: probe of 30be0000.ethernet failed with error -2
>
> Booting fails now because kernel isn't able to mount to nfs rootfs.
>
> [  111.652134] VFS: Unable to mount root fs via NFS, trying floppy.
> [  111.658510] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
>
> This problem is similar with the one met on i.MX 8QXP.

Does this patch help?
https://www.spinics.net/lists/netdev/msg545573.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
