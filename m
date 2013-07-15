From: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 15 Jul 2013 15:35:16 -0700
Subject: [PATCH, re-send] Always trap on BUG()
In-Reply-To: <20130715222755.GY24642@n2100.arm.linux.org.uk>
References: <201307051738.35930.arnd@arndb.de>
 <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org>
 <20130715222755.GY24642@n2100.arm.linux.org.uk>
Message-ID: <51E47924.9030005@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 03:27 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 15, 2013 at 03:16:12PM -0700, Andrew Morton wrote:
>> I've been thinking for a while that CONFIG_BUG=n is a pretty dumb thing
>> to do, and that maintaining it (and trying to fix the warnings it
>> produces) aren't worth the effort and that we should remove the whole
>> thing.  Perhaps your patch changes that calculus, dunno.  Please discuss.
> 
> This isn't about introducing "CONFIG_BUG=n" - this is about making a
> kernel with CONFIG_BUG=n build without producing tonnes and tonnes of
> warnings, as it does today.  It makes building randconfig pretty
> useless to find what could be more important warnings.
> 

Well, there are three alternatives here, right:

1. We can use unreachable(), which means that the compiler can assume it
never happens.

2. We can trap without metadata.

3. We can trap with metadata (current CONFIG_BUG=y).

I am *guessing* this does 2, but it isn't clear.

	-hpa
