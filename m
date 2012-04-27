From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Apr 2012 15:25:38 -0700
Subject: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family
 detection
In-Reply-To: <20120427220813.GE19196@animalcreek.com> (Mark A. Greer's message
 of "Fri, 27 Apr 2012 15:08:13 -0700")
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
 <20120427220813.GE19196@animalcreek.com>
Message-ID: <87aa1wyfq5.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> On Thu, Apr 26, 2012 at 04:29:45PM -0700, Kevin Hilman wrote:
>
> Hi Kevin.
>
>> This is a rebased version of this series which is ready for broader
>> testing.  I'd especially appreciate testing from those of you with
>> AM35x platforms.
>> 
>> Currently, our SoC detection is based on SoC family detection
>> (using die ID) and the presence of specific IP blocks (or feature.)
>> 
>> This series begins the separation of the SoC family detection and
>> specific IP detection by completely removing IP detection from the SoC
>> family detection (cpu_is_*.)
>> 
>> Applies on top of v3.4-rc4, boot tested on AM3517 EVM.
>
> Your series applied and booted without issue until the point that
> pm_idle is called.  At that point it hung because its doing a wfi
> and not getting an interrupt to wake up back up.  That's expected
> behaviour so your patches are good (IMHO) but I need to finish and
> submit a new version of my patches to fix that issue.

For the benefit of others wanting to test this:

You have to use 'nohlt' on the cmdline on AM35x in order to avoid WFI
and the wakeup problems that are still being worked on.

Kevin
