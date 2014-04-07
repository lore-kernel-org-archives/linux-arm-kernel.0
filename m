From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Apr 2014 16:58:09 +0100
Subject: [PATCH 00/75] l2c series
In-Reply-To: <1bd898f9-5fb8-4d9a-968c-711b607eb961@VA3EHSMHS031.ehs.local>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <533D7672.4090003@monstr.eu> <20140403193328.GY7528@n2100.arm.linux.org.uk>
 <533E5B71.20406@monstr.eu> <20140404192824.GG7528@n2100.arm.linux.org.uk>
 <5342440E.2020301@monstr.eu> <20140407090002.GU7528@n2100.arm.linux.org.uk>
 <53426BE8.5090405@monstr.eu>
 <1bd898f9-5fb8-4d9a-968c-711b607eb961@VA3EHSMHS031.ehs.local>
Message-ID: <20140407155808.GG7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 03:52:08PM +0000, Punnaiah Choudary Kalluri wrote:
> It means there are two drivers, one for l2 cache edac and one for l2
> cache configuration and management in a single file. Please correct me
> if I am wrong.

Correct - just because you have one piece of hardware which needs to
register with two subsystems isn't always a reason to create two
separate drivers, and then have to deal with the problem of two
separate drivers needing access to the same registers, possibly with
register access synchronisation issues.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
