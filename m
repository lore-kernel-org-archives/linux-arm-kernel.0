From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 11:10:58 +0200
Subject: [PATCH 27/32] gpio: Add support for the FXL6408 GPIO expander.
In-Reply-To: <1464817421-8519-28-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-28-git-send-email-kraxel@redhat.com>
Message-ID: <CACRpkdax3AmnprT48zL7J92ddMvLYeRXi9OrQK_JrBT8_zZQoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 11:43 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:

> +#define FXL6408_OUTPUT                 0x05
> +/* Bits here make the output High-Z, instead of the OUTPUT value. */
> +#define FXL6408_OUTPUT_HIGH_Z          0x07
(...)
> +       /* Disable High-Z of outputs, so that our OUTPUT updates
> +        * actually take effect.
> +        */
> +       i2c_smbus_write_byte_data(client, FXL6408_OUTPUT_HIGH_Z, 0);

High-Z is probably the same as open drain right? And if not open drain,
it is push-pull.

So you want to implement .set_single_ended() for configuring the lines in
"high-z", i.e. open drain output mode.

Yours,
Linus Walleij
