From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 07 Mar 2012 13:04:34 +0100
Subject: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in
 _set_gpio_dataout_*
In-Reply-To: <1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
Message-ID: <4F574ED2.4020102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
> In the existing _set_gpio_dataout_*() implementation, the dataout
> register is overwritten every time the function is called. This is
> not intended behavior because that would end up one user of a GPIO
> line overwriting what is written by another. Fix this so that previous
> value is always preserved until explicitly changed by respective
> user/driver of the GPIO line.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
This can also go as fix.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
