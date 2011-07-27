From: khilman@ti.com (Hilman, Kevin)
Date: Wed, 27 Jul 2011 14:45:33 -0700
Subject: [RFC/PATCH 0/7] decouple platform_device from omap_device
In-Reply-To: <20110727140457.GA8558@manju-desktop>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<20110727140457.GA8558@manju-desktop>
Message-ID: <CALyTGODe8r9zr4fA+AX=-XhpLjNXKtfHzxFUWMNSehDawEDMBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath,

On Wed, Jul 27, 2011 at 7:04 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> Kevin,
>
> On Thu, Jul 21, 2011 at 04:52:10PM -0700, Kevin Hilman wrote:
>> Here's a first whack, proof-of-concept on how we could start to
>> decouple the platform_device from an omap_device.
>>
>> The main RFC is in the last patch, and everything leading up to it are
>> misc. omap_device cleanups that make the last patch cleaner and
>> clearer. ?It's really the last patch that does the decoupling.
>>
>> This will be necessary if we're going to decouple the platform_device
>> creation from the omap_device/omap_hwmod creation etc. ?This patch
>> leaves them both done in omap_device_build(), but shows that they can
>> be decoupled.
> Can you pls mention baseline used for these patches? I tried applying on
> latest mainline, v3.0 and ?git://git.pwsan.com/linux-2.6 prcm-devel-3.1

Oops, sorry.  I forgot to mention it.

Due to some misc. dependencies (mainly on Beagle board file), I've
temporarily based it on the for-next branch of the arm-soc tree[1]
since that has everything already queued for the next merge window. I
also based it on the omap_device patch I posted which changes the pr_*
prints to dev_*.

For convenience, I've pushed this series to the 'wip/od-devres' branch
of my tree[2].

Sorry for the confusion,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git

[2] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
