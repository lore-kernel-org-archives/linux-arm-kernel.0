Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3590C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88DF20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXtS9uVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88DF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KDjxJyrOXAOkOoiiEusIKQ66gZBIkb6eji5VA8fhx+0=; b=bXtS9uVH1J/w3y
	mCVaPoGmBzlw0uZflg3XA6I8Ovtw2Md7A++dzAon2Q0RUdtK7qlKYa1tsiDnABtFJeehu56miExjB
	ZmX4rh7tRS+P77QmL4CgjKSWBIdKw4ousCeVPI39/F2JtMqVlPZRBBVUbcqcyVXTVtL8vtBdFHsyq
	hK5dwZCjA6LyrXqehHlD6wYyFeagAkSeKbmBlyiy9UA+ugnvef7NxF25DYl8ugUssSc3eZf47eF/0
	Hid9oNTdxX1A09P4v4HHqB6Y/Zm4kVLYkymK/HlWoiWAcwYrZK/JAbfYQBS5j4WgF9tP92OvdIVMa
	48qA0jVoWZwW1puQoG7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKyC-00016q-8w; Fri, 07 Dec 2018 18:35:24 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKx1-0006yk-0v; Fri, 07 Dec 2018 18:34:16 +0000
Received: by mail-wm1-f65.google.com with SMTP id a18so5490863wmj.1;
 Fri, 07 Dec 2018 10:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7OErVHsTz+9MWPsO58Jikl5ucj/hyhsAvpkjo2HRL7E=;
 b=rZzF7s+CfUGc5lFVZ8BxX2qgGjdl93F8N2lYs8DNV7YJKR18ngd2V9ylm0m0c/uKsy
 9cG0n6bMiuINyh+QxwrU4acv6joXhoZ1LUHfiNuR8GjMkIHQzqPchHseQMsg3xx81MQF
 TlHnKZxOmHK0JPF3LSCgxI+zd8irmE+trLX96RalfwyYUZECzImgddUvmzXUwTytos1Z
 B1hssGwxi/5ne9Ccuv+nM2Vvcfo/rMXow9WheLBnGNBkBdzYMKOfB9h1VN4/XRkovF0g
 wisivmsMHiNEYVKVCFpMFuLjV7C3MRSCK53l5MeKEzBjmwifcGatjewROfVIZZMPlyrX
 pKDg==
X-Gm-Message-State: AA+aEWbasQekTSq06bYe0mLUF40Dm3Np3ipgYJuwu8Kz1yTOTjsCNiza
 IFAAh64PBmHzfwDyXeKwVos=
X-Google-Smtp-Source: AFSGD/X4G2+XJl+JhN8RDVP2LMggg81K4y0vL7qKDJ6QOumyqTioRUEkUYA/xEt8mJPJu4Pkn7ap9w==
X-Received: by 2002:a1c:8104:: with SMTP id c4mr2867021wmd.133.1544207638938; 
 Fri, 07 Dec 2018 10:33:58 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id v132sm4772865wme.20.2018.12.07.10.33.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 10:33:58 -0800 (PST)
Date: Fri, 7 Dec 2018 19:33:55 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Carlo Caione <ccaione@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
Message-ID: <20181207183355.GA17435@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
 <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
 <20181206155228.GA15225@ingrassia.epigenesys.com>
 <20181206185158.GA19901@ingrassia.epigenesys.com>
 <44c9eedf4dc2616645c2a49b080f42a493fe03fd.camel@baylibre.com>
 <463139583299c0099c812ad12017fe6d32662db4.camel@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463139583299c0099c812ad12017fe6d32662db4.camel@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_103411_689969_A5F24FA8 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 11:03:20AM +0000, Carlo Caione wrote:
> On Fri, 2018-12-07 at 11:49 +0100, Jerome Brunet wrote:
> > On Thu, 2018-12-06 at 19:51 +0100, Emiliano Ingrassia wrote:
> > > Hi Carlo,
> > >
> > > I keep running tests with packet generator,
> > > using nload to show bandwidth usage.
> > >
> > > Here is my test results with packet generators
> > > both running on laptop and board with rate 1 Gbps.
> >
> > Testing in UDP is unlikely to give us clear picture of anything for
> > this sort
> > of fixes.
> >
> > All your test seems in show it the fact the Amlogic SoC usually
> > prioritize the
> > TX traffic over RX, which is something we've known about for a while.
> >
> > It would be helpful if you could provide TCP figures with a traffic
> > generator
> > we can all share an inspect, such as iperf3
>
> For reference you can use something like:
>
> iperf3 -c ${IP} -i ${IPERF_LOGPERIOD} -w 400k -p ${PORT} -t ${DURATION}
>

Thanks Carlo. Just to be consistent, what value did you use for DURATION?

> Cheers,
>
> --
> Carlo Caione
>

Regards,

Emiliano

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
