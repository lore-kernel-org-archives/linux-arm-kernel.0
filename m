Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:30:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F71208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z0AyrTm5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSLpxFfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F71208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kJz91LQeMP8sSo2uMD4Tj67MFSyQA/XqHpEfV4qlaE8=; b=Z0AyrTm5jluLK+
	BrtVYFq9NhOHclE+1TcCcXFg5BIXXmtf8A63P+nJ5PlJWpMkVgyEd15Em7sTXwWxcU5e37EkHh4ug
	tDdZMaJ9vka73GsMGg9NVbcOm74W8zVoWAhIJ3/VoHMTiq+bCr0hK3VdoIUAAjePYy/Yby3YknO0H
	JcBxWgSgiCvAqwC68Pc8VjE63XSkI12FC2do1ibu4HFK/0g2kRT1BlX+qRSH393uYPbdrycj2nWDe
	RevISD/GQ3/XiEOnuiHd1Kh4Mc0LoFQjyu6TnjIxBFqELTc9QZRl3Adx1f62u2wErMMQdxkb8VmX6
	A7sxBROSKwr7gW704puw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFHG-0004SS-68; Fri, 07 Dec 2018 12:30:42 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFHC-0004Rb-SR
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:30:40 +0000
Received: by mail-lj1-x242.google.com with SMTP id 83-v6so3387030ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7/os7eFrdjZAa8Lq9Ha1NGHegsNC2tJAUi1QBzjgVMQ=;
 b=SSLpxFfyZYwuHYHP7p2Ut2Ty0LIsEi2IOaquypyrl11wWADZI5DTskb1yEnwosmu3F
 QbuaZcnzjsIZ48O/a+3qY3rmAlHrYo/SAVokD6v2CHjIgYsM5viEGzMT/kF1oUCHWnuE
 t8/5HrEp5FGlYzCHYbj+ff8E+Rejt00fJHjvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7/os7eFrdjZAa8Lq9Ha1NGHegsNC2tJAUi1QBzjgVMQ=;
 b=imYKjM1B9DqnA6xjZOUTyTM7TBqCkzPZB4qg3Bz2eQ3aqI25fIB1d4cBUNuSCJdbzP
 B1V4JU9rk5OR3QfmralOVRnld6KjQDJcKTgp0iolbU3GykjdnIo7+mv+nYNYaUcD8oNT
 +LmYkkG8piKfzBNkACRh+teWpOR9lhNimBGNeWicjiSrCSjNp9rMW9yI8vZ9gxlIuYVo
 h2pfGBjyfyMVcH2qsj7rUM9h4tNtv3BWcxKlLX6WQ5R/kGzFb0ELsnM7zzW82vFuRhOt
 qQBXd6JYv/STEB2XHChqmotmqVkqbKIMc6WcqJWAxD863T27Xz/1kKQEmSB+/aGIks0j
 z43A==
X-Gm-Message-State: AA+aEWb7JagdQwDJYCxCYoZTBBiYp4v0zf/6p/a7MFYqNYPgz8qLT6Jf
 UC4lrF8BPKI07kJojueUotheS4xfDzXUoGRq7YJQGw==
X-Google-Smtp-Source: AFSGD/WIGfniGElDiivYNO8T1H7qXLY6BOgDe33KqinRMAlSPWQOurZ6BCja9DW032eHL0yw8rctBq1I6VWBugDcKZY=
X-Received: by 2002:a2e:994:: with SMTP id
 142-v6mr1090584ljj.120.1544185826433; 
 Fri, 07 Dec 2018 04:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20181203154100.4280-1-wens@csie.org>
In-Reply-To: <20181203154100.4280-1-wens@csie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 13:30:14 +0100
Message-ID: <CACRpkdYbdDfN93oXEkSmoFAEdrQwzk7mTCreOgem6RTJPWVj5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: sunxi: a64: Drop numeral from csi0/ts0
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_043038_926351_9F6A7779 
X-CRM114-Status: GOOD (  10.10  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, jagan@amarulasolutions.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 4:41 PM Chen-Yu Tsai <wens@csie.org> wrote:

> This small series renames the csi0 and ts0 pin function names to csi and
> ts. This makes the names match the datasheet. As there are only one of
> each type of controller, having a numeral suffix doesn't make sense.
>
> I'd like to do the rename now while we don't have users nor support for
> these two controllers. I planned to send this together with CSI support
> for the A64, but Jagan beat me to it, so here it is.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
