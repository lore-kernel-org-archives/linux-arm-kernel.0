From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Apr 2011 01:19:10 +0200
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <4D9E4114.3090102@bluewatersys.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<alpine.LFD.2.00.1104071840430.28032@xanadu.home>
	<4D9E4114.3090102@bluewatersys.com>
Message-ID: <201104080119.11378.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 April 2011, Ryan Mallon wrote:
>>>>> /sys/devices/soc/${NAME}/
>>>>> /sys/devices/platform/soc${NUMBER}/
>>>>
>>>> I prefer the second format here since the path is always the same which
>>>> makes it easier to write parsing tools. The name should be an entry in
>>>> the directory rather than the name of the directory itself.

In the first case, we would ensure that every directory under /sys/devices/soc
is an SOC device, so you would not need to parse the name at all, which is
even simpler. I'm open to other arguments either way, but I think this
one is not particularly important.

> > That would mean two separate instances of Linux, just like two systems.  
> > SMP across multiple SOCs doesn't make much sense, and I don't think they 
> > are likely to be designed for that ability either.
> 
> So we probably don't need the ability to have multiple SoC directories
> under sysfs then?

There are systems that have multiple ones, they are just not as common.

> For the other part of the question, do you think it makes sense for the
> CPU's to be child devices of the SoC (and for the CPU devices to be
> potentially symlinked from the SoC directory)?

No, the CPUs are children of /sys/devices/system, and we should not change
that. Symlinks sound like a good idea though.

	Arnd
