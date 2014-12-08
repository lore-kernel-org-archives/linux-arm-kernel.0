From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Dec 2014 13:10:39 -0200
Subject: [PATCH 4/5] media: ov2640: add a master clock for sensor
In-Reply-To: <1418038147-13221-5-git-send-email-josh.wu@atmel.com>
References: <1418038147-13221-1-git-send-email-josh.wu@atmel.com>
 <1418038147-13221-5-git-send-email-josh.wu@atmel.com>
Message-ID: <CAOMZO5ASNUCz908esJ3iTQ6VEQGeNi-HOmqMOf12c633Q8pavw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 8, 2014 at 9:29 AM, Josh Wu <josh.wu@atmel.com> wrote:

> +       priv->master_clk = devm_clk_get(&client->dev, "xvclk");
> +       if (IS_ERR(priv->master_clk))
> +               return -EINVAL;

You should return PTR_ERR(priv->master_clk) instead.
