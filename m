Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC920C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:54:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12CA218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o63+Z9Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12CA218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JwhwQP3AvYYZqyfVhOKWey8aBqeWy3+UjK/D2VdjMA0=; b=o63+Z9SaMi76rl
	01iB96meL00HnHIvKqn4cWcTsimC8+2SCDtU1vqnM4UYEtibbJYdhvK+Z2H8BswRk3tDYHaWZwGfY
	tI1kE0lkHWoOZFyEjwiiZH+uYKB5LHsuhKdiJc7qGw2lymJamnSC3a5O8HB1gWwBOqulVCccyy3YM
	gj8ZRDU1lM726E0500ck2k3X5iYVPpVGPVK1N7kS4QKlOE//mjvId0zoXsiVeYS0Ejq7FBL1zeyHJ
	vQifzerqUxqL0g+KjzPAoi5Nuh6imWu42D0prajVgG+sPPF19XoAN5K/EUsQkq9nqGVxTmL1kcjvA
	flZAz9BeBURHFv3yFeng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmk8Y-0003OX-DM; Thu, 24 Jan 2019 18:54:02 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmk8V-0003O3-CC; Thu, 24 Jan 2019 18:54:01 +0000
Received: from oxbaltgw60.schlund.de ([172.19.246.147]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6Kl7-1hFrcc3CzR-016gNU; Thu, 24 Jan 2019 19:53:51 +0100
Date: Thu, 24 Jan 2019 19:53:50 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Message-ID: <358883737.20143.1548356030930@email.ionos.de>
In-Reply-To: <87imydvs55.fsf@anholt.net>
References: <1548353060-4900-1-git-send-email-stefan.wahren@i2se.com>
 <87imydvs55.fsf@anholt.net>
Subject: Re: [PATCH V2] soc: bcm: Make PM driver default for BCM2835
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:aFT+N5oR99P8+2CVGx53Y0Ft4GXt/alM0Ew8e67rOVziyJnU21I
 1ifCxEoY6rFagEP+INOLzUQfAktSZiE8eTbfc89wLZdIqdUOKelQkdOH1ukD0+qaTHQaqIT
 4Y0YucBZ7zR/JSIVpOd9WGa/L9Y+o0yWmqGQIS51YCq0eeN92Oo43fiWLpg3EuKvfG/eYct
 D2rAGGFA8QG/OF/dE4Zgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nHvwT9t4zG8=:cS8o9A+ksxdg3Xk/mPvRAE
 WBV9qoWFpaWtX9lb8fhp713pNh6fiE5wML0DKba0kJootH1CIgCc/niebg99100hDaxqJFRAW
 li/yH+mJfaU9m3sXW+0kW14BenHwx3t34cmrvD0k73k4kwWTJOGMTZi1uIL329VYUaeONNPah
 mDxHiCGWlvZumfVotQXAwsJQKllkWx/9xnGz3vUCt3oArXAPmkLNjmnN8MNHWwTOL+2hO4pnA
 7Nct53LWCBrd9M5IWbi/9xMEbgvzu5T+5vIWd67kcM8J3oTOoBBqscy9SRSNKNCTh0DvkwK0p
 TJWWIyoKE0jOubwriUE4ipbgl0wf3lxcJTERJxtpid1+YU0wlJQd5mGGS4sTK9EW8ENByQS4T
 6PbkIC+ReivN91c5qoDF5vn2t57yrkLjy4zHc34AYGOcjRRI3xz5xIgceg9qJZ52VxT2flEGo
 f+DKZ8kIa5WXyn29towO4A/8rM6Ml57xpjIIFiF5DnAPWV54Qhcmgmm6Ujn9znPzuecx7QkqZ
 fiDJJ5xd1ZJflnOVMsc2AYy6THfpao3b/pKvDia0k3qbO2TH2YZOVUghUj+/ZjnOYHtkSOFeS
 Bb7JB7KUzlQXYjINhC7elUO56yNKKTXdiuizZaX3T/TMkFVmbDUXsqtXxT9ehX1uAnrV2IGLj
 MSc5tmWh+kWaujiby+VetQ1OnUX6hcCnQe5dei4ARHuswahI/G4QKcnGwjWaeSfqM8ZaUPkR4
 9bhvbqRhto4hayo//THm5LHUOBZtsCdQn+gfJFRZGJSuOj+G8s7SoG3O/GI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_105359_712689_A2BBA106 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 24. Januar 2019 um 19:15 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
> > PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.
> >
> > Otherwise the driver won't probe and HDMI output stays black:
> > vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

I allowed me to applied this to bcm2835-drivers-next.

Please feel to prepare the pull requests for Florian.

Thanks
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
