From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Apr 2013 18:03:17 +0900
Subject: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <515C2E24.1080108@cogentembedded.com>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
 <87y5d16b1d.wl%kuninori.morimoto.gx@renesas.com>
 <515AC4C8.1080803@cogentembedded.com>
 <87sj38cvfn.wl%kuninori.morimoto.gx@renesas.com>
 <515C2E24.1080108@cogentembedded.com>
Message-ID: <20130404090317.GB23848@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 05:27:00PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 03-04-2013 4:25, Kuninori Morimoto wrote:
> 
> >>>Current ARM SoC is trying to not use platform_device_register()
> >>>Please use platform_device_register_xxx()
> >>>Same comment for [2/2]
> 
> >>     Is there some rationale to it? I don't find platform_device_register_xxx()
> >>especially handy to use.
> 
> >http://www.spinics.net/lists/linux-sh/msg16871.html
> 
>    I don't see there actual Greg KH's rationale for not using
> platform_register_device().

I'm sure that you can find the rationale if you look.
If not you can ask him, if it is important to you.
Failing that, I can ask him, if its important to you.

However, the point is that Arnd, who is the upstream for shmobile, has
indicated that he would prefer
platform_device_register_{full,resndata,data,simple} used instead of
platform_register_device(). And furthermore Magnus appears to have started
following this advice in his series "[PATCH 01/04] ARM: shmobile: r8a7740
pinmux platform device cleanup".

I would like you to update this patch to follow that advice too.
Likewise for the similar R8A7778 patch.
