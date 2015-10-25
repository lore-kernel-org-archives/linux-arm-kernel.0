From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 25 Oct 2015 10:52:00 +0100
Subject: [PATCH-RESEND 0/3] i2c: core/pxa: Add support for hardware lock
In-Reply-To: <1433270731-23790-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1433270731-23790-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20151025095200.GE2159@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 12:15:28AM +0530, Vaibhav Hiremath wrote:
> To justify the need for hardware lock, lets take a real usecase scenario -
>     
> In case of Marvell SoC, PXA910 silicon, both AP and CP are present and
> these two ARM cores are sharing one pair of I2C pins.
>     
> In order to keep I2C transaction operated with atomic, hardware lock
> (RIPC) is required.
>     
> This patch extends support for atomic operation by adding hardware lock support
> to the i2c-core.
> 
> PATCH[1/3] : Core changes for hardware lock
> PATCH[2/3 & 3/3] : hardware lock support to i2c-pxa bus driver.

Why don't you use the hwspinlock subsystem?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/c8731197/attachment.sig>
