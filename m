From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 6 Nov 2015 15:05:23 -0800
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <7hmvuqg3f1.fsf@deeprootsystems.com>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <20151105094615.GP8644@n2100.arm.linux.org.uk>
 <563B81DA.2080409@redhat.com>
 <20151105162719.GQ8644@n2100.arm.linux.org.uk>
 <563BFCC4.8050705@redhat.com>
 <CAGXu5jLS8GPxmMQwd9qw+w+fkMqU-GYyME5WUuKZZ4qTesVzCQ@mail.gmail.com>
 <563CF510.9080506@redhat.com>
 <CAGXu5jKLgL0Kt5xCWv-3ZUX94m1DNXLqsEDQKHoq7T=m6P7tvQ@mail.gmail.com>
 <CAGXu5j+Jeg-Cwc7Tr8UeY9vkJLudw07+b=m0h-d9GuSyKiO4QA@mail.gmail.com>
 <CAMAWPa9XvdS+dF78c7Fgs4ekRy7wVnfFT=0A5NLpu0UYaqV7fA@mail.gmail.com>
 <CAGXu5j+U-Q2R1Hw4qSPpFUKz3xyYrASGc5buMJTSy0K-3mWHBA@mail.gmail.com>
 <7h8u6ahm7d.fsf@deeprootsystems.com>
 <CAGXu5jJnjHkkX3y31y5LJFhNrP=A8_BASg2MUR5rwA5MLPeVQg@mail.gmail.com>
 <7hmvuqg3f1.fsf@deeprootsystems.com>
Message-ID: <CAMAWPa_i9H9nw_hY5-=hJmenhXW2u_9DSKgZ5mEV0c_afGgqcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 2:37 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Fri, Nov 6, 2015 at 1:06 PM, Kevin Hilman <khilman@kernel.org> wrote:
>
> [...]
>
>> Well, all the stuff I wrote tests for in lkdtm expect the kernel to
>> entirely Oops, and examining the Oops from outside is needed to verify
>> it was the correct type of Oops. I don't think testing via lkdtm can
>> be done from kselftest sensibly.
>
> Well, at least on arm32, it's definitely oops'ing, but it's not a full
> panic, so the oops could be grabbed from dmesg.
>
> FWIW, below is a log from and arm32 board running mainline v4.3 that
> runs through all the non-panic/lockup tests one after the other without
> a reboot.

... however, a run on arm64 and it locks up after the OVERFLOW test,
so I think you're right that we need an "outside observer" to reliably
determine pass/fail on these.  We'll start looking at that.

Kevin
