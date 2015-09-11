From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 11 Sep 2015 20:53:12 +0200
Subject: [PATCH-v5 RESEND 2/5] i2c: pxa: enable/disable i2c module across
 msg xfer
In-Reply-To: <1440395978-9065-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150911185312.GA1516@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:29:35AM +0530, Vaibhav Hiremath wrote:
> From: Yi Zhang <yizhang@marvell.com>
> 
> Enable i2c module/unit before transmission and disable when it
> finishes.
> 
> why?
> It's because the i2c bus may be disturbed if the slave device,
> typically a touch, powers on.

I am not convinced, "may disturb" is too weak for me. It would need a
way more detailed description of the problem which makes clear that
this mechanism is the only way to go forward.

Can't you use Runtime PM for that?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/9527ea2d/attachment.sig>
