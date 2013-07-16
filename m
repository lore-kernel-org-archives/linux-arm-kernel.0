From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 17:30:23 -0600
Subject: [PATCH V2 5/5] ARM: remove #gpio-ranges-cells property
In-Reply-To: <51E47F85.4050905@wwwdotorg.org>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
 <1373913629-32179-5-git-send-email-swarren@wwwdotorg.org>
 <51E44ED9.9020807@gmail.com> <51E47F85.4050905@wwwdotorg.org>
Message-ID: <51E5D78F.8060400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 05:02 PM, Stephen Warren wrote:
> On 07/15/2013 01:34 PM, Rob Herring wrote:
>> On 07/15/2013 01:40 PM, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> This property is no longer required by the GPIO binding. Remove it.
>>
>> Won't this break compatibility with older kernel? It is one thing to
>> deprecate, but removal is another. If the relevant maintainers don't
>> care, then I guess it is fine.
> 
> Yes.
> 
> I had originally hoped this could sneak in late for 3.11, but I suppose
> it's too late now. vf610.dtsi is a new file in 3.11 so has no legacy to
> protect.
> 
> Admittedly, the #gpio-cells property was added into the SPEAr files in 3.10.

One more thought here:

I know DT bindings are supposed to evolve so that a new kernel will
support arbitrary old DTs. I'll call that backwards-compatibility for
the DT parsing code.

However, this situation is the reverse; this patch would prevent a new
DT running on an older kernel. I'll call that forwards-compatibility.
I'm not sure if the intent is to support this or not? It's certainly the
first I explicitly thought about compatibility in this direction...
