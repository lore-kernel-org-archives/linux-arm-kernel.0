From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 28 Mar 2018 00:33:15 +0200
Subject: [PATCH v1] pwm: mediatek: improve precision in rate calculation
In-Reply-To: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
References: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
Message-ID: <20180327223314.GH28163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 04:49:14PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add a way that turning resolution from in nanosecond into in picosecond
> to improve noticeably almost 4.5% precision.
> 
> It's necessary to hold the new resolution with type u64 and thus related
> operations on u64 are applied instead in those rate calculations.
> 
> And the patch has a dependency on [1].
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012225.html
> 
> Cc: stable at vger.kernel.org
> Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/f2ff269c/attachment.sig>
