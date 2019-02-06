Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B0C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:49:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC45C217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="duw9wI1E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdOtrgUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC45C217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jGHVPKw7bYS6GzLAsEGP5IBTfQEIUiUb9V0ey6/e7g=; b=duw9wI1ERMCqTm
	iU+AaEdFmWmlLWIoAuYfX/sExl4bjFP0a1UlKecp94RMRvrhr9F8imSUPblWaCWtQLFK7E1K7BJGE
	jn7lCDcgrl3SH9jMwGtaKAFHemPdNjW01ZRxT5ntPzk902AaHyvvtFVzs3+sPxwbOSgW5T3cHx8Ao
	EkjgPHnAJU7B/PPsTcvNJQe3pcsKHER/oh3mx5y3UMYoQTVIbDqs4aLay044ZLgcb1/T7SUFRKXaL
	b5+9+M9OBfxH9XnPbYI72tR/4Oy8S49sNqFKmUmzySt/dA4a3A8Gpa7IOViHwBl85kadXi//fdiCi
	f5yTrpgcTgZzJM2AEw2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grBOj-0001tk-PD; Wed, 06 Feb 2019 00:49:05 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grBOg-0001tK-8J; Wed, 06 Feb 2019 00:49:03 +0000
Received: by mail-pg1-x542.google.com with SMTP id d72so2164590pga.9;
 Tue, 05 Feb 2019 16:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fygf7zWkpHlUBvY4zArgNZspQNtVM7b7j+lUpAebLec=;
 b=hdOtrgUc1ADXkYukL13QGUfJ7CwesoZ7E0n4bgeu5erX7Gn44rpWwpINfAat/4tUGD
 fUQH98Ykl7AGGNgHMMKhgOltgsCUMTvVJHAFMd7pZRBHRnFnLZmmBT/lL3N4zyXXek/a
 fGhG1BptWMCDJyvihwNYcddyEi1/VJlzv9RwkpS4f8V45+gS/XjbWxTcF/SJNeGonzNx
 BSeWoPJNxnegoxGkYrsnNCt/lg/AQa4bFMUw9WN/720K7v4FbuWXZZ2uDRIJw7SzbcEH
 hZITZ68bezkJ+1NQP8b4ZT5nqISifouRybaiuSJZenWoBXxBVU5hoXyj4ZKF7ViMGZJx
 ODRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fygf7zWkpHlUBvY4zArgNZspQNtVM7b7j+lUpAebLec=;
 b=mfVqY9KQWB+KBtsZM7jyCpP1JMFnR3Aw+KsJF2NTi7m/ufeJF6YafBsZDhpMbj6ynz
 Vorykmsp3lsoAf0sCK/R5x0pqt3olX1+38XMX7ulReS0XAc76wquxQD1nqigxg6QZ3HS
 8+NHh9/i0fuhc/pfcmVOfVCj4tilxgWoFyYx6OewVqJqssUb3zD9wVmvGox+QSbC9WXr
 krkGXx958EyPzgEoIHt+Jxv3NHd6hJSud1jN0duiGyGJVEG6kJV1kZ4KbcCkRunF7MfA
 coORfXQpJCfqLqk5zmb9/T4qWqd59ReEyN7xCvL4kndwzzfRIOsaMUSoEOpdvkXK7zsS
 XU2A==
X-Gm-Message-State: AHQUAuZ4WaC+i6uvCa82iLmsjPX2HgOeyLEpicSq6JKg4DW4Ic3eoN3q
 yHbq5lFex8BMC/5zc159h7Y=
X-Google-Smtp-Source: AHgI3IYDogd3BK/tFiyIGNgJ7rE1G+A1DKOBywq2yU4HzXfPZB8t8oNMN1rFLBk8JYJ4W+YGgoB/XA==
X-Received: by 2002:a63:be0a:: with SMTP id l10mr2349341pgf.292.1549414141257; 
 Tue, 05 Feb 2019 16:49:01 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id g6sm6990242pgq.18.2019.02.05.16.48.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 16:48:59 -0800 (PST)
Date: Tue, 5 Feb 2019 16:48:51 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/7] thermal: mediatek: add calibration item
Message-ID: <20190206004837.GC19687@localhost.localdomain>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
 <1549006693-11659-4-git-send-email-michael.kao@mediatek.com>
 <dcc04c1e-eb7d-024e-abc8-7b75504947c2@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dcc04c1e-eb7d-024e-abc8-7b75504947c2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_164902_292102_D51DAD05 
