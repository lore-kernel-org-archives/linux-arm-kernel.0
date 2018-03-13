From: greg@kroah.com (Greg KH)
Date: Tue, 13 Mar 2018 11:03:16 +0100
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <20180306213129.GG13586@sirena.org.uk>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
 <20180306142634.GC13586@sirena.org.uk>
 <20180306172525.GA6618@kroah.com>
 <20180306213129.GG13586@sirena.org.uk>
Message-ID: <20180313100316.GA1999@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 09:31:29PM +0000, Mark Brown wrote:
> On Tue, Mar 06, 2018 at 09:25:25AM -0800, Greg KH wrote:
> > On Tue, Mar 06, 2018 at 02:26:34PM +0000, Mark Brown wrote:
> > Really?  Like what?  Last I looked it's only about 300 or so patches.
> > Something like less than .5% of the normal SoC backport size for any ARM
> > system recently.  There were some numbers published a few months ago
> > about the real count, I can dig them up if you are curious.
> 
> Really.  
> 
> The Android tree is making non-trivial modifications adding new features
> in core bits of the kernel like the scheduler - that's got an impact
> which will have follow on validation costs if it's not introduced early
> on in the process.

Ah crap, I forgot all about the scheduler mess.  Sorry about that, I've
been focusing on device-specific stuff too much (nothing I much care
lives outside of drivers/...)

So you are right, for some types of devices, the andoid-common tree
isn't the best idea.  However, the validation "costs" better be starting
all over based on the intrusiveness of these patches, they are
non-trivial :(

thanks,

greg k-h
