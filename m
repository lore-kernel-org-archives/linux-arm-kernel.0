Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5960CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:49:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2905220878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WjQM36M1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXepVupu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2905220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SFe+NJ//41UPXrw5tTTfQbPs66ET5fGFUSN4UyqtQuM=; b=WjQM36M1EUx2dA
	AdlcYa9N2N45iKLTXg+B3lLhHHk7EDeFdGVuuQCvezXHyfyAOMFyhENMmjHP4i8J5/PwHohUtU8uE
	qJkl+KjQyEWJkpvV6/MG8Fv3f6lZkOM2aCF2mLiRWLjWSh7AeM3pqNpBHcKUH7BVC4rqpyAKLaOda
	Xzhxu48fVgpO1RCdX5Fc4kx9Z14g00uoqKzjJ7GcEqYj6hPOo4Q3AwQZRK82LXkek8XU3fcB2XpPm
	3dQSkZRbd6MZtRXgyXSwLDCTJXS0J/o3qwgEoHb1+ZWlqNYnm127mxNgrDnpFVcuxBz8sfFVW0ygV
	CqEC6E3JeQI989zxjqZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaM9-0004JG-Os; Wed, 05 Dec 2018 16:49:01 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaM5-0004IP-W6
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:48:59 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so10317605plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AnzAHnoneX5ZUW+xu0j1i8VHCi4fiXdut00F2JmCibo=;
 b=YXepVupuFmAQ2gjjv3uwK93d00JBcSl/oY2H6FQHu6IgYVwKvIqnKlRH+vumE5vPPy
 Vo3KDjAxq15vCa6OH2etaevsiYR/gcyIk6qyE094rA/VNjn7OcKRIx8KckmIMTTbBShd
 OxFXaUA4lnEsxYsbTi+delBRVIORL7/4Klazw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AnzAHnoneX5ZUW+xu0j1i8VHCi4fiXdut00F2JmCibo=;
 b=XwLi+9LoabsSoud5777cfRtax/75C5o+WvQfsY2KsPVHAKrDq8x6r/Xx7Et5rbGbDK
 dGgTeow7qBi3eJDe/XNTw4ukoD0ZmtLqxJmsy3gU6/qfG7sc/KJJDhpTcvIWMqFnQZJ/
 swg/beXniVPl4bNJyjItdWDjF+Vmt5F7yZI2WfcBqDV/5yMA6HtgrLKsOgukDVsMw0dz
 dAN96MH79SZGZhAKHrlKiDfxnkKwRF7zIaNSxs+neApWRw4iStWP3d29qTW8HpQLssFA
 77XZvSnfMWv150mZ4jlxH6ugfKg7ZwmZm4cc6v0tbLyQfSx2ZNndchJ9PHeLujj83npq
 E4Ow==
X-Gm-Message-State: AA+aEWYyVyIOygpClavLSGiqlJ5ueeFU6wcJAzRp2pp7bfxihncJvhWw
 iQTg+zy5WAEW5Ad5RKLvJuMFeA==
X-Google-Smtp-Source: AFSGD/UjEReNMNv/F/Nz6tLnLIfpSj7iMMVkXhc0qtdXvQe6y7rr+038+pHv+YdLVABvhHadxHqnrA==
X-Received: by 2002:a17:902:b592:: with SMTP id
 a18mr16369133pls.293.1544028526943; 
 Wed, 05 Dec 2018 08:48:46 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id k24sm39220231pfj.13.2018.12.05.08.48.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 08:48:46 -0800 (PST)
Date: Wed, 5 Dec 2018 08:48:43 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
Message-ID: <20181205164843.GB1492@tuxbook-pro>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
 <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
 <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_084858_043243_8549DDB4 
X-CRM114-Status: GOOD (  22.66  )
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
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>, Stephen Boyd <sboyd@kernel.org>,
 MSM <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed 05 Dec 08:38 PST 2018, Jeffrey Hugo wrote:

> On 12/5/2018 9:12 AM, Marc Gonzalez wrote:
> > On 15/11/2018 21:44, Jeffrey Hugo wrote:
> > 
> > > The root parent clock of most msm8998 clock is the "xo" clock.  The DT node
> > > is incorrectly named "xo_board", which prevents Linux from correctly
> > > parsing the clock tree, resulting in most clocks being unparented and
> > > unable to be manipulated.  The end result is that we can't turn on clocks
> > > for peripherals like SD, so init usually fails.
> > > 
> > > Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > index 78227cc..a948d4b 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > @@ -53,7 +53,7 @@
> > >   	};
> > >   	clocks {
> > > -		xo_board {
> > > +		xo {
> > >   			compatible = "fixed-clock";
> > >   			#clock-cells = <0>;
> > >   			clock-frequency = <19200000>;
> > > 
> > 
> > Isn't there going to be a problem for msm8998 in drivers/clk/qcom/clk-smd-rpm.c
> > which uses "xo_board" for parent_names?
> 
> Looks like you are right.  This doesn't seem to be the correct way to
> address the issue then.  I'll have to dig in and take another look.
> 

The appropriate solution is to describe references between clock drivers
explicitly in DeviceTree and by that not rely on a global namespace.
That will also sort out any initialization ordering issues that we might
have.

But this task has not yet made it off the todo lists where it lives...

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
