From: joel.schopp@amd.com (Joel Schopp)
Date: Tue, 19 Aug 2014 09:49:07 -0500
Subject: [PATCH v5] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140819143834.GE31086@cbox>
References: <20140818203604.4654.99905.stgit@joelaarch64.amd.com>
 <20140819122420.GC31086@cbox> <53F35DFD.9070804@amd.com>
 <20140819143834.GE31086@cbox>
Message-ID: <53F363E3.8060108@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> The return is a value,not just an error code. Because of this returning
>> an error overloads that value.  0 just seemed like a convenient invalid
>> value to check since a vttbr_x of 0 is invalid, but returning a negative
>> error code would be as equally invalid.  If this is the only issue it
>> doesn't seem worth respinning the patch for, but I'll change it to
>> -EINVAL if for some reason a v6 is needed.
> Have you given up on doing the alignment check with the proper size on
> the pgd allocation for this patch?
Yes, I'd rather leave the extra check out of this patch.  If I were
changing the pgd allocation code I would make sure to add a check, or if
there were a static check there now I would update it for the dynamic
value from the hardware, but it seems unrelated to add several checks to
other parts of the code beyond those already in the patch.  I did leave
the functions in the headers such that checks like this could be added
when someone is updating the code for other reasons, say 4 level page
tables.

-Joel
