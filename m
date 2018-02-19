From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 12:29:24 -0600
Subject: [PATCH v3 4/5] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
In-Reply-To: <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
 <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
Message-ID: <CAL_JsqJgo0pKJjrs2fdw+q=DJYwht0X5L3Bomz8gf98mEN7hkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 5:28 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> The MediaTek audio hardware block that exposes functionalities that are
> handled by separate subsystems in the kernel.  These functions are all
> mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
> up with other functions within the same registers.

I still don't think this change is necessary.

Just because a hardware block in DT maps to different subsystems in a
particular OS doesn't mean you need a DT node for each OS subsystem.
What we have subsystems for changes over time and DT shouldn't really
be changing based on that. And DT is not the only way to instantiate
drivers.

Rob
