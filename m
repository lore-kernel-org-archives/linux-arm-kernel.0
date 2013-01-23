From: balbi@ti.com (Felipe Balbi)
Date: Wed, 23 Jan 2013 13:47:25 +0200
Subject: [V4 PATCH 18/26] usb: phy: mv_usb2_phy: add externel chip support
In-Reply-To: <CADApbeghH7EdQaz7PP-pPK4huhxJ0OrLDEGTHBg4s0+3SQbRoA@mail.gmail.com>
References: <xiechao.mail@gmail.com>
 <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
 <1358762864-9249-19-git-send-email-chao.xie@marvell.com>
 <20130121155156.GM23505@n2100.arm.linux.org.uk>
 <CADApbeghH7EdQaz7PP-pPK4huhxJ0OrLDEGTHBg4s0+3SQbRoA@mail.gmail.com>
Message-ID: <20130123114725.GH29258@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 22, 2013 at 10:51:32AM +0800, Chao Xie wrote:
> On Mon, Jan 21, 2013 at 11:51 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jan 21, 2013 at 05:07:36AM -0500, Chao Xie wrote:
> >> +     mv_phy->extern_chip.head = devm_kzalloc(&pdev->dev,
> >> +                                     sizeof(*mv_phy->extern_chip.head),
> >> +                                     GFP_KERNEL);
> >> +     if (mv_phy->extern_chip.head == NULL)
> >> +             return -ENOMEM;
> >> +     ATOMIC_INIT_NOTIFIER_HEAD(mv_phy->extern_chip.head);
> >
> > Why do you need to allocate an atomic notifier list head as an entirely
> > separate data structure?
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Th reason is that the original code seperate the extern_chip and phy
> support. So it depends
> on the ->head to detect whether extern_chip is initialized or not.
> Now it is combined with phy, the ->phy pointer can do the job.

does that need to be dynamically allocated ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/36addcdc/attachment.sig>
