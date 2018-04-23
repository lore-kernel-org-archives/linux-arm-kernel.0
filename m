From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 23 Apr 2018 08:20:43 -0600
Subject: Reporting more CPU features in /proc/cpuinfo
In-Reply-To: <CAGXu5jKpU+pCi_S9PPqG9pYezkzjekXPohyBXJmXe87GqCEGnw@mail.gmail.com>
References: <CAGXu5jKpU+pCi_S9PPqG9pYezkzjekXPohyBXJmXe87GqCEGnw@mail.gmail.com>
Message-ID: <520006aa-4b67-eb77-253e-4c9dc4aa3329@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/2018 2:04 PM, Kees Cook wrote:
> Hi!
> 
> I'd like to have more CPU features visible in /proc/cpuinfo so it's
> possible to determine from userspace if the running system has various
> defenses. For example, I'd like to know that a device has hardware PXN
> and PAN. (I'd love to see emulated features listed separately too, but
> I could imagine that not being a great match for /proc/cpuinfo.)
> 
> One specific reason for this to do basic feature testing from
> userspace without needing to catch the boot-time dmesg output. For
> example, being able to answer the question "Does this system provide
> PAN?" The answer is yes if either emulated PAN is visible in
> /proc/config.gz or if hw PAN Is provided by the CPU (which I'd expect
> to discover via /proc/cpuinfo like on x86 for things like SMAP).
> 
> Thoughts?
> 
> -Kees
> 

I too, would like to see /proc/cpuinfo to be more useful, but last time 
this was brought up by Al Stone[1], there was significant pushback from 
Mark.

Maybe Mark has changed his position since then?

[1] https://lkml.org/lkml/2017/9/26/786

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
