Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C91C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:44:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41F1218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="suxBsEyq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joKwKbqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41F1218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0IacdEssow5OHIPkxvwidhL4NZB0wGn64viTX+s9FfY=; b=suxBsEyqBdi4OK
	Dm5GFCZ9tyGy4YLL38nEWoIVAEMDyYAgFe5mWvE47pg8/iEkeGOtWjrlqRDzhjGD3yuXQWBHroN62
	ldMgC3z9IgYAq/G8F9cVWHCvGqUun4cXnQbAGp14FnlhPiuWlnhEBSu4ei7bbxsqqyea3f2Pu8p+V
	Ai+2DCJ7lI74yIwywNXS9yvYUlkf20KEi6YlOncrTzcXQbg5eYmMoxvp/cYcFsfphPMGkdLt+VCuI
	xzjJ2ox86Nk0vOCRnK8lXLV4y7oHfOXWMomtkMCpZLPHfmJa4dYyZjYo2ucVVrQmi2//3nuVmQ4cE
	lLcyBEB0Emygn1ooJ0MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4ax-0000TD-LQ; Fri, 25 Jan 2019 16:44:43 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4at-0000Sr-NF
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:44:41 +0000
Received: by mail-oi1-x244.google.com with SMTP id y23so8124692oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 08:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KXxgI/gFHo4ENmPjpfUp+n/MQkpucTbgVDOs+5am68E=;
 b=joKwKbqbHN13PZjVE0QDOQgqLAdlhGdRd6928DQlkLEZiHFPngg4vvNl/0ASWCsSMo
 K0Y5A9W2hoUfIG2v8yKjbthBZtegFSK1KzxJcj8VF7qfXqUtarcak7dftOoKDUGP+Cji
 HPavyLLAu+qz/7yWBGmNzpEey62jC3JEOeeQWI9lWNonpKUgy7AXkozY+XCLbuero7B8
 C2bxGnt40jtaAXQcJePyf0E7/DsoA1Ik6SrTsULfzIRSCPlsB9uJp7efxgQWof84w80a
 B3Ql6w54rBCwO7UrNb/SE0HtKQKrBSqwem+lpJLzxGsFUJmJsNaFazqpxq7bGhfOvb2u
 JOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KXxgI/gFHo4ENmPjpfUp+n/MQkpucTbgVDOs+5am68E=;
 b=mDae3joVhZhPrSem2Lk31sQ+MwKt16M4oMr6mISuyNkVo9nFmlByHwhEauuzf3+kbA
 nz1YVzCkgx1uy9kC0BlVq7QlQyWX6ZAQynDnD/OGLGnudxqD9E6GNiKN0TkmBHGcqszv
 +zgOhb6ZFAanuEccatNQcsNSoL7upASxrLK2hAzI1L8o1ofrk322s5u2dykkZsH3/AK8
 H/fIqJKlfSZ/X/Bz4LJor9WYgrAB1o23p5WIWD78k2eKxsfmbDuiZPCHfsjYGLtEMYxs
 O0hztdtgKfbbzBMfcX0k9MQNJ8pqKSateUur6v25P5w1XfuBcyowIQccQlXGA7zA/te8
 OIGQ==
X-Gm-Message-State: AHQUAuagq5d9tmOY5xOPnrxcFVnZyECpJ4X9dS8RLUdfXC6NbZMI3+/p
 1H7tY5SBT8JbanIjVQQ0yCK8xD9F8YRau7f74Sk=
X-Google-Smtp-Source: ALg8bN7UsNgfIf+GvfiIg6UGD0JYFk57dF1DUNp6uHIyfr8ejA4ovsYxUZFqwQmDylb+ZPWKlS+8nQSdtJ6xcF0SUps=
X-Received: by 2002:aca:ac04:: with SMTP id v4mr1843871oie.342.1548434675871; 
 Fri, 25 Jan 2019 08:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20190125162034.12984-1-l.stach@pengutronix.de>
In-Reply-To: <20190125162034.12984-1-l.stach@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Jan 2019 14:44:24 -0200
Message-ID: <CAOMZO5B-fo0qM7Jc8jtauJY0FKMnKBJQdjUddTwsVPb9GTtjKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_084439_795639_1DAE7CF1 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: patchwork-lst@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lucas,

On Fri, Jan 25, 2019 at 2:21 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> The GPCv2 sits between most of the peripherals and the GIC and
> functions as a wakeup controller for the CPU cores.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

In order to avoid boot issues during bisection, please invert the
order of the patches in the series, then you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
