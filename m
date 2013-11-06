From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 5 Nov 2013 23:37:54 -0800
Subject: [PATCH 0/3] follow up fixes for V7 big endian changes
In-Reply-To: <20131105152042.GT16735@n2100.arm.linux.org.uk>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
 <20131105152042.GT16735@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr0_xvVGhfo0WLav53eBR1XffTeKYedquCEw8HEPCfp9fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2013 07:20, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 04, 2013 at 06:16:02PM -0800, Victor Kamensky wrote:
>> 3) ARM: fix mov to mvn conversion in case of 64 bit phys_addr_t and BE
>> Conflict resolution between [5] and [6] was not entirely correct for
>> the case when 'mov' instruction has to be converted into 'mvn'
>> instruction.
>
> This is a good reason why rushing stuff along when there's two people
> working in the same area is bad news.  The person who gets to do the
> conflict resolution doesn't always know what the correct solution is,
> so many of them are pure guesses, and many of them won't be adequately
> tested.
>
> Quite honestly, I would have preferred *not* to have pulled Ben's BE
> changes along with Santosh's other changes, and have Ben rebase for
> the _following_ merge window to prevent exactly this kind of mess.

Sorry, I probably confused folks and pushed too hard with my tc2
"all fine" testing message. Lesson learned.

> The BE stuff has been one problem after another...

In what sense? Does it create problems for something
or someone? I hope not. I think it is in pair with other efforts,
and I think we go after issues quickly enough. Or you mean that
we keep discovering more and more BE issues to fix. I agree
with that. I think we will see more. We are working on few
known issues like BE V7 kprobes, and BE V7 KVM. I think we will
see BE breakages and follow up fixes too. And IMHO it is
normal, BE is side feature, outside of main direction
and it is easy for guys to miss BE issue. That is why Linaro
is going to setup automatic BE builds and tests, and we
will monitor and fix discovered issues.

Thanks,
Victor
