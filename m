From: elder@linaro.org (Alex Elder)
Date: Tue, 01 Jul 2014 07:21:40 -0500
Subject: [PATCH] mach-bcm SMC: address clang inline asm incompatibility
In-Reply-To: <20140701121544.GK32514@n2100.arm.linux.org.uk>
References: <1404216339-6480-1-git-send-email-elder@linaro.org>
 <20140701121544.GK32514@n2100.arm.linux.org.uk>
Message-ID: <53B2A7D4.4020007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 07:15 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 01, 2014 at 07:05:39AM -0500, Alex Elder wrote:
>> My GCC-based build environment likes to call register r12 by the
>> name "ip" in inline asm.  Behan Webster informed me that his Clang-
>> based build environment likes "r12" instead.
> 
> Two objections, one of which is an acceptable outcome:
> 1. Why can't clang just learn these alternative names?

I suggested that.  I don't know where to send that suggestion
though.

> 2. Why can't we just use "r12" here?

I don't recall the details, but when I wrote the code originally
that way it gave me errors.  It's why I had the "Also called r12"
comment next to the symbol declaration.

I agree, I'd rather have either one of those than this #ifdef
workaround.  I was supplying this as a potentially quicker fix
for the problem Behan was hitting.

					-Alex
