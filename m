From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Sep 2014 20:56:12 -0500
Subject: [PATCH/RESEND] tty: serial: msm: Add DT based earlycon support
In-Reply-To: <1410473644-19103-1-git-send-email-sboyd@codeaurora.org>
References: <1410473644-19103-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAL_JsqLtx9+P1-O+gVRRhpjntHuNQZp4ASV8ScBhZB7gWDsGFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 5:14 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Add support for DT based early console on platforms with the msm
> serial hardware.
>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

One comment, but looks good to me.

Acked-by: Rob Herring <robh@kernel.org>

> +static int __init
> +msm_serial_early_console_setup(struct earlycon_device *device, const char *opt)
> +{
> +       if (!device->port.membase)
> +               return -ENODEV;
> +
> +       device->con->write = msm_serial_early_write;
> +       return 0;
> +}
> +OF_EARLYCON_DECLARE(msm_serial, "qcom,msm-uart",
> +                   msm_serial_early_console_setup);

Don't you want to support kernel command line as well? Then if you
can't change the DT or bootloader's command line, you can add it into
the kernel build with the appended command line. Don't forget to
document it in kernel-parameters.txt if you do.

Rob
