Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D8120874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="juYs027T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNVQenO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D8120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ECaUXvTo28rB/i7Skdl5JkTZ9BrOfYo41491Yx4oKk=; b=juYs027TlUc706
	zpvvaNTFM3vNf0R6TpoU6FNlcbAC86IcCfYH3rVia+ywdG4j9jQhkwKp2ThhrPkuvGtWCrwgL4eoK
	WAXDbhtNFmBnpgrI7eCXFHE4cuZaACFzenVAoVwdZYGNOMqiehB1BUatkwCRNLiSMXadXJKxq/6GI
	aFK5Xo/FrB+D0gODthQfU6BHTcooU4VVEYSuJTgtsJmpck3yNILdIa8q7gcY3xLsx5U4++hbtgwTv
	SpzdSJJr2gS++BNGtRWXsd0a3seSJnPysHK47nzNKQFc7FQpYhTT00ZXSMprMgWcBa5gFPipqckMX
	KmqFc/MPpKkT/KzdJPtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMWO-00078J-AL; Fri, 04 Jan 2019 10:16:08 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMWL-00077x-JP
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 10:16:07 +0000
Received: by mail-pl1-x644.google.com with SMTP id e11so17248168plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=e0v/J119cUda2esQEjVh+aFzshtuHBTqU46owA02KgI=;
 b=dNVQenO4JCbAMAAPJDJSdlvv4NXOnbaA6TGUFuyLb9neNo2zroesebC8tUb/sKmnUR
 d+wM3D8zDhr6/MfSASAIgXp2mqX5cJuUaLy6pIloeiXTji9we1abvHZiFAYRNN1htwz9
 7kGznB5U5edZayNyg4HWGZ7nUnhu95dTBWjEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=e0v/J119cUda2esQEjVh+aFzshtuHBTqU46owA02KgI=;
 b=kDlMvUGtY8Sdhmfd8731b6tmx8b361KYRFSYjg940ItzA2fu1CAuCPh5tI1ZI6Viwg
 oduHi5qjPn5A2zTlYHCRG7ClTb9/hskBfXWLjztJm1YpWJ+3Fuf+I9L+6RfPzZK4eZc2
 SP6hsuu8fKgXoyiCttE6f8sIAxpxtBj7c6WSMKKXfA7KlMVN7Hag+sYN03Xrz4DHg6rp
 x1fPFVRfzqpKnpBK6SQQkMhCmbU9EQxZvMjJnVpfv/yntZrSPAznWiW6lQ3b7sNTzOAr
 FuuPUPpxm7if8wlFXCb8/7/yWDuAI29IskiWdKxLyvJqOBupCLuMg7BCCfTgOa/hQlxL
 VILQ==
X-Gm-Message-State: AJcUukftALYlhA7d/ehdtcUA3Sgo+yjRk/+O4vQo98M+RFHTbOKG78rU
 RgGzZX0DbLFZLwpnumvcG6ljlg==
X-Google-Smtp-Source: ALg8bN4shCnfxgvs1tyOF58w+3udY2yziO8YKNPPSRVIxYteRyIp9CT295A9l1cv+823xkM65TeR/w==
X-Received: by 2002:a17:902:7e0d:: with SMTP id
 b13mr50960281plm.154.1546596964671; 
 Fri, 04 Jan 2019 02:16:04 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id x27sm108630943pfe.178.2019.01.04.02.16.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 02:16:03 -0800 (PST)
Date: Fri, 4 Jan 2019 15:46:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Message-ID: <20190104101601.mpo4vpfcvsfauk2u@vireshk-i7>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
 <CAJZ5v0g4ABiPGGeLuzLN=1cT+7ejUP5hCgoN3_nhvr=Foaxa6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4ABiPGGeLuzLN=1cT+7ejUP5hCgoN3_nhvr=Foaxa6Q@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_021605_647181_8CE71A19 
X-CRM114-Status: GOOD (  16.43  )
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
Cc: Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "4 . 20" <stable@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Quentin Perret <quentin.perret@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Douglas.Raillard@arm.com, Valentin Schneider <valentin.schneider@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04-01-19, 11:10, Rafael J. Wysocki wrote:
> On Fri, Jan 4, 2019 at 10:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> > _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> > automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> > affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> > failures or on invocations of the policy->exit() callback.
> >
> > Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> > called from these drivers instead of dev_pm_opp_cpumask_remove_table().
> >
> > In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> > opp_list isn't getting accessed simultaneously from other parts of the
> > OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> > the opp_table->lock while traversing through the OPP list. And to
> > accomplish that, this patch also creates _opp_kref_release_unlocked()
> > which can be called from this new helper with the opp_table lock already
> > held.
> >
> > Cc: 4.20 <stable@vger.kernel.org> # v4.20
> > Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> > Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I guess I'll pick it up by hand.

Sure.

> I'm assuming that you have tested it, have you?

Yes, but I had to fake few dynamic OPPs and ignore the static ones
coming from DT. Lets wait for Sudeep or Valentin to test this, who
have real hardware to fix with this patch.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
