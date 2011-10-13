From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Oct 2011 12:04:25 -0400 (EDT)
Subject: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
In-Reply-To: <CACVXFVMoac7psbfO6UdDvNux4c8bQYS4YNUdz1C-o+CiJzyuZA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1110131202350.2026-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Ming Lei wrote:

> Hi,
> 
> On Thu, Oct 13, 2011 at 10:31 PM, Alan Stern <stern@rowland.harvard.edu>
> >> Maybe we should understand the correct model of the ordering constraints
> >> for the multiple device dependancies first, could you give a description or
> >> some examples about it?
> >
> > The requirement is that devices must be capable of resuming in the
> > order given by dpm_list, and they must be capable of suspending in
> > the reverse order.
> >
> > Therefore if device A can't work unless device B is functional, then B
> > must come before A in dpm_list.
> 
> If all devices can support async suspend and resume correctly, looks like
> the device order given by dpm_list is not needed any longer, doesn't it?

It _is_ needed, because the user can disable async suspend/resume via 
/sys/power/pm_async.

Also, not all devices do support async suspend/resume.

Alan Stern
