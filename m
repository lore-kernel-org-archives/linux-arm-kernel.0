From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Feb 2016 09:47:08 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <13475776.5b1DTHhHh9@wuerfel>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <13475776.5b1DTHhHh9@wuerfel>
Message-ID: <20160209094707.GA22874@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 04:40:54PM +0100, Arnd Bergmann wrote:
> * Do we expect to handle this using live patching indefinitely? I can imagine
>   that at some point in the future, ARMv8.2+ systems will be the vast majority,
>   so it might be nice to support enabling it unconditionally (same for any
>   of the alternative bits really). Is there a long-term strategy?

Another good reason for an option turning these things on by default is
that it makes debugging *so* much easier when the vmlinux matches what's
actually running!

So yes, that's definitely something we should look at in the long-term,
but we still need the live patching for distro kernels that will assumedly
want a single Image covering ARMv8+ for a while.

Will
