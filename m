From: kaloz@openwrt.org (Imre Kaloz)
Date: Sun, 09 Sep 2012 10:46:34 +0200
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <1729018.3VWhxcipzn@wuerfel>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209061546.45242.arnd@arndb.de>
 <20120908215609.GH13739@n2100.arm.linux.org.uk> <1729018.3VWhxcipzn@wuerfel>
Message-ID: <op.wkc1bwjx2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 09 Sep 2012 03:16:54 +0200, Arnd Bergmann <arnd@arndb.de> wrote:

<snip>

>> so in that case I'm not going to know if anything is broken on an IOP32x
>> kernel until that gets rebooted (which it will do soon because I want to
>> change its disks - but hopefully not before 62 days time.)
>
> I was specifically saying "a port gets started", not "a port is fully
> working". The example I was thinking of is the mach-cns3xxx, which
> was introduced in a very minimal state about 2 years ago. The only
> users I could find on the internet are on OpenWRT, which adds
> support for an actual board file (upstream only has the evaluation
> board) as well as SMP, clock, i2c, ethernet, gpio, and a bunch of
> bug fixes[1]. I'd say we should either find someone who is willing to
> submit the patches upstream and make sure they work with at least
> one version, or we can remove what we have today because it's evidently
> not used.

For some time now you have to have clocks support to be able to get SMP  
and co working. Without that and DT it doesn't really make sense to submit  
those patches.

<snip>

> * ixp4xx is (as expected) actively used, but a lot of patches are stuck
> in openwrt[2] and not getting submitted.
> Greg also submitted a regression fix, Ben Hutchins promised
> another fix from Debian.

Mostly the same as above. Don't forget that DT support will essentially  
get rid of all separate board support files, so those patches will have to  
be translated to dts files instead.

Since I'm doing all the OpenWrt work (as well as upstreaming non-ARM  
stuff) in my free time, things got stuck and will likely stay that way for  
another month or so.


Imre
