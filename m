From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 3 Aug 2015 15:39:45 -0400 (EDT)
Subject: [PATCH] usb: ehci-platform: Fix using multiple controllers from OF
In-Reply-To: <1438629150-11662-1-git-send-email-albeu@free.fr>
Message-ID: <Pine.LNX.4.44L0.1508031538370.1667-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Aug 2015, Alban Bedel wrote:

> When using OF defined controllers the platform data struct is shared
> between all devices, so it can't be used for device specific settings.
> However it is currently used for the OF properties
> needs-reset-on-resume and has-transaction-translator.
> 
> To fix this issue move setting hcd->has_tt to the probe and
> move pdata->reset_on_resume to the private data.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>

That's a subtle problem and a good call on your part.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
