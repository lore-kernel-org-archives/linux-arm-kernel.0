From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jul 2011 14:04:52 +0100
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <201107141458.25994.arnd@arndb.de>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<201107132251.48606.arnd@arndb.de> <4E1E8FBB.1040002@linaro.org>
	<201107141458.25994.arnd@arndb.de>
Message-ID: <4E1EE974.4060102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/11 13:58, Arnd Bergmann wrote:
> On Thursday 14 July 2011, Lee Jones wrote:
>>> It seems the final outcome was to have a data structure of function
>>> pointers to get the attribute contents, which is less nice but still
>>> acceptable IMHO.
>>
>> I did think this was a little neater than passing strings all over the
>> place.
> 
> To give some background on why I think it is not:
> 
> The contents of the files are all static, so you can generate them
> at compile time from an init function that is then discarded. When you
> build a kernel for many different SoCs, you only need the pointers
> at run-time, while your approach means that the kernel image will
> have to keep all the functions for every SoC that is built in.
> 
> Also, in many cases, the strings themselves will be static and not
> taken from a specific register.

I see your point.

>> I'm pleased you think this patch is now acceptable. Would you
>> mind re-enforcing your approval with a Signed-off-by please?
> 
> A Signed-off-by is not appropriate because I was not involved in sending
> the patch but in reviewing it. I can give you a 'Reviewed-by', which
> is the appropriate reply in this case.

That'll do, thanks.
