From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 30 Oct 2017 14:06:58 -0700
Subject: [PATCH v2 1/3] usb: host: remove ehci-msm.c
In-Reply-To: <Pine.LNX.4.44L0.1710261105090.1365-100000@iolanthe.rowland.org>
References: <20171026134827.615-2-elder@linaro.org>
 <Pine.LNX.4.44L0.1710261105090.1365-100000@iolanthe.rowland.org>
Message-ID: <20171030210658.GJ1275@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 26 Oct 08:06 PDT 2017, Alan Stern wrote:

> On Thu, 26 Oct 2017, Alex Elder wrote:
> 
> > No Qualcomm SoC requires the "ehci-msm.c" code any more.  So remove it.
> 
> What about old Qualcomm SoCs?  What should they use instead?
> 

These drivers where unfortunately broken by design (host and gadget mode
where implemented in separate drivers that where racing) and the
ChipIdea driver has been updated to support driving the host-mode on
these platforms as well.

So all platforms existing upstream should be covered by the remaining
drivers.

Regards,
Bjorn
