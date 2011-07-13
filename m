From: gregkh@suse.de (Greg KH)
Date: Wed, 13 Jul 2011 22:32:26 +0200
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <4E1DCA83.7010204@codeaurora.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<1310476090-9807-2-git-send-email-lee.jones@linaro.org>
	<4E1C7650.6010700@codeaurora.org> <4E1D4F88.3070501@linaro.org>
	<4E1DCA83.7010204@codeaurora.org>
Message-ID: <20110713203226.GA23055@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 09:40:35AM -0700, Saravana Kannan wrote:
> On 07/13/2011 12:55 AM, Lee Jones wrote:
> >On 12/07/11 17:29, Saravana Kannan wrote:
> >>Can you please make this code as part of soc_device_register? Otherwise,
> >>every SoC that wants to add its own set of attributes will have to
> >>repeat this code.
> >
> >That's the idea.
> >
> >I initially had it all as part of soc_device_register, but Arnd told me
> >to remove it in this patch-set.
> >
> >See here:
> >
> >On 17/04/11 19:36, Arnd Bergmann wrote:
> >>For the nonstandard attributes, I would recommend having the individual
> >>drivers call device_create_file, in order to discourage the use of
> >>device specific attribute names.
> 
> Arnd,
> 
> I don't think forcing individual driver to call device_create_file()
> is really going to be much of a discouragement.

Yes it is as calling that is broken and wrong and userspace will race
with the kernel and bad things will happen on the wrong phase of the
moon.

But again, I never saw the original series to explain why...

greg k-h
