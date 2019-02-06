Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:17:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7652520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m3Pe40e2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWLwripM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7652520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PYl0VJkHAryHJLF/nVX5IhXYcJkLY7T607apA/CPzVE=; b=m3Pe40e2fOwlls
	asLI68AG7qJnliHBXghL2WBI5ovM3KcrauPTem+5W7RY2VReHx5X95l+ouVSC2aSihWckfmO+N+7D
	jHEcenx2wQTPvdkcAbKSPM6BVzHAoZBq9FIhsbVxOPWSF5Kk4lwzzKayRfzDVt68k6HAmG41WstBl
	3L8VAY6V82DxXHYDpKFh57XDJwRJuQVEKAtPB5Bzp7p+vge9dfHEBIRZX5wmaa8H+cgdv1ueRtlTF
	KxYjErhW4plGQDzrMXI0AeLcyBgNDYTJiOXsNjN0wx2V8CmbJLHEeIncfj/T9ljUObqAzi3nYizM+
	F4wK+Jxd5C6O69n3EMPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grRkv-0006d1-6O; Wed, 06 Feb 2019 18:17:05 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grRkr-0006by-MK
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:17:03 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so3233892pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MhIG2ByH0nfB88vhi3Ju2g4JuRs3GssxeE0tYPDVI3g=;
 b=JWLwripM7cig2N6/Lra2zSRJZA3puuvePaI0FeoUozufAmBTtsF2ulgF8eJJnMBlwx
 Ijo7GUr+Z1HnpbOGUMkPMO16fPpmq/XbGnzJMkw5YyVFm09so+/MLeShpFfC/d68Kc2s
 6PC7OWBH1QdTX3Os9LaA0Sd+PucwM6oEU1SaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MhIG2ByH0nfB88vhi3Ju2g4JuRs3GssxeE0tYPDVI3g=;
 b=kI8P3NOIDUfjkV7UaxEuqPAvdFXFNt7DPRbogJoqFz/aeGSQbLarhDrlo7+ibKlH2S
 vjNk/079jzA980/W1hqN4xhALGRcJfPujpR1jOCTQsQigDTNCMzndevLSbUpYKbhHBOV
 cinNxSpwazzcuYNOLcqYgcP6vHPoy7FzDyBCi1esrDHTMrQj4S6ZCb41yTLWw5HwAOe8
 aN7RxbNTmmZBtD8z2O5J/mfxZDFw7Z1H2cmhQkpR9HQM+1DrR8eh34k23UC/0h1Ug1BW
 1W/01YpQ2wmYjonkd34tDfrCSVhOvQ23VBbFy9j52aJfUx49pULFT8mYLi988MqR6aU7
 HYuQ==
X-Gm-Message-State: AHQUAubKl75Oesi/oBwtjijedinKAHNf6b+xgeGG0Rtva9J0tMJXmTvM
 3u8XGNLD5Bl+sRtRGJXKN81AAw==
X-Google-Smtp-Source: AHgI3IY+Qn+GaBsUDviGTrhL0JwUFojmyAInDmLBAgvqUwEOEvNJ8pySZM6KiT5YYwTQ9N2x7AHnRQ==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr10701296pgh.6.1549477020321; 
 Wed, 06 Feb 2019 10:17:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id i12sm7669354pgs.28.2019.02.06.10.16.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 10:16:59 -0800 (PST)
Date: Wed, 6 Feb 2019 10:16:59 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Message-ID: <20190206181659.GI117604@google.com>
References: <20190205175225.25923-1-mka@chromium.org>
 <20190205175225.25923-2-mka@chromium.org>
 <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_101701_756168_8C49111A 
X-CRM114-Status: GOOD (  20.38  )
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
Cc: Taniya Das <tdas@codeaurora.org>, Nicolas Boichat <drinkcat@chromium.org>,
 linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, CK Hu <ck.hu@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Quentin,

On Wed, Feb 06, 2019 at 10:13:18AM +0000, Quentin Perret wrote:
> Hi Matthias,
> 
> On Tuesday 05 Feb 2019 at 09:52:25 (-0800), Matthias Kaehlcke wrote:
> > Try and register an Energy Model from mediatek-cpufreq to allow
> > interested subsystems like the task scheduler to use the provided
> > information.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > index eb8920d398181..e6168ee582783 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
> >  		return ret;
> >  	}
> >  
> > +	dev_pm_opp_of_register_em(policy->cpus);
> 
> I'm not familiar with the mediatek-cpufreq driver so bear with me, but
> the code sets policy->cpus just below here. Is there any particular
> reason for not using that in PM_EM ?

You are prefectly right, I missed the obvious and didn't get my hands
on hardware yet for testing.

So much for screwing up a one-liner ... I'll send a fix.

I thought Viresh already applied the patch, however in opp/linux-next
I currently only see the other one of this series for qcom-hw, so it
seems sending a new version rather than a fix-up patch is the way to
go.

Thanks for the review!

> >  	cpumask_copy(policy->cpus, &info->cpus);
> >  	policy->freq_table = freq_table;
> >  	policy->driver_data = info;
> 
> Thanks,
> Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
