From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 2 Feb 2017 20:51:53 +0000
Subject: [PATCH] log2: make order_base_2() behave correctly on const input
 value zero
In-Reply-To: <CA+55aFxaPcHM8adD_K8tYX_Wu45h83sXfyQs94pW8XJ1GOyABQ@mail.gmail.com>
References: <1486055052-6442-1-git-send-email-ard.biesheuvel@linaro.org>
 <CA+55aFxaPcHM8adD_K8tYX_Wu45h83sXfyQs94pW8XJ1GOyABQ@mail.gmail.com>
Message-ID: <E4F95D6E-A0EE-489D-BDE6-AD42A0D334A1@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 2 Feb 2017, at 20:49, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Thu, Feb 2, 2017 at 9:04 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> 
>> So update order_base_2() to adhere to its own documented interface.
> 
> Ok, looks like you screwed up the types according to the build server.
> 
> Making the return type "unsigned long" is slightly excessive. If you
> need an unsigned long to describe the log2 of a number in the kernel,
> you're playing with numbers that are *way* too big.
> 
> The old code used "ilog2()", which returns an int.
> 

Yeah I cloned roundup_pow_of_2, and failed to spot that ilog2 returns an int. I sent out the v2 already

> Which is plenty big enough of a type.
> 
>                Linus
