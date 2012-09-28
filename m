From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Sep 2012 13:05:33 -0600
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <E1THfgr-0006Fg-KT@jdl.com>
References: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-2-git-send-email-mmayer@broadcom.com>
 <20120925233054.GL9800@truffula.fritz.box> <50624393.30607@broadcom.com>
 <20120926003508.GB31993@truffula.fritz.box> <50632F78.4030709@broadcom.com>
 <5065D9C7.40906@wwwdotorg.org> <E1THfgr-0006Fg-KT@jdl.com>
Message-ID: <5065F4FD.4010807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 12:53 PM, Jon Loeliger wrote:
>>>
>>> Yeah, seems like the kernel DTC is quite old.
>>
>> FYI, I'm working on a patch to the kernel to bring in the latest dtc.
> 
> Awesome.  Thank you.
> 
>> I've run a regression test vs. the old dtc in the kernel ...
> 
> Which is the icky step.  Again, thank you.
> 
>> ... and found that
>> some of the PowerPC .dts files don't compile with the new dtc (but did
>> with the old), all due to non-existent labels/paths being referenced.
>> I'll try and track down whether this is a regression in dtc, or simply
>> buggy .dts files that weren't noticed before.
> 
> I think you should just smack the PowerPC guys. :-)

For the record in this thread, it was a regression I introduced into dtc
- the patch I just sent was for this.

>> Everything non-PowerPC works fine, and most PowerPC files work fine.
>> Where compilation succeeds, the md5sum of the .dtb is identical in every
>> case.

... and with that patch, every .dts in the kernel compiles to the same
md5sum before/after.
