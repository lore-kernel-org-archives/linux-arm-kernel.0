Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C6EC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:28:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3927C20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nf2KdxNe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QobLlQf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927C20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BK+8Ous29D6XhJXFyLOgbJysrFxtUvu0y2CE2XW4Xbw=; b=nf2KdxNegfzZ2b
	osRXEDCh4VFiR2cn6KtOfWSAxubnrjHmiDD3kAagX6EedbnmI+9Qtd+LmtVy2LNoRXkdhAYktbh2t
	Vfl2qLOB5ijH9bc7IIfw4GX0Y6HK/mfhARfbQZYhzBSG2yXPHjM/u8Qy2SGN1bEzFIo6dLaBi4noS
	xmf9oBvuUI2fWh+D+oly2r8jxEIIjZsyJRqrY3sNywqRResLgiKvoGlfQg1YRBrArDPAqduIXagPK
	3auMh3gi2Bs4w2uNUU7Yom0yXtKcVMD06m1Fkz4LP2qx7qW26bv3erqAWHLE6kGc9fb9Patun8RML
	ggPi4zu3HoNDglnkeizw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3ch-0007qf-52; Wed, 12 Dec 2018 12:28:19 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3cd-0007pm-Hk
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:28:17 +0000
Received: by mail-lf1-x135.google.com with SMTP id i26so13402400lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 04:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=aT9nxty3TM86li7NiJ79pWPOjhxTxj/YelOjTEDq83w=;
 b=QobLlQf9oYvejh/veq9vhaZmcML3aC6xyCQhCxKYfYXHwkQ+bNxM7kgVtliSwAErcP
 axq8C3y/YYX/Z47j25CPopwyC6qj8A4fXf67dG66+iOBe7FgvLDR+Kv6QDQLZ4KUNELT
 6HjU7d4SiKwdZx/JIa1EtbjQxfo8GrroZhu84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=aT9nxty3TM86li7NiJ79pWPOjhxTxj/YelOjTEDq83w=;
 b=Gwd5QXmUkik9LVi7y4NLosUX0Myn5vT01NNdPjTeS73tNZQd+yBDe1rAZItUO1m1gV
 htii0Rbu1Pl78LvgzEboA7cgOTZNDgX1zfFY9f4GY4su2EwWntxpZoJVAxrY1kAn2bZj
 CJbOUFwKkBwugKVVJ12mIyF5xyFZebtK7ZwxYduj5CcVuDWmGwxu9+WEWWoSzuYPJZDI
 KoFJ/r6LoB1EfdjykzQOKqdyTv3Rbf449aEnacy7VKTthOFJpgbL4yzWzL62jrcRfyj4
 DHk0Rrg6DVcn4Jc++iogxk3xk8bkmlE9XbjcW/5x7Rt6NvR6mobRp5ZD2T1LtPRjR3cV
 e60Q==
X-Gm-Message-State: AA+aEWZYHouej5qGDaxGX7LG3Z198904jc84BhkzQYu8uecJRFXglhv9
 Y/Z/4/WKsVQJXQORXLTrE7Z82Rd/BAI=
X-Google-Smtp-Source: AFSGD/VU6amgqRzpZG3A6RG4hwYSFTHnoZk+EsH31/yYQBl1iZP3YkcJaDjk5o44zXXBQBmBw0GbKA==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr11573166lfh.6.1544617683123; 
 Wed, 12 Dec 2018 04:28:03 -0800 (PST)
Received: from jax.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t19-v6sm3258901lje.23.2018.12.12.04.28.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 04:28:02 -0800 (PST)
Date: Wed, 12 Dec 2018 13:28:00 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm-soc <arm@kernel.org>
Subject: [GIT PULL] tee driver fix for v4.21
Message-ID: <20181212122800.GA29450@jax.ideon.se>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_042815_586380_BE55271F 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello arm-soc maintainers,

Please pull this tee driver fix for a possible double list_del() in the
OP-TEE driver while uninitializing.

Thanks,
Jens

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21

for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:

  tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)

----------------------------------------------------------------
Avoid possible double list_del in supplicant comms

A fix for the OP-TEE driver to avoid possible double list_del during
tee-supplicant communication while the system is shutting down.

----------------------------------------------------------------
Zhizhou Zhang (1):
      tee: optee: avoid possible double list_del()

 drivers/tee/optee/supp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
