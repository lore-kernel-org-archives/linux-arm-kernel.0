From: gregkh@suse.de (Greg KH)
Date: Wed, 20 Oct 2010 15:47:46 -0700
Subject: [PATCH 4/6] usb: Add support for VIA VT8500 and compatibles in
	EHCI HCD
In-Reply-To: <AANLkTikhuW8+bKi8CS59Byrv8XRE6iKCiegc3ZcyCJnW@mail.gmail.com>
References: <1287608139-21354-1-git-send-email-alchark@gmail.com>
	<1287608139-21354-4-git-send-email-alchark@gmail.com>
	<20101020211710.GB10006@suse.de>
	<AANLkTikhuW8+bKi8CS59Byrv8XRE6iKCiegc3ZcyCJnW@mail.gmail.com>
Message-ID: <20101020224746.GA21385@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 02:41:54AM +0400, Alexey Charkov wrote:
> 2010/10/21 Greg KH <gregkh@suse.de>:
> > On Thu, Oct 21, 2010 at 12:55:36AM +0400, Alexey Charkov wrote:
> >> VIA and WonderMedia Systems-on-Chip feature a standard EHCI host
> >> controller. This adds necessary glue to use the standard driver
> >> with these systems.
> >>
> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> ---
> >>
> >> Please review and state whether this could be acceptable for a merge
> >> to mainline in the coming 2.6.37 window. If possible, I would deeply
> >> appreciate a merge to a relevant git tree for integration prior to
> >> asking Linus to pull the changes. I could rebase the code if needed,
> >> currently this is against Linus' master branch.
> >>
> >> This patch relies on the basic architecture support for VT8500/WM8505
> >> to be in place, as introduced by PATCH 1/6 in this series.
> >
> > Will this code fail to build without that patch?
> >
> 
> As all the additions are ifdef-ed, it won't unless somebody manually
> defines CONFIG_ARCH_VT8500. But in that case the person should
> probably know what (s)he is doing.

Ok, how about we wait for the core code to be accepted, and then have
you resend the drivers for submission?

Make sense?

thanks,

greg k-h
