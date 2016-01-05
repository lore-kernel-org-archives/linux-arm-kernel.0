From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 5 Jan 2016 10:59:24 -0500 (EST)
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL_Jsq+P8SBmWzNURrmNgz8soCn4QPOPid4SXF0a3TYL_SH27A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1601051058050.1666-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jan 2016, Rob Herring wrote:

> >>> > It's not clear (to me, anyway) how this is meant to work.  USB is a
> >>> > completely discoverable bus: There is no way to represent devices
> >>> > statically; they have to be discovered.  But a device can't be
> >>> > discovered unless it is functional, so if an onboard hub (or any other
> >>> > sort of USB device) requires power, clocks, or something similar in
> >>> > order to function, it won't be discovered.  There won't be any device
> >>> > structure to probe, and "forcing driver probe" won't accomplish
> >>> > anything.
> >>> >
> >>> > It seems to me that the only way something like this could be made to
> >>> > work is if the necessary actions are keyed off the host controller (and
> >>> > in particular, _not_ the hub driver), presumably at the time the
> >>> > controller is probed.
> 
> The problem with putting this in the the host controller driver is it
> assumes the initialization sequence is generic enough to be described
> in DT and that initialization is the only time we need DT data. The
> MFD example is a perfect example of another case. Suspend/resume also
> comes to mind. Even if we could put the control in both places, that
> is poor design IMO. I'd rather just make it a requirement that the
> bootloader do enough setup that devices can be discovered.

That would be okay with me.  It would make things a lot simpler (but it 
would also waste energy in situations where the devices weren't being 
used).

Alan Stern
