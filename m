Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:25:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39882190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WjUEXgRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39882190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MDyAv2899oTpAQwmsPYBslBrOsfXMjoXVBuzgS3PV1o=; b=WjUEXgRiX1mYx3
	rL7jXjfNHP0Ad2jvk8UQSIXFANcoFNIl6vkHHnt9PP4DU5/kYWFcBQx2Yt4XQfSlZ70fEqsGelc6W
	IEQviI2rRj5eGhykQcgpNBHfjYH0k/aP1F002EliEdeyDYUh7k7ijfgYe+qFIyzb/YDS/SFws0vZN
	FYbJhoLgiUtcE172LbmRhoITclJ3CpCJAgRO4fCRYA/lz1tz9ZGlqCE81BKLbll9Ys+0gq/joG8DW
	NChsZGKrTm1bw3SfYMkhE2kcCE5Qb8faoz12NfRoF1YAo9JoWUnh+k9hgXxESx6UXuUO91EVkGiEm
	cKlW7ygAoP1NXwWoK3+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaPUL-0004g6-K0; Fri, 21 Dec 2018 18:25:33 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaPUH-0004eZ-TR
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 18:25:31 +0000
Received: by mail-ot1-f68.google.com with SMTP id v23so5911629otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 10:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nnv9jUXgk30zxmuYJX7EViK68oqsu0CngVr3vKAQyFQ=;
 b=DEZOMTGyT8DlS4FgJETLYfFhYpZR2r0on72eoCPtlY7vfcWw5ANbsjAWRAIlbIdlH1
 vA3W1s4b7ZW6f0Gt5oiUxJhavgMhmGk9JSWzH9PhOwFxlOXTI3A0mgmmXQIQGLJTxS2n
 8H2SlK7Ee1fnJI+54cH0DNEqeiAODP8sB0ywGaVfMTp0hNRARsbadBCqXJyRPUw71HxV
 SN4czYkkwHSip+/vlmfNlU4+rKSXqqwsrvb5iX5Cf+J8i1S1JxEJIQs5Fvyc+fw6ZWPB
 kpra89JGS5KwwTkbz9ulIP98kG0Igm2MYIsIN3xebqdfohZ9tNVEEPs0oqOyYFp3A5QA
 E0Nw==
X-Gm-Message-State: AJcUukeVO8duKmcLtIvzsAZiQUJz+PcIxe7YOhVWRwF6fxt/TB/JFtCc
 fA1/0uuuNsjIDjbUWpNEcw==
X-Google-Smtp-Source: ALg8bN4Yh2IvPYPf3f3hnBkLlqZFGQds/veTkjWTyBnajbn3Anfvr8DHJUZ79vglPDmqAOXduoDy7g==
X-Received: by 2002:a9d:14e:: with SMTP id 72mr2489882otu.54.1545416719180;
 Fri, 21 Dec 2018 10:25:19 -0800 (PST)
Received: from localhost (ip-70-12-27-227.kscymo.spcsdns.net. [70.12.27.227])
 by smtp.gmail.com with ESMTPSA id
 b12sm11120812otp.75.2018.12.21.10.25.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 10:25:18 -0800 (PST)
Date: Fri, 21 Dec 2018 12:25:12 -0600
From: Rob Herring <robh@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v5 6/8] iio: adc: add STMPE ADC devicetree bindings
Message-ID: <20181221182512.GA8531@bogus>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-7-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-7-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_102529_955011_A1AB00B0 
X-CRM114-Status: GOOD (  18.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, linux-iio@vger.kernel.org,
 stefan@agner.ch, thierry.reding@gmail.com,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, digetx@gmail.com,
 lee.jones@linaro.org, linux-stm32@st-md-mailman.stormreply.com,
 robh@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 marcel.ziswiler@toradex.com, linux-input@vger.kernel.org,
 coquelin.stm32@gmail.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 Philippe Schenker <philippe.schenker@toradex.com>,
 linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Hartmut Knaack <knaack.h@gmx.de>, shawnguo@kernel.org, jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 21 Dec 2018 14:46:35 +0100, Philippe Schenker wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC. This also corrects
> a typo in st,sample-time it is rather "6 -> 124 clocks" according
> to the datasheet and not 144.
> We need to use the naming stmpe_adc in devicetree because this is given
> by the mfd device.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Changes in v5:
>  - Made a one column list
>  - Cleared note about precedence
>  - Changed example to a full STMPE811 device with MFD, touchscreen, and the new
>    stmpe_adc driver.
>  - Added Jonathan Cameron's Reviewed-by
> 
> Changes in v4:
>  - Put reformatting in a separate precursor patch.
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++
>  .../bindings/input/touchscreen/stmpe.txt      | 88 +++++++++++++------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 +++
>  3 files changed, 98 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
