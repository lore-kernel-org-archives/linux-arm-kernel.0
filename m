From: mike@compulab.co.il (mike at compulab.co.il)
Date: Wed, 18 May 2011 19:12:31 +0300
Subject: [GIT PULL v2 0/3] TrimSlice updates for 2.6.40
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04986AAB1E@HQMAIL01.nvidia.com>
References: <cover.1305576864.git.mike@compulab.co.il>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAB1E@HQMAIL01.nvidia.com>
Message-ID: <20110518161230.GA3029@gentoodev.compulab.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, May 17, 2011 at 01:41:56PM -0700, Stephen Warren wrote:
> Mike Rapoport wrote at Monday, May 16, 2011 2:23 PM:
> > Hi Colin,
> > Please consider pulling TrimSlice updates for 2.6.40 merge window.
> > These patches add registration of i2c, audio and USB devices.
> 
> Mike, a comment and a question:
> 
> First off, your git branch isn't based on tegra's for-next branch, but
> rather something much in the future of it. Hence, the merge brings in a
> bunch of unrelated changes. It is a fast-forward though so it's
> probably fine?
 
My branch is based on recent Linus' tree. I presume Colin will reabse
his -next on it before sending pull request...

> Second, I tried to test this, but failed. I hit two issues:
> 
> 1) USB didn't seem to work for me; the following prints continuously:
> 
> [   93.952248] usb 3-1: new high speed USB device number 126 using tegra-ehci
> [   94.022291] hub 3-0:1.0: unable to enumerate USB device on port 1
> 
> This means I can't use the built-in SSD as the root filesystem.
>
> I see this problem irrespective of whether I tell U-Boot to initialize
> USB before booting or not.

Yeah, this is caused by issue with USB1 port reset. Greg already took
the patch that fixes it (1).

> Which branches did you have merged to test this? I did:
> 
> * Create a new branch from Tegra's for-next.
> * Merge the branch from your pull request.
> * Merge ASoC for-2.6.40 branch to pick up the audio driver.
> * Cherry-pick a few I2C fixes I've been working on. I don't recall if
> they are necessary for Trimslice or not, but shouldn't hurt.

I'd rather take the ASoC for-2.6.40 and apply the first two patches +
I2C fixes.

> 2) I can boot into a recent ChromeOS filesystem on the SD card, and
> see e.g. the audio driver initialize OK. However, both speaker-test
> and aplay segfault immediately. They work fine on other HW, such as
> Seaboard, with this disk image. I know this used to work on Trimslice
> a few weeks back, so perhaps I'll go and try an older disk image.

I've never tried audio with ChromiumOS. I've tested with Maverick and
aplay didn't complain.
>
[1] http://www.mail-archive.com/linux-tegra at vger.kernel.org/msg00581.html

--
Sincerely yours,
Mike.
