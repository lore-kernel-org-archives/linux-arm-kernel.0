From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 May 2012 12:07:45 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <4F9EE024.8000906@redhat.com>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <4F9EE024.8000906@redhat.com>
Message-ID: <20120501110744.GD2305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 07:55:32PM +0100, Jon Masters wrote:
> But I'll look over your patch and do some poking. Now that we know where
> this problem is, I think the priority is for me to test this patch from
> you (took the day off, but I'll give it a test tonight) to make sure
> nothing blows up, then schedule some time for audit to make sure it's
> actually doing anything useful. I'll email you later today. Still
> leaning toward recommending nobody actually turn on audit on ARM systems
> until we know that it doesn't do anything else that's terrible.

Well this might make you smile.

The original audit code blew up the ARM kernel because it assumed a big-endian
target, which we since fixed. However, it looks like the userspace audit tools
only support ARMEB, so I've not been able to get them working on my board.
Linaro even had the heart to package them up nicely in their v7l filesystem!

I doubt it's much effort to fix the tools, but it implies nobody is using
them on armv7l today and turning it off is probably your safest bet for the time
being.

Will
