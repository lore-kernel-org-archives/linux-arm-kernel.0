From: yizhang@mx0b-0016f401.pphosted.com (Yi Zhang)
Date: Wed, 3 Jun 2015 18:56:26 +0800
Subject: [PATCH 12/12] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <556DE0EB.1010609@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org>
 <20150528132312.GC2067@n2100.arm.linux.org.uk>
 <556DDF43.4050804@linaro.org> <556DE0EB.1010609@linaro.org>
Message-ID: <20150603105626.GE6696@yizhang>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 10:29:23PM +0530, Vaibhav Hiremath wrote:
> 
> 
> On Tuesday 02 June 2015 10:22 PM, Vaibhav Hiremath wrote:
> >
> >
> >On Thursday 28 May 2015 06:53 PM, Russell King - ARM Linux wrote:
> >>On Thu, May 28, 2015 at 06:33:44PM +0530, Vaibhav Hiremath wrote:
> >>>From: Yi Zhang <yizhang@marvell.com>
> >>>
> >>>Enable i2c module/unit before transmission and disable when it finishes.
> >>>
> >>>why?
> >>>It's because the i2c bus may be distrubed if the slave device,
> >>>typically a touch, powers on.
> >>
> >>"disturbed"
> >>
> >>I'd recommend that this is a DT property - not every platform is going to
> >>want this, and as there is rudimentary I2C slave support in this driver,
> >>this change breaks that.
> >>
> >
> >I would take it as two different comments here, and I believe you also
> >meant same,
> >
> >1. Not breaking I2C slave support
> >
> >Not sure whether enabling/disabling module in ISR would suffice here.
> >To be specific, in the functions i2c_pxa_slave_start() &
> >i2c_pxa_slave_stop()
> >
> >
> 
> Please ignore this option, as enable is important to generate interrupt
> on slave start.
  
  Yes, you are right, enabling i2c controller first is must for
  generating the interrupt
> 
> I will add DT property with clear note on SLAVE support issue, so that
> it can be disabled and SLAVE support should work as is.
> 
> Thanks,
> Vaibhav
