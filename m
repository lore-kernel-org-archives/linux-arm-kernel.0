From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 5 Feb 2016 13:30:25 +0530
Subject: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
 without a stop bit
In-Reply-To: <20160204200903.GE1958@tetsubishi>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
 <20160124112915.GA1775@katana>
 <001401d15988$59f6dcf0$0de496d0$@codeaurora.org>
 <20160204200903.GE1958@tetsubishi>
Message-ID: <006e01d15feb$4a08d0a0$de1a71e0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Wolfram Sang
> Sent: Friday, February 05, 2016 1:39 AM
> To: Sricharan
> Cc: devicetree at vger.kernel.org; architt at codeaurora.org; linux-arm-
> msm at vger.kernel.org; ntelkar at codeaurora.org; galak at codeaurora.org;
> linux-kernel at vger.kernel.org; andy.gross at linaro.org; linux-
> i2c at vger.kernel.org; iivanov at mm-sol.com; agross at codeaurora.org;
> dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
> without a stop bit
> 
> Hi,
> 
> > Ah, so what I meant above is there is no 'STOP' bit between each msg
> > in i2c_msgs, but 'REAPEATED_START' still holds true.  We are sending
> > 'START' bit for each msg.
> > So these is how each msg in i2c_msg is sent,
> >
> > |------MSG1--------|-----MSG2---------|------MSG3------------|
> >
> >   |START|DATA|------|START|DATA|---|START|DATA|STOP|
> >
> > If my commit text does not make this clear, I  can reword that ?
> 
> OK, now this looks to me perfectly fine: A number of *messages*
> concatenated into one *transfer* by repeated start. That's the way it
should
> be.
> 
> So, I'd simply remove these words:
> 
> "The QUP i2c hardware has no way to inform that there should not be a
> 'STOP' at the end of transaction. The only way to implement this is to
> coalesce all the i2c_msg in i2c_msgs in to one transaction and transfer
them."
> 
> This sounded like the HW needed a special handling, so I was under the
> impression REP_START was broken. However, unless I misunderstood
> something again, this now sounds like the standard case and we can keep
> the commit message simple. If you are okay with that, I can update it
here,
> no need to resend.
> 
      Yes the above modified commit text looks perfect to be updated and
thanks
      for the update as well.

Regards,
 Sricharan
