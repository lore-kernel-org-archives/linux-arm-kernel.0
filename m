From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 17:02:29 -0600
Subject: [PATCH V2 5/5] ARM: remove #gpio-ranges-cells property
In-Reply-To: <51E44ED9.9020807@gmail.com>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
 <1373913629-32179-5-git-send-email-swarren@wwwdotorg.org>
 <51E44ED9.9020807@gmail.com>
Message-ID: <51E47F85.4050905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 01:34 PM, Rob Herring wrote:
> On 07/15/2013 01:40 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This property is no longer required by the GPIO binding. Remove it.
> 
> Won't this break compatibility with older kernel? It is one thing to
> deprecate, but removal is another. If the relevant maintainers don't
> care, then I guess it is fine.

Yes.

I had originally hoped this could sneak in late for 3.11, but I suppose
it's too late now. vf610.dtsi is a new file in 3.11 so has no legacy to
protect.

Admittedly, the #gpio-cells property was added into the SPEAr files in 3.10.
