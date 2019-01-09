Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D28DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:16:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250CF20685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q0fu1o5C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkn+Ji+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250CF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6aOvb+JLQXcEA3w37zIivHNroQJ+IHFO1edKQldXCds=; b=q0fu1o5Cu7o6lV
	8hjGWWTp5jP7PDDaKRE/k64ZtSWtuIFaouji4x0exPBmQYD1LV+i/UINbKCPP38NbWuBWKwqJ42Mf
	YTByXCuFKujIR8h4ZYMbHs8TrbAxqCfvN72aAQYWfWLjBS2GdFMdFRbU9EAQBD1CQsiv1yvdxW+Bt
	1PZZJzZ2cMM4fn35vXciPTEA9ThHwG6OpFIbBsYkJChbFKb4uF+DK1EGe0+pLILk2+C6pOOM36WKA
	d9I/hTIf+2hyLBjTFzmNjj2NL8Ct+UybFgV5OId9XtM/usacp77g0xtsRyPTZw7V9aa81wEcZda8I
	8j7YqJwUJ2QWYRFjAHrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJLI-00056K-Up; Wed, 09 Jan 2019 19:16:44 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJLG-00055t-Ce
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 19:16:44 +0000
Received: by mail-io1-xd42.google.com with SMTP id m19so6927422ioh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nos+fLZoxrtPXR3D1l5SyNpchRZms6O2vizTKVE38Ic=;
 b=Dkn+Ji+4bgfUAW0dmbfI+ferd/rG+6iEiMYCh/pfOEOAT+fkvW3kt+Km5g9lwN1Nwf
 7eDSVetXED+eiIPqdM+Rkx5izfAGsWSFPMu88Et27ckJpTB2vlAkaN6yEDJRrOQfMvH5
 qDNSjkLhOOhKHZYu3FjmHlgq3Lx5w2xIeaz6G8/fHiex56dzD/enOawtIGy8ha2fxUbk
 d39xKaBYBRMWAxwm+o1s8PJavurJdwjXzeflSokLeObyH3YhgB5GDyScep3Ktry+enSh
 bz5GqlMBpiW28dsSRMep9AzfJ4EOfp8/4cqSmoa2JLj4+ixsZpOfAsSQ+6t5uy7mEEy7
 9I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nos+fLZoxrtPXR3D1l5SyNpchRZms6O2vizTKVE38Ic=;
 b=EE3aLa+oR9SIlh3MYpjJVulPmslslUHaNMBFQhGU1rAcL1obiZ4G8KhIQSoYzx/T06
 VeSNfuXlASyIQnUPpr97+CwBtpkgtu9M9DUNwQnyoLBIhp88c8BtACc857anFVemQvz+
 xig+kcc3ZbJVESuyKgtpbFyyILQId2QVC4925D0g1J8nEB+Ro7LyOuAxRP2EYa+UU9C1
 UjMp8nqm56+mBpY6LaOUuunNjECu/5ZBW4pbx1o9cGpe64JjAKEgYbiGgU0fNzB/V9Z5
 hBwh9iM+o1Lgx7gg5VMFZsUyz3lo2GYn+zOER0E3DDeMZ0+wZrUi4oj/wAKmci+sK2Jp
 rXEQ==
X-Gm-Message-State: AJcUukcf1E4TaFXPqdnurjydOWl9pvGXVqj+8YXCdllzliqgwsHyQBFC
 F4j8rufRMIXUgYIIcyyiiWyWgzIruzRi8MnAfwE=
X-Google-Smtp-Source: ALg8bN4/ipMkq5PwKy5dMxrSI27gzSyvW98Q/6YdxD7Vaed4lZRpGKzhhCO+bszn+5T0ccJea+C0Hs0HOidE+T8o0vk=
X-Received: by 2002:a6b:f814:: with SMTP id o20mr4642430ioh.129.1547061400444; 
 Wed, 09 Jan 2019 11:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <CAD=FV=XLWUwkQLStKzV5DGji0WNEk44ft51NTWJmQNG7GW4Rkg@mail.gmail.com>
In-Reply-To: <CAD=FV=XLWUwkQLStKzV5DGji0WNEk44ft51NTWJmQNG7GW4Rkg@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 9 Jan 2019 14:16:28 -0500
Message-ID: <CAF6AEGvuzcFxsNv+MO_B50eA8ztemc0VXe0dSQLARPprTvyAbQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] arm64: dts: Add sdm845 GPU/GMU and SMMU
To: Doug Anderson <dianders@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_111642_432788_FC779A2B 
X-CRM114-Status: GOOD (  21.97  )
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
 Rajendra Nayak <rnayak@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, vireshk@kernel.org,
 Andy Gross <andy.gross@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 1:20 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi Rob,
>
> On Tue, Dec 18, 2018 at 10:32 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Now that more of the sdm845 bindings are headed upstream this a refresh of
> > of https://patchwork.freedesktop.org/series/39308/ to add bindings and nodes
> > for the GPU/GMU and GPU SMMU for sdm845. v7 of this patchset also removes
> > interrupt-names from the driver and the existing DT changes per feedback from
> > Rob Herring.
> >
> > This is based on :
> > git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
> >
> > with:
> > https://lore.kernel.org/patchwork/patch/1018365/
> >
> > This change requires the following dependencies:
> >
> > include/dt-bindings/power/qcom-rpmpd.h:
> > https://patchwork.kernel.org/patch/10711119/
> >
> > qcom,smmu-v2 binding:
> > https://patchwork.kernel.org/patch/10581911/
> >
> > v7: Add patches to remove interrupt-names, add version specific compatible
> >     string for gmu
> > v6: Update GPU bindings for a6xx and make the examples match the nodes and vice
> >  versa.  Clean up types and rebase on
> >  https://lore.kernel.org/patchwork/patch/1018365/ to help facilitate merging.
> > v5: Use symbolic names for the RPMH power levels defined in OPP table,
> >  move the opp tables as children of their respective nodes and rename
> >  the iommu device.
> > v4: Rebase
> > v3: Split GMU PDC region into two GPU specific sections, fix indentation,
> >   really use qcom,gmu for the phandle name
> > v2: changed qcom,arc-level to qcom,level following discussion with Viresh;
> >   change gmu phandle to qcom,gmu per Rob
> >
> > Jordan Crouse (6):
> >   drm/msm/gpu: Remove hardcoded interrupt name
> >   drm/msm: drop interrupt-names
> >   ARM: dts: qcom: Removed unused interrupt-names from GPU node
> >   arm64: dts: qcom: msm8916: Remove unused interrupt-names from GPU
> >   dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings
> >   arm64: dts: sdm845: Add gpu and gmu device nodes
>
> I know it's been holidays and everyone (including me) has been on
> vacation, but just wanted to make sure the current status of this
> series was explicitly called out.  :-)
>
>
> I believe patches #1 and #2 are ready to land and will go through your tree.
>
> Patches #3 and #4 should probably go through Andy's tree and are not
> urgent (they are just cleanup).  They can sit on the back burner until
> patches #1 and #2 have hit mainline.  That's a good reason to land #1
> and #2 sooner.  ;-)
>
> I think patch #5 is also ready to land.  There's been some
> bikeshedding about the exact format for the opp table, but none of
> that bikeshedding affects the bindings that Jordan wrote.  If you
> agree that this is OK to land, it would also be nice to get in.
>
> ...then Jordan can spin patch #6 (once Rob H Acks Rajendra's opp
> bindings) alone at a future date.
>

I've picked up 1+2 and 5..  I assume it makes more sense for agross to
pick up the rest?

BR,
-R

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
