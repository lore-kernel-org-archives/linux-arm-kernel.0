From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Apr 2013 14:22:31 +0200
Subject: [PATCH 7/8] dmaengine: ste_dma40: Use the BIT macro to replace
 ugly '(1 << x)'s
In-Reply-To: <20130410093412.GI25316@gmail.com>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <201304092112.56039.arnd@arndb.de> <20130410093412.GI25316@gmail.com>
Message-ID: <201304101422.31601.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 April 2013, Lee Jones wrote:
> On Tue, 09 Apr 2013, Arnd Bergmann wrote:

> > Yes, good point. The macro is only used in one place, to compare
> > two compile-time constant values, but we should define macros in
> > drivers that are already provided by the kernel.
> 
> Okay, it looks like the generic implementation has brackets in it,
> which isn't allowed for this particular usecase.

Ah, right.

> I'll fix this one instead.

Probably not worth then. You could open-code the comparison where
it is used and remove the macro if you want, but I probably
would not bother.

	Arnd
