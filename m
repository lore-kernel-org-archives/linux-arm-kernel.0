From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 8 Apr 2015 11:00:49 +0530
Subject: [PATCH V2 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <20150407050640.GB9225@qualcomm.com>
References: <1428345067-21878-1-git-send-email-sricharan@codeaurora.org>
 <1428345067-21878-3-git-send-email-sricharan@codeaurora.org>
 <20150407050640.GB9225@qualcomm.com>
Message-ID: <000201d071bd$30b1f130$9215d390$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Andy Gross
> Sent: Tuesday, April 07, 2015 10:37 AM
> To: Sricharan R
> Cc: srichara at qti.qualcomm.com; devicetree at vger.kernel.org; linux-arm-
> msm at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> i2c at vger.kernel.org; iivanov at mm-sol.com; galak at codeaurora.org;
> dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2 2/6] i2c: qup: Add V2 tags support
> 
> On Tue, Apr 07, 2015 at 12:01:03AM +0530, Sricharan R wrote:
> 
> <snip>
> 
> > +static u32 qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8
*tbuf,
> > +			     int dlen, u8 *dbuf)
> > +{
> > +	u32 val = 0, idx = 0, pos = 0, i = 0, t;
> > +	int  len = tlen + dlen;
> > +	u8 *buf = tbuf;
> > +
> > +	while (len > 0) {
> > +		if (qup_i2c_wait_ready(qup, QUP_OUT_FULL, 0, 4)) {
> 
> Instead of 0 and 4 can we use some #defines?  This applies for all of the
> i2c_wait_ready calls
> 
> <snip>
> 
 Ok, will change this with some macro.

Regards,
 Sricharan

> 
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
