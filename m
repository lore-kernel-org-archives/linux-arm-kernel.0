Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:48:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B88720823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nOG1qkg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B88720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JZwX+SUqHUqR24S/f3fpv1AC3Mn4BAdtUcxA4BLdzeg=; b=nOG1qkg8AxFbDQ
	rtKfHvp88hYNCar6YN4cDwZWbd5huh56vW8iKRU5Rp54MdvyLQmWmCMCbw0in7moM+3NuWDU1vydO
	aimVseRuK2GWrzHnDRHuENk+l94/CQyoe140/CH8fVVVrWRSApIj1HcEso+C4JMXTthFnv4bFHzTn
	g95s2RUaryXwKYC70kaou8SzVoPliFoTJg5hfZ4RwTSXcJ+XqT+q3tCg/ZYbZ7YLR3A5ngRbTZ5wm
	asFBABxIZZ9gJ8aR4HjWPqnuHsBqYHmIZFcZwUUvdE88N0SPCs9SjR7woe2k5u3v0NeBMqyKZaR10
	SUSNbprXuRkLLQzIBOXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqmF-0000sH-6A; Mon, 18 Feb 2019 21:48:39 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqmA-0000rT-UZ; Mon, 18 Feb 2019 21:48:36 +0000
Received: from oxbaltgw06.schlund.de ([172.19.246.12]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mf0uq-1hWqYR0lvG-00gYED; Mon, 18 Feb 2019 22:48:29 +0100
Date: Mon, 18 Feb 2019 22:48:28 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
Message-ID: <582983974.587867.1550526508995@email.ionos.de>
In-Reply-To: <3e9a387c-2ebc-c762-6222-90efc851e4ed@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
 <1528638260.343699.1550436208775@email.ionos.de>
 <3e9a387c-2ebc-c762-6222-90efc851e4ed@davidjohnsummers.uk>
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:zhtXsb7cWKi9se5v7bUGTCHHJddwYU4lng7cRIR4PBTljUR2eVr
 e2vgNeoxXJBnfhRuqfNVMGneLmHl8z2QG2+ygNQOYLI5afME1gEWE77DfZ8l5SCVKEXNzqg
 DYKBzHjSmLVFKBxzw8iPyYow6rkmj/OKpkBwsbilB1oajvLuOlOD8wX2QOVSkyUIqbAIvJN
 ryPA8XeKHKhPWuviDvB3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jQ0JOCKsbhA=:xR1sybVsfLseGvlCBhfs49
 QsmfGJz8qUvNtGW0EEM5/uUTev4XXp8tUqWgZ10tddWFlWxq4/z7jqWLSyaq8IxRwLix7JFnB
 7dlbSoKQ/A7gu6ni+InO2tSnL1POVijxj0TmyX3dcPKB5bnIjNKQTI8QPGPZXZCd6VwBy4s7k
 zlOVHXTaPEkk4pWtvIRk/OPYqHha+cupqctJEOtXScGPKcesVPapZaU4XgDAhFyr1F9WuEFCg
 i8hFb/+fBgMYcoxuX14niT74l0H1sPIF6G3/Cb7bSqiEuh8n7tNpqYaAXhC+6vp6IE5gUHz1L
 NfOfMulS23txGWkTonCVsv1Tfb/0IU7NR/BU41ejDThuaX6mGGgVuKTFisPYVdo7LjhEMOgLJ
 8+t2a+cVp/1QkdrX5RgEEUr1nSCbBGSRk57C1F3u2929QxnhDFuCvxi1i2DJXOYvsgrNyKCm9
 fijnB96ZQKDlWSutWgcyg6tCpbzOxqUzYl8/YM3HyhGktJVKZLX3SbeS6fWxnHXVN9O0PBrjA
 o6xvFAh5n+1hrvuIXLmm0B0r9mRh1IyXkf+E3OXJ50Y2fSmrQZ/oyjdi1BaLZ4GBuWZPVA5Ca
 cdIC/kLY6QPcbEYsdfjNoi+fhOYzn/4g+SE47ShjSBA9F5cMeUXG6nYYLiN9HKR7R5FoQvJz7
 cqLgVsEW85h7RzlIR/rw/UtNHak3I16A36ZROuwteLFuHTLCx4hdTpKCb/xCLj28+hnN/WKjO
 gttXiSUuslrz7o+tXalxxZnwG9Or8SvlJ39H8Z2ekO6ec3l12UADMgNz4Dw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_134835_287058_E3AD0B8C 
X-CRM114-Status: GOOD (  18.86  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

> David Summers <beagleboard@davidjohnsummers.uk> hat am 18. Februar 2019 um 21:26 geschrieben:
> 
> 
> On 17/02/2019 20:43, Stefan Wahren wrote:
> > Hi David,
> >
> >> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 13:15 geschrieben:
> >>
> >>
> >> +
> >> +	sdio_pwrseq: sdio-pwrseq {
> >> +		compatible = "mmc-pwrseq-simple";
> >> +		clocks = <&rk808 RK808_CLKOUT1>;
> >> +		clock-names = "ext_clock";
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&wifi_enable>;
> > As i wrote at the Arch board it would be nice to keep the Asus comment here:
> >
> > /*
> >   * On the module itself this is one of these (depending
> >   * on the actual card populated):
> >   * - SDIO_RESET_L_WL_REG_ON
> >   * - PDN (power down when low)
> >   */
> >
> Sorry Stefan,
> 
> I'm with Robin on this one.

i don't known anything about the reference design. So please ignore my comment.

> 
> 
> >> +		reset-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_LOW>, <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
> >> +	};
> >>   };
> >>   
> >>   &cpu0 {
> >> @@ -337,8 +345,8 @@
> >>   
> >>   &io_domains {
> >>   	status = "okay";
> >> -
> > Please drop this whitespace change
> Most {} in dts don't have white space line in - only between {} {}. So a 
> white space line in the middle of a single {} is unusual. I can't see 
> what its needed for, or what it makes clearer. So to me removing makes 
> it more in line with everything else. If people are unhappy though I'll 
> add the white line back in again.

I don't have a problem with dropping the empy line in general. But it's unrelated to this change. So please make it a separate patch or drop it completely.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
