From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 30 Aug 2009 16:45:25 -0700
Subject: Fwd: [PATCH] em7210: fix memory size
In-Reply-To: <e9c3a7c20908301631j50ccb0d6q8ab1ee61a2f4d247@mail.gmail.com>
References: <87k51ru2gw.fsf@lechat.rtp-net.org>
	<e9c3a7c20908301631j50ccb0d6q8ab1ee61a2f4d247@mail.gmail.com>
Message-ID: <e9c3a7c20908301645v4cfdec4ehe2ed1e6efaf261ed@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ replied to wrong mailing list ]


---------- Forwarded message ----------
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, Aug 30, 2009 at 4:31 PM
Subject: Re: [PATCH] em7210: fix memory size
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-arm-kernel at lists.arm.linux.org.uk


On Wed, Jul 29, 2009 at 4:56 AM, Arnaud Patard<arnaud.patard@rtp-net.org> wrote:
>
> The default memory module size on the ss4000e is 256M but Redboot has
> been hardcoded to pass 512M to the kernel through ATAG. As getting a new
> redboot is more than unlikely, it has to be fixed in the kernel
> (unfortunately). This patch does that.
>

I am on the fence on this one. ?On the one hand it makes sense in that
the kernel is usable without a "mem=256M..." command line option on
default configured platforms. ?Users that have upgraded the memory can
pass a "mem=512M..." to use their extra memory. ?However, it still
seems that this will appear as a regression to any current 512M
platforms that are not passing a command line option, and a "don't
care" to everyone who must be passing "mem=256M..." to get a
functional platform.

Hmm... ?can you say a bit more about this comment "solving this issue will help
also people porting the d-i on the device." [1] That might help tip the balance.

Thanks,
Dan

[1]: http://marc.info/?l=linux-arm-kernel&m=124810119114783&w=2
