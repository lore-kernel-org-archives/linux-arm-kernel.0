Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:42:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB5920834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TL0Z0WY/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcuIxjvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB5920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sznFsgfFRE9XtW7yBXOYlv/tasDeUllauDF+ebP293o=; b=TL0Z0WY/HtQlFB
	Or2r9/SpqFpgDjtLVmNs6sN8eKvxiWM04ab3foUtGpvrekFhOOuKUBRmF+lfogey5It0KUAyca8jd
	xEzHU0eJOWKa+HpZ6MER7X4H6LPs4oy5EX8JZ5NTfpywCue6xAwPOm210R237zAdBHBcQz2zeAUXw
	uJkjD9OZHOgVU40QQw/ycREBjaketTzlOLIphcgMw/GAozS37rcTHNFPllNwNCjoIMO8S38Mj9AjG
	vB6dL/zttAKITcfD69ynRFWiQ9vWe5yddUerLpVksthSjiVidqUEMKCF/7G06TYSWhtwDD+OVeVeI
	I/I2RWfXGF46T6s5lUaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmcY-0000zm-O8; Mon, 03 Dec 2018 11:42:38 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmcV-0000z0-Le
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:42:36 +0000
Received: by mail-ot1-x342.google.com with SMTP id 81so11289783otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 03:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2WtzCc7AgTuIPm8d6x2VuZKjqnIwdGuXPFknWJoEers=;
 b=LcuIxjvRUiqwQejzTumi5yXTkKjn+SksN8B4AgCCeBMiUOc+U19co/6Ay0Hfvw/zt3
 EgdwtwK7YqeyV0EUsHWR8/0SBxXZ0bWwU2PdGyk363v2stDcLK9F1L9L63SsZW5bE0j/
 8ftxhHJIAfRMGD+qGDkU9rYCbZOe+rWkzB9nWoMf1RnAbztROX54i58pijc224UFCwjV
 nbj0TELbuSeer0UW7Rb23BYY0zGp0v2PT77w1G7zkK43f1PY+kpPitRRDYJQ6DJPRyFN
 8ev5sdgy0NB2XVseytyZBAytGBFL3XRc7J+3lxTDOiCvu7hX8Mxd9leEEoaArmrmHv/6
 Hzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2WtzCc7AgTuIPm8d6x2VuZKjqnIwdGuXPFknWJoEers=;
 b=TueAUFMOMmoDB3rn5zrNPLnkkIQSYWlWtnKuZsZaAajkP7I6/zWYOxH8jD0kfQHD0/
 +pqZnk5NShRhYxGEFcu1dXcRn+/AYLeaSDXagOZMhMmoouS25eVegVT7Vqkb9fItHN4V
 5M9VqrWuAHPIjUskhUx/wHnHVcLiQ8BaNYuz2J2NsA/9wmSl9eYGb/JEb7dYdgOp1VFO
 FislxhPEfYqZxmfVyNNWdTRA8/NhMHxrV3ar46F6aNLa8gt0Z2KbVH1o4PDucFsejPY5
 L7vpYo6MMjvv+cq2yPB2OszNCS3kPB6P8pe+2vCiQu0biHxrqK7WD4PN3kOS7+swsrqn
 DjeA==
X-Gm-Message-State: AA+aEWZt2t2BABXtZM3TF7Z1Amcpq0FQjD8M34XiKQ0O9UWD4T3Gu7Nt
 nUh0ky64/1WjU7wv7eF4u+Cu8bz9ZmX1U+xrHJk=
X-Google-Smtp-Source: AFSGD/UySL6cSKHhgQYnEHIwvmq+CKebPJXBJgM2FHMsaUvpc6PmX8oQLlm0qci7cezPGVd1EOd+3U9tqTf8gWmGKRQ=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr10360972otj.228.1543837344547; 
 Mon, 03 Dec 2018 03:42:24 -0800 (PST)
MIME-Version: 1.0
References: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Dec 2018 09:42:26 -0200
Message-ID: <CAOMZO5Bc2z9mtWN5HDDbLggryEaxF6eay2Wnu8AdBSBNFZSmXw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: update the cpu power up timing setting
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_034235_709720_21E41F8C 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 12:45 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> The sw2iso count should cover ARM LDO ramp-up time,
> the MAX ARM LDO ramp-up time may be up to more than
> 100us on some boards, this patch sets sw2iso to 0xf
> (~384us) which is the reset value, and it is much
> more safe to cover different boards, since we have
> observed that some customer boards failed with current
> setting of 0x2.
>
> Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
