From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 6 Apr 2016 09:35:49 +0200
Subject: [PATCH 5/9] iio: accel: mma7455: use regmap to retrieve struct
 device
In-Reply-To: <acaeee6c3c1f99900614baf99ab31e6e5b515970.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
 <acaeee6c3c1f99900614baf99ab31e6e5b515970.1459918214.git.amsfield22@gmail.com>
Message-ID: <CAGhQ9VxnwX6n6PfOFAhYSPfP7eAA+YFLjTcJf+Ay60R8sHV_Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison,

On 6 April 2016 at 07:18, Alison Schofield <amsfield22@gmail.com> wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
>
> Patch created using Coccinelle plus manual edits.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> ---
>  drivers/iio/accel/mma7455_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
> index c633cc2..c902f54 100644
> --- a/drivers/iio/accel/mma7455_core.c
> +++ b/drivers/iio/accel/mma7455_core.c
> @@ -55,11 +55,11 @@
>
>  struct mma7455_data {
>         struct regmap *regmap;
> -       struct device *dev;
>  };
>
>  static int mma7455_drdy(struct mma7455_data *mma7455)
>  {
> +       struct device *dev = regmap_get_device(mma7455->regmap);

ah, nice!

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
