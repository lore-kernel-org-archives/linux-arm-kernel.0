From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Jan 2015 16:19:13 +0000
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150128161316.GS26493@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127174818.GM26493@n2100.arm.linux.org.uk>
 <20150128005032.GK28663@atomide.com> <201501281458.22088@pali>
 <alpine.LFD.2.11.1501280925400.1322@knanqh.ubzr>
 <CAL_Jsq+rESm8q44ABRbh9hqMsfcMNx0kcXJ5ONbn1=ue-RvHFg@mail.gmail.com>
 <20150128161316.GS26493@n2100.arm.linux.org.uk>
Message-ID: <20150128161913.GU1569@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 04:13:17PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 28, 2015 at 09:57:18AM -0600, Rob Herring wrote:
> > I'm fine with that, but we just need to have a standard kernel
> > userspace interface in addition to something like
> > /proc/device-tree/bootreason. Perhaps this can be the default
> > implementation for the watchdog dev. Someday when we decide DT is crap
> > and have a new boot interface, we'll have people relying on
> > /proc/device-tree. I hope to be retired when that happens...
> 
> Anyone who thinks that DT can be replaced in the same way that we made
> the mistake with ATAGs would really need their head examined.
> 
> As you point out, removing DT removes the /proc/device-tree/ sub-tree.
> Whether we like it or not, that is a userspace API, one which we have
> users of already.  That pretty much means that we can't remove DT for
> existing platforms or any platform we have now converted to DT.

<ok, I'll go there!>

... and for platforms that can also be booted via ACPI? If we have to
convert the ACPI tables into a device-tree purely for /proc/device-tree,
then we may as well boot with the thing too :)

Seriously though, I don't see how we can maintain this directory for
ACPI, regardless of whether or not it's ABI.

Will
