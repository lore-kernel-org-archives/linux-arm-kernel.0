From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Sep 2014 15:52:57 +0100
Subject: [PATCH v2 0/3] arm_arch_timer: VDSO preparation, code
 consolidation
In-Reply-To: <20140924144541.GJ15842@e104818-lin.cambridge.arm.com>
References: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
 <20140922153919.GQ25809@arm.com>
 <20140922223022.GO5182@n2100.arm.linux.org.uk>
 <20140924144541.GJ15842@e104818-lin.cambridge.arm.com>
Message-ID: <20140924145257.GY5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 03:45:41PM +0100, Catalin Marinas wrote:
> On Mon, Sep 22, 2014 at 11:30:23PM +0100, Russell King - ARM Linux wrote:
> > I raised a while back with Will whether there's much point to having
> > this on ARM.  While it's useful for virtualisation, the majority of
> > 32-bit ARM doesn't run virtualised.
> 
> This has nothing to do with virtualisation. The main reason we use
> CNTVCT is to not require kernel binary differences when running the OS
> as host or guest. But it does _not_ mean that it is only used when
> running as a guest.
> 
> > So there's little point in having the VDSO on the majority of
> > platforms - it will just add additional unnecessary cycles slowing
> > down the system calls that the VDSO is designed to try to speed up.
> 
> A good reason for VDSO is to avoid a system call for gettimeofday when
> you can read the clocks source from user space. That's a significant
> improvement on CPUs like A7, A15.

I'm *not* arguing against having a VDSO to speed up that crap.  What
I'm trying to get to the bottom of - something which has been totally
lost sight of - is what the friggin effect of this stuff is on CPUs
*without* the architected timer.

Until I get an answer to what the measured effect is, I'm saying no to
VDSO on ARM, because - as seems to be the norm - the evaluation job is
only half done.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
