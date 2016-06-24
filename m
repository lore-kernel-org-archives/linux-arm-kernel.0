From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Jun 2016 11:12:30 -0500
Subject: [PATCH v2 1/2] can: rcar_canfd: Add Classical CAN only mode
 support
In-Reply-To: <1466598707-44076-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466598707-44076-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <20160624161230.GA21437@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 01:31:46PM +0100, Ramesh Shanmugasundaram wrote:
> The controller can operate in one of the two global modes
>  - CAN FD only mode (default)
>  - Classical CAN (CAN2.0) only mode
> 
> This patch adds support for Classical CAN only mode. It can be enabled
> by defining the optional device tree property "renesas,no-can-fd" of this
> node.
> 
> Note: R-Car Gen3 h/w manual v0.51E shows bit6 of RSCFDnCFDGCFG as
> reserved, which is incorrect. This bit is same as RSCFDnGCFG.
> 
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
>  .../devicetree/bindings/net/can/rcar_canfd.txt     |  21 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/net/can/rcar/rcar_canfd.c                  | 355 ++++++++++++++-------
>  2 files changed, 255 insertions(+), 121 deletions(-)
