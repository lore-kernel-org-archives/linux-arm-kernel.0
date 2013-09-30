From: tbird20d@gmail.com (Tim Bird)
Date: Mon, 30 Sep 2013 11:14:11 -0700
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <20130924121939.GD12758@n2100.arm.linux.org.uk>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com>
 <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
Message-ID: <CA+bK7J7=x6=ZsWnSkGByvDLbht9nD6G3wQ5d05P-D96v6udDgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 5:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 24, 2013 at 08:01:52AM -0400, Jason Cooper wrote:
>> On Tue, Sep 24, 2013 at 12:55:19PM +0200, Gerlando Falauto wrote:
>> > So it shouldn't be such a crazy idea to create a dtbuImage.<dtb>
>> > within Kbuild (as opposed to from an external wrapper for make).
>>
>> Yes :)  The problem is that we are moving to multiplatform zImages.  In
>> that scenario, the uImage target isn't very helpful because it needs to
>> be custom to each board.  Additionally, appended-dtb was intended as a
>> developer tool and isn't intended as a deployable item.  It also
>> defeats the purpose of multiplatform.
>
> And we've already taken the decision that we will not be augmenting
> kbuild with any more ubooot specific stuff, especially with anything
> that goes against the long term goal of having a single kernel image
> which is bootable across multiple platforms.
>
> Having kbuild wrap the zImage + DTB up into a uImage goes directly
> against this goal, because it turns the produced kernel into something
> which is specific to a single target.  It's much worse than what we
> had before we went to DT, because with this it can only be used on a
> _single_ target, whereas prior to DT we could boot a single kernel
> on a variety of compatible targets.
>
> Moreover, the support for appending the DTB to the zImage is a stop-gap
> solution for the transition to a full DT based environment - don't
> expect it to be around into the long term future.  Modern platforms
> should be using a DT compatible boot loader, which means you don't
> want to use the DTB appended to zImage method.
>

What is the long-term mechanism/methodology for creating a kernel
that runs on a single system?  So many drivers now have device-tree
dependencies that it seems unlikely we'll be able to avoid using
device tree.  But if we don't care or don't want to support more than
a single platform, what should we do (if appending DTB to the zImage
will eventually go away).  Will the requirement be that all future
Linux bootloaders will be DT-aware?

 -- Tim Bird
Senior Software Engineer, Sony Mobile
Architecture Group Chair, CE Workgroup, Linux Foundation
