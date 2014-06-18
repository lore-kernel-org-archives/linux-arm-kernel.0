From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Jun 2014 17:10:32 +0200
Subject: Dove DT and HDMI on v3.16-rc1
In-Reply-To: <20140618150103.GE32514@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
 <535F6DAF.1010400@gmail.com> <20140615152554.GA13870@n2100.arm.linux.org.uk>
 <53A19DFA.7030207@gmail.com> <20140618143447.GA22890@arch.cereza>
 <20140618150103.GE32514@n2100.arm.linux.org.uk>
Message-ID: <53A1ABE8.8050401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 05:01 PM, Russell King - ARM Linux wrote:
> On Wed, Jun 18, 2014 at 11:34:48AM -0300, Ezequiel Garcia wrote:
>> On 18 Jun 04:11 PM, Sebastian Hesselbarth wrote:
>>> Using your libdrm-armada and xf86-video-armada on Ubuntu raring armhf,
>>> I can run Xfce4 on 1920x1080p60 on Dove Cubox without any blanking
>>> issues. Using xrandr -s <mode> will fail after 2-3 times but that
>>> shouldn't be related to the issues you see.
>>>
>>> Please test above branch with kernel config at
>>> https://dl.dropboxusercontent.com/u/59928252/config-dove-v3.16-rc1-hdmi
>>> and report back if issues are still there.
>>>
>>> Anyone having a Dove CuBox ready, please also test. Russell has a git
>>> branch for the required video lib and drivers.
>>>
>>
>> Can you point me at those?
>
> Beware - the machine is rather aged and slow by todays standards ((c)git
> is rather heavy weight):
>
>   http://ftp.arm.linux.org.uk/cgit/
>
> The xf86-video-armada.git tree is not trivial to build as there's
> dependencies on the Vivante galcore libraries - and even if you have
> them, there's then there's non-trivial changes to the kernel-side driver
> to support dmabuf imports.  Welcome to the world of closed source graphics
> libraries making open source hard... I've been wishing for etnaviv for
> a while now...
>
> Even though the kernel side is supposed to be GPL, I'm really not happy
> distributing it or publishing changes as there are a number of files with
> headers which seem to be GPL-incompatible (which I've eliminated from my
> tree through updates) but the problem is wonderful git keeps them as
> history... and in my tree it's a massive 93 patches, against an old
> version of the code (0.8.0.1998) which I then sort-of updated to the
> version OLPC were carrying towards the start of 2013.
>
> It's probably best if Sebastian walks you through getting it up and
> running as my experience is with my kernels and userspace, which has all
> the necessary hacks in.

I basically followed Russell's guide from
http://www.home.arm.linux.org.uk/~rmk/cubox/carrier-1-readme.txt

with this binary/include package from SolidRun
http://download.solid-run.com/pub/solidrun/cubox/packages/marvell-opengl/marvell-opengl-hardfp-new-headers.zip

xf86-video-armada needs some missing
#include "picturestr.h"
for raring, but whole process has been very straight forward.

Feel free to bug me on IRC anytime you hit some build errors or
anything else.

Sebastian
