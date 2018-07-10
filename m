From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 10 Jul 2018 17:49:26 +0200
Subject: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
In-Reply-To: <20180702114033.15654-4-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
Message-ID: <20180710154926.GB8492@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:40:28PM +0300, Mikko Perttunen wrote:
> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
> send_data function of the mailbox driver is expected to block until
> the message has been sent. The new option is used with the Tegra
> Combined UART driver to minimize unnecessary overhead when transmitting
> data.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mailbox/mailbox.c | 30 +++++++++++++++++++++---------
>  drivers/mailbox/mailbox.h |  1 +
>  2 files changed, 22 insertions(+), 9 deletions(-)

Jassi,

any comments on this patch and 4/8 and 5/8? Greg's already said that
he'd be fine if I take the serial driver (patch 6/8) through the Tegra
tree to resolve the dependencies. If you're okay with the three mailbox
patches I can pick them up as well with your Acked-by.

Otherwise, if you'd prefer to take these through the mailbox tree, let
me know and I'll wait until sometime after v4.19-rc1 before I send out
pull requests for the DT changes.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/b0ca31a4/attachment.sig>
