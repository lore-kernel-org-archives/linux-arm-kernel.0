From: swetland@google.com (Brian Swetland)
Date: Tue, 2 Mar 2010 14:56:33 -0800
Subject: board/device file names, and machine names
In-Reply-To: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 2, 2010 at 1:29 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
>
> Hi,
>
> I was wondering if you (or the list) had any suggestions for proper
> names to use in these two cases. Under mach-msm we have tons of devices
> that could be added, and it can sometimes be hard to isolate a sane
> name ..
>
> I'll use the Nexus One device as an example .. HTC originally called
> this device the HTC Passion prior to release.. Google named the same
> device "mahimahi" prior to release .. Then finally it was released as
> Nexus One .
>
> So one device has at least three names (more I'm sure),
>
> ? ? ? ?Passion
> ? ? ? ?Mahimahi
> ? ? ? ?Nexus One
>
> Google has most of the code support under board files with the name
> mahimahi.
>
> To me it makes a lot more sense to use a mass marketed name like "Nexus
> One" .. Few people know what an HTC Passion is, and extremely few know
> what "mahimahi" is.

We would, of course, prefer to keep the board named mahimahi for all
the reasons that have been mentioned in various previous discussions
around trout, etc:
1. This was the name used during development for the platform.
2. This is the name the bootloader uses and the production bootloader
passes module parameters, etc under this name
3. This is the name the production userspace build for these phones
uses to identify the specific hardware and locate some features.
4. The Kconfig description provides a reasonable place to put more
expansive description of the various enduser visible product names.
5. My understanding has always been that MACH_* identifies a
particular board which may be instantiated in a number of products
6. I'm still unconvinced that a machine name like "mahimahi" is any
more or less confusing than any other common machine name for an ARM
board, which tend to be codenames, strange alphanumeric designators,
or combinations of the two.

This seems like an unforunate issue to bikeshed about, and by
insisting on renaming the board names, more hurdles are put up between
the (often competing, at least for our time) goals of "going to
mainline" and "maintaining an up to date tree that works on production
hardware without regression".

Thanks,

Brian


>
> Here is a link to mach-msm from Google's tree so you can see the naming
> they use,
>
> http://android.git.kernel.org/?p=kernel/msm.git;a=tree;f=arch/arm/mach-msm;h=f67bef98c885df15781d3122e3325f6164884118;hb=refs/heads/android-msm-2.6.29-nexusone
>
> Another example of this is,
>
> arch/arm/mach-msm/board-trout.c
>
> which in mainline we renamed to,
>
> arch/arm/mach-msm/board-dream.c
>
> Dream is actually a released name, so it seems to make more sense.
> However, there are many other names we could have used.
>
> machine_is_xx names have a similar kind of problem .. However, it's lot
> easier to mainline a machine_is_xxx name ..
>
> Any comments welcome, since this stuff is disputed and up in the air.
> I'm sure many other projects have faced similar problems also.
>
> Daniel
>
