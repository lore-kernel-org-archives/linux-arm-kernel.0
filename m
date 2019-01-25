Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A0CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867F82084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B20vVUAb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpNy4djI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867F82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ROlehaTcZItSccU9UobLqsNXuL0UdKIOXiBJvDjYPWQ=; b=B20vVUAbUDgRD2
	4Mjtf6ehC3nvsEVWVWrBIF4Q6NLYG5gaW9p8/Se97PBnCsJ0LAl887DHr8C7/khUB7tGDqk9m3ZMU
	Ogcl1zB0m30Y+/qSZ/K3Wvzzk4hxdT3xU8P2BZEeFHzn55frBxrbeCOLBCl2A8fGyxJkln4mfn1od
	3Jij9OXTQYh2/wQaOJZbcscguDKhsJdnYneYgwkQSkkvAgomlY+2OZHLBBvFcvch3ezmMrJPCfM+A
	lJXM7ET+6aVBDAEiB3y73wcAIplCS+JvpkzGVP0cusAIhYGQH7sDcgo4qFbRZtP64xnPwGbwmpE+z
	rCLDeFrFLCW3yOtjZJUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmx04-0006cP-4p; Fri, 25 Jan 2019 08:38:08 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmx01-0006c4-9G
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 08:38:06 +0000
Received: by mail-oi1-x244.google.com with SMTP id u18so7099974oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 00:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=haHzJNDp12yWJPXSle2OntLzZrKFwMCCU83mF0ecmKA=;
 b=YpNy4djIv/CLDFurHku8NdDYVOmlTOlJ5PfcTGx5tNYYAMqVwJFp5bwtmWDXvtzgvq
 83Re15JOtknX3AtqSqZUFyd/TbgLrtY5RFgMXW7veyA4IVrwBARuhy+WJrQOKB4+FQYO
 ssaZK3nKLJxfzby4wjAdRxuE4WWs7ERwdHkxzgvx9zKpPjd0jvgH/+UIYc7pHFA+SB0Y
 UxEIvlaJYzbCdDNoALZAnbMTE7YwfLshCNatp98gLv8JdAeeGTUf9hyoJeJvNaW3wDJm
 tJXYy6jwDB/duXU6HF5g6rH204rOg/wUG6JmsqtoOxEVR6jtIM0JgqvgmFkJ+LOtB+lC
 eBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=haHzJNDp12yWJPXSle2OntLzZrKFwMCCU83mF0ecmKA=;
 b=g3rgLuH7ESbvx9kSnJoUJao5lQiUJnEXtnkooe1GH5EPBf/zct8WMI4koztvEyyN9e
 uFIbVdRgckxbdqCjnepWQ4ppnw50x9NfUVrFbh21UUyChgWDJfJIJS+XIokf148vlxso
 h9dqnwchkIByBntlIVOyD7VX4hcTnzWO17nRUrrDMOI+DbK59e0Ui9vQcG2o5m6gb2Jp
 u33kzJHioXylIHIno73mVQrNOECBicWW8a0zz2jezpiFvYPFizody8tzVo66sTF4oJHR
 hIQVCsR6XyQCAnedGo2PIetLGj2wwxfCHcuTMqUGk1SRFho8nfPI0Abn/0q39hmv/okr
 8Efw==
X-Gm-Message-State: AJcUukdU+sTFuAOT4WLzpKv72GGujAjEy7Q0Ce0E5qS9loW8o1Kc4vht
 Yo+MkyCc3p3qmRkNa/zSuT92IW3DW94mYaPFujw=
X-Google-Smtp-Source: ALg8bN4OQghFj0Qhji9Py+s0mZZfnsCALno/T/sHLcTMLC0CpCTXHv8YkS2KEN2lZo0bF6ZKGhY7G4ZlNRlIfZy7Bvg=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr727284oib.41.1548405483792;
 Fri, 25 Jan 2019 00:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20190122165546.11712-1-ccaione@baylibre.com>
In-Reply-To: <20190122165546.11712-1-ccaione@baylibre.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Fri, 25 Jan 2019 08:37:52 +0000
Message-ID: <CAGUNXRSBMnvgtWgUk1b83=x04T81Bw0h0Q5GahCR7htej8eoiw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Fix boot from eMMC
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_003805_349429_81ED12ED 
X-CRM114-Status: GOOD (  11.21  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 abailon@baylibre.com, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jan 2019 at 16:57, Carlo Caione <ccaione@baylibre.com> wrote:
> The boot from eMMC is currently broken on the NXP i.MX8MQ EVK board.
> When trying to boot from eMMC it fails with:
>
> ...
> [    1.271938] mmc1: Tuning failed, falling back to fixed sampling clock
> [    1.287429] print_req_error: I/O error, dev mmcblk1, sector 1 flags 0
> [    1.306833] mmc1: Tuning failed, falling back to fixed sampling clock
> [    1.322325] print_req_error: I/O error, dev mmcblk1, sector 2 flags 0
> [    1.329559] Buffer I/O error on dev mmcblk1, logical block 0, async page read
> [    1.336714]  mmcblk1: unable to read partition table
> ...
>
> The problem is the result of a partial misconfiguration of the pins and
> the missing assigned clock rate.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Tested on my i.MX8MQ-EVK. I'm still booting from the SD card, but I
can confirm it resolves the indicated I/O errors during boot and I can
now see and mount the partitions on the eMMC.

Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
