Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C3AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:04:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0132B20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="llvzTM5W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsgFsXpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0132B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XD7ffytfgm0esx4HEHlf/jooezG9+/qDZ3F4zCHRe4g=; b=llvzTM5WGXY0pX
	YDFnOO243veqYsS/IQowT4n6EIkp1CC1u36/PkRff+dUK/MIROueC+uYUkjlk6CGz86h7URm+OHBh
	ptnUAw86ms3JQJAWdjv0tCQUU2PP2KvU7xqCEahPjqqiV5e3DsffNBKVU+qYwmvxf2qVtBLYDIGSl
	wqWurKNMomXSStHMMV4chA+PUv4AlyB6npvHK0KonpEaTXtmEY5pqdTfIzBJCwH7deUpIdsokxyjX
	8e3FU9EuLTSN8nX+9CtXWDQzD+Pur4QrreQIzy8cXpvdfZjd76tg7UMcrxoloxGCV3HzwDE/ZRTSe
	xtpwlD8SvUtfiuUyTBVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glunC-0007rn-72; Tue, 22 Jan 2019 12:04:34 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glun8-0007rT-Q8
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 12:04:32 +0000
Received: by mail-ot1-x342.google.com with SMTP id s5so23371672oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 04:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m7jsE4Tw1xCW5t0wypc1X0Au9kqzaXoEy9kbB86CPt8=;
 b=ZsgFsXpcW6XtHb2lsjTydDJ1hDInMEzKy8f1SphglDnXzShPGqRqsbx5wREI46EUop
 3Bvu9VuJoQA+D/5SPjwMo7nABCRev/8WVWPkiZAP76V+XDE26qYhQQd5p8RC9HWwuM3E
 UihbzHNY2ah89FYWTOhXaZhq9JrY7fdwtzSSRAS0M+cuEy1VCP8KnNF5xD2GvEUUxTiZ
 qctx8gSyDipT3Gy0JQk8HiPdJIWkyhRxQVLvGmuEvOLB/dm4bDzFrtBVwofAc0nPqP12
 AhR7yKlWyNPyy0eAv9ppCeKGTHULmgwln1K7iiQ5BFHWHPzU29m1DCbtdo/SlrTR8hgL
 PEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m7jsE4Tw1xCW5t0wypc1X0Au9kqzaXoEy9kbB86CPt8=;
 b=mZ4JFBlNNaRRL7Dbi4zrS65kj3987G8vHoaRpo3bDU4OT4+HFRkeIVOb3NjCo87QOq
 CzUbW8kw9hj8EEndGUzimBEoYljELAqqp+fmpQlkIcfm4Zu2C1ixt5RAdCMsvG7L4OE6
 I2KJDT5F9ggKOAh3sLvXZV4fv1SgOS93/E+UG00vWO/cHrLZKazdelWTeNyaeldt23uD
 pjY3qFKlL34cne3xjPvrwRLCmm28iVcYWNRJZs+NvBqbL4ukCwCM8pCNS1/KfSkELmH4
 biGKGpFr2S+Z2Mfj85vZKgxX9hsXyS53E7cpDFV5LnClkNREQ1iDKo9o5BBmHxdEHeJ6
 ayHA==
X-Gm-Message-State: AJcUukegAlaKB1PZHlWUSfsZRzpG9UZmkCTOWfka+ULi2rapqJ5JC9N5
 dcRkrf8wbMJ3WpCwciGd2VDQBEjbQf7aG3KTUeU=
X-Google-Smtp-Source: ALg8bN5qSxxEIG8wSGkrwLVUXrxWz8sRPKD0ffbba5eK8ljBL1tad4RUvhwBlsmqj+c4c3851r3Ent8kwL8fHzkR8mA=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr22697415otj.228.1548158666865; 
 Tue, 22 Jan 2019 04:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20190121202905.31224-1-festevam@gmail.com>
 <20190122060624.GD19929@dragon>
In-Reply-To: <20190122060624.GD19929@dragon>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Jan 2019 10:04:21 -0200
Message-ID: <CAOMZO5DbN0akhLobCuuw2GqFCbz+VdfDfh=6KHks_7bbChN+0A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Remove 'simple-bus' from anatop compatible
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_040430_868456_29860289 
X-CRM114-Status: UNSURE (   8.05  )
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
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

On Tue, Jan 22, 2019 at 4:07 AM Shawn Guo <shawnguo@kernel.org> wrote:

> Will the child regulator devices still be populated by kernel?

It seems there is an issue with this patch indeed. Please ignore it
for now and I will try another fix.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
