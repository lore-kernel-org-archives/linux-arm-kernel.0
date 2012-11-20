From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Nov 2012 14:46:21 +0100
Subject: [PATCH 065/493] i2c: remove use of __devexit_p
In-Reply-To: <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120144621.5d2c213a@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

As mentioned on the lm-sensors list for hwmon patches already, I think
it would be much clearer to not split __devexit, __devexit_p, __devinit
etc. removal into separate patches. One patch per subsystem would be
easier to review and apply. If patches grow too large then you'd rather
split in a different direction, for example drivers/i2c/muxes vs.
drivers/i2c/busses or even grouped by related bus drivers (see entries
"I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
MAINTAINERS for examples of meaningful groups.)

-- 
Jean Delvare
