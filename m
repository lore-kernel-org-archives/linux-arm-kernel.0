Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E07C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:35:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C550520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckbrr0o6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnI5jtzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C550520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h/EYJE4eksceRzyYSwaTBvLLoQQdP30wvxOEH+SDFvE=; b=ckbrr0o6fsGU4r
	IT5bok53qtyk800lzYcg10iv/EHwHJermYvGx+xl0ssjvVqQpJLXF9UGN40R5bX7Sm1wJPzSu4wfW
	AjtEMCQmKlTxxPvzfPeeXg/wUmqIBwx+Nsb0p9/LjvOCSE/qVrsKqBiAY3mqCeGSN7MbRR9POhoms
	kTBm9Ys3az1ubzXdjKD4AEAAa+ksVyI3ZMnQ1ieZ5mzALvAiIQilnumvpdM+8HqQ1vn9d7Vsfd1PL
	kNbd+uDLhBtW3kRWwrJfAn2OdwhUMk7UBlfQbj7ZBx4VFdAJCSwNAdnn0TTKXprZ6lWhdKWMc08ER
	FryHyMcfifVAFrmzgg/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSYe2-0008Gn-QM; Fri, 30 Nov 2018 02:35:06 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSYdx-0007kx-JY
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 02:35:04 +0000
Received: by mail-oi1-x242.google.com with SMTP id t204so3517414oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 18:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8Axev834yRx7ZCsXLYPXHnuu+iX1TwQTTk8ffcEj8EM=;
 b=PnI5jtzsxX6GMx107ZR///Vr6HkkS3DNK2VL9AyqB+G8NhwWtA6W2JbAwMChk3Mn4j
 RLni/JWJDBks6rn7gxrqH16wCKIcqy6VCsjcmZhxBJwShjE7M+wzf1/go16Smcu4PYI0
 hU1ncZ2+f+EIIvx2z2S29ROecmSPXRe2gQZmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8Axev834yRx7ZCsXLYPXHnuu+iX1TwQTTk8ffcEj8EM=;
 b=bX9TALGTDFme0lp7dvyqcA8bhCKOuHHHB+sJz30v0I1w9EQBT629DbB2fYAGYHCWQy
 Ur2A+2orXgoyFYOoUOQcDs+uCkDxP++rAGhueTUImHKRGPdZjCc24Phn1Kt+FukAL4Om
 +56ebsOffA2/pePp/2aRkTakrqSmeEXwTs4Kvp/SwkDVQOrdvGQ6LZXmVissieRW3/qO
 AdXEbnuYs7Zv+3y+OIEgv364/bvLoIXy8gxGbi+oUwPcQ8sX1hgVHUkmvYoVveRoJCEz
 rKFfau3cQrm1b4ecBs9hKYeEv97zHtIKw0DrlbpJKBF7DnBSWsBLPMqrKj/i6GswcZAs
 zquQ==
X-Gm-Message-State: AA+aEWZpZSjQOvXA1X9g7DyTVXnAVR0s6nezeSceaki3giLDQqC31xjL
 xfj0CiEt/BYrjnVcmumV+XN6QQ==
X-Google-Smtp-Source: AFSGD/W2q9tuqcqhgbUUiQn4OTFvXTLTR6C7YoDnEuuTx5QR0L5zJHgxNTx0i6n/UW3yHKwKh4Zvyw==
X-Received: by 2002:aca:3141:: with SMTP id x62mr2264244oix.194.1543545290233; 
 Thu, 29 Nov 2018 18:34:50 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:d408:b2c2:72bf:467a])
 by smtp.gmail.com with ESMTPSA id e42sm4863102oth.36.2018.11.29.18.34.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 18:34:49 -0800 (PST)
Date: Thu, 29 Nov 2018 20:34:47 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Message-ID: <20181130023447.GE32306@hector.attlocal.net>
References: <20181129163826.178670-1-swboyd@chromium.org>
 <20181129223600.GC32306@hector.attlocal.net>
 <20181129224234.GD32306@hector.attlocal.net>
 <20181130131201.6fc91dcd@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130131201.6fc91dcd@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_183502_784486_39853E07 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: Rob Clark <robdclark@gmail.com>, kbuild test robot <lkp@intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 01:12:01PM +1100, Stephen Rothwell wrote:
> Hi Andy,
> 
> On Thu, 29 Nov 2018 16:42:34 -0600 Andy Gross <andy.gross@linaro.org> wrote:
> >
> > On Thu, Nov 29, 2018 at 04:36:00PM -0600, Andy Gross wrote:
> > > On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote:  
> > > > We need to check the call to cmd_db_read_aux_data() for the error case,
> > > > so that we don't continue and use potentially uninitialized values for
> > > > 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> > > > warnings:
> > > > 
> > > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
> > > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
> > > >      pri_count >>= 1;
> > > >                ^~~
> > > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
> > > > [-Wmaybe-uninitialized]
> > > >      sec_count >>= 1;
> > > >                ^~~
> > > > 
> > > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Cc: Evan Green <evgreen@chromium.org>
> > > > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > > > Cc: Rob Clark <robdclark@gmail.com>
> > > > Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>  
> > 
> > On second thought, this needs to go through drm tree.
> 
> Why?  The commit that introduces the warnings is only in the qcom

Sorry, I wasn't thinking it through earlier.  Yes, due to the two patches in our
tree changing the API, this needs to go through my tree.  I asked Rob to ack
it so I could take it in.  He did that and now it's been added to my pull and
also pushed to -next.

Sorry for the confusion on my part.

Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
