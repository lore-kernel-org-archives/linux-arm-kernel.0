From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 13 Oct 2011 23:21:23 +0800
Subject: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
In-Reply-To: <Pine.LNX.4.44L0.1110131029510.2026-100000@iolanthe.rowland.org>
References: <CACVXFVNXyzzJw7UK+OFuDe23voQvyywoP9AvUsV=iPDFPO4fPw@mail.gmail.com>
	<Pine.LNX.4.44L0.1110131029510.2026-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVMoac7psbfO6UdDvNux4c8bQYS4YNUdz1C-o+CiJzyuZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 13, 2011 at 10:31 PM, Alan Stern <stern@rowland.harvard.edu>
>> Maybe we should understand the correct model of the ordering constraints
>> for the multiple device dependancies first, could you give a description or
>> some examples about it?
>
> The requirement is that devices must be capable of resuming in the
> order given by dpm_list, and they must be capable of suspending in
> the reverse order.
>
> Therefore if device A can't work unless device B is functional, then B
> must come before A in dpm_list.

If all devices can support async suspend and resume correctly, looks like
the device order given by dpm_list is not needed any longer, doesn't it?


thanks,
-- 
Ming Lei
