From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Nov 2013 21:00:34 -0600
Subject: [PATCH 00/13] mfd: menelaus: a few cleanups
In-Reply-To: <20131127204621.GI24645@blackmetal.musicnaut.iki.fi>
References: <1385579217-20127-1-git-send-email-balbi@ti.com>
 <20131127200247.GH24645@blackmetal.musicnaut.iki.fi>
 <20131127201149.GB20734@saruman.home>
 <20131127204621.GI24645@blackmetal.musicnaut.iki.fi>
Message-ID: <20131128030033.GA15444@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 27, 2013 at 10:46:21PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Nov 27, 2013 at 02:11:49PM -0600, Felipe Balbi wrote:
> > On Wed, Nov 27, 2013 at 10:02:47PM +0200, Aaro Koskinen wrote:
> > > On Wed, Nov 27, 2013 at 01:06:44PM -0600, Felipe Balbi wrote:
> > > > few cleanups on the old menelaus driver. I don't have
> > > > HW to test these patches, maybe Aaro can help here ?
> > > 
> > > Hmm, I got:
> > > 
> > > [    1.330000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > > [    1.340000] pgd = c0004000
> > > [    1.340000] [00000000] *pgd=00000000
> > > [    1.350000] Internal error: Oops: 17 [#1] ARM
> > > [    1.350000] CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.0-rc1-n8x0_tiny-los.git-729021f-00018-g74a0f39 #2
> > > [    1.350000] task: c782c000 ti: c782e000 task.ti: c782e000
> > > [    1.350000] PC is at mutex_lock+0x0/0x20
> > > [    1.350000] LR is at __irq_get_desc_lock+0x6c/0x88
> [...]
> > > [    1.350000] [<c016745c>] (mutex_lock+0x0/0x20) from [<c00509ac>] (__irq_get_desc_lock+0x6c/0x88)
> > > [    1.350000] [<c00509ac>] (__irq_get_desc_lock+0x6c/0x88) from [<c0053518>] (__irq_set_handler+0x24/0x128)
> > > [    1.350000] [<c0053518>] (__irq_set_handler+0x24/0x128) from [<c013ec80>] (menelaus_probe+0xbc/0x280)
> > > [    1.350000] [<c013ec80>] (menelaus_probe+0xbc/0x280) from [<c0140ab8>] (i2c_device_probe+0x98/0xc0)
> 
> [...]
> 
> > hmm, irq_set_chip_and_handler() will call back into the irq_chip we just
> > registered, so my ->irq_bus_lock needs to have everything setup
> > (chip_data my mutex), this should solve it:
> 
> Yes, that fixes it. Seems to work fine now.

Awesome, should I add your tested-by ? I also added a few extra patches
on top which I'll send soon.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/7506067c/attachment.sig>
