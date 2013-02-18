From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 14:38:32 +0900
Subject: [PATCH 2/2 v3] [RFC] ARM: shmobile: r8a7779: Add TMU02 platform
 device
In-Reply-To: <1361147376-1228-3-git-send-email-horms+renesas@verge.net.au>
References: <1361147376-1228-1-git-send-email-horms+renesas@verge.net.au>
 <1361147376-1228-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoQf7O1cGDAUDBAY6xKeor+BA9G22tZcvSEZoVbdurCPxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 9:29 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> This is intended primarily to exercise the TMUO2 clock definition
> in clock-r8a7779.c. I would appreciate review before I queue it up or
> drop it.

Why on earth would you want to queue this up? The TMU driver
interfaces to the Linux kernel as clock event or clock source. We
currently have one channel assigned as clock event, and another as
clock source. Adding more channels does not really improve anything
from a Linux kernel timer handling point of view.

However, say that you for some reason really enjoyed creating new
platform devices then I recommend you to go all the way and hook up
all 9 channels that are provided by the 3-channel TMU blocks TMU0,
TMU1 and TMU2. Usually we stick to two channels though.

Thanks,

/ magnus
