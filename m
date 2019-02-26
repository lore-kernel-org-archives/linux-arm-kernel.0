Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82271C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:22:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBA621841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FeOU4KMt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNjZCV6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBA621841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ORmbnuEiRKyOAjEfYybvw1BlyvyrkrRtzcW53ttUSww=; b=FeOU4KMtaMXm0P
	gED5pYMvr6pPsPORIRB1gMZ6bKSj71/V2VB035owXDFzBs9y8LGE/B6R6gK9J/+KGksC5HPgsZm+h
	RmNh3SM7Q5s2ObcW2W9HB/wnM1JKjk93GGen13FoY7vAcEfPucNefz58qsllHE1/OXD8NVWc5uBqI
	1XMzj1JEB3Ja7pTrcF1gmzf3QiZOG4HSaDMGOMGE9AOA1g6LyD2LX3tSUwMl2nuTx2r6vb+4D4paO
	uZATk8PIRCFX9Ksk3euui9yqGDhgyN0uEKSt4emOLWx8jaaVwTGalnFLNPBplac0by0CODY+niC0C
	1mT1+9iufYOADtGGdnTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gySOV-0004ED-B2; Tue, 26 Feb 2019 02:22:55 +0000
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gySOS-0004Dl-9e
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 02:22:53 +0000
Received: by mail-ot1-x331.google.com with SMTP id n71so9794311ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 18:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RPOE5qG/jMcZ3PMmmCJSjnKJ+x3bN8vo1DSRd0K9XWc=;
 b=kNjZCV6i2HnQ4RjtNaPvVLxQEfy9+263Ap/e1vUgbjkqxzvPI2fp9Yh8Ln9C4vo1fH
 QpiM4jcIX2j8xhvoKPPigny/UFChzFF0zhL3AyWgSlBFrk2iBe7zj4YUgJjRjc7gJL/W
 rt/fZn2/0vbQnZCBksTdplB9282mzHDQXwj0649LSEfGEAjxdTCbVBT4bqGOnKhHgpck
 z8fA3fuwpLgqx3Ji4u3goytCOcErrrWYwnzX9sAM6U5x7D2kkcf3ZHM4UxuiowmiYIQY
 mBGXFDcooLc6gjYejSzgVXqdW4T/cjkmBlnjFjqH1K3VRlaX6qzb4b1sm2v3wa+nkmKf
 xFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RPOE5qG/jMcZ3PMmmCJSjnKJ+x3bN8vo1DSRd0K9XWc=;
 b=kXD0G24qyq4UzDM244qB9DGCthgBXlLZtWW1fDzzAtnck7FtZLXF2AxaN6kzFKkcO1
 jXtVaUJsas0+gAGgDl2EBXWLVkiriLm9t7M6qVzchcnJiQC7rtT7XgPt/SiGovfY7/+c
 iOaoAjf5NK1+CT2c+Z/ydBDmQ0TI5cJqsRJgcmk+gJWx5pg/cK0l/dPLjVvlSE7+jfFz
 t+FK8cIJX+VQq/SN/BxYgpJW38u2jr3rXVyzIpQAZhPbsPWYk5jH4Rh9jtl+xNAzAFiu
 SwyDuKwQI0mu1APug4W9ZKH8QWhLzUF4OP2XCbuJ1nOKIUP6HSDbNfXzLzm+xgjdwaEH
 9Bhg==
X-Gm-Message-State: AHQUAuZIUlYilOhgf8bMapTURZPdSgy2hH2j0NkFfpqwGKD3DbiNRAvq
 bwhZjyLzMjldk8SJZMFea7jh0X0lWyS3NBDScwk=
X-Google-Smtp-Source: AHgI3IY8xDCQX5Y6pXTvRqLytYqUdl8s2LiayKYRQKr/NZ8b4eXYBbxjq1bTJlFG8Q76usZY9y80fD7DTp4k6t3AU7o=
X-Received: by 2002:a9d:6d94:: with SMTP id x20mr13208712otp.78.1551147771341; 
 Mon, 25 Feb 2019 18:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
 <20190226020623.18324-1-okuno.kohji@jp.panasonic.com>
 <CAOMZO5BzMuWa16d3NOtOFgdBNOCL3YGsYW2s0eGxbnnx8+wdJA@mail.gmail.com>
 <20190226.111916.501059283228026708.okuno.kohji@jp.panasonic.com>
In-Reply-To: <20190226.111916.501059283228026708.okuno.kohji@jp.panasonic.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Feb 2019 23:22:40 -0300
Message-ID: <CAOMZO5DOF0Tc=OKkjw3_xzJ2BY4eq1pRWPCfR7QBjnJZcst8JQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx6q: cpuidle: fix bug that CPU might not wake
 up at expected time
To: Kohji Okuno <okuno.kohji@jp.panasonic.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_182252_362209_D9F218E7 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kohji,

On Mon, Feb 25, 2019 at 11:19 PM Kohji Okuno
<okuno.kohji@jp.panasonic.com> wrote:
>
> Hi Fabio,
>
> Than you for your comment.
> Just to be sure, let me check.
>
> Should we change as follows?
>
> -      if (++num_idle_cpus == num_online_cpus()) {
> +      num_idle_cpus++
> +      if (num_idle_cpus == num_online_cpus()) {

Instead of doing:

       if (num_idle_cpus-- == num_online_cpus()) {
               imx6_set_lpm(WAIT_CLOCKED);
       }

You should do:

       if (num_idle_cpus-- == num_online_cpus())
               imx6_set_lpm(WAIT_CLOCKED);

No need for adding { for an if block if only one statement is used.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
