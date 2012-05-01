From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 May 2012 12:37:03 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <20120501110744.GD2305@mudshark.cambridge.arm.com>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <4F9EE024.8000906@redhat.com>
 <20120501110744.GD2305@mudshark.cambridge.arm.com>
Message-ID: <20120501113703.GY24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 12:07:45PM +0100, Will Deacon wrote:
> On Mon, Apr 30, 2012 at 07:55:32PM +0100, Jon Masters wrote:
> > But I'll look over your patch and do some poking. Now that we know where
> > this problem is, I think the priority is for me to test this patch from
> > you (took the day off, but I'll give it a test tonight) to make sure
> > nothing blows up, then schedule some time for audit to make sure it's
> > actually doing anything useful. I'll email you later today. Still
> > leaning toward recommending nobody actually turn on audit on ARM systems
> > until we know that it doesn't do anything else that's terrible.
> 
> Well this might make you smile.

No it doesn't.  This is insane and absurd.

You know my views on this crappy audit stuff, I made myself pretty clear
after we discovered the back door merging of this code which had zero
review from ARM people, and my view on that has just been reinforced by
your comments which clearly indicate that there's no way this has ever
been properly tested.

It should have never gone into the mainline kernel.
