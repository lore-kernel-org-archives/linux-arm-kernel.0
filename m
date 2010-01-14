From: jason.wessel@windriver.com (Jason Wessel)
Date: Thu, 14 Jan 2010 12:57:35 -0600
Subject: [PATCH 20/40] arm,
	kgdb: Add hook to catch an oops with debugger
In-Reply-To: <20100114174821.GB21385@n2100.arm.linux.org.uk>
References: <1263481176-1897-1-git-send-email-jason.wessel@windriver.com><1263481176-1897-21-git-send-email-jason.wessel@windriver.com>
	<20100114174821.GB21385@n2100.arm.linux.org.uk>
Message-ID: <4B4F691F.3030500@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Thu, Jan 14, 2010 at 08:59:16AM -0600, Jason Wessel wrote:
>   
>> Add in a low level hook to catch calls to die() in the debugger.
>>
>> After the debugger is done, the standard system rules will be in play
>> for the original exception.
>>
>> The kdb debugger wants a chance to catch these sorts of exceptions for
>> analysis.
>>     
>
> NAK.  I have a similar patch which implements the hook properly - but
> with one caveat.  It needs a review to ensure that its safe to return
> from die().  Until that's established, this patch can not be merged.
>   

I dropped the patch which you NAK'ed from the series.

As for your included patch, I will try it out  against the various
regression tests I have, which exercise the oops and exception paths.

> Please also ensure that the linux-arm-kernel list is copied with ARM
> patches.
>
>   

Check.


Thanks,
Jason.
