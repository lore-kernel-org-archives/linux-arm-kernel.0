From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Sep 2018 18:18:53 -0700
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <1533318808-10781-4-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
Message-ID: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
>
> Add ZynqMP firmware IOCTL API to control and configure
> devices like PLLs, SD, Gem, etc.
>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>

This patch worries me somewhat. It's a transparent pass-through ioctl
driver. Is there a spec available for what the implemented IOCTLs are?

Should some of them be proper drivers instead of an opaque
pass-through like this? Could some of them have stability impact on
the platform such that there are security concerns and the list of
arguments should somehow be sanitized?

What's the intended usecase anyway? Just a debug tool during
development, or something that you expect heavy use of by some
userspace middleware?


-Olof
