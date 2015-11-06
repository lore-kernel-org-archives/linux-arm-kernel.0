From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 6 Nov 2015 12:11:08 -0800
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <CAGXu5j+Jeg-Cwc7Tr8UeY9vkJLudw07+b=m0h-d9GuSyKiO4QA@mail.gmail.com>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <20151105094615.GP8644@n2100.arm.linux.org.uk>
 <563B81DA.2080409@redhat.com>
 <20151105162719.GQ8644@n2100.arm.linux.org.uk>
 <563BFCC4.8050705@redhat.com>
 <CAGXu5jLS8GPxmMQwd9qw+w+fkMqU-GYyME5WUuKZZ4qTesVzCQ@mail.gmail.com>
 <563CF510.9080506@redhat.com>
 <CAGXu5jKLgL0Kt5xCWv-3ZUX94m1DNXLqsEDQKHoq7T=m6P7tvQ@mail.gmail.com>
 <CAGXu5j+Jeg-Cwc7Tr8UeY9vkJLudw07+b=m0h-d9GuSyKiO4QA@mail.gmail.com>
Message-ID: <CAMAWPa9XvdS+dF78c7Fgs4ekRy7wVnfFT=0A5NLpu0UYaqV7fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 11:12 AM, Kees Cook <keescook@chromium.org> wrote:

[...]

> Hi Kevin and Kernel CI folks,
>
> Could lkdtm get added to the kernel-CI workflows? Extracting and
> validating Oops details when poking lkdtm would be extremely valuable
> for these cases. :)

Yeah, we can add that.

What arches should we expect this to be working on?  For starters
we'll get builds going with CONFIG_LKDTM=y, and then start looking at
adding the tests on arches that should work.

Thes will be an interesting failure modes to catch because a kernel
panic is actually a PASS, and a failure to panic is a FAIL.  :)

Kevin
