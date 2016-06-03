From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 3 Jun 2016 10:29:40 -0500
Subject: [PATCH v2 1/3] of: add common OF-based component functionality
In-Reply-To: <E1b8pyR-0005OJ-V3@rmk-PC.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyR-0005OJ-V3@rmk-PC.armlinux.org.uk>
Message-ID: <CAL_JsqKaRGk6RMdDWUFYH8_J1gp3pcNeuvx-r=JSg7nc6jh_eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 9:21 AM, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> Add common OF-based component functionality for matching devices by
> device node, and releasing the device node at the appropraite time.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/of/Makefile          |  2 +-
>  drivers/of/of_component.c    | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_component.h | 14 ++++++++++++++

I'd prefer this to go into drivers/base/component.c. That's the
general direction we've been moving.

I'd expect this would cause some build failures unless the cases you
converted all depend on CONFIG_OF.

Rob
