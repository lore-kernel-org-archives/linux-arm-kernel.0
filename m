From: chuansheng.liu@intel.com (Liu, Chuansheng)
Date: Tue, 13 Nov 2012 01:21:57 +0000
Subject: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
In-Reply-To: <20121112172651.GC15159@pengutronix.de>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <20121112172651.GC15159@pengutronix.de>
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A1C3952@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Tuesday, November 13, 2012 1:27 AM
> To: Liu, Chuansheng
> Cc: linus.walleij at linaro.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; linux-i2c at vger.kernel.org
> Subject: Re: [PATCH 1/7] I2c-nomadik: Fix the usage of
> wait_for_completion_timeout
> 
> On Wed, Nov 07, 2012 at 01:18:37AM +0800, Chuansheng Liu wrote:
> >
> > The return value of wait_for_completion_timeout() is always
> > >= 0 with unsigned int type.
> >
> > So the condition "ret < 0" or "ret >= 0" is pointless.
> >
> > Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> 
> You forgot to add the i2c-list, so I nearly overlooked this patch.
> Luckily I haven't, so applied to for-next, thanks! Did you use a script
> to find all occurences? Would be nice to know. Also, please take care of
> the subject line. "I2c" is misspelled.
Thanks your pointing out. I just manually reviewed the code when found this point.
Would like to try some auto-script but failed:)
