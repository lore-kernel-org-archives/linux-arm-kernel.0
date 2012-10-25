From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 15:39:27 +0300
Subject: [PATCH v2 3/7] i2c: omap: also complete() when stat becomes zero
In-Reply-To: <508933E4.7070608@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-4-git-send-email-balbi@ti.com>
 <508933E4.7070608@ti.com>
Message-ID: <20121025123927.GY21217@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 06:13:16PM +0530, Santosh Shilimkar wrote:
> On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> >In case we loop on IRQ handler until stat is
> >finally zero, we would end up in a situation
> >where all I2C transfers would misteriously
> >timeout because we were not calling complete()
> >in that situation.
> >
> >Fix the issue by moving omap_i2c_complete_cmd()
> >call inside the 'out' label.
> >
> >Signed-off-by: Felipe Balbi <balbi@ti.com>
> >---
> Looks fine. Have you hit this issue in any corner case ?

in fact, yes. With a difficult to reproduce situation with drv2665 (one
of TI's piezo drivers) I saw that I was missing the ack and all
transfers were timing out ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/53259a9f/attachment.sig>
