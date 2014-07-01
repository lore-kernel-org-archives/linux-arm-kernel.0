From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 23:44:38 +0100
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <CAKv+Gu-4kzpNf4+0WcsteeOd+=z2-fnCumxDyTFY5yCT9jrB4A@mail.gmail.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <CAKv+Gu87_5Fx=z6Kg3EBi7YTm+f9DpiaZVw_UU9xKZD1MoJW8w@mail.gmail.com>
 <53B2E311.6030609@mentor.com>
 <CAKv+Gu-4kzpNf4+0WcsteeOd+=z2-fnCumxDyTFY5yCT9jrB4A@mail.gmail.com>
Message-ID: <20140701224438.GD32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 10:08:07PM +0200, Ard Biesheuvel wrote:
> We (at Linaro) had independently identified VDSO for ARM as a topic of
> interest after seeing gettimeofday() turn up in a couple of benchmarks
> (which btw seem to be the primary users of gettimeofday() at such a
> high rate), so of course, when someone else steps up and does the
> work, i am happy to at least spend some time testing it. Therefore, I
> would be happy to test your new version either before or after you
> (re)post it, whichever you prefer.

As has been covered by Nathan in a previous reply - the VDSO is only
of real benefit on CPUs with the architected timer.  Those without
this do not have access from userspace to an appropriate timer to
allow the VDSO to compute the current time.

Hence, the VDSO will just call into the kernel via the standard (and
very same) syscalls that glibc would otherwise have used.

This is illustrated nicely by the results posted for iMX6, which
reflects how the VDSO is going to affect platforms without the
architected timer.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
