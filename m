Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EC2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:13:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC5B2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L8iE+9Ut";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DH68Crua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC5B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3zFB83t0Kvst2n0fpdlvVXsAgA4QJp4pa9qSGXyiv6Q=; b=L8iE+9UtHj6Q5w
	/V/n0srxLJO0ep3TM8tOCyn/A8PRWFx5lzZRe2BSob7zHx7SeabmSzxV3XfY8EYZ88bHjpfqyEWqA
	D1HWrRs61uxlYm3UCAqbneWT5sn0c6uyEejY53Cp8/d1RX9usiv0JgPJvrwL78uGk3tfp/BgbvpGX
	L1082pV5iWSFmkE21H6ulxShyWKBwwzt14E5VYPAPTiOzN96J3GBMtjG9pKK+Js7J5wkISOP8F58P
	v3G//aQIFG44VoEueSY7NpV4OFwc6dnDonBkgTaDB91ttx46ToZ0jTiT3M2G/DJ+x6XyIAb0I9dHh
	r1RkeUPTJ2nXcvvf++vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUiDt-000467-L6; Thu, 06 Dec 2018 01:13:01 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUiDn-000459-2B
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:12:58 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so10891450pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 17:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=xc1DcH3Ccdt7Hjtu4AOtF7sgap6z8qY7r0DkdlQf02Q=;
 b=DH68Crua34XImI/EB+WV3DPl0eNCgXN0ZmZih8+939mNhFjN5T4tATswlOwaUzPQM8
 SabJP3OrtEkWNgjSukwyG9YmU5FNhlFQ4JwjviSHt6tzYTQcwBvYoJ266S2VNFG5g+TV
 gBfhhVrRZr/VMWcukf+6QqTVvc49e8RQlwlec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=xc1DcH3Ccdt7Hjtu4AOtF7sgap6z8qY7r0DkdlQf02Q=;
 b=Q0dzzHCxCh1H+p854tBOtWRhhmDQDQkGHtLI54e3N8Lwx/ETIUnk82D7JtN3FZHcPc
 mDCrwOIY2G2+muSTBRY8Odqb6P8iUunw2NX8xGeySlrtb9WNHFWXqAoqraFxzS0YG90j
 pRVsyanflB0O6fhroON0RUWKErjdX/iZaCTmS9/UNUF3oihuD2H6PqMlQNVE5Te39w+a
 sw2qVnErk4Q6uXh/C7r6UxzW2kLaPhCIY4VYzQItNPrG3kqESEkjOxNC/Vihsr4OcEjC
 W0U5TGr1uzUaHf5GDyhx+L23PDtToFHdXuzjDyVetrpuxJ9//wzTrTMK5R95ECIiDfwc
 yxxg==
X-Gm-Message-State: AA+aEWbKKkDdeU3BzP8WNVdpUqNiOnuwNukE6mHrh838E0puInCkCscI
 chkEHCJRiIereXMIY4YbOL1VIQ==
X-Google-Smtp-Source: AFSGD/X2m+iq2XcJF7bJpbVAh0eAlCrOhLIhPbfYf6YHdOBGsADCjuvdN/1Ts8KWnuyE2uU5GfQROw==
X-Received: by 2002:a63:8ac4:: with SMTP id
 y187mr22552911pgd.446.1544058764302; 
 Wed, 05 Dec 2018 17:12:44 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h10sm24859653pgn.11.2018.12.05.17.12.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 17:12:43 -0800 (PST)
Date: Wed, 5 Dec 2018 17:10:45 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
Message-ID: <20181206011045.GA23336@builder>
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
 <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_171255_118813_5483CF62 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: Ohad Ben Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri 30 Nov 06:45 PST 2018, Benjamin Gaignard wrote:

> Le mer. 14 nov. 2018 =E0 10:00, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> a =E9crit :
> >
> > This serie adds the support of the hardware semaphore block for stm32mp=
1 SoC.
> >
> > version 4:
> > - add Linaro SoB
> =

> Gentle ping on this series
> =


Sorry about that Benjamin, I was convinced that I picked your patches
already. Applied first two patches to hwspinlock tree.

I expect the dts update to go through the ST tree, and I guess the
complaint from 0day tells us they already are?

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
