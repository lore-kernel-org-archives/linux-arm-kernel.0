Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36DDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:35:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14922081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c24noRzH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nExYkwuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14922081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xSEmH71doXVdxEd4IKrBydh0QeWrIcNvQvyKaO+U1T8=; b=c24noRzH1lbDXL
	cECLrVqrXvquFTzLzR7wVi2WJl6IsvG0fub80PZvepwm9LM+Uv76+YYAEkEtwMSYRT9Z6s+YhLo5r
	G+d6c0aKps4cTlec3SJnA2yKd7Yixrmtd+ft0KMHt/6UXxY2f5RNyAnG2BM10bE6JhMthBssbOl73
	YQAJ3tpbHlTtUvUuhppVXG57aZXwkDjTArCL1dyGpDEu/wKEHzGZck/e3JMDCdpqDzDsndCFG9zDD
	1NORWij+g5J9XayCyNp9ozjJfIDyEUAzAq9OxWu1y+Iqk4wHdd+2oHR5ncSqcG5RXXQkiK8wECwWv
	VsJqjcj6a0+rUpjbJUWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWU9L-0002uF-2R; Mon, 10 Dec 2018 22:35:39 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWU91-0001Ls-A5
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:35:24 +0000
Received: by mail-yb1-xb41.google.com with SMTP id b4so2925864ybg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hmD+rcKv+QmbxvfADc4Evrghh2JGTcEKcQK2aSTrd5w=;
 b=nExYkwujOf7mDx3KK2ciS82CfEOMemoFIAyLw/Cc61FCleuhtFnp2vArJEMQlHsgsi
 jJg5dhJ2R5TeWOhPjIEpJVyb9xJ1ONrOxn3vwFLLjcDVFgDgHQ+p/Uj8YtJGvEeqrvlV
 S/U6KJsCX/ytia2RRJRVxDTpMoWbO2+YQyI64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hmD+rcKv+QmbxvfADc4Evrghh2JGTcEKcQK2aSTrd5w=;
 b=nt+ooA16RwXGloBiQec3QYGztCA3ee3gQXWUKn+cLGOsV9gvoMbGs6wmBbwyF4S2M0
 eRhW4YslEJk3XXNHDtBDgHFnVe7ZdaN3IgSdAUk7NNIVbdXJw6lbjVBbA3ARTfNQKQzZ
 ov/Igr+NcR+PDkb385D6O8aDj6rni/u34+Ti+y+dZrFKqihFMZb+RoKS7Wai6SKbB6UR
 C7+j4QMy5VkR3H3/BjmS7GoPYbjhmYZqhlfqAsaUuuGZDcP3zn3oC+etAJ5CL35Fb3dF
 Q2xtws+WFPn8MNHvLfcP/fv8t4xtw/MmnuuIs2CNHVrkgXVGNNJgFKTG+j/puT796YfA
 8f0Q==
X-Gm-Message-State: AA+aEWa+AwWIwC24PBnO5DZsNFwuPv0r3MgJTMNfNy6uiILX7olKbPYP
 KWmd5NhlmsF56Y3/hd+C5eu9ooVU3RE=
X-Google-Smtp-Source: AFSGD/U5tZfuo2/51mRXAlk7u8fbmK75ptGg8S6E1kyKRtr5ePZfYxMVkkWAQSiiV5+mwKLgiEA/fQ==
X-Received: by 2002:a25:52c1:: with SMTP id
 g184mr14187799ybb.289.1544481303785; 
 Mon, 10 Dec 2018 14:35:03 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com.
 [209.85.219.171])
 by smtp.gmail.com with ESMTPSA id q24sm4132577ywa.95.2018.12.10.14.35.01
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 14:35:02 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id b4so2925798ybg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:35:01 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr13910924ybj.137.1544481301490; 
 Mon, 10 Dec 2018 14:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com>
 <20181209103740.GB30658@n2100.armlinux.org.uk>
In-Reply-To: <20181209103740.GB30658@n2100.armlinux.org.uk>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 10 Dec 2018 14:34:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
Message-ID: <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
To: Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_143520_210310_6E8D1DF0 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: kbuild test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 LKML <linux-kernel@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>,
 kbuild-all@01.org, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 9, 2018 at 2:38 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Sun, Dec 09, 2018 at 06:28:11PM +0800, kbuild test robot wrote:
> > Hi Ard,
> >
> > I love your patch! Perhaps something to improve:
>
> Hi,
>
> This looks to me like a false warning - how can a patch touching arch
> code affect the result of lib/test_ubsan.c?  Please can you double-
> check this result?

Yeah, no idea. Do you want me to toss this into the ARM patch queue?
If not, I can this through the gcc-plugin tree.

-Kees

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
