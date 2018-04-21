From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 21 Apr 2018 18:23:33 +0200
Subject: [PATCH 10/61] gpio: simplify getting .drvdata
In-Reply-To: <34f4679f-d306-073b-eae0-28c9e8965780@xilinx.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <34f4679f-d306-073b-eae0-28c9e8965780@xilinx.com>
Message-ID: <20180421162333.d4jtidmbxrx76k4x@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Thanks for the reviews!

> There are two more occurences in this gpio-zynq driver.
> zynq_gpio_resume, zynq_gpio_suspend. It wasn't detected because these
> two lines are not together. But the same change can be applied for them too.

Not really. The rule would have matched if there was just "something"
inbetween. It did not match because the "something" involves the
variable 'pdev', so we can't remove it. And just changing towards
'dev_get_drvdata' and keeping 'pdev' was not worth the hazzle in my
book. Especially since I think the code should probably get refactored.
Calling platform_get_irq() in suspend/resume paths in order to get the
irq_data looks a little expensive to me, but I haven't tested it.

Best wishes,

   Wolfram

PS: Please quote only relevant parts of the message, it is a lot easier
to find comments then IMO.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180421/58d80d4b/attachment.sig>
