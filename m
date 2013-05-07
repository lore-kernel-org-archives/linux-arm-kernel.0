From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 7 May 2013 09:15:00 -0400
Subject: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <20130507003651.GA26035@obsidianresearch.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
 <20130506223653.GA12089@obsidianresearch.com> <51884971.9050508@ti.com>
 <20130507003651.GA26035@obsidianresearch.com>
Message-ID: <5188FE54.6050200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On 06-05-2013 20:36, Jason Gunthorpe wrote:
> On Mon, May 06, 2013 at 08:23:13PM -0400, Eduardo Valentin wrote:
> 
>>> I get the impression it is desired to minimize driver kconfig
>>> dependencies to the minimum required to compile to increase build
>>> testing coverage, so maybe it would be appropriate to drop this
>>> entirely?
> 
>> Well, it is also desired to compile things to the correct target
>> right?
> 
> There is some of that too..
> 
> But broadly the direction seems that drivers should have minimal
> dependencies so, eg, the thermal maintainer compiling for x86 should
> be able to compile test/static analyze your driver..
> 

Well, I do not see much of this attempt actually. Do you have some link
/ evidene that shows someone who actually cares about compiling drivers
for targets that they are not used for? On this specific driver, I
actually have  had exactly the opposite advice [1]. I am not convinced
people actually want to do that.

>> Thats the idea behind this config option. It follows the same design as
>> CONFIG_ARCH_HAS_CPUFREQ, for instance.
> 
> That is entirely contained inside arch/arm and doesn't involve
> drivers.

It actually goes outside arch/arm.

> 
> Jason
> 
> 

[1] - https://patchwork.kernel.org/patch/1185431/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130507/97d2e2b2/attachment-0001.sig>
