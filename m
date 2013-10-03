From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 3 Oct 2013 08:27:15 -0700
Subject: Use of drivers/platform and matching include?
In-Reply-To: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
Message-ID: <20131003152715.GA15931@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 09:45:38AM -0500, Kumar Gala wrote:
> As we look at upstreaming more support for the Qualcomm MSM SoCs there
> are a number of drivers or library like routines that are unique to
> the MSM platform, we are thinking that putting them under:
> 
> drivers/platform/qcom/

What type of drivers are these?  Shouldn't they really go under the
specific driver type directory instead?

> would make sense.  In addition there are headers that might need to
> get shared with drivers in other locations so I wanted to see what the
> take was on introducing:
> 
> include/linux/platform/qcom/
> 
> An example driver would be the means we utilize to communicate memory
> regions between various HW blocks on the SoC.  So a video/media core
> driver might need access to a header/functions from the memory region
> driver.

Isn't there arch-specific include directories already that are good for
stuff like this?

thanks,

greg k-h
