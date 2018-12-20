Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBC2218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lYJTyTdS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jq9FmGN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBC2218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cfW2b6FInPngAPIRoYbDjCU/AE8wrgjDknRIO4ui7fE=; b=lYJTyTdSkVRH+g
	Q4X63UF49ZSyjQONMmzHGYrX9T1bS4YUDxvipzxDYkJlAgMVLW8kStCp1HKrP6xkuBfJ5puNEtIKR
	AVugiPGym0UdB+S6YyURzwY9nYutyxbBq8GJivRoUwQJxQciX9O67fE9ybHh02mQd/SJMqIcpKgKA
	isHBdvq/lvcJlTki9XBjf2to1z/DREgZHz/bU30xx+pzGpryY0+bSbxbU9O8bwWoP1L2gV8AmZU08
	0U8wUKBZSP1dtz5Vdsp3Mv6a7A/ZybhQC4veHFPCfIEYhnO9mhb1XsOkAHEHRduHhu5La+18X8Plv
	JRIvW7Kif0Q8/ChnEiAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga7cP-0002xC-R9; Thu, 20 Dec 2018 23:20:41 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga7cM-0002vW-2u
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 23:20:39 +0000
Received: by mail-it1-x144.google.com with SMTP id g85so4500387ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aJCstcpioKX1kDPN9Do4ajl4wQrLRjEEgz6HAK8MoUY=;
 b=jq9FmGN4dEMDtMTdoSlw+U4KYxRXJEWTp0D/E5gKQxakIGOQlDSyOpAf28F3X6D93Q
 zBWTouplLsJzDsBHyzbPw5I5cneJ2jm5gNKicFCRLDOnZkK23qJn4Olt6gCsRkaBV4ys
 ff+XaSkC4mwtm7wQHD6ms6kOp4MHJ4ZTcCjH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aJCstcpioKX1kDPN9Do4ajl4wQrLRjEEgz6HAK8MoUY=;
 b=lGPA0p/q2VYXBf5GabTfXUjwHBb+/qs6wTkwXjVjZmRKHfvsmx67LcAGbfAeDHuYDB
 DI6VcngYA3Is0P7HMAvR9ISmbsoV7SUdQEn2TO8W010j0cn9Lhc9iS8ApZqlOsS2btGA
 DDlEstXwv+v9/hZRs0QAaQHHtAbdDq8AGwiSakmlHWsShQkAe7CZDTPWih7ODA6mtCU1
 r0SmE/1Gza9IckIlNUwdTtxm5OrAgRr1rnTTmQ0rYGVQ4MSFtHGa3jeLNwSF4NNi98rx
 cXJs5ASc4z83acd4XOaQhrWg7l1Zafp8C+RWecfTW863zRzLJumVfDPQ2DI8AVPY0dvx
 8QKA==
X-Gm-Message-State: AJcUukeShhiOTHhDWwr5DG19M9xv8VeaaZIZp8RzM47DtQieJjj/i14+
 5KfhSsclzeTRoMVylBAojJdJg+y9rbfoyu4d00s1ug==
X-Google-Smtp-Source: AFSGD/WPKU3M+3Jvw6zAtXzZltMyw24jz/yuzayxY6/Dl1M0Ds3Tovkz1K5Cs+O0YvNmtCqawmFHb/ey5XpGON0VQjM=
X-Received: by 2002:a24:bd0e:: with SMTP id x14mr502314ite.123.1545348024331; 
 Thu, 20 Dec 2018 15:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20181024013132.115907-1-dbasehore@chromium.org>
 <154534054131.79149.12015186156265337224@swboyd.mtv.corp.google.com>
In-Reply-To: <154534054131.79149.12015186156265337224@swboyd.mtv.corp.google.com>
From: "dbasehore ." <dbasehore@chromium.org>
Date: Thu, 20 Dec 2018 15:20:13 -0800
Message-ID: <CAGAzgsq=p-2N6ybFXNTnz5SDkcdktA+Gk6e3gxrjpJB+L8389A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Coordinated Clks
To: sboyd@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_152038_129980_1BD6DA5B 
X-CRM114-Status: GOOD (  15.19  )
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
Cc: aisheng.dong@nxp.com, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-doc@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-rockchip@lists.infradead.org, mchehab+samsung@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 1:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Derek Basehore (2018-10-23 18:31:26)
> > Here's the first set of patches that I'm working on for the Common
> > Clk Framework. Part of this patch series adds a new clk op,
> > pre_rate_req. This is designed to replace the clk notifier approach
> > that many clk drivers use right now to setup alt parents or temporary
> > dividers. This should allow for the removal of the
> > CLK_RECALC_NEW_RATES flag and the implementation of a better locking
> > scheme for the prepare lock.
>
> Are you going to resend this series? I can do a review but I wonder how
> much it will change anyway.
>

I'm going to resend next year. I got distracted trying to get other
code to work. This code has bugs in it, so a new patch set is
required.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
