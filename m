From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jul 2013 21:15:12 -0300
Subject: [PATCH v2 6/8] usb: host: ohci-s3c2410 Use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1374536965-3545-7-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <1374536965-3545-7-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CAOMZO5D4X+GT+LdUOjorJ8xgBCwv9iAP4W-RzKrbnE-93kxmUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 8:49 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

>         dev_dbg(&dev->dev, "s3c2410_start_hc:\n");
>
> -       clk_enable(usb_clk);
> +       clk_prepare_enable(usb_clk);

 clk_prepare_enable may fail, so you would better check its return value.
