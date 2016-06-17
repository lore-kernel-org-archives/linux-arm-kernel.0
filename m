From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 17 Jun 2016 13:56:11 +0200
Subject: [PATCH v10 0/8] add i2c driver supported for rk3399
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20160617115611.GC6876@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 09:57:35PM +0800, David Wu wrote:
> There are three points differert from others:
>  - new method to caculate i2c timings for rk3399
>  - pclk and function clk are separated at rk3399
>  - add fast-plus mode supported for rk3399
> 
> David Wu (8):
>   i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
>   i2c: rk3x: use struct "rk3x_i2c_calced_timings"
>   i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
>   i2c: rk3x: Change SoC data to not use array
>   i2c: rk3x: Move spec timing data to "static const" structs
>   dt-bindings: i2c: rk3x: add support for rk3399
>   i2c: rk3x: add i2c support for rk3399 soc
>   i2c: rk3x: support fast-mode plus for rk3399
> 
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-

Applied whole series to for-next, thanks! This was nicely refactored and
easy to review, thanks. Also thanks to all reviewers who helped this
series. I fixed one checkpatch issue for you, though:

WARNING: Statements should start on a tabstop
#278: FILE: drivers/i2c/busses/i2c-rk3x.c:789:
+	 if (min_div_for_hold >= min_total_div) {

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/7db97d4c/attachment.sig>
