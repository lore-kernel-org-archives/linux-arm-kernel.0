Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:55:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7328206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QbrgUPqi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZXUxv+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7328206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wuviWCecWAAZ+W+qvlJ5fvsfxe591L+mUv99xBFXvy8=; b=QbrgUPqin/1UPX
	95k7c1ixGEN9JzVgbLbZ9eLmv7kWu2GIxwRdSu+wahlQfG+DkIf37R11yEb0FrljAISfKmsxe4dH0
	BBcGo5N69brxz8MNGeP4NA/X/YW4z2l7CD6ehbsoBT3IxgFRU8a06BohNdZi1kDcG9Qqg4OyjnM0Q
	6beBfOl4wBjLxhB/gHpjMWFNt7SaFdd7EbN/oyYEzrAW6o1iMnv9u/esG2tC4br9aOpo7z3qr5FhW
	3wqc0N+qjdjOGCLI0ZYAioRHxNVznQ5yBO/NOE1s4XB0Qe2CDE8rhPcpAkm+j14rkoqPDe1FZTdgm
	OajwoAjdFwnpwTG5ArWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTj4M-0002Fp-AI; Mon, 03 Dec 2018 07:55:06 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTj4J-0001iw-F0
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 07:55:05 +0000
Received: by mail-qt1-x843.google.com with SMTP id d18so12680337qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 23:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VrSGmEmCmctVABvMIJ8SgSrl/TKDAGeiz9gzxzRolcU=;
 b=DZXUxv+fL66pObqWqMBlJIbJ1cmfv9QMNw+v3d3cn16mvCzyY9FYhUJtIzLNlIyUvk
 aZ68XlnM1TgAY8tKBDpOyHRlkCvrRPKiJuyRfqpx9VEJNBcYgqwQNoZWBYsxwDeEUBgJ
 T7WWljO6/raQDGy0+j41uzMO43wpge7PYasM2dKJIUAy+wU44CS6PAISDIIpcvDFIsyQ
 feHxndWFnkc2KZnK9pLJ4afEB5FSXnmewqzWtMnNFqhhFx+H+AxogXSMebYRGUJWHlPM
 MbS0S+ZxlFhY/MVX3oP7Fvj/cFAUuZMj/zNyd4HrjuGYfhHVBLw2rNAEHwhkcfQk4Q4R
 s5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VrSGmEmCmctVABvMIJ8SgSrl/TKDAGeiz9gzxzRolcU=;
 b=g4zqwq4rAvG6F2iF+FGYlBhonA+0dqZc3npmB1uG33hSx1IWzMDNGwDa6QJZoZkW7c
 XBunkDTp3ijL6PhUN78b2U/LNz0Qusvob9lKsYJ9tsk2gdOfvDF7Y0cHD14aykS1/ihb
 H7/9uWH2S06j7a3AGZ7lfVEury4jywmo69jENdnL9HeUVN1t39VvEyKnwwKHfCJ6VvPo
 ufvRbUffH5jwVJ7MBbjM4HcIetcPFP49qUP9tu41KqpTKqZpOmnfaWbaR9aKpy5mkkjr
 mqGS34DQiP/QbF0OEXMcEIMtPtr5PF764wPt+zfi7vA492lTcenbWDcOfWr8wVvHGmuq
 l9Mw==
X-Gm-Message-State: AA+aEWaPExn44h/hDqkOn+QJOdyVabBerKUAXGRC9qyinYhlgmVOOtu4
 HKMAIyin/YrTtaJ85CFPlVFjCNLiIa5RUPdgnjI=
X-Google-Smtp-Source: AFSGD/X0pdnpmyCILjdCPYTnh8KN0uqkin0YivVYE7iHBjO5/rnb9GX60IZPwiYqYTVMBu+nWmEGDeIYmW6uIJa1ot8=
X-Received: by 2002:a0c:c2ce:: with SMTP id c14mr15177923qvi.7.1543823691629; 
 Sun, 02 Dec 2018 23:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-7-lkundrak@v3.sk>
 <20181202231328.GB23087@wrath>
In-Reply-To: <20181202231328.GB23087@wrath>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Dec 2018 09:54:40 +0200
Message-ID: <CAHp75Vc9pbj-jTQ86qV54FDtxzzoY-vvgH9qtvoFWWY1JQOMew@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] Platform: OLPC: Add XO-1.75 EC driver
To: Darren Hart <dvhart@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_235503_526649_07D65880 
X-CRM114-Status: GOOD (  20.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, devel@driverdev.osuosl.org,
 Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@zonque.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 1:13 AM Darren Hart <dvhart@infradead.org> wrote:
> On Fri, Nov 16, 2018 at 05:23:52PM +0100, Lubomir Rintel wrote:
> > It's based off the driver from the OLPC kernel sources. Somewhat
> > modernized and cleaned up, for better or worse.
> >
> > Modified to plug into the olpc-ec driver infrastructure (so that battery
> > interface and debugfs could be reused) and the SPI slave framework.

> > - Count the terminating NUL in LOG_BUF_SIZE
> > - Make olpc_xo175_ec_is_valid_cmd() return -EINVAL instead of -1
> >   on error
> > - Spell keyboard/touchpad in full for CHAN_KEYBOARD/TOUCHPAD messages
> > - Use a #define for PM wakeup processing time
> > - Log a message on unknown event
> > - Escape logging payload with %*pE
> > - Replace an open-coded min()
> > - Correct an error code on short read
> > - replaced PM callback #ifdefs with __maybe_unusedm SET_RUNTIME_PM_OPS
> >   and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> > - dev_get_drvdata() instead of a round-trip through platform device
> > - s/unsigned char x/u8 x/ in olpc_xo175_ec_resume()
> > - Use GENMASK() instead of 0xffff for the event mask
> > - Replace cmd tx/resp rx buffers with structures
> > - Turned suspend hint arguments into a struct, and tidied up the comment
>
> Just from these comments, each of these could be a separate patch. You
> can group related things together, or those that change the same line or
> function for example. Order them with cleanups / non-functional-changes
> first, followed by functional changes.
>
> >
> > Basically all of the above is based on the review by Andy Shevchenko.
>
> Andy, what was your intent for Lubomir here? From the above, this looks
> like it should be several patches to me.

This is a new module, I don't see why it can't be one patch. For the
existing code I agree with you.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
