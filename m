From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Sep 2014 16:08:07 +0100
Subject: [PATCH v2 0/3] arm_arch_timer: VDSO preparation, code
 consolidation
In-Reply-To: <20140924150408.GK15842@e104818-lin.cambridge.arm.com>
References: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
 <20140922153919.GQ25809@arm.com>
 <20140922223022.GO5182@n2100.arm.linux.org.uk>
 <20140924144541.GJ15842@e104818-lin.cambridge.arm.com>
 <20140924145257.GY5182@n2100.arm.linux.org.uk>
 <20140924150408.GK15842@e104818-lin.cambridge.arm.com>
Message-ID: <20140924150806.GZ5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 04:04:09PM +0100, Catalin Marinas wrote:
> On Wed, Sep 24, 2014 at 03:52:57PM +0100, Russell King - ARM Linux wrote:
> > I'm *not* arguing against having a VDSO to speed up that crap.  What
> > I'm trying to get to the bottom of - something which has been totally
> > lost sight of - is what the friggin effect of this stuff is on CPUs
> > *without* the architected timer.
> > 
> > Until I get an answer to what the measured effect is, I'm saying no to
> > VDSO on ARM, because - as seems to be the norm - the evaluation job is
> > only half done.
> 
> I agree.
> 
> If there is an overhead (possibly), I think it can be solved in software
> maybe by having two VDSO images, one with gettimeofday and one without.
> If it's only gettimeofday in VDSO (and signal return still via the
> vectors page), we could just avoid inserting it into the user address
> space when arch timers aren't present.

The signal handling is no longer in the vectors page (it hasn't been for
over a year now), it is in a separate page which is mapped randomly.
These VDSO patches change it to place it along side the VDSO pages.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
