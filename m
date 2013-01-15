From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 15 Jan 2013 18:20:20 +1300
Subject: [PATCH v2] gpio: vt8500: memory cleanup missing
In-Reply-To: <1358188644-23838-1-git-send-email-linux@prisktech.co.nz>
References: <1358188644-23838-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1358227220.5928.2.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-15 at 07:37 +1300, Tony Prisk wrote:
> This driver is missing a .remove callback, and the fail path on
> probe is incomplete.
> 
> If an error occurs in vt8500_add_chips, gpio_base is not unmapped.
> The driver is also ignoring the return value from this function so
> if a chip fails to register it completes as successful.
> 
> Replaced pr_err with dev_err in vt8500_add_chips since the device is
> available.
> 
> There is also no .remove callback defined. To allow removing the
> registered chips, I have moved *vtchip to be a static global.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> Hi Grant,
> 
> Let me know what you think of these changes.
> 
> v2:
> Removed unnecessary whitespace change.
> Removed test against pdev->dev.of_node (np). Replaced code with a
>   devm_request_and_ioremap so np is now unneccessary. This also removes the need
>   for cleanup in the fail path.
> Move struct vt8500_gpio_chip within vt8500_data and store the iobase and
>   num_banks in vt8500_data.
> 

Grant,

If there are no further changes for this patch, would you mind
correcting the commit message when you merge it?

-There is also no .remove callback defined. To allow removing the
-Registered chips, I have moved *vtchip to be a static global.
+ There is also no .remove callback defined.

Otherwise, I will fix it along with whatever other comments come in.

Regards
Tony P
