From: jcm@redhat.com (Jon Masters)
Date: Tue, 01 May 2012 12:52:07 -0400
Subject: [PATCH] ARM: Fix restoration of IP scratch register when auditing
 syscalls
In-Reply-To: <20120501113703.GY24211@n2100.arm.linux.org.uk>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <4F9EE024.8000906@redhat.com>
 <20120501110744.GD2305@mudshark.cambridge.arm.com>
 <20120501113703.GY24211@n2100.arm.linux.org.uk>
Message-ID: <4FA014B7.2050205@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Hope you're doing well. Look forward to possibly seeing you in Hong Kong
- if you make it, I know you are insanely busy these days!

On 05/01/2012 07:37 AM, Russell King - ARM Linux wrote:
> On Tue, May 01, 2012 at 12:07:45PM +0100, Will Deacon wrote:
>> On Mon, Apr 30, 2012 at 07:55:32PM +0100, Jon Masters wrote:
>>> But I'll look over your patch and do some poking. Now that we know where
>>> this problem is, I think the priority is for me to test this patch from
>>> you (took the day off, but I'll give it a test tonight) to make sure
>>> nothing blows up, then schedule some time for audit to make sure it's
>>> actually doing anything useful. I'll email you later today. Still
>>> leaning toward recommending nobody actually turn on audit on ARM systems
>>> until we know that it doesn't do anything else that's terrible.
>>
>> Well this might make you smile.

Thanks Will, it did. I'll get back to poking at the followup patch you
posted. In the end, I tried actually taking the day off yesterday and
didn't get chance to poke at it some more. btw, it was awesome. I did
nothing, and it was everything I thought it could be </Office Space>.

> No it doesn't.  This is insane and absurd.
> 
> You know my views on this crappy audit stuff, I made myself pretty clear
> after we discovered the back door merging of this code which had zero
> review from ARM people, and my view on that has just been reinforced by
> your comments which clearly indicate that there's no way this has ever
> been properly tested.

I choose to take a different angle here. I think Eric and others are
doing good work, and I think on the whole we can solve some of these
problems by making sure more folks have access to ARM hardware -
something I am trying to get moving for at least RH employees.

> It should have never gone into the mainline kernel.

This I do agree with. But that's history. Let's figure this out, fix it,
and move on. I realize not everyone likes audit, but it's something that
exists on x86. For various reasons I'm very motivated that we have
feature parity with x86 in the ARM space, especially as ARM moves into
(shall we say) "bigger devices". Therefore, audit needs to ultimately
work on ARM systems if we want them to be in that space.

I want us on the RH/Fedora end of things to get more involved with ARM
kernel stuff upstream. We'll try to help with less embedded stuff that
needs testing in the future, especially by using it in the default
Fedora configuration, which has lots of non-embedded options on.

Jon.
