Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19686C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:10:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD63F20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xd2E0o7L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez6NUEEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD63F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijGQ/GQ+WeOBzYvahryvVR1ZwNEL3XbKT4QESFE82eU=; b=Xd2E0o7LJqFYVQ
	VVJb0uixnNc3MLhw934YiND/XNkr6uU7FtQu8YZramowHZGHAYXvtpkxDQdAQeqRml3bwa7No/5ad
	91WaCZ4onyQ6Su7F9yLxe3x5V+puwJD1KuxlWlzLEM4sQoFFtRBV4JuoxjhUG/1M1VBspt5BEY//X
	GDXtbT6DjsxlZcgD+iLMCqJi7YAtBD6FoLp8rx51e8PGWg0MtH9DF7NWdsutYYcK4a3ywjqNB8Aa2
	r9t1glMvDtNSprpgCCaacOdX9iLPqAsIxJCtPEd97gfH/uS5aM+NVJbLNMzENI7piP3nJ011O523y
	V9dFkkn/TYnVejyt0Aqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGS1-0004U4-2z; Thu, 13 Dec 2018 02:10:09 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGRy-0003UJ-C1
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 02:10:07 +0000
Received: by mail-ot1-x341.google.com with SMTP id u16so452302otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 18:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=imX79k8hryZqWwipn8HJiFoCAq9gA/WHAN6S7qVON5E=;
 b=ez6NUEEEFgAbWzLt1W0y2/7MtNSfGFUhzbNasMNS/SjgxSxnMqyWEXqqq2dce1dyEs
 s7zMKVDtoUvGPpf+5hVTV5aIfuOcXPCmqZqzpM6tI2kYcltpgUtqpU1p4OWZTiSFOl55
 Zqj1BjW7hqUCNKnSCKN7B2RbSXIlXRg8o27Dj3Cigy5wtjx+GNmDXH84peY2je/N1vNV
 2xgWeMb2AfHnJhyWb54RGmYgINlwwEBkBjrQCectY4PyTyHfU6wc/Sip1ngov6sCIZsY
 16FvxT/cZiY6xgNzQKNY6g+JTBe15Mdsqs+Sp54KeIl8DrQjR8aRKGy+Ml77Yx1uo6AM
 Kycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=imX79k8hryZqWwipn8HJiFoCAq9gA/WHAN6S7qVON5E=;
 b=m9McwySWDV4oYxxtVDC212JKYtbhDHERUQvcsYTzHW8zxeVDlnPVoi5IOgEtmbUHWj
 zRIqM/cEOU5qiBql/glSL0sj0TWQj2BPsTY3AR22xdt0M8XqqDpZwySJUTl4x6AjxImk
 P2XYHow7QpbqMnRPcng++EtHP8U6jiQ3wW2TaUL6W4d+K/E1eXtuoU2xyD1DYAFT3jdM
 jUOczeitlxAg6TugOdmmrUrV6MP5Uos3E0by35Gfm38b2T6NOMf5luUrl35twPsR/fIi
 JqCQrr8P4Dilbb43bpWKNi3hRI0lxtHzVwMDkmnhsR+9L8J1JvXmBafUgh11tylJ08Td
 4tYQ==
X-Gm-Message-State: AA+aEWb9s+GWzbP2dSNcoYTt8yXSs0httpy4aeV/Fm6vk7HInZPVP/xi
 mY1RdESIkrJ5W6y9LIkpNh+jnM2Hop7ns12tOu8=
X-Google-Smtp-Source: AFSGD/XTK9p+/RmC3jNEyYXePEFp5tFgp1uOIlCDpTKvmAEm0yf0wq1OeuW3He8XXfG4SFHrtfoXdLGbBH1/rPrBcb4=
X-Received: by 2002:a9d:401:: with SMTP id 1mr15328569otc.78.1544666995335;
 Wed, 12 Dec 2018 18:09:55 -0800 (PST)
MIME-Version: 1.0
References: <1544647253-3806-1-git-send-email-festevam@gmail.com>
 <20181213015509.GA11997@dragon>
In-Reply-To: <20181213015509.GA11997@dragon>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Dec 2018 00:09:51 -0200
Message-ID: <CAOMZO5AR3GQsMnOLEFfkF5U-1T0n1USMzDf2Xe4sSSykbBYO8A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_181006_428652_D63D04E2 
X-CRM114-Status: UNSURE (   7.77  )
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

On Wed, Dec 12, 2018 at 11:56 PM Shawn Guo <shawnguo@kernel.org> wrote:

> I would suggest you drop the mentioning of the commit from your commit
> log, so that Mark can take the patch as a preparation for i.MX8 landing.

Thanks for your suggestion. I did it in v2.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
