Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2366C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E861222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RAxlhHnJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE1izkNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E861222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xTwiIoakmoZNFewwQSO+VQYXjjzLJECXlZnQ4jfqvIs=; b=RAxlhHnJbo7hZu
	2qX64G5JFOXnXOKq8nEbscOnWHzCVFEl6oeEJlO9+8tjU8xP/rasQ1yqSr6Vy+IA4J7K/omz1jWjD
	1pC0wF24Tl+yQg1vHDX8GyMcCuUwI3sBPgU8NwnNxTcvJQZMSnrIEiphx97ylxslrksS5dudt1uC1
	R/sTp5//f2FJK0/8TnaU+WbKUNafOoizf1gCeg5ADRm5HvJ8XBxc8KPBK3ZsEgVBnTNNzNvXXALc1
	xcdTb9HoOuoxuVdT/Pi+Z8sukmJdby5RtXH1S4g6isR6rLBqDft3dOG8A2sDwo4KnxU7WhNd5yiqa
	EGlMlmQxYb2i+EILDHGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfF7-00025D-Uu; Tue, 12 Feb 2019 21:05:25 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfF4-00024G-Qv
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 21:05:24 +0000
Received: by mail-ot1-x32b.google.com with SMTP id w25so127854otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 13:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uh461jKQsfZTov0Fo60VHZogw5ep9433+4fyJ7nFkVM=;
 b=FE1izkNf9ltpNZoQLIOrK0eMjfazsKURtMGiSQ+4GpXyOBplkJy0Vt4ziO7cMbn0Ym
 05alaP8UixPhBNnba+0CeKk1LZxdDy8w8I91CTZ8LjfM1/lLp99JBy+oyeeVzdJrDyGd
 gr/rnDoAuXkBLy7bkNr0B/6dxpz0X3/Uoblfq6VG3Z+xs3WdUNXIaxD974dBICClLLtZ
 ZRdTldA93Hte0q6bjYXvmEDaEdkiTbRsS9/CZu283xANXInvSROPkFJAASNbCQi/wAAV
 z4yLB8n1xqIjqf734xjnC4VE1b9pNy3sF98J8z9EdYFLixNep0EgAdUPZAhJKgP9/Vzb
 dszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uh461jKQsfZTov0Fo60VHZogw5ep9433+4fyJ7nFkVM=;
 b=XRGvUiQ8KZ5J8mB5/jZl9g9yyKBG3ykBza1rIRafkzHiNZv6mjhhwpBbmyOP8FzF3d
 VJoEmU4Wt/YkYAEWPzmsjD6rVV33rbD4mwTzaPIiOE7/5V1u6DnGIUsAnOa3LPXP4Qjp
 wswWaHgQdzBdxXB9mD4H2WSbTdsBh8AQ7Lor26ym9J6NnPUtqo9ipb90ZXzSSwdq5Yif
 2AGgCO63/0LCJcOvQu2Hwlr8XBvvQOMSn7Fk/QfekBoM8OgwiTdm5BtSObEiV9VnYXxp
 v3y0iKW6edx5/ecAN5dm4P2OnRXvrfweTrDTVgDd1woiaTsaGsZUMplPYKO8a8Z373SX
 E2WQ==
X-Gm-Message-State: AHQUAuYKZl2p8WrhLUjLxRhSqT3jwsrVk/mOATcA3bY04wDnMFr8pCBC
 fvSpTElwgzVOuwcatQ8+TVWYWMK2r9mXSO6HuVU=
X-Google-Smtp-Source: AHgI3IYYQF6VRabGQN1BCP2T+oSviUM62RiwUW/AJ8qOxrWNXxOdgZrH9w+R5Vit8OoAo7SNjnjwOJ5DYj5eAya4NF8=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr5712720otl.196.1550005518593; 
 Tue, 12 Feb 2019 13:05:18 -0800 (PST)
MIME-Version: 1.0
References: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
 <1550005119-25750-3-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550005119-25750-3-git-send-email-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Feb 2019 19:05:07 -0200
Message-ID: <CAOMZO5BK6JqS+3PTDQDcALqvZQhv0jh2_nPRLGnVk8KryFCVMQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
To: Frank Li <frank.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_130522_869957_C20F4376 
X-CRM114-Status: UNSURE (   7.36  )
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

> +Example:
> +
> +       ddr_pmu0: ddr_pmu@5c020000 {

Same comments about underscore in node names.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
