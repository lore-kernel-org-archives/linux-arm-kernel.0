Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:35:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49AAD20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIwQSbuw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MW/N4POS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AAD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hokp8Fi/oArBUSN7CB+A0LTfucRyPtd49WP9MbtCw98=; b=GIwQSbuwQwQ2QV
	cDq4J9h8iPoa5WPRCCOjnHoB3KBvHRCrdQxVj0569y7W+9nBSW8TTnx//A+dO7ML3hFe2MKRyvpTK
	khwrvl7Vy1RQU7G/qS1V3r5B949krDOcWM3rAeHjXcEV93kwex/f9BtaK8j/Ev959oYQIR12WqZ8W
	8oPEhzLeK34Z4+GzsGy34+nPWiAAXs2N8O9pKrkFTwWTYkw+ogM6I4malz9hl2TCEk3sPrhAU4jgF
	+8B81EOzRA27E7lp7RrjCgP4muol/1QAW0CS2JHYDC9NNUL93LF2ZOdQoWWxCEPbcJ9PbS/sgyNt7
	pH2U0lvrUH820nN0y37Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gipHl-0004sU-Fg; Sun, 13 Jan 2019 23:35:21 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gipHf-0004ry-RI
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 23:35:19 +0000
Received: by mail-lj1-x241.google.com with SMTP id s5-v6so17395701ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 15:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zjYM19yOEPsU+ud8BmeG3oivsix/FAcL+sYI9urX9rk=;
 b=MW/N4POSy7TdPq1Ne41HvuwWSN/MkcTZus15aM7ZGhQIjNzJWbNBjiUG7diGgq0dUH
 Ni9AnEopQ2Kkfxx5IScmMHrx0N2UDZyowdGJEdJ6q9H1Ku+BEfWC3CLt2Nj46Spmiqst
 FdMbK2XvPsU4uvSRMAw8VJbxJ8lC+q28P4gT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zjYM19yOEPsU+ud8BmeG3oivsix/FAcL+sYI9urX9rk=;
 b=jF/1E9mQ3ZNjvj+IRihGlexDBvP5KnSoJJP0AVL7NRjr48MJ5ckbh6bce8GF3S/glc
 1gkj56QieZrdxfGuFzArT3Hr4kxF5+ttTEgTelfW5WFNq9bP6iJH77snkCt11w/DMWwC
 Pbi+zxP5T+sXviumPdlXxKxQQdY0czHMwkUA9ULyZz87b2/p6GC5Wt4QIHvzQujPe3Dm
 17m7OAie5VvwYgLiPPi96Vtwk9Pmkem6t75tdHBgwKyEnKC17gSKT6cQNxX/NTQnREoE
 g4bZsG5GUB4nFUTAE6IxmhvvU59ccuWaYO0nMydVU/ogsPkAB9vqmPOhMBYWv+7q5SyU
 5dvA==
X-Gm-Message-State: AJcUukfibGKIA5v9FtXBlMGUwYCmOpaEXjohP53S/MJcZfpKUKK/00Xd
 hRTiP11fRVn756E6quSShID5JCNdP6rc2h4NUBo6wQ==
X-Google-Smtp-Source: ALg8bN4XtCjqiIajtM6DrDZUytYdp9E/E7b6Z7d4cXqSMzj710KzdzYgUDLMZo7mhs6ReDo5+TQNKtIe01hiTmFvcSI=
X-Received: by 2002:a2e:710a:: with SMTP id
 m10-v6mr12818811ljc.66.1547422513407; 
 Sun, 13 Jan 2019 15:35:13 -0800 (PST)
MIME-Version: 1.0
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish> <20190113154028.GB4635@lunn.ch>
In-Reply-To: <20190113154028.GB4635@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Jan 2019 00:35:01 +0100
Message-ID: <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
To: Andrew Lunn <andrew@lunn.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_153515_893097_8C085AA2 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: linux-pwm@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 13, 2019 at 4:40 PM Andrew Lunn <andrew@lunn.ch> wrote:

> > Another look at this comment made me realize that we need comphy
> > initialization support in the kernel for PCIe reset to work correctly.
> >
> > The workaround that this patch proposes will not solve the problem for
> > v5.0, since the GPIO get_direction patch will only appear in v5.1.
>
> You could ask for it to be applied to v5.0 since a real fix depends on
> it.

If it makes a piece of hardware work that was working before and
now is not working as a result of other kernel changes I would
definately apply it because that is a clear cut regression.

I am under the impression that this is the case?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
