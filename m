From: sdharia@codeaurora.org (Sagar Dharia)
Date: Mon, 4 Jun 2012 03:36:55 -0700 (PDT)
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <20120604102747.GC7538@opensource.wolfsonmicro.com>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
 <20120601001617.GA16311@plastictigers.com>
 <74993ac9d11db0db7080c0864daef397.squirrel@www.codeaurora.org>
 <20120604102747.GC7538@opensource.wolfsonmicro.com>
Message-ID: <69926c6ce4b1e004069662fb13287e9b.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> While taking care of the comments for RFC, I have introduced a
>> completion
>> that will be signalled when LA is given to the device. The driver can
>> wait
>> on that completion (wait_enum) instead of polling.
>
> This would mean that the thread the probe is happening in will be
> blocked until the LA is assigned.  That sounds like it might cause
> problems, either slowing things down or worst case causing a deadlock.
>
I would expect that the slim_device's driver will only power-on the device
during probe (and use wait_for_completion during 1st transfer to get LA).
Typically transfers are not done as part of probe. Even if transfers need
to be done as part of probe, I expect wait_for_completion (with timeout to
avoid potential HW problems causing linux probe to wait forever) will be
better than polling for get_logical_addr.


Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
