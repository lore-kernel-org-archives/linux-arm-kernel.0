Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98781218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IECj53kN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqetOHPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98781218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ShYb4OVQnE/Fkt2mf/QZi0pt5d992ADlt9WsDidBRw4=; b=IECj53kNeVMs+W
	9o5sBDwkV+bO/6MsfxPi2yV9ybZyHBvQ6mHlhJWzGULVvMfZr6RXl52tqS0gZI7DI4Ci9xGtSjB9S
	6b9jv8sB59QglUm9vpzUocfotMTG9yPPLMjkympEzWIWpau5zWz8Ou8rO2HUV8kyl0kMbrP19Z96Z
	SOgLSC4yYKQxVvfHwV8397zFd07QNp/lNU+r0y2dONVLvj0wfPSRUdtzVSNHI3m8lIkDHYxQ67QJh
	MiTamYIqrmBh5Og460RRC/DT9eiGx4z5cUacanygX8Mk9CzWAb3sNAygElxdZ3lETOn96uWIyOuvZ
	fJzovWxEI/xUTyzbLHOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpMTF-0000Mz-Cm; Fri, 01 Feb 2019 00:14:13 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpMTB-0000Ma-Vt
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 00:14:11 +0000
Received: by mail-wm1-x341.google.com with SMTP id b11so4329908wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 16:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G5dUd1cmXTgOfeTepQdL/ltms5dnxE83Orq8mXBbnPg=;
 b=HqetOHPCIwZNWCjuo05uaE3oQSL9bU7/O08brsk/A+BKBSvys7envQ7jhk66gtAu2B
 jV2F6Gow33S+7XK+oDA/lkQpwczRpNlUdowQwBqRjE/ZgKaxSyguDxJ8N9ussokPQ248
 nxW9UM/8XEQNw3L+X9dZsqI3IryTWC/renkvoyYc3xFjJq4Xr8mhLrVNxETu5vWqpcGS
 s0xeM3hpqvJ3MnrnGhA06jmI5yIT6wDoxWdP0zBmBavCCxt4hROGw2ibBpVukKG7oQGd
 NUYbG8e8ZsbKf8YI2ShDjS4Gjpoby+aMUT3lNweMGcg5w/dFx3rJEAsT3tJGuVKs68qb
 yjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G5dUd1cmXTgOfeTepQdL/ltms5dnxE83Orq8mXBbnPg=;
 b=aMeXm2oLrllSiUSkaBBJOP+tvwudTwhOH2UWqshJ1Hb9hE/R5H3r+6AZ3qx2y1jy6Z
 86khp29AJ1EmeiKo6cf9ytEG6Dr3ZatWOLrOrXwpG0P+fKBncYN544S1xLxiYwF/n3Dw
 X1DMWgcnZkm6SM4bWOYN2VtkIBPpSEH7dwHY2ihi6tpqmMlv4pB4gK30JRC7PkUqvGQ0
 6JflUvzF0MgkbriRj39VD28cjWlBUG+5NPdq2US2mMRquLkjgCYXBUFF1rIyZdwQGR9k
 aVyS+c67+fAaRRW8W7LHn/vdDXmUFpDD5lqlBN8N7dZjKCgAy3rv+2ty7i2pg4dXhytF
 5zLg==
X-Gm-Message-State: AHQUAubV8P+LdmmCrBGerGh9zLwhN5csw2dSpIPIObyQQvEKMXQiM6wT
 R/vY3rC4JIBl31dCZAWoUzbvlLf/cnugSqWdSCw=
X-Google-Smtp-Source: AHgI3IZeBbZY1qlQtvhyIS4uUAdFpaZ43zIjXBh19mPFqPd51bOnAo6snpXEhZ710VhFDpaeHvSFPskr2MEq/upSb/M=
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr91967wmk.37.1548980047336;
 Thu, 31 Jan 2019 16:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20190131204524.1218-1-andrew.smirnov@gmail.com>
 <CAOMZO5Dgz1TS_KgCR5ikdYsM=VAS3iJ-TDGuythzxvGULuaC-g@mail.gmail.com>
In-Reply-To: <CAOMZO5Dgz1TS_KgCR5ikdYsM=VAS3iJ-TDGuythzxvGULuaC-g@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 31 Jan 2019 16:13:56 -0800
Message-ID: <CAHQ1cqEVc1f+Ja=vaRH_07kBwk34cc2vh-_HskS4-LhOznv3xA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Make GPC default interrupt parent
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_161410_051139_AD6C5B23 
X-CRM114-Status: UNSURE (   9.52  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 1:47 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey
>
> On Thu, Jan 31, 2019 at 7:11 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > Now that the GPCv2 driver supports i.MX8MQ, make GPC default interrupt
> > parent.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Lucas has already submitted this same change and another one that
> selects the GPC driver as part of a series.
>

OK, good to know. Please disregard this patch, then.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
