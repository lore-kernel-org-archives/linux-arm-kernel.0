Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD79C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:51:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD883217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PgeNqKJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD883217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CR3zP+66oq5DFFjL7uBtO8425DaJ7Ui/kIcmzZLKL7k=; b=PgeNqKJveXTvDO
	UoQzFjj7PgY7cnT71UocYarYq0VmQWLtPtnNQ2KpcsOhI5Bxh1RCzWyjN5R79FEUkO6GVJysoWV3a
	AvZFgF5baqHH214Vl3muGrT5It/pEDt90Eg/q9oMQmVdFcC8Swxvq5bUUdKnG2IZwCa3fOPYFgZ/C
	m4CW/YQyR2lClAFuFiX9Vic4L4CWXttjqctYXhskhOviUCMpZkcd8HI+wacdtvw90l2EATklg4jGx
	r0gJXpzCeZulANBqCmQ0bHLnqwGSFUnIHAJmOUt1d1LhZ/REmoR6nj+phLv2aAlSwE+JTvf6KgO+U
	swDthZmAMg2s1m728DsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgwY-000750-3s; Wed, 19 Dec 2018 18:51:42 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgwV-00073d-0K
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:51:40 +0000
Received: by mail-vs1-f66.google.com with SMTP id b74so12887818vsd.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 10:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5TokM2+3ceSDd993kUoj1piT2WfOUEotHgursvSqn7U=;
 b=Z5NkBqtSa5Hwy9z7o5e+2TmURb4eNJ8EVTczlv0BTIqkSC1/G+QzhEO6e2V9UiA/Ne
 h5E6L2cBMMccvGjxx7tyZ6cHh1sWU595DUhOXkb7DSCjnL88s2MUiAwwHyYXORW72FSq
 CRZrEjJgXU4YbfXXgqLsYpzMp1K5vmC5O+92IIO83NfHNj6+uhQ9XNvvfHlPKf8JRSCc
 f8d+7cljtGnBSQbay8WuEvpXGhrDhiMMwoEI/vleqz1rpvN1m49XMXanivhu8xpayVii
 XGxMFVapPmowLuWF/qQWBP1xmYOH4RWCnUUWVj2zEm2O2pHWnxMmUZ8ez95WvETRFWVr
 y5Tg==
X-Gm-Message-State: AA+aEWYfx0xznPHuv1S5w4UY9GyuGkznWnyejeY6rbKsnmbPNupc1fJb
 9/0aC4uSd896+ECtTRZI/VdXEkky2XwIheOnXho=
X-Google-Smtp-Source: AFSGD/UPpm9AurcroU6T2utUMLC7hQtL57qd6KO8xucaimFsyH9yDa/aWc9kTo1YwtfBVAtUSlXD8pzkap7fXdFjTTw=
X-Received: by 2002:a67:c202:: with SMTP id i2mr9840788vsj.11.1545245487507;
 Wed, 19 Dec 2018 10:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20181218134743.13692-1-geert+renesas@glider.be>
 <20181219174735.GJ8130@sirena.org.uk>
In-Reply-To: <20181219174735.GJ8130@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Dec 2018 19:51:14 +0100
Message-ID: <CAMuHMdXb5VcGB=0DiAXfvyoAMS-Yzctc5G_1_E3m_64tv9R1Kg@mail.gmail.com>
Subject: Re: [PATCH trivial] ASoC: xlnx: Grammar s/the the/the/
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_105139_050395_C3A6FF23 
X-CRM114-Status: GOOD (  10.87  )
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Jiri Kosina <trivial@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mark,

On Wed, Dec 19, 2018 at 6:47 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Dec 18, 2018 at 02:47:43PM +0100, Geert Uytterhoeven wrote:
> > Fixes: 33f8db9a89200c18 ("ASoC: xlnx: enable i2s driver build")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I already applied a patch from someone else fixing this.

Indeed, commit 3930bdad68d0fb1d ("ASoC: xlnx: Grammar s/the the/the/")
in linux-next, authored by me ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
