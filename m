From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Jul 2012 22:38:22 -0700
Subject: [PATCH] ARM: mxs: fix compile error caused by prom_update_property
 change
In-Reply-To: <5010D670.6070303@bluegiga.com>
References: <1342160035-24170-1-git-send-email-shawn.guo@linaro.org>
 <5010D670.6070303@bluegiga.com>
Message-ID: <CAOesGMhwX_ZSZrUraMBazsj7BmJTi_ihGNoOjx__+kLS-SSJ=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 10:32 PM, Lauri Hintsala
<lauri.hintsala@bluegiga.com> wrote:
> Hi,
>
>
> On 07/13/2012 09:13 AM, Shawn Guo wrote:
>>
>> The commit 475d009 (of: Improve prom_update_property() function)
>> changed prom_update_property interface, and causes the compile
>> error below.
>>
>>    CC      arch/arm/mach-mxs/mach-mxs.o
>> arch/arm/mach-mxs/mach-mxs.c: In function ?update_fec_mac_prop?:
>> arch/arm/mach-mxs/mach-mxs.c:216:4: error: too many arguments to function
>> ?prom_update_property?
>> include/linux/of.h:263:12: note: declared here
>>
>> Update the caller update_fec_mac_prop to fix the error.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> ---
>> The error is seen on next-20120712 where commit 475d009 (of: Improve
>> prom_update_property() function) emerges.
>
>
> What's the status of this patch? Current Torvald's master is unbuildable for
> mxs because of this issue.
>
> Compiler gives an error:
> arch/arm/mach-mxs/mach-mxs.c: In function 'update_fec_mac_prop':
> arch/arm/mach-mxs/mach-mxs.c:213: error: too many arguments to function
> 'prom_update_property'
> make[1]: *** [arch/arm/mach-mxs/mach-mxs.o] Error 1

Thanks for the follow-up, I had missed it when first sent out. I've
applied it to our fixes branch that will be sent out shortly.


-Olof
