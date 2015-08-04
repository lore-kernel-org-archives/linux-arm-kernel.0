From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 4 Aug 2015 10:29:56 -0400 (EDT)
Subject: [PATCH v2] usb: ehci-platform: Fix using multiple controllers
 from OF
In-Reply-To: <1438678757-26582-1-git-send-email-albeu@free.fr>
Message-ID: <Pine.LNX.4.44L0.1508041029250.1577-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Aug 2015, Alban Bedel wrote:

> When using OF defined controllers the platform data struct is shared
> between all devices, so it can't be used for device specific settings.
> However it is currently used for the OF properties
> needs-reset-on-resume and has-transaction-translator.
> 
> To fix this issue move setting hcd->has_tt to the probe and
> move pdata->reset_on_resume to the private data.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> Changelog:
> v2: * Use true instead of 1 to set boolean type

Acked-by: Alan Stern <stern@rowland.harvard.edu>
