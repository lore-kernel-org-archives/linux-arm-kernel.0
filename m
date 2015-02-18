From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Feb 2015 14:09:04 +0100
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <20150218115853.GB22296@x1>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-2-git-send-email-antoine.tenart@free-electrons.com>
 <20150216124808.GC14545@x1> <20150217092020.GC4507@kwain>
 <20150217115447.GA3989@x1> <20150218084004.GD21937@kwain>
 <20150218090958.GA18042@x1> <20150218092225.GE21937@kwain>
 <20150218104023.GA22296@x1> <54E4730D.1060507@gmail.com>
 <20150218115853.GB22296@x1>
Message-ID: <54E48EF0.4050807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2015 12:58 PM, Lee Jones wrote:
> I do agree that using 'simple-bus' to describe only this IP would be
> an abuse.  However, my foundation thought/argument is unchanged.  This
> 'driver' is a hack.  It has no functional use besides to work around a
> problem of semantics and as such has no place in MFD.

Lee,

sorry I don't get it. Here you say that using simple-bus is an abuse...

> Back onto the simple-bus theme, as this is a syscon device it is a bus
> of sorts.  Have you thought about making it a child of your its syscon
> node, then using simple-bus to get the OF framework to register the
> child devices?

... and here you suggest to use simple-bus to register the child
devices?

I fundamentally disagree that either this registers or syscon in general
should in any way be seen as a bus. The chip control registers is an
highly unsorted bunch of bits that we try to match with cleanly
separated subsystems. This makes it a resource but no bus of any sort.

The problem that we try to solve here is not a DT problem but solely
driven by the fact that we need something to register platform_devices
for pinctrl and reset. The unit we describe in DT is a pinctrl-clock-
power-reset-unit - or short chip control.

If you argue that mfd is not the right place for this "driver" we'll
have to find a different place for it. I remember Mike has no problem
with extending early probed clock drivers to register additional
platform_devices - so I guess we end up putting it in there ignoring
mfd's ability to do it for us.

Do we agree on that?

Sebastian
