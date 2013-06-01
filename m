From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 1 Jun 2013 11:58:18 -0300
Subject: [PATCH v2 2/2] ARM: mxs: Pass the system revision
In-Reply-To: <3068502.pO6ZTjjROM@kerker>
References: <1370040127-15072-1-git-send-email-festevam@gmail.com>
 <1370040127-15072-2-git-send-email-festevam@gmail.com>
 <3068502.pO6ZTjjROM@kerker>
Message-ID: <CAOMZO5DqQXDbHEdD+SMtQLkAVrx0AffDL46=JoiqFnc_-6wTFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sat, Jun 1, 2013 at 9:19 AM, Michael Heimpold <mhei@heimpold.de> wrote:

> I think it would be difficult to use system_rev for this purpose as some
> boards I know about are using this field to pass a board/PCB revision from
> U-Boot to the kernel.

Can you please provide some real examples?

For mx28 I see no boards passing ATAGS from bootloader to the kernel.

If you look at FSL kernel code the system revision is hardcoded in the
board file.

For mx5/mx6 boards we do pass ATAGS from bootloader to kernel in the
same format it was used here.

For example: on mx53 it will be 0x53112 (where 0x53 means mx53, 1 is
the board revision and 12 means TO1.2)

> After spending a short look through documentation in kernel and U-Boot
> I did not find any hint whether this was the indended usage of this field.
>
> I would rather argue about introducing a new line
> "SoC revision: ..." as this is the revision you want to pass to user-space.
>
> The lines "Revision" and "Serial" should IMHO left
> alone for usage by board vendors.

As I mentioned in the commit log, the only reason we are doing this
here is to allow a mainline kernel to run som mxs applications like
Gstreamer plugins and kobs-ng.

Regards,

Fabio Estevam
