Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E3AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:20:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C9920859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4EU2Neo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j7MPIMgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C9920859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G/QKPJ6tZzX71+4K1mDcK1b3Xj9jHoKtbVzNPlsWJQA=; b=P4EU2NeoSdXJub
	O6iIiJ8VkR2ldWIrINQEqYxQkjhlDT6J0jjh2k+Fyjlt775HPGmL3DhpPYwOuqYVj+nZo3VUz+yu1
	Xahhd5r2GBhuy528h+3aTAq/Gl4UY+zpjdvWhwUnkrcI5KKNKbdcoBXD7/yV1Vl+JE7/DJz8ECjhW
	MElHaPoc6SNhpigdQXK631h1O2Ul4dUvoCC0d0tU16j+VpIdV1z5Itlfc4kGhEXyHBOxcU3Q/XK2J
	qlthd1gA327/wI8OLGANZKFIkl0Irm/uyWv8xuUb0nDoXVTrg2dkMkWURZ1Hfbl6g7oQFG+HUhTTq
	2l5Iw2I5ipUHLcQaLGjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIT0-0005u5-71; Wed, 09 Jan 2019 18:20:38 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghISw-0005tk-VY
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:20:36 +0000
Received: by mail-vs1-xe43.google.com with SMTP id x64so5345710vsa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hOXGtpqwtrvF5CgfOzBam0WfSfypg3L9A9da3lEy0Vk=;
 b=j7MPIMgi9ftlc0ysNSDaBDFM3dvOp8OQWQ+o+3bvt4mOFb5jfezxGjQ7qOQMRsmrwg
 ayF4T2cKUFIESaPTuriEH5jJlS9SHf+4bG8fgf6bzuOi+zL1TSdthHso/p2AsKFkS6wt
 SKbnpAVuCSunjMmURNHhI0eTWQ9LCmIwIbQYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hOXGtpqwtrvF5CgfOzBam0WfSfypg3L9A9da3lEy0Vk=;
 b=X/ue7k4x9/tJbAzLBQNtdTGs01mzTifxDjBYvt4jQ6Tr85FA64p1g4rKEyNwXJ5TUl
 UXi0bDCE1NoYdYX2c+z3UZruY9cUtgv86ZcoXeIUYv2w9RqwvXOQsJyd5FrzqmnLSo4P
 vLaBWZotzaHV8ah61DqkZhSlPYrxPUiSnC/4+hDa16KKIPSXvjBlFPDG4ik+RaC7QOgE
 e4c2YT9Y7WOgIUMVJ/ixLQuGktXaAmUYdhFfqFAbjqIqRLKwT09Fc31CXXccJ8lbSgpF
 axHQz98SOhkekiQbpGKhQ6ygQ2Adv19/t19gXnmjY2aQ5CqR39dH8XPFu0AYZC72nUNC
 fZ7g==
X-Gm-Message-State: AJcUuke0RjFI76XA/pt1UE7GoJ6tQQlveuKfADl1FlSDths8s98s7VCn
 XkL4GzQPAmNPwT5CwKZhLSL62odV22U=
X-Google-Smtp-Source: ALg8bN5uyGJPBt9C8lQ1qTs5DwbWbPG9vSlHtPLHzjIXBqO3N1um75jKMzT5+llRB/OPK+8hGAnv3w==
X-Received: by 2002:a67:e0d4:: with SMTP id m20mr2979618vsl.182.1547058033491; 
 Wed, 09 Jan 2019 10:20:33 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43])
 by smtp.gmail.com with ESMTPSA id a187sm43064361vkf.26.2019.01.09.10.20.31
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 10:20:32 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id z3so5348233vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 10:20:31 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr3027292vsk.111.1547058031595; 
 Wed, 09 Jan 2019 10:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
In-Reply-To: <20181218183241.12830-1-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 9 Jan 2019 10:20:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XLWUwkQLStKzV5DGji0WNEk44ft51NTWJmQNG7GW4Rkg@mail.gmail.com>
Message-ID: <CAD=FV=XLWUwkQLStKzV5DGji0WNEk44ft51NTWJmQNG7GW4Rkg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] arm64: dts: Add sdm845 GPU/GMU and SMMU
To: Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>, 
 Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_102035_037155_2496E464 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Tue, Dec 18, 2018 at 10:32 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Now that more of the sdm845 bindings are headed upstream this a refresh of
> of https://patchwork.freedesktop.org/series/39308/ to add bindings and nodes
> for the GPU/GMU and GPU SMMU for sdm845. v7 of this patchset also removes
> interrupt-names from the driver and the existing DT changes per feedback from
> Rob Herring.
>
> This is based on :
> git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
>
> with:
> https://lore.kernel.org/patchwork/patch/1018365/
>
> This change requires the following dependencies:
>
> include/dt-bindings/power/qcom-rpmpd.h:
> https://patchwork.kernel.org/patch/10711119/
>
> qcom,smmu-v2 binding:
> https://patchwork.kernel.org/patch/10581911/
>
> v7: Add patches to remove interrupt-names, add version specific compatible
>     string for gmu
> v6: Update GPU bindings for a6xx and make the examples match the nodes and vice
>  versa.  Clean up types and rebase on
>  https://lore.kernel.org/patchwork/patch/1018365/ to help facilitate merging.
> v5: Use symbolic names for the RPMH power levels defined in OPP table,
>  move the opp tables as children of their respective nodes and rename
>  the iommu device.
> v4: Rebase
> v3: Split GMU PDC region into two GPU specific sections, fix indentation,
>   really use qcom,gmu for the phandle name
> v2: changed qcom,arc-level to qcom,level following discussion with Viresh;
>   change gmu phandle to qcom,gmu per Rob
>
> Jordan Crouse (6):
>   drm/msm/gpu: Remove hardcoded interrupt name
>   drm/msm: drop interrupt-names
>   ARM: dts: qcom: Removed unused interrupt-names from GPU node
>   arm64: dts: qcom: msm8916: Remove unused interrupt-names from GPU
>   dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings
>   arm64: dts: sdm845: Add gpu and gmu device nodes

I know it's been holidays and everyone (including me) has been on
vacation, but just wanted to make sure the current status of this
series was explicitly called out.  :-)


I believe patches #1 and #2 are ready to land and will go through your tree.

Patches #3 and #4 should probably go through Andy's tree and are not
urgent (they are just cleanup).  They can sit on the back burner until
patches #1 and #2 have hit mainline.  That's a good reason to land #1
and #2 sooner.  ;-)

I think patch #5 is also ready to land.  There's been some
bikeshedding about the exact format for the opp table, but none of
that bikeshedding affects the bindings that Jordan wrote.  If you
agree that this is OK to land, it would also be nice to get in.

...then Jordan can spin patch #6 (once Rob H Acks Rajendra's opp
bindings) alone at a future date.


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
