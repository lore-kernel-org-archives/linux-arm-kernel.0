From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2011 14:58:25 +0200
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <4E1E8FBB.1040002@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<201107132251.48606.arnd@arndb.de> <4E1E8FBB.1040002@linaro.org>
Message-ID: <201107141458.25994.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 July 2011, Lee Jones wrote:
> > It seems the final outcome was to have a data structure of function
> > pointers to get the attribute contents, which is less nice but still
> > acceptable IMHO.
> 
> I did think this was a little neater than passing strings all over the
> place.

To give some background on why I think it is not:

The contents of the files are all static, so you can generate them
at compile time from an init function that is then discarded. When you
build a kernel for many different SoCs, you only need the pointers
at run-time, while your approach means that the kernel image will
have to keep all the functions for every SoC that is built in.

Also, in many cases, the strings themselves will be static and not
taken from a specific register.

> I'm pleased you think this patch is now acceptable. Would you
> mind re-enforcing your approval with a Signed-off-by please?

A Signed-off-by is not appropriate because I was not involved in sending
the patch but in reviewing it. I can give you a 'Reviewed-by', which
is the appropriate reply in this case.

> I will endeavor to look at the other patch and attempt to reorganise the
> Platform Drivers in sysfs sometime soon after this one has been accepted.

Ok.

	Arnd
