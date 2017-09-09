From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sat, 9 Sep 2017 16:33:55 +0900
Subject: [PATCH] scripts: make extract-vmlinux support armel/armhf
In-Reply-To: <20170901231654.GY20805@n2100.armlinux.org.uk>
References: <20170831153631.31026-1-rogershimizu@gmail.com>
 <20170831154941.GS20805@n2100.armlinux.org.uk>
 <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
 <20170831161957.GU20805@n2100.armlinux.org.uk>
 <20170831174318.GM6008@atomide.com>
 <20170901231654.GY20805@n2100.armlinux.org.uk>
Message-ID: <CAEQ9gEk6iGFY0hx36QbQHywKbttWTJdQxZzpOKULCgFLvS9TOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 2, 2017 at 8:16 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Aug 31, 2017 at 10:43:19AM -0700, Tony Lindgren wrote:
>> * Russell King - ARM Linux <linux@armlinux.org.uk> [170831 09:21]:
>> > On Fri, Sep 01, 2017 at 01:05:16AM +0900, Roger Shimizu wrote:
>> > > On Fri, Sep 1, 2017 at 12:49 AM, Russell King - ARM Linux
>> > > <linux@armlinux.org.uk> wrote:
>> > > > What's the use case - what are you using the output of this script with?
>> > >
>> > > I already provided a use case, to trace a Debian kernel issue caused
>> > > by kernel size.
>> > > - https://bugs.debian.org/870185#50
>> >
>> > Sorry, I haven't time to look - it needs me to use firefox on a
>> > different machine.  Maybe you could help by providing some details
>> > by email, otherwise I've got extra work to do at some point in the
>> > future (probably days away) if I remember (your mail will get buried).
>> > Much of my time is in front of a _textual_ _only_ interface, and elinks
>> > does not work with several modern SSL-only sites.
>> >
>> > > I also see other people complaining this issue:
>> > >  - https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
>> > >  - https://bugs.linaro.org/show_bug.cgi?id=461
>> > >
>> > > By a random web search, I find another blog post on how to dissamble the kernel.
>> > >  - https://blog.packagecloud.io/eng/2016/03/08/how-to-extract-and-disassmble-a-linux-kernel-image-vmlinuz/
>> >
>> > Yea, all SSL sites, I'm not going to try elinks with them, I don't
>> > have the time to mess around.
>>
>> I think the use case is to get the booted kernel size from zImage
>> to avoid overwriting dts or initramfs. Don't we already have that
>> at the end of zImage somewhere for kexec?
>
> We do, but finding where that is is difficult if a DTB has been appended
> as it's right at the end of the compressed data.  kexec doesn't use it,
> it just assumes there's a 5x expansion of the kernel compressed image.

My patch already take the appended DTB blob part into consideration.
It uses "unxz --single-stream" instead of "unxz" to extract, so unxz
just ignore the DTB.

I confirmed it works well on my armel box, which need to append a
device specific DTB.

For the use case, I already provided several bug reports and blog posts.
I think current script is broken for armel/armhf, which can be fixed
by my patch.
So please kindly consider this patch. Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
