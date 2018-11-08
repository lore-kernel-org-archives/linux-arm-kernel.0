From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 8 Nov 2018 12:43:23 +0000
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <20181107215854.GD12248@brain-police>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <20181107215854.GD12248@brain-police>
Message-ID: <533eff05-4fb9-e8e7-553d-16979055e8f5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 07/11/18 21:58, Will Deacon wrote:
> Hi Julien,
> 
> On Wed, Sep 26, 2018 at 02:56:17PM +0100, Julien Thierry wrote:
>> Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
>> using it to access memory. When taking an exception, it is possible that
>> the context during which the exception occured had SP mis-aligned. The
>> entry code needs to make sure that the stack is aligned before using it to
>> save the context.
> 
> Do you know what we haven't had reports of this crashing? Is it because GCC
> tends to keep the SP aligned anyway, so we're getting away with it for the
> moment? Trying to work out whether this is a candidate for -stable.
> 

I think that GCC tends to keep the SP aligned anyway is the most likely 
explanation, yes.

I tried looking for specific options that could make this more likely, 
but all I could find was the option -mpreferred-stack-boundary only 
available for x86 and -mstack-alignment only provided by clang.

Couldn't find anything yet on the gcc arm64 side that would either 
guarantee we'd have an aligned stack nor that GCC would make it very 
very likely.

I can try to investigate a bit more.

Thanks,

-- 
Julien Thierry
