From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 10:24:30 +0100
Subject: [PATCH v3 1/3] mfd: tps6586x: add version detection
In-Reply-To: <77384d24810d9a22fc04cad6f7468f54a9cbaafe.1386100296.git.stefan@agner.ch>
References: <cover.1386100296.git.stefan@agner.ch>
 <77384d24810d9a22fc04cad6f7468f54a9cbaafe.1386100296.git.stefan@agner.ch>
Message-ID: <20131204092429.GM19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 08:57:27PM +0100, Stefan Agner wrote:
> Use the VERSIONCRC to determine the exact device version. According to
> the datasheet this register can be used as device identifier. The
> identification is needed since some tps6586x regulators use a different
> voltage table.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Since the struct tps6586x is inside the c file, I could not easily
> move the tps6586x_get_version function as inline to the header file.
> 
> Changes since v2:
>   - Avoid moving devm_kzalloc
> ---
>  drivers/mfd/tps6586x.c       | 43 ++++++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/tps6586x.h |  7 +++++++
>  2 files changed, 45 insertions(+), 5 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/b0e3f037/attachment.sig>
