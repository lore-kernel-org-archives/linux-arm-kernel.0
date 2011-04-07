From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Apr 2011 18:01:39 -0400 (EDT)
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <4D9E30AE.9080105@bluewatersys.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103112313.16128.arnd@arndb.de> <4D9DE532.5000802@linaro.org>
	<201104072329.24243.arnd@arndb.de>
	<4D9E30AE.9080105@bluewatersys.com>
Message-ID: <alpine.LFD.2.00.1104071756080.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2011, Ryan Mallon wrote:

> On 04/08/2011 09:29 AM, Arnd Bergmann wrote:
> > I'll try to capture the opinions from the other people as well,
> > hopefully this represents a consensus. Please correct me otherwise.
> > 
> > I believe the uncontroversial parts are:
> > 
> > * Make it not an entry but a device with certain properties.
> > * Make the naming so that you can have more than one of them.
> > * Put all devices on an SoC that uses this scheme underneath that
> >   device by setting their parents to the SoC device.
> > 
> > For the location of the device, I have not seen a clear consensus yet,
> > but I'm fine with eihter of these:
> > 
> > /sys/devices/soc/${NAME}/
> > /sys/devices/platform/soc${NUMBER}/
> 
> I prefer the second format here since the path is always the same which
> makes it easier to write parsing tools. The name should be an entry in
> the directory rather than the name of the directory itself.
> 
> Probably SoC number should match CPU number for SMP machines right?

Not really.  SOC means System On Chip.  you usually have only one SOC on 
a board, and within that SOC you may have one or more CPUs.  SMP 
machines are still likely to have only one SOC.


Nicolas
