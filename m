From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jan 2013 13:02:32 +0100
Subject: [PATCH] gpio: vt8500: memory cleanup missing
In-Reply-To: <20130110105710.GA19944@n2100.arm.linux.org.uk>
References: <1357163240-23131-1-git-send-email-linux@prisktech.co.nz>
 <20130110105710.GA19944@n2100.arm.linux.org.uk>
Message-ID: <CACRpkda+1MqPp-KBe5w+pTeHChE0Daa+U97dO+d1Px_Ssi_vHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 11:57 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 03, 2013 at 10:47:20AM +1300, Tony Prisk wrote:

>> +static int vt8500_gpio_remove(struct platform_device *pdev)
>> +{
>> +     int i;
>> +     int ret;
>> +     const struct vt8500_gpio_data *data;
>> +     void __iomem *gpio_base = vtchip[0].base;
>> +     const struct of_device_id *of_id =
>> +                             of_match_device(vt8500_gpio_dt_ids, &pdev->dev);
>> +
>
> You can get at the vtchip pointer if you put it into the platform device's
> driver data pointer.  That way, you're not artificially limiting this
> driver to just one device, and, with your changes it will go wrong if DT
> ever lists more than one device.

Good point, I'm sloppy today :-(

Patch dropped.

Tony pls proceed as indicated by Russell.

Yours,
Linus Walleij
