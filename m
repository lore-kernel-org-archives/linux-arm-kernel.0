From: mmayer@broadcom.com (Markus Mayer)
Date: Wed, 28 Nov 2012 12:53:29 -0800
Subject: vexpress compilation error in next-20121127
In-Reply-To: <1354106164.2987.21.camel@hornet>
References: <50B56601.5010305@broadcom.com> <1354106164.2987.21.camel@hornet>
Message-ID: <50B679C9.2010808@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-11-28 04:36 AM, Pawel Moll wrote:
> On Wed, 2012-11-28 at 01:16 +0000, Markus Mayer wrote:
>> Hi Pawel,
>>
>> There seems to be an issue compiling vexpress at this point. The problem
>> being that vexpress' makefile references reset.o, but there's no reset.c
>> in arch/arm/mach-vexpress.
[...]
> That's strange... The reset.c comes from the vexpress/drivers branch,
> which seems to be merged correctly in the arm-soc:
>
> http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=tree;f=arch/arm/mach-vexpress;hb=refs/heads/for-next
>
> And it's there in the linux-next head:
>
> https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=tree;f=arch/arm/mach-vexpress
>
> Also the next-20121127 looks good for me:
>
> https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=tree;f=arch/arm/mach-vexpress;h=47f9de5972efaa719c35bb9dce177fbd2954647c;hb=ce2931ab5e448a93fee55d9d82de9f5e754ff6f7
>
> Are you sure you've checked out the correct tag?

What I did was to clone next/soc. reset.c is not in that -- and that's 
the branch that fails to build. I do see that the commit is in for-next, 
however.

What I am really concerned about is an arm-soc branch that has commit 
8ac49e0485 in it 
(http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commit;h=8ac49e0485bb79223a111b366a3b1f5ec9148729). 
That commit seems to be in next/soc as well as for-next. Therefore, 
either one might serve my purpose. I am able to build for-next, but 
cannot build next/soc due to the above problem.

Is there a quick way to describe the difference between these two 
branches? I am okay to use for-next rather than next/soc, but I would 
like to know what the difference between the two.

Also, is it okay for one of the two branches to temporarily not build 
(as is currently the case with next/soc)?

Thanks,
-Markus
