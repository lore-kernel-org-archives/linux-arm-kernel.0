Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C291EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:24:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9433C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rY4MYCxo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoCeipWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9433C217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K1A45Y05/cG3yCv/J3mAOkbqEEYV+VCc0VeAECJYU/Y=; b=rY4MYCxoqoEDcf
	24PFhGKMWrHwkOcrQ8U2NJWlvl78NiL4DgVq8ZsmJPhVnBEHH5xHn5p0gdCB53bgdBIdmX7+azqB7
	fxuIYyTD/yX6KXnuLooRDXacD9f1XJtjubzWwjj82QMUwQkFEs6X7EG8numfxHLHqDHf1NCS1CsAv
	geLTFKoynRKbYWIamX803nzt9/rXL86JWqWX2S+sjgONpvmWHM8Q2l5+iQXdjVFs17k+o5QZpUf9v
	ovGqakkICyddOKjzXcDHvJQqTZVQUhShtWOMqPpSoEiS0nowD2APEiqpzTlInOGL3evShphQLDqng
	S1glREr3BnzW+eaWRujw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCYK-00019o-KL; Tue, 18 Dec 2018 10:24:40 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCYI-0000ze-8l
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:24:39 +0000
Received: by mail-ot1-x344.google.com with SMTP id v23so15143857otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yo7Facm+uSYKgarZQ4xUxE44ZtaxU+yeTJgTB+RxuT0=;
 b=DoCeipWgtTObf1Tdh3wWrZagBXIJM5ER3+NFm/HmgSmJN7g1hJenXjpkmfsvUpAJyX
 V9y6SRJc9CjB37efxJFzrZDHDOYsc5UrruqOv7SttCLhGYVlHZY1wdwG7MAQuvqdFG2b
 NQRt69okHxgGmMKRHcGd0vrhhjgP1v1xX01GKkBNzWQP88FjAgmj5+m646HKLpVeGB7g
 V4zO0j6bt6vIKCiBUWkFSYswIF9HMuknk+Hha/IgvuOjnhZXZ52FVZhOgLlDbJ73mEuu
 lmUrJbMEiT95g+gOsIngC4daKM8S/X4iuER9DypFd8BXQvdvZeVKLXuqbdOC+j9D0sit
 5uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yo7Facm+uSYKgarZQ4xUxE44ZtaxU+yeTJgTB+RxuT0=;
 b=dx1cqvcC/cwNvNlYjVXjP2XSL4mbUlQ04dYSoEqfDAvzDM+cbRPFa5c8e/Gxd4xSVm
 TwMH2ByRJzfO+NK4uk/wnrqfP5cbgF39qEcOvk/RV6CWFioym/itj3RPKV4bAcVBDkVG
 wwrEOMWhwIBGTQ75LvcnTkj7xBkxAHL4/Zv5xK++EQpq74+45GUN4CkhptAiWJsrsEmo
 iTj80M1HVjlH3emJ85Q0SHqi9Z61fsRzRHeSMdrGp/AJ3zL+CTC9zyt6Wgovo5VSMvAz
 8Yei7EODbRvnwNyy3HwhiiCr7etqJhAZE03B8D+ObHrElCy+UmXylA63E6CFdxBydmBE
 fyHw==
X-Gm-Message-State: AA+aEWZ+T1QVpXiJR01SNcxAxW1HdqaSjD/1nfMctkYrejgZgaXedag7
 NJZ/GKbyBwgZbFF83VMrWn7zHEDrboB15GQV1bw=
X-Google-Smtp-Source: AFSGD/UIY/FTWyCQeuSxVhLDdIJHQw2yDs06WOA6Fw6acKSMAU4CFGKmoRCvw5FSH7KkT9q6DFZjc1tO4F9uZiDpDYE=
X-Received: by 2002:a9d:282:: with SMTP id 2mr11560721otl.287.1545128665354;
 Tue, 18 Dec 2018 02:24:25 -0800 (PST)
MIME-Version: 1.0
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 18 Dec 2018 08:24:19 -0200
Message-ID: <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
To: Anson Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_022438_308721_09CEB365 
X-CRM114-Status: UNSURE (   7.59  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anson,

On Tue, Dec 18, 2018 at 12:56 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> On i.MX8M, some of the bus clocks' rate could be changed in TF-A,

Do you mean ATF (ARM Trusted Firmware) instead?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
