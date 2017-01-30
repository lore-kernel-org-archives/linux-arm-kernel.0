From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jan 2017 08:10:20 +0100
Subject: [PATCH] pwm - Fix possible NULL derefrence.
In-Reply-To: <1485751953-29341-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130045241epcas1p2a5a0625327e4caab59236ec85551f95e@epcas1p2.samsung.com>
 <1485751953-29341-1-git-send-email-shailendra.v@samsung.com>
Message-ID: <20170130071020.GE3585@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 10:22:33AM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/pwm/pwm-sun4i.c |    4 ++++
>  drivers/pwm/pwm-tegra.c |    5 +++++
>  2 files changed, 9 insertions(+)

Both of these drivers will only run on purely OF systems, so this check
is unnecessary.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/cf76abbe/attachment.sig>
