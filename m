From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 May 2017 10:36:21 +0200
Subject: [PATCH] i2c: designware: Fix bogus sda_hold_time due to
 uninitialized vars
In-Reply-To: <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
 <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Message-ID: <20170522083621.upovyjqo56ywqdrl@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 07:46:55AM +0200, Jan Kiszka wrote:
> We need to initializes those variables to 0 for platforms that do not
> provide ACPI parameters. Otherwise, we set sda_hold_time to random
> values, breaking e.g. Galileo and IOT2000 boards.
> 
> Fixes: 9d6408433019 ("i2c: designware: don't infer timings described by ACPI from clock rate")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/312b1807/attachment.sig>
