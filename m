Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0616CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:33:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C384120880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BXzXy+Rt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQzLIDyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C384120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YiWKNWKZ+OUopwTUySMMuy0My2OR8C0l1jvieTcEPdg=; b=BXzXy+RteULYIU
	7blAihGdWHt3vV+GZAXhAPhyUsQEBNgcvtK0MpKJCuGs3uFZaAWDvnWNxB9s9vQH+FGzlS22PPbFC
	USXoe8xt920DInVixEClNnAvJxU56NMrLncL4mmx8cT2hoeb6z0gamzbNX6+XpeV0latgp3TBzR+Q
	/67XTKBOv2fhF2yPEmS97rhQ3cSANNXM4JvVwW7EisdRAw5911QGbMFJACwteRCEyxopQjGzeoQ3M
	MaK6bkMqIdDt1WL1xlRk8aLA/dTMrIxOG/d4Z9BSn5qVaIhnbkdvnajrV2+9f/EHHIYqJDF0OjoGF
	Vax7IVXwS+e9iAF+ja5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkjR-0002Fd-JQ; Thu, 21 Feb 2019 09:33:29 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkjM-00027A-2l
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 09:33:27 +0000
Received: by mail-pl1-x641.google.com with SMTP id c4so8858500pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F0y1DogflDopug8Aip76ki3u/LmLn/vcTnG1MIPcGCg=;
 b=DQzLIDyWrSS7M66LifQ1uwF2ZPEgEdqQBALW6xyJOODHcYpD26gnRM7zpfz5YbFlMO
 q/qcSKKJWNFfIUWYb/UYxb6S618epvRf1XrvTU65sXLCarU9OT4wd98j6Da0LdFHSk17
 QNZxjx5CKAm0XQ+s7jspnx8AiffcIs756seNIKvM/G/v6DuxEE0jSFcfedG9FVwEhoWT
 uf0B0udYIFaGlALeBuj6gjTFqft9CKOECXQySccfULYnYtboTPx0Tu+tjtDyYXcwpdV6
 aYg4UXty4x6PD0kcytGJCh4e7vQFJ+e0zlufBwbGlBP0Wg8Qvtlvycl/78W70713wH1P
 MMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F0y1DogflDopug8Aip76ki3u/LmLn/vcTnG1MIPcGCg=;
 b=GGWpw5wP/ULorjYUCtdUUBWHiFZ/Vyv5XM2KfO+fDRd5r8rQyIwbLb8A+HFilN4V8w
 CzdiE8+GaETAzc9sS4DUYxUizbs5ZB/ZyulGtpXfJjqC/bQ13d3h3ewfYS4IoarWP6S2
 lJVzn3Zd8V95an2Uc6JhL8W1OVuTX9bv/cFpGaO7BvQrLhk73FYaUk2TbkRh6XaiWOZv
 8CImjPZkHodQC6IRNP2RS9dZz1ipBe7CpdJWruLO1hsoddVJaslpLyS5U0GL3J2h+WIz
 c3GviFy1KcHomF7hhGaL+O3y7VWqENGLpRjhDx3gjg6oqabvQSnWpjPobS2RqxC9iS5Y
 dxZA==
X-Gm-Message-State: AHQUAuZqJV3+If4WbMP7FY5DgoxeOUR+Mp4TNkXeFz5InJS5Kt22MteP
 Wp5MTJCQc3Y7PpboVa00IbpW
X-Google-Smtp-Source: AHgI3IaFwdy2f7HBoZu2Xlgq0Vo9z/5CH+SlLqnR+X0F/p/Hw6mM8wV8uUNo7obnbzQYQVKEoZBR9g==
X-Received: by 2002:a17:902:6f08:: with SMTP id
 w8mr26436093plk.5.1550741601699; 
 Thu, 21 Feb 2019 01:33:21 -0800 (PST)
Received: from mani ([103.59.133.81])
 by smtp.gmail.com with ESMTPSA id f16sm33591040pgg.20.2019.02.21.01.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 01:33:20 -0800 (PST)
Date: Thu, 21 Feb 2019 15:03:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Actions ARM64 DT updates for v5.1
Message-ID: <20190221093314.GA7726@mani>
References: <20190218135042.GA13218@mani>
 <CAK8P3a1k22OQF0iX8SR5RVS_9gfyYb19b9deuN_mNG+WF0LNGg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a1k22OQF0iX8SR5RVS_9gfyYb19b9deuN_mNG+WF0LNGg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_013324_678867_C20B1BFD 
X-CRM114-Status: GOOD (  19.31  )
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
Cc: arm-soc <arm@kernel.org>, linux-actions@lists.infradead.org,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On Wed, Feb 20, 2019 at 04:37:58PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 18, 2019 at 2:50 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > ---
> > The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> >
> >   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mani/linux-actions.git tags/actions-arm64-dt-for-v5.1
> >
> > for you to fetch changes up to 9175a8116f452a515cea734c6fedee6788e6bc33:
> >
> >   arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1 (2019-02-16 11:32:46 +0530)
> >
> > ----------------------------------------------------------------
> > Actions ARM64 DT changes for v5.1:
> >
> > - Add interrupt properties to S900 pinctrl node
> > - Add Reset controller support for S700
> > - Add Reset controller support for S900
> > - Add pinctrl support for S700
> > - Add I2C support for S700
> > - Enable I2C0 and I2C1 for s700-cubieboard7
> >
> > ----------------------------------------------------------------
> > Manivannan Sadhasivam (3):
> >       arm64: dts: actions: Add interrupt properties to pinctrl node for S900
> >       arm64: dts: actions: Add Reset Controller support for S700 SoC
> >       arm64: dts: actions: Add Reset Controller support for S900 SoC
> >
> > Parthiban Nallathambi (2):
> >       arm64: dts: actions: s700: Add I2C controller nodes
> >       arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1
> >
> > Saravanan Sekar (1):
> >       arm64: dts: actions: Add pinctrl node for Actions Semi S700
> 
> Pulled into arm/dt, but please try to improve the tag description for
> the next round: the text you have is more or less just a repeat
> of the one-line subjects of the individual patches.
> 
> Instead, what you want to do is give a high-level description of what
> is going on overall in your branch (e.g. adding multiple DT nodes for
> missing devices) and ideally some background (e.g. how much
> of the SoCs are actually described now, and how much is still
> missing here).
> 

Sorry for that. I will keep these in mind next time.

Thanks,
Mani

>        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
