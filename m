From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 Sep 2011 13:35:58 +0200
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs based
	on platform device name.
In-Reply-To: <20110906110311.GM6619@n2100.arm.linux.org.uk>
References: <1731819.jJi37IsjvJ@flatron> <1660939.8M3FnZsmga@flatron>
	<20110906110311.GM6619@n2100.arm.linux.org.uk>
Message-ID: <5725201.5LdnvaEu1n@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 of September 2011 at 12:03:11, Russell King - ARM Linux wrote:
> On Tue, Sep 06, 2011 at 12:41:07PM +0200, Tomasz Figa wrote:
> > On Thursday 01 of September 2011 at 13:18:32, Tomasz Figa wrote:
> > > Well, now we have three alternatives:
> > > - to leave it as is (i.e. changing platform device names)
> > > - to use cpu_is_* (does it ever exist for S3C64xx or soc_is_s3c64xx is its equivalent?)
> > > - to use soc_is_* 
> > > 
> > > Waiting for more comments then.
> > > 
> > Ping.
> > 
> > Should I keep it as is or rather change it to use soc_is_s3c64xx instead?
> 
> I don't know what question you're asking (the questions don't make sense
> in terms of the quoted context.)
> 
> If you're asking whether you should use a cpu_ prefix instead of a soc_
> prefix for identifying s3c64xx, then consider the question.
> 
> What is the CPU?
> 
> What are S3C64xx / OMAP / PXA310 / SA-11x0 / AT91RM9200?  CPU or SoC ?
> What are Cortex A8/A9 / Xscale / StrongARM / ARM920?  CPU or SoC ?

Well, I believe that the context I quoted explains everything, but let me
explain that again:

The patch is about a driver being able to check to what SoC a device belongs,
but there are at least two ways to achieve that.

I can see many drivers using the way I used, i.e. distinct platform device names
for each SoC that has to be differentiated plus a generic one. However, I was
suggested that using cpu_is_*/soc_is_* might be a better approach, while at the
same time I received an opinion that the original method is the preferred one.

Best regards,
Tom
