From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 29 Jan 2015 12:29:00 +0000
Subject: Hangs in libhugetlbfs tests in -next
In-Reply-To: <20150128152412.GX21293@sirena.org.uk>
References: <20150128152412.GX21293@sirena.org.uk>
Message-ID: <CAPvkgC1LjQ0A2OkNjOAU3HAWVBiu3E=9pjJynPF4QFzyoRQRnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2015 at 15:24, Mark Brown <broonie@kernel.org> wrote:
> For at least the past couple of days tests of libhugetlbfs have been
> hanging on mustang in the mlock test running ARMv8 defconfig with both
> 32 bit and 64 bit userspace - after the mprotect test (the one before
> it) we get no console output for several hours so it appears that the
> test has deadlocked.  The tail of the log is:
>
> | find_path (2M: 64):   PASS
> | unlinked_fd (2M: 64): PASS
> | readback (2M: 64):    PASS
> | truncate (2M: 64):    PASS
> | shared (2M: 64):      PASS
> | mprotect (2M: 64):    PASS
>
> and then a timeout.
>
> This may be a generic bug but my ability to run these tests on other
> platforms with huge page support using the infrastructure I'm using is
> limited so I've not been able to test elsewhere and confirm.

I've reproduced this on Juno, it looks like hugtlb_fault is being
called repeatedly in the mlock test.

I'll investigate further.

Cheers,
-- 
Steve
