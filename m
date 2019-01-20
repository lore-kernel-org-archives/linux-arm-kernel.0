Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66772C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:54:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DE02085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q+7ZoI8P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJnM2xae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DE02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z8Fpx7utp4BuSJvy/ej7s2r7gFUw0SBlf2OyYOnX3KU=; b=q+7ZoI8PSUSxSU
	6w3DdvI/d2iDCzUXHSBX/uyGfPNYgLlylOCndFNWwXMh28ARPeCPeWV/QMlemPGMhwlFyNLQh1dhG
	SCsD5BkUpdLiepATBuOwumizqNmZE5QinXjfk5epnM7slAmXoJtMOMbrBLBNVLenrz30uidT81i78
	y18VKh+rS0Cai1d218ab8OtKz3uvOFLijUOF7rYvryttEMUWlEOTq9excV0Qlw9ty+0szl2dUqnTh
	RARrKSaaEOii4Mag1lMs7DuqdkEKl46sVVtYzS9WudMu0SdqgmEdQIbIsyzbjdhQD3yldmE19di0g
	0I9BOhgkgBl4U2mWNuAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl9oV-0003Y2-Ht; Sun, 20 Jan 2019 09:54:47 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl9oS-0003XD-43
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 09:54:45 +0000
Received: by mail-ed1-x543.google.com with SMTP id f23so14384736edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 01:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I6cNL5ToUtCNsr/CKvfB8RhbwkcNkmposyYLF5WsXX0=;
 b=qJnM2xaej1cC9JT9+UKiqJjCSsp4yBGQoNBjPHFoVNieeUD3xzNrffnXbuz5cGZBP6
 Ffa1aB5UbjsniPG9KlXUGRv04Cq6D+7U4w/WyMAxordNxBByySOfZgzoczWAG5T6VLip
 MbC8bK84rqf3MAW3iAXo+fbXWvfc854+pWI5lilzn6+EMdSiz8LaxBm+2s9kwiq80HmW
 Xi89C9DevR/UHbJbmrbUQ75+y1IxFxPnR75wJIAtifmSHBkymdFC4AOCIA0zxgdo4sma
 +KLzB9wtzpSYReKPJxwZuaK7UzUkWbASXFlG198g8mj8VG80JCVVAqHQlBKRuz8Wva8q
 k1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I6cNL5ToUtCNsr/CKvfB8RhbwkcNkmposyYLF5WsXX0=;
 b=BdKKG/pSHKairbMs+gdhsX5T5D7rukW6dJAJxn1z8Z3P+A5AOk0TA1HRKFyY4OdBM0
 NxXIB44XzRndDgmX6YHrlgGl0PKywsofQLnSz7nXNoXQ76EhQX3vjzNc+RGYXblSvl0y
 8/e2Bnc3mXgAHt7bZmZigcBXCBm1pglm4KgE0SrzIKYTsfxjBr1flRRo70M18oeERJE/
 ihdg7udz7cD5/Y+uDZ1yXNHyyxmNqF/UkV5fyh/5ReNZSBW94v8Q3kmCXuYAUzgQKcjB
 Ca7TWRneFS0Z1sO94M5sPZoesBb0Qn/wzPsYv+/s7YtLx8ScftxhafpX0e9l+aTOTMu+
 P2uQ==
X-Gm-Message-State: AJcUukeAVypaQmb1PcPdVBlpBy+IZ61GKBwEqGUylpdK9MjboniBYhMv
 vT//+TS852W5tdjGMwPzbrNWp3+5/VXuUHK2WZk=
X-Google-Smtp-Source: ALg8bN6nxxziJ1hdtrCfwWxbX5KkBx4SnU3osNdATcCywXqHwZw05R8ZpHnnqCjhMezeffvHH3GTrjSVXQGQcC1sjFA=
X-Received: by 2002:a17:906:a4cf:: with SMTP id
 cc15-v6mr20897762ejb.157.1547978079939; 
 Sun, 20 Jan 2019 01:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190120023150.17138-2-angus@akkea.ca>
In-Reply-To: <20190120023150.17138-2-angus@akkea.ca>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Sun, 20 Jan 2019 11:54:28 +0200
Message-ID: <CAEnQRZDzvmn-6YyoQRrWbkbH8d1ej8aFE1wFAiXQtqzHxyW2eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dma: imx-sdma: fix NULL pointer de-reference
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_015444_166076_1E93945F 
X-CRM114-Status: UNSURE (   8.48  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 20, 2019 at 4:34 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> On the imx8mq I get NULL pointer de-deference errors if the device
> isn't passed in during allocation.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Hi Angus,

I have already sent a fix for this:

https://patchwork.kernel.org/patch/10758203/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