X-CRM114-Status: GOOD (  20.83  )
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
Cc: =Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 =Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 michael.kao@mediatek.com, =Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, =Zhang Rui <rui.zhang@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 06:31:41PM +0100, Matthias Brugger wrote:
> 
> 
> On 01/02/2019 08:38, michael.kao@mediatek.com wrote:
> > From: Michael Kao <michael.kao@mediatek.com>
> > 
> > Add calibration item in thermal_data to support
> > the project with different calibration coefficient.
> > 
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > ---
> >  drivers/thermal/mtk_thermal.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index 07f8ad7..45c6587 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -105,6 +105,9 @@
> >  /* The number of sensing points per bank */
> >  #define MT8173_NUM_SENSORS_PER_ZONE	4
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT8173_CALIBRATION	165
> > +
> 
> Calibration value is the same for all SoCs (including mt8183), we can define it
> once and use it in all mtk_thermal structs.

Well, on patch 7 we have:

+#define MT8183_CALIBRATION	153

> 
> Regards,
> Matthias
> 
> 
> >  /*
> >   * Layout of the fuses providing the calibration data
> >   * These macros could be used for MT8173, MT2701, and MT2712.
> > @@ -147,6 +150,9 @@ enum {
> >  /* The number of sensing points per bank */
> >  #define MT2701_NUM_SENSORS_PER_ZONE	3
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT2701_CALIBRATION	165
> > +
> >  /* MT2712 thermal sensors */
> >  #define MT2712_TS1	0
> >  #define MT2712_TS2	1
> > @@ -162,12 +168,18 @@ enum {
> >  /* The number of sensing points per bank */
> >  #define MT2712_NUM_SENSORS_PER_ZONE	4
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT2712_CALIBRATION	165
> > +
> >  #define MT7622_TEMP_AUXADC_CHANNEL	11
> >  #define MT7622_NUM_SENSORS		1
> >  #define MT7622_NUM_ZONES		1
> >  #define MT7622_NUM_SENSORS_PER_ZONE	1
> >  #define MT7622_TS1	0
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT7622_CALIBRATION	165
> > +
> >  struct mtk_thermal;
> >  
> >  struct thermal_bank_cfg {
> > @@ -188,6 +200,7 @@ struct mtk_thermal_data {
> >  	const int *sensor_mux_values;
> >  	const int *msr;
> >  	const int *adcpnp;
> > +	const int cali_val;
> >  	struct thermal_bank_cfg bank_data[];
> >  };
> >  
> > @@ -295,6 +308,7 @@ struct mtk_thermal {
> >  	.num_banks = MT8173_NUM_ZONES,
> >  	.num_sensors = MT8173_NUM_SENSORS,
> >  	.vts_index = mt8173_vts_index,
> > +	.cali_val = MT8173_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 2,
> > @@ -330,6 +344,7 @@ struct mtk_thermal {
> >  	.num_banks = 1,
> >  	.num_sensors = MT2701_NUM_SENSORS,
> >  	.vts_index = mt2701_vts_index,
> > +	.cali_val = MT2701_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 3,
> > @@ -356,6 +371,7 @@ struct mtk_thermal {
> >  	.num_banks = 1,
> >  	.num_sensors = MT2712_NUM_SENSORS,
> >  	.vts_index = mt2712_vts_index,
> > +	.cali_val = MT2712_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 4,
> > @@ -376,6 +392,7 @@ struct mtk_thermal {
> >  	.num_banks = MT7622_NUM_ZONES,
> >  	.num_sensors = MT7622_NUM_SENSORS,
> >  	.vts_index = mt7622_vts_index,
> > +	.cali_val = MT7622_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 1,
> > @@ -402,7 +419,7 @@ static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
> >  	raw &= 0xfff;
> >  
> >  	tmp = 203450520 << 3;
> > -	tmp /= 165 + mt->o_slope;
> > +	tmp /= mt->conf->cali_val + mt->o_slope;
> >  	tmp /= 10000 + mt->adc_ge;
> >  	tmp *= raw - mt->vts[sensno] - 3350;
> >  	tmp >>= 3;
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
