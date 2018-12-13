Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A5C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:33:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1400620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y6m/oR6X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRPUIpaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1400620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C0RAOrkUt5pNomMAeTy+eY0djW9iJddHoU73Jj4mksM=; b=Y6m/oR6XEk/lK/
	W/ntq9e70/Kcm/hCjRSPhxQVsDF7YifUA69aCjNtL0O0Rxp1Gfw7X4ugqT/j+Gpwv6ZrZ3o2JZNg6
	OkfyxI5Pj2qKazW3NyLJktCVlqUGBUjgb9mpYWfXxXF7dM+WFELg4ILlgqms+dtyVwELZCdVUJHuR
	9Ck/o7MdHuEjb0Gc1CDTuLRfbFHFszybtMrDzIxi9CC8omjm3k6ygqJw/EP29JsT1h0qLC/jTmRPc
	2l8qR/CjkQr/Vzetc+1kIbNI+4UQGR+3zBEgp6kFn5y0kZCedRq31VM1/d4fMhssci/YLqzoeToNa
	bxe0igIwFpaCLtWvCcBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLV0-0002It-V8; Thu, 13 Dec 2018 07:33:34 +0000
Received: from mail-it1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLUx-0002ID-AH
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 07:33:32 +0000
Received: by mail-it1-x12e.google.com with SMTP id x19so2339998itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 23:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=emcFNrV6+KkTZaZVcCwgcZGyWbWDkVLcNf9DWoN24xM=;
 b=BRPUIpazGCf9/mdzFPsfhkQfs/6sEywzM5HlsRliUGjBd05e9YnXwX9iXy1OBXj39R
 AFyw8spyZSEN9/MuJf5OfCdHPX/5qUjfyqz0qyv1pUVZuotSYrnSn/ZsTiFs2caOJY61
 oA0b6stjDxEuzVQZqQzF84kNqX9oCxY9mpM9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=emcFNrV6+KkTZaZVcCwgcZGyWbWDkVLcNf9DWoN24xM=;
 b=JGv83KaFnsc9LYF1SBRegDq88qD/laOlXdIADU1JNXptJPUmKkBjp162sHMBsRX/Ub
 ypA3VZ16+N0FJYOSAJKk1PaZ4AC9YNUFT5pmeQt4qsoj1qW9685FnsXdgZX9blNcHv8I
 9DudRMaYZfTJmoy6LOwV/rEsuEcrkYgbLk5cD+8Qa4TGrxkvODpSthYuoIu6NbbFxeDA
 bQagBfyf6g35RoNBdSFUz3WvbsgUkWSQvufAKC7AEo3ZFmFYcfxtGs4QgCZShzYViuOr
 UJpbDuin+tPGvsZmgS75N2gtq67eoD/TIGTU0fWdncX19e5Hzd4bAdhZKSd8nCaPNu5u
 tnDA==
X-Gm-Message-State: AA+aEWaZj4SoRCOUAe4GoU1IQN4+MrqoXoGDUhtXwTlx651N+UVYZDBq
 w1sNQDSJtVNNDj1Kkudbz48YfCyDr+6aB7iEEfmz9g==
X-Google-Smtp-Source: AFSGD/XjcojXWWkBsD1pZBgWIqoW7dhfglF2tZb5eYtQ1oJ1/sTbtI7yNTvdXdOicTgSWF+AKLizHnIL7IHiNJt2BHs=
X-Received: by 2002:a24:874a:: with SMTP id f71mr8381112ite.120.1544686399869; 
 Wed, 12 Dec 2018 23:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20181212123121.GB29450@jax.ideon.se>
 <20181212213833.nretkviqn66bnxtf@localhost>
In-Reply-To: <20181212213833.nretkviqn66bnxtf@localhost>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 13 Dec 2018 08:33:07 +0100
Message-ID: <CAHUa44HQkwt8D=e0KtWu6NGmuf5QoJhjsx=ASRUEXmAtErqQMQ@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys for v4.21
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_233331_353998_04591BF4 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof,

On Wed, Dec 12, 2018 at 11:16 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Dec 12, 2018 at 01:31:21PM +0100, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull this small OP-TEE driver enhancement. A friendly log message
> > is added to inform that dynamic shared memory is used when initiazing
> > the OP-TEE driver.
>
> Hi Jens,
>
> We generally try to keep our branches based on quite early -rc releases (rc
> 1/2/3), to avoid having to merge-back into our tree from upstream too much.

Sorry, I'll keep that in mind from now on.

>
> Your branch is unfortunately based on -rc6. Would you prefer to respin it with
> an older base, or should I cherry-pick over the patch from it? Either is OK
> with me.

If you don't mind cherry-pick over please do so.

Thanks,
Jens

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
