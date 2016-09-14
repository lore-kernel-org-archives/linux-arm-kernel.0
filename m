From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Sep 2016 10:52:39 +0200
Subject: [PATCH 18/33] pcmcia: sa1100: provide generic CF support
In-Reply-To: <E1beJl3-0000nS-Nw@rmk-PC.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJl3-0000nS-Nw@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkda7qHx4JVdVv+q3=twTup9rDD2ke8K-tSH9CkhZMQqemg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:25 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Provide generic non-voltage sensing socket support for StrongARM
> platforms using the gpiolib and regulator subsystems to obtain the
> resources to control the socket.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
(...)

> +static int sa11x0_drv_pcmcia_probe(struct platform_device *pdev)
> +{
> +       struct soc_pcmcia_socket *skt;
> +       struct device *dev = &pdev->dev;
> +
> +       if (dev->id == -1)
> +               return sa11x0_drv_pcmcia_legacy_probe(pdev);

There is a typo there, it should be pdev->id rather than dev->id.

After fixing this, my legacy h3600 PCMCIA started probing again.

(It revealed another bug in fetching GPIOs but it is an orthogobal
problem altogether, looking into it.)

Yours,
Linus Walleij
