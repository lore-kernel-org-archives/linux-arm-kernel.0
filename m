From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jan 2017 12:03:40 +0000
Subject: [PATCH 2/2] arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA
In-Reply-To: <20170105194944.GY4930@rric.localdomain>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
 <20170104132831.GD18193@arm.com>
 <CAKv+Gu8MdpVDCSjfum7AMtbgR6cTP5H+67svhDSu6bkaijvvyg@mail.gmail.com>
 <20170104140223.GF18193@arm.com>
 <20170105112407.GU4930@rric.localdomain>
 <20170105120819.GH679@arm.com>
 <20170105122200.GV4930@rric.localdomain>
 <20170105194944.GY4930@rric.localdomain>
Message-ID: <20170106120339.GA20726@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 08:49:44PM +0100, Robert Richter wrote:
> On 05.01.17 13:22:00, Robert Richter wrote:
> > On 05.01.17 12:08:20, Will Deacon wrote:
> > > I really can't see how the fix causes a crash, and I couldn't reproduce
> > > it on any of my boards, nor could any of the Linaro folk afaik. Are you
> > > definitely running mainline with just these two patches from Ard?
> > 
> > Yes, just both patches applied. Various other solutions were working.
> 
> I have retested the same kernel (v4.9 based) as before and now it
> boots fine including rtc-efi device registration (it was crashing
> there):
> 
>  rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
> 
> There could be a difference in firmware and mem setup, though I also
> downgraded the firmware to test it, but can't reproduce it anymore. I
> could reliable trigger the crash the first time.
> 
> FTR the oops.

Hmm, I just can't help but think you were accidentally running with
additional patches when you saw this oops previously. For example,
your log looks very similar to this one:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473666.html

but then again, these crashes probably often look alike.

Will
