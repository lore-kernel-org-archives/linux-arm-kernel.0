From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 09 Feb 2013 13:38:21 +0000
Subject: [PATCH v3] gpio: vt8500: memory cleanup missing
In-Reply-To: <1358485102-6585-1-git-send-email-linux@prisktech.co.nz>
References: <1358485102-6585-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130209133821.5FDC93E30EC@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jan 2013 17:58:22 +1300, Tony Prisk <linux@prisktech.co.nz> wrote:
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
> There is also no .remove callback defined so the function is added.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Applied, thanks.

g.
