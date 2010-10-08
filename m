From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 8 Oct 2010 12:32:35 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101007192245.GC26435@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 7, 2010 at 10:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 07, 2010 at 12:44:22PM +0300, Felipe Contreras wrote:
>> Many drivers are broken, and there's no alternative in sight. Such a big
>> change should stay as a warning for now, and only later should it
>> actually fail.
>>
>> The drivers are not doing something correct, we get it, but for now it's
>> better to allow them to work (they do 99% of the time anyway) rather
>> than to force everyone to revert this patch in their internal trees
>> until there's a solution. A slightly broken functionality is better than
>> no functionality at all.
>>
>> A warning lets people know that what they are doing is not right, and
>> they should fix it.
>
> So what are _you_ going to do to fix these drivers? ?Continue reverting
> this patch? ?Or are you just going to ignore the issue entirely?

_I_ don't maintain any of these drivers.

I think when _you_ remove functionality from the architecture, you
should provide a mechanism that drivers can migrate to. Since there's
nothing like that, not even a guideline, you are breaking the drivers
willingly, and expecting other people to fix a difficult problem that
you yourself have no idea how to fix properly. At least for 2.6.36,
and probably 2.6.37, I think it's clear what people will do; revert
that patch in their trees, and think twice before switching to a newer
version.

> Unless people can come up with a plan to fix their drivers using ioremap
> on system RAM thereby violating the architecture specification, I'm
> _not_ going to apply this patch.

And then people wonder why companies don't try to work in upstream as
often as they should. If you, the ARM maintainer doesn't care about
breaking drivers with no warning whatsoever, I wonder why would driver
writers would feel compelled to fix the ARM architecture ASAP (if they
are even capable of doing that), specially if they already missed the
deadline, which had a grace period of between .36-rc1 and .36.

Other projects remove functionality only when there's an alternative
in place, and provide a grace period for the migration. I thought that
was sensible.

-- 
Felipe Contreras
