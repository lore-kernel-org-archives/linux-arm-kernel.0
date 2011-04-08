From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 08 Apr 2011 08:41:32 +0100
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <201104080535.02769.arnd@arndb.de>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201104080119.11378.arnd@arndb.de>
	<20110407232959.GA29305@kroah.com>
	<201104080535.02769.arnd@arndb.de>
Message-ID: <4D9EBC2C.2050809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/11 04:35, Arnd Bergmann wrote:
> On Friday 08 April 2011, Greg KH wrote:
>> Symlinks are a requirement as multiple cpus can be attached to a single
>> SoC.
>>
>> What about multiple cpus that are attached to multiple SoCs?  Why even
>> try to describe this relationship, what would userspace get out of this
>> information?
> 
> The only one I can think of is node affinity. I've worked with a system
> (IBM QS2x Cell blade) that had two SoCs with multiple CPUs each. There was
> a significant performance penalty when talking to devices on the remote
> SoC. In that case, we used the NUMA node information in /sys/ to deal
> with it, but we might not want to use the NUMA infrastructure on systems
> that only have RAM on one node.

I'm struggling to see a scenario where we'd have multiple SoCs on a
single device and only one filesystem. ux500 sub-arch code is yet to
facilitate SoC counting functionality. If were are to implement per-SoC
directories would this need to be added?
