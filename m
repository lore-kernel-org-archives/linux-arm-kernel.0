Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94592C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6421A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OlE/KJ2W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="WkqbY192"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6421A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:In-Reply-To:
	References:MIME-Version:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ei+IbyXBaHfc6mW0sJXeK3hYTSol4+vikFBCC5NwgD8=; b=OlE/KJ2WIPgWX8
	Ht7BgGV3RgJhFAmXSuY2TT43sAyWpsDphJy7xeGioDHYjcTg6lnmLoEYJdsmcDCCIloUnyouvzvSx
	aJs9fxQeIDHGkB8ZoIjHGwzTFlLKvpaLXCtS5izS4/wRMiQtQAfX9sbe9wUHB5PCeAlBMo7JNoWyM
	ozyQzi54d6E3kXdniNBmc8FDUAryZ/Yyr7NgxnPLg4GYhFZ8cNzDUI3xolb6VV4WkxGFzkDb6Ov96
	FcIiW4HZ8+sgp9f+69629su9Jfa2mZI+ah6RHZjhgKHWxUsU+fjRqZbr8fVV42fZQ8gAglffJKN+t
	P2X1AJzlKvOe9ncybneQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwMR-00051n-SM; Mon, 03 Dec 2018 22:06:39 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwMK-00050E-UC
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:06:38 +0000
Received: by mail-ot1-x336.google.com with SMTP id 40so13209117oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
 h=from:mime-version:references:in-reply-to:date:message-id:subject:to
 :cc; bh=kPz2fS32xKXYAczV0ZrE8OqocFQwTPzcdpuQFXv/7DE=;
 b=WkqbY1928xqc9iBMKSMXQoQClKb3Xl9KoNZ6qTygB4NaRobJwkrJQNfBEe/uTeAtiV
 3pRH4j2/VoxXLZhcIid+7flm92kkqQQepM6yNAotHbrz01jWG3wUgTnGvJOZBYOMup7B
 SjDkoFt+xdFBLxeknoxDipEXDNXjUomoQwVtr4Pju4poKrffri0Gv1mHIrf7cAkqPLZC
 p6PWqghXH0wOhK57Ab5uDmnCc6Q+ovSpsj+UtHIuuHGUDrQ90F2dxuNtZJ+NrMTeYDWd
 mR0EXfV2i2Af+uKK4gkQZ9UckM3Mm3rv/g3ks0uQ8vjSuCcDGDGkThIIGrf1zbV/nhqz
 q4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:references:in-reply-to:date
 :message-id:subject:to:cc;
 bh=kPz2fS32xKXYAczV0ZrE8OqocFQwTPzcdpuQFXv/7DE=;
 b=owh0f9W4jUzoIqC8CdmIZcMPkkzQDTTcCH1SPZWEvwYpObnmyk9rWP5BEnAXRBUqmO
 0JynZiSx9CDUkJK/MFps6nbm5ojm/VtgUNsN1SpXoipgexGemFfC355NNdgoGHU3K/fS
 hE5DM5rwpUIc/eNmWau0VcoHrXAlNRFSQHp6Pd17GPCZj1Wb8DCDTJrG6f03y4IKCb7P
 d46H8eWzJmE5d1XggPlkZNnpnnlnt0OYtWlpWL5+WjM0XZHQL8KuGBNR9eD5/+SnuYh4
 00fp1fQHKEKGjJffcYdrTtuJKhcklaOAyIqDkM94PdvfFGJR1HgzwuBxYJyVlRQMeba1
 MTNQ==
X-Gm-Message-State: AA+aEWavGdMhk1MwQ2JZDbKWvvPnuoXGMC6yp2bm5gkP+Slxbqhi/tdK
 kcxxMruuU4tDoN3PfUjyVvnl4EJCMHDQ+Q==
X-Google-Smtp-Source: AFSGD/XVNxldNs+zoRk5YOvpotgrDMK5udzEznP0rkAeNXQCil/nZ/gr3C67rpFXR2edfo1mkvsUig==
X-Received: by 2002:a9d:871:: with SMTP id 104mr11226186oty.189.1543874780437; 
 Mon, 03 Dec 2018 14:06:20 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com.
 [209.85.210.54])
 by smtp.gmail.com with ESMTPSA id 102sm7257607otj.65.2018.12.03.14.06.19
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 14:06:19 -0800 (PST)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f54.google.com with SMTP id s5so13194890oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:06:19 -0800 (PST)
X-Received: by 2002:a9d:1b2c:: with SMTP id l41mr10684052otl.1.1543874778760; 
 Mon, 03 Dec 2018 14:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20181201193858.20738-1-otavio@ossystems.com.br>
In-Reply-To: <20181201193858.20738-1-otavio@ossystems.com.br>
Date: Mon, 3 Dec 2018 20:05:53 -0200
X-Gmail-Original-Message-ID: <CAP9ODKo62r8ZrHTj9mHvjbhMXHhaLxA8Hak3su4-yV0dAxNY-g@mail.gmail.com>
Message-ID: <CAP9ODKo62r8ZrHTj9mHvjbhMXHhaLxA8Hak3su4-yV0dAxNY-g@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable ATH10K SDIO support
To: Otavio Salvador <otavio@ossystems.com.br>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_140632_967796_EFADA179 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>,
 Kernel development list <linux-kernel@vger.kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 1, 2018 at 5:39 PM Otavio Salvador <otavio@ossystems.com.br> wrote:
> The use of ATH10K WiFi is becoming common in i.MX based boards,
> especially on new designs, so enable the driver support as module so
> it can be used out of box.
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Please ignore this patch for now, the driver did not work on the
custom board ... once we get it working, I resend the patch.

Sorry for the noise.

Best regards

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
