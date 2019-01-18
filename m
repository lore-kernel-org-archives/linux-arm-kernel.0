Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53FC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:56:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EF520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ab+hU7us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EF520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1fvrsugEl3kaVhiPK/4nMri+7IyOiVpImX0/6cZWDK4=; b=ab+hU7us0LfPab
	m8acKNviQBz7bnLe41GAq0i/d7nEp002v088qlm8G0kTCg6cLpihE18KW6iK/0S9h79uCCYH2iHv8
	Q4lg3kZqdwzI9TnD1pRDDnydYCSgjMpypAlytlHX869gTICKtpZ1rpUdHftrp7XNd+YIlHdyWWXeD
	+FisPh9pYZgEMJ/gX9DS5mQ3618sirHAm9Z8SLXnGpESzH06PufyDezWHIEN7S7bgFzvNp4qhJUNd
	0J89BZKaJET+ewbQjpzcbuQF8FFLaVfR00E5Xw2PBtqdDhPaI1iNKdS1O75+qKjA/B9UYN1kasTFM
	ynigodCMCg4QUXHaN3/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd3k-0004TZ-6P; Fri, 18 Jan 2019 22:56:20 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd3h-0004T3-3u
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 22:56:18 +0000
Received: by mail-oi1-f194.google.com with SMTP id y23so10259278oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 14:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=auZQbowt5s5QjzxAiRB8oW0KegrxKItGnAZm7hbf3L8=;
 b=RMYqp7QdadCJoZcN46nthtzzN5+k0ejsvIVd3vEAdpLyxVFpIADrnJIopdLMU86taL
 Uz6hY6sCslm9J26qar1Iys7ftsRWzrAz8FxBaLWah4TCO/oL2IgZ+mOdyghNMiPV8gNY
 +c6qVmz1xiNV2HvHteafdAeOvYrGmWogga0PxxrTkO+06Zxd9Sq0AIdm00dW7FWBzkEv
 fxoTfE2X/ATi2JNig4xPrmSH5Spe99FSp4B9iFlLQrqO1Q+6qdvsZkjltDt+vvNd3j1g
 fu1Nb3+aiKzmtMW2s9kmancUjga3bRhavN/4FfrSz/ttLa0FSYu2kLhrj9cC7ZbkaUNk
 4/OQ==
X-Gm-Message-State: AJcUuke3mLIK97skuqPyZyMnJQlUiJhn1NF2wLAtk4HX8gXmKxZt9Vxw
 mHp4hH3R7GP1P9KQ+mnvdplqxKZO
X-Google-Smtp-Source: ALg8bN43avmBCXpXkj9dhNqqYK7srj03/VxL4qNGcky/vCXcr+dG60geqXMR6LP4RuWz0lJA4N2/WQ==
X-Received: by 2002:aca:cfca:: with SMTP id f193mr475545oig.141.1547852175615; 
 Fri, 18 Jan 2019 14:56:15 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com.
 [209.85.167.173])
 by smtp.gmail.com with ESMTPSA id r9sm2977248otq.81.2019.01.18.14.56.15
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:56:15 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id v6so10281799oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 14:56:15 -0800 (PST)
X-Received: by 2002:aca:31cb:: with SMTP id x194mr1775720oix.213.1547852174889; 
 Fri, 18 Jan 2019 14:56:14 -0800 (PST)
MIME-Version: 1.0
References: <1545403302-22475-1-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1545403302-22475-1-git-send-email-madalin.bucur@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 18 Jan 2019 16:56:03 -0600
X-Gmail-Original-Message-ID: <CADRPPNQGxzx4uX=vOsAK0k3PUSzCj0MPfrKzZb4dYk+dpx=7-w@mail.gmail.com>
Message-ID: <CADRPPNQGxzx4uX=vOsAK0k3PUSzCj0MPfrKzZb4dYk+dpx=7-w@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qbman: avoid race in clearing QMan interrupt
To: madalin.bucur@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145617_156679_8FB196F2 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: Netdev <netdev@vger.kernel.org>, Roy Pledge <roy.pledge@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 8:43 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> By clearing all interrupt sources, not only those that
> already occurred, the existing code may acknowledge by
> mistake interrupts that occurred after the code checks
> for them.
>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Applied for fix.  Thanks.  Suggest to forward it to
stable@vger.kernel.org after merged into Linus' tree.  It would be
better to add "Cc: stable@vger.kernel.org" in the commit message for
similar patches next time.

Regards,
Leo

> ---
>  drivers/soc/fsl/qbman/qman.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 52c153cd795a..636f83f781f5 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1143,18 +1143,19 @@ static void qm_mr_process_task(struct work_struct *work);
>  static irqreturn_t portal_isr(int irq, void *ptr)
>  {
>         struct qman_portal *p = ptr;
> -
> -       u32 clear = QM_DQAVAIL_MASK | p->irq_sources;
>         u32 is = qm_in(&p->p, QM_REG_ISR) & p->irq_sources;
> +       u32 clear = 0;
>
>         if (unlikely(!is))
>                 return IRQ_NONE;
>
>         /* DQRR-handling if it's interrupt-driven */
> -       if (is & QM_PIRQ_DQRI)
> +       if (is & QM_PIRQ_DQRI) {
>                 __poll_portal_fast(p, QMAN_POLL_LIMIT);
> +               clear = QM_DQAVAIL_MASK | QM_PIRQ_DQRI;
> +       }
>         /* Handling of anything else that's interrupt-driven */
> -       clear |= __poll_portal_slow(p, is);
> +       clear |= __poll_portal_slow(p, is) & QM_PIRQ_SLOW;
>         qm_out(&p->p, QM_REG_ISR, clear);
>         return IRQ_HANDLED;
>  }
> --
> 2.1.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
