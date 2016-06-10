From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Jun 2016 10:02:45 +0900
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <ab5e3a98-7ff2-dc8f-d255-f6da26f43527@cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
 <20160601005751.GG20527@verge.net.au>
 <fdab2628-60bd-c41b-296b-38cd71a6c5da@cogentembedded.com>
 <CAMuHMdUkOpEp+YCbZVZppdN4C7KKpDS9_gEuXi_WKZXM9YHgEQ@mail.gmail.com>
 <ab5e3a98-7ff2-dc8f-d255-f6da26f43527@cogentembedded.com>
Message-ID: <20160610010245.GA10152@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 11:58:45PM +0300, Sergei Shtylyov wrote:
> On 06/07/2016 10:13 AM, Geert Uytterhoeven wrote:
> 
> [...]
> 
> >>>And that the system behaves sanely on suspend/resume.
> >>
> >>   I'd be thankful if you told me how to test that. :-)
> >
> >System suspend:
> >
> >    echo mem > /sys/power/state
> 
>    Oh. I know that one! :-)
> 
> >System resume: You're gonna need a "wakeup-source" in your DTS, e.g. gpio-keys.
> >Serial should work too, echo "enabled" to the corresponding wakeup
> >file in /sys first.
> 
>    I'm afraid I couldn't find that file. All I saw were RPM controls...
> 
> >In case of issues, try "echo 0 > /sys/module/printk/parameters/console_suspend".
> 
>    There's no problems suspending, it's the resuming that's a problem for me.
> 
> >Good luck!
> 
>    As usual, there was no luck. :-)
> 
> WBR, Sergei

Does resume work for UP (i.e. without SMP)?

How did testing CPU hotplug go? Did it work for all CPUs?

If things work less well for SMP than UP I am inclined to ask
you to defer adding SMP support.
