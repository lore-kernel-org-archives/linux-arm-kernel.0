From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 28 Jan 2016 08:50:04 -0600
Subject: [PATCH] arm64: Disallow combination of ARCH_XGENE and 16K page
 size
In-Reply-To: <20160128112033.GI17123@leverpostej>
References: <1453936230-7305-1-git-send-email-dann.frazier@canonical.com>
 <20160128103441.GS14823@e104818-lin.cambridge.arm.com>
 <20160128110820.GE30928@arm.com> <20160128112033.GI17123@leverpostej>
Message-ID: <56AA2A9C.5080602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2016 05:20 AM, Mark Rutland wrote:
> On Thu, Jan 28, 2016 at 11:08:20AM +0000, Will Deacon wrote:
>> On Thu, Jan 28, 2016 at 10:34:41AM +0000, Catalin Marinas wrote:

>> I thought there was also a suggestion that we could fail gracefully in
>> the EFI stub if we detected an unsupported page size?
>
> Yup. There are other things we could/should test, too.
>
> I believe Jeremy had a patch, but due to churn in that area it didn't
> get picked up.

I will clean-up and re-post that patch in the future too. It was fairly 
trivial so if someone feels the need for immediately...

https://lkml.org/lkml/2015/10/14/948

IMHO, The main sticking point initially was that the correct place for 
the check was a moving target. That problem has been fixed, so it should 
be easy to move it.
