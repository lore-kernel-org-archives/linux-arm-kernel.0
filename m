From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 19 May 2017 14:38:01 +0200
Subject: [PATCH] i2c: designware: don't infer timings described by ACPI
 from clock rate
In-Reply-To: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
Message-ID: <20170519123801.l25pvu5n2bjfwzt6@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 09:56:40AM +0100, Ard Biesheuvel wrote:
> Commit bd698d24b1b57 ("i2c: designware: Get selected speed mode
> sda-hold-time via ACPI") updated the logic that reads the timing
> parameters for various I2C bus rates from the DSDT, to only read
> the timing parameters for the currently selected mode.
> 
> This causes a WARN_ON() splat on platforms that legally omit the clock
> frequency from the ACPI description, because in the new situation, the
> core I2C designware driver still accesses the fields in the driver
> struct that we no longer populate, and proceeds to calculate them from
> the clock frequency. Since the clock frequency is unspecified, the
> driver complains loudly using a WARN_ON().
> 
> So revert back to the old situation, where the struct fields for all
> timings are populated, but retain the new logic which chooses the SDA
> hold time from the timing mode that is currently in use.
> 
> Fixes: bd698d24b1b57 ("i2c: designware: Get selected speed mode ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/405553a6/attachment.sig>
