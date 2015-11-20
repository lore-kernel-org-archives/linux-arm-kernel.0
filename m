From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 20 Nov 2015 16:17:19 +0000
Subject: [PATCH v9 6/6] tests/guest-debug: introduce basic gdbstub tests
In-Reply-To: <1447345251-22625-7-git-send-email-alex.bennee@linaro.org>
References: <1447345251-22625-1-git-send-email-alex.bennee@linaro.org>
 <1447345251-22625-7-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA9q1MpiM4vM+RH-YQ2RpB=eV-Xgyw1-yw6qHG0hbem6_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 16:20, Alex Benn?e <alex.bennee@linaro.org> wrote:
> From: Alex Benn?e <alex@bennee.com>
>
> The aim of these tests is to combine with an appropriate kernel
> image (with symbol-file vmlinux) and check it behaves as it should.
> Given a kernel it checks:
>
>   - single step
>   - software breakpoint
>   - hardware breakpoint
>   - access, read and write watchpoints
>
> On success it returns 0 to the calling process.
>
> I've not plumbed this into the "make check" logic though as we need a
> solution for providing non-host binaries to the tests. However the test
> is structured to work with pretty much any Linux kernel image as it
> uses the basic kernel_init code which is common across architectures.

Do these tests pass if you run them on the TCG QEMU, just out
of interest?

I'm not a great fan of tests that aren't in 'make check'
because IME they just bitrot, but as you say we have no
sensible approach for handling tests that need to run real
guest code :-(

thanks
-- PMM
