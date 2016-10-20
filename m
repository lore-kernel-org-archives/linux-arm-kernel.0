From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 20 Oct 2016 13:21:47 +0300
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <6c6fcceb-c6f2-219d-492a-a8b38fd83093@ti.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
 <65fde145-0820-794d-d345-621f66cdacc0@ti.com>
 <7a2ffcd0-fe1d-c887-53b7-7cb5e1e61222@ti.com> <4975084.EGQPv58AK6@avalon>
 <daf49046-ad0a-d9e2-d744-1e06085c6585@ti.com>
 <CAMpxmJXT8hcSc0-svbwAq5r_JOFsYV852gtE0vuXL8hHykXnRQ@mail.gmail.com>
 <6c6fcceb-c6f2-219d-492a-a8b38fd83093@ti.com>
Message-ID: <bb7bac91-8eb1-fe23-ca9c-857e0fda6ecd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/16 13:07, Sekhar Nori wrote:

> Per me, compatible property is an ordered list precisely for the reason
> that things should continue to "work" with as closely matched driver as
> possible. So even if someone is running a kernel which does not
> recognize "ti,da850-tilcdc", it should still be able to probe the driver
> based on "ti,am33xx-tilcdc" and provide as close to full functionality
> as possible.
> 
> That said, I will not insist on keeping it around if Tomi is
> uncomfortable. And having read the binding documentation accepted by
> Jyri, it actually says the compatible property should be __one of__
> "ti,am33xx-tilcdc" or "ti,da850-tilcdc".

Well, they are just not compatible as far as I know. If the LCDC on
DA850 would be identified as AM335x LCDC, and used as such, it would not
work at all. They have different registers, AM335x LCDC has registers
that do not exist on DA850.

With our driver it happens to work, because the driver looks at the IP
revision in the registers, and then decides that this IP is not AM335x
LCDC even if the dts says so. But I see that as a driver "feature",
nothing that the .dts can depend on.

Perhaps it might work the other way around, using DA850 driver on
AM335x, as DA850 LCDC is a kind of subset of AM335x LCDC. But I'm not
sure even about that.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/b0a52fc5/attachment.sig>
