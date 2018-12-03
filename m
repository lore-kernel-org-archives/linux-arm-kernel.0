Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F247C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7621420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="evdmlM2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7621420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w9XdIeYeu0il5XXssMBktvVai+9iV8pvKvUDuZT45Zo=; b=evdmlM2/ZhWXhU
	KoFdtGLCNi2OrxjbhVX2pAmkdVyQzKnn2rNnGwUdjxjwJ2ppGZ9Hb+VoV09Omh38+EyhY63un1+xC
	Hv5GOweC/xqdJbOz+nY+684Kc1z6Mb+B7fSpR+v2RfWhApkEPKVa6ot4Cq74ymH5tdcpCGe21FKc+
	Ki36ha8i0UWYm2vFAYfoZzVwRzfixVA4SKM0aW8niZYcao8dbt3BZ0Gsyz61uQ+MgD62JdZDaWK0g
	EidMC5wNFzfKYkJT5dGkR8YzkaxuUoa+t9YIvEcebDrRw5Sx+MMPFLD1N2aPzZFOgxEsB003s5fOM
	znG8vN0EjnTrtNFjmjHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrw5-0000WE-Vo; Mon, 03 Dec 2018 17:23:09 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrw2-0000Ut-RQ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:23:08 +0000
Received: by mail-ed1-f66.google.com with SMTP id h50so11466020ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eLe7hs6zK3nWa9FKvIs4EFvCkDLHitkC5GX4jfkvnAg=;
 b=IMxGFYqDMJ6E+KgtJAxmIhIDYni4ZRLyR08Sp29IbKMNBOX4MDzP8euG6vDXBV+zzl
 1VHfJqpUAE9KQlS/LKgZEC6D5hZMciZKF0YwpzLZ1jPhMg60VggYyydgE5BudH57yXk5
 EvlbsdmT0rXtp4Dl9SDiK9WtQmaRkyp556M7Aek+pUhekERqTtM2dihB2PFlMFjMnznc
 P1Q4EELCk38ptwCrWroN355+xZ2/wYCalN/e4JT4uDS1cM1wwQJyByCrDtzH0I4JHH4O
 t15Dg33TBnlb4XLJfizZW/OiZan3sb8MYbuL2u+pAyhwmjhYi3cf34mxkt+mfDmWJCiV
 ikYw==
X-Gm-Message-State: AA+aEWYfRwOrz30ezETF5ouPLGd/bMrj1vCy2ibN8pYjw//oo1EWsAHW
 hxXYe/57lZBGdjRES8CNIVI=
X-Google-Smtp-Source: AFSGD/UVFb/g3/KZkTEIhhqIhgyuc7N4aD7jHiNnsxXKWL4NjRzfuHJALxsLkY0LM/kemHFLT5czdg==
X-Received: by 2002:a05:6402:1299:: with SMTP id
 w25mr14506777edv.237.1543857774456; 
 Mon, 03 Dec 2018 09:22:54 -0800 (PST)
Received: from kozik-lap ([178.38.170.116])
 by smtp.googlemail.com with ESMTPSA id g3sm4129579edc.63.2018.12.03.09.22.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 09:22:53 -0800 (PST)
Date: Mon, 3 Dec 2018 18:22:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
Message-ID: <20181203172251.GA15124@kozik-lap>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1@eucas1p1.samsung.com>
 <1543847475-7600-6-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543847475-7600-6-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_092306_885248_07F51BC6 
X-CRM114-Status: GOOD (  17.00  )
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
Cc: mark.rutland@arm.com, anton@enomsg.org, len.brown@intel.com, pavel@ucw.cz,
 m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org,
 b.zolnierkie@samsung.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
 devicetree@vger.kernel.org, keescook@chromium.org, linux-pm@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, tony.luck@intel.com,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com, kgene@kernel.org,
 ccross@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:31:15PM +0100, Lukasz Luba wrote:
> Mark the state for devfreq device while entring suspend/resume process.
> 
> The patch is based on earlier work by Tobias Jakobi.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>  2 files changed, 4 insertions(+)

Thanks, applied with some minor commit msg changes. In general, please
take care about title prefix (git log --oneline
arch/arm/boot/dts/exynos*) and always explain why you are doing this.
You just mentioned "what" but that is pretty obvious by looking at
commit contents. The commit msg should answer why these should be marked
as opp-suspend and why these values were chosen.

The cover letter just briefly describes "issue with devfreq devices' frequency
during suspend/resume"... but what issue?

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index b6091c2..4429b72 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -298,6 +298,7 @@
>  			opp-400000000 {
>  				opp-hz = /bits/ 64 <400000000>;
>  				opp-microvolt = <1150000>;
> +				opp-suspend;
>  			};
>  		};
>  
> @@ -367,6 +368,7 @@
>  			};
>  			opp-200000000 {
>  				opp-hz = /bits/ 64 <200000000>;
> +				opp-suspend;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 51f72f0..908c0c4 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -432,6 +432,7 @@
>  			opp-400000000 {
>  				opp-hz = /bits/ 64 <400000000>;
>  				opp-microvolt = <1050000>;
> +				opp-suspend;
>  			};
>  		};
>  
> @@ -520,6 +521,7 @@
>  			opp-200000000 {
>  				opp-hz = /bits/ 64 <200000000>;
>  				opp-microvolt = <1000000>;
> +				opp-suspend;
>  			};
>  		};
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
