From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 19 Mar 2015 12:00:02 +0100
Subject: [PATCH v2 2/2] i2c: driver for the Conexant Digicolor I2C
 controller
In-Reply-To: <866aada336ddbeec18749a1c301ab9b365baadde.1426758858.git.baruch@tkos.co.il>
References: <844001df525b3073e50cbd95f357c0eb9912a394.1426758858.git.baruch@tkos.co.il>
 <866aada336ddbeec18749a1c301ab9b365baadde.1426758858.git.baruch@tkos.co.il>
Message-ID: <20150319110002.GD914@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 11:54:18AM +0200, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2:
>    * Address the comment of Wolfram Sang:
>     - Advertise the I2C_FUNC_NOSTART capability
>     - Rebase on v4.0-rc1

Please fix:

Applying: i2c: driver for the Conexant Digicolor I2C controller
    CHECKPATCH
...

ERROR: code indent should use tabs where possible
#119: FILE: drivers/i2c/busses/i2c-digicolor.c:68:
+        STATE_IDLE,$

WARNING: please, no spaces at the start of a line
#119: FILE: drivers/i2c/busses/i2c-digicolor.c:68:
+        STATE_IDLE,$

ERROR: code indent should use tabs where possible
#120: FILE: drivers/i2c/busses/i2c-digicolor.c:69:
+        STATE_START,$

WARNING: please, no spaces at the start of a line
#120: FILE: drivers/i2c/busses/i2c-digicolor.c:69:
+        STATE_START,$

ERROR: code indent should use tabs where possible
#121: FILE: drivers/i2c/busses/i2c-digicolor.c:70:
+        STATE_ADDR,$

WARNING: please, no spaces at the start of a line
#121: FILE: drivers/i2c/busses/i2c-digicolor.c:70:
+        STATE_ADDR,$

ERROR: code indent should use tabs where possible
#122: FILE: drivers/i2c/busses/i2c-digicolor.c:71:
+        STATE_WRITE,$

WARNING: please, no spaces at the start of a line
#122: FILE: drivers/i2c/busses/i2c-digicolor.c:71:
+        STATE_WRITE,$

ERROR: code indent should use tabs where possible
#123: FILE: drivers/i2c/busses/i2c-digicolor.c:72:
+        STATE_READ,$

WARNING: please, no spaces at the start of a line
#123: FILE: drivers/i2c/busses/i2c-digicolor.c:72:
+        STATE_READ,$

ERROR: code indent should use tabs where possible
#124: FILE: drivers/i2c/busses/i2c-digicolor.c:73:
+        STATE_STOP,$

WARNING: please, no spaces at the start of a line
#124: FILE: drivers/i2c/busses/i2c-digicolor.c:73:
+        STATE_STOP,$

CHECK: spaces preferred around that '+' (ctx:VxV)
#160: FILE: drivers/i2c/busses/i2c-digicolor.c:109:
+	bool last = (i2c->msgbuf_ptr+1 == i2c->msg->len);
 	                            ^

WARNING: Missing a blank line after declarations
#161: FILE: drivers/i2c/busses/i2c-digicolor.c:110:
+	bool last = (i2c->msgbuf_ptr+1 == i2c->msg->len);
+	dc_i2c_cmd(i2c, last ? II_CMD_GET_NOACK : II_CMD_GET_ACK);

CHECK: Logical continuations should be on the previous line
#226: FILE: drivers/i2c/busses/i2c-digicolor.c:175:
+	if (cmd_status == II_CMD_STATUS_ACK_BAD
+	    || cmd_status == II_CMD_STATUS_ABORT) {

CHECK: spaces preferred around that '-' (ctx:VxV)
#329: FILE: drivers/i2c/busses/i2c-digicolor.c:278:
+	writeb_relaxed(clocktime-1, i2c->regs + II_CLOCKTIME);
 	                        ^

There are more checkpatch warnings I don't care about much.
You can decide about them.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/2ee17fd3/attachment.sig>
