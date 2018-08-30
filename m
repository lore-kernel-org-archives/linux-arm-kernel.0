From: wufan@codeaurora.org (wufan)
Date: Thu, 30 Aug 2018 10:45:03 -0600
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
 <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
 <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
Message-ID: <001101d44080$cd2a73d0$677f5b70$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

> > For ghes_edac the bank/device is informational, and nothing would go
> > wrong if the bank/device numbers are the same as another entry. But
> > the handle is now critical for DIMM lookup, thus pull it out.
> 
> Is printing the handle to the kernel log critical?
> 
> I'd expect something collecting errors to read from sysfs, not dmesg. I
> thought the whole point here was to update the per-dimm counters in sysfs.

No, printing out the handle is not critical. What I meant is because the 
information is critical it would be nice to have it available for debugging 
purpose. Otherwise it would be hard to find the handle if bank/device
is not accurate. 

Thanks,
Fan
