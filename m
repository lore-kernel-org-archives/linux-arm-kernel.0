From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 02 Feb 2013 06:09:24 +0400
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130202004455.GX2637@n2100.arm.linux.org.uk>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi> <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk> <510C58DF.3010103@mvista.com>
 <20130202004455.GX2637@n2100.arm.linux.org.uk>
Message-ID: <510C7554.3060800@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-02-2013 4:44, Russell King - ARM Linux wrote:

>>>> On Fri, Feb 01, 2013 at 11:49:11PM +0300, Sergei Shtylyov wrote:
>>>>>> good point, do you wanna send some patches ?

>>>>>      I have already sent them countless times and even stuck CPPI 4.1 support (in
>>>>> arch/arm/common/cppi41.c) in Russell's patch system. TI requested to remove the
>>>>> patch. :-(

>>>> sticking into arch/arm/common/ wasn't a nice move. But then again, so
>>>> wasn't asking for the patch to be removed :-s

>>> Err, patches don't get removed, they get moved to 'discarded'.

>>     Any chance to bring it back to life? :-)
>>     Although... drivers/usb/musb/cppi41.c would need to be somewhat
>> reworked for at least AM35x and I don't have time. But that may change,
>> of course.

> Right, I've just looked back at the various meeting minutes from December
> 2010 when the CPPI stuff was discussed.  Yes, I archive these things and
> all email discussions for referencing in cases like this.

    Thanks.

> Unfortunately, they do not contain any useful information other than the
> topic having been brought up.  At that point, the CPPI stuff was in
> mach-davinci, and I had suggested moving it into drivers/dma.

    I don't remember that, probably was out of the loop again.

> The result of that was to say that it doesn't fit the DMA engine APIs.

    I remember this as a discussion happening post me sending the patch to the 
patch system and it being discarded...

> So someone came up with the idea of putting it in arch/arm/common - which

    Probably was me. There was also idea of putting it into drivers/usb/musb/ 
-- which TI indeed followed in its Arago prject. I firmly denied that suggestion.

> I frankly ignored by email (how long have we been saying "no drivers in
> arch/arm" ?)

    But there *are* drivers there! And look at edma.c which is about to be 
moved there... Anyway, I haven't seen such warnings, probably was too late in 
the game.

> Now, it would've been discussed in that meeting, but unfortunately no
> record exists of that.  What does follow that meeting is a discussion
> trail.  From what I can see there, but it looks to me like the decision
> was taken to move it to the DMA engine API, and work on sorting out MUSB
> was going to commence.

> The last email in that says "I'll get to that soon"... and that is also
> the final email I have on this topic.  I guess if nothing has happened...
> Shrug, that's someone elses problem.

    Well, as usual... :-(

> Anyway, the answer for putting it in arch/arm/common hasn't changed,
> and really, where we are now, post Linus having a moan about the size
> of arch/arm, that answer is even more concrete in the negative.  It's
> 54K of code which should not be under arch/arm at all.

> Anyway, if you need to look at the patch, it's 6305/1.  Typing into the
> summary search box 'cppi' found it in one go.

    Thanks, I remember this variant was under arch/arm/common/.
    Now however, I see what happened to that variant in somewhat different 
light. Looks like it was entirely your decision to discard the patch, without 
TI's request...

WBR, Sergei
