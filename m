From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Jan 2012 13:29:17 +0100
Subject: [PATCH] mach-u300: do away with MMC config files
In-Reply-To: <20120120110923.GI1068@n2100.arm.linux.org.uk>
References: <1327057220-8300-1-git-send-email-linus.walleij@stericsson.com>
 <20120120110923.GI1068@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZCQm6WcEWw3d8M2j9AikGhhX+off9pVT04Ps2hJPqkpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 12:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 20, 2012 at 12:00:20PM +0100, Linus Walleij wrote:
>> ?static struct amba_device mmcsd_device = {
>> ? ? ? .dev = {
>> ? ? ? ? ? ? ? .init_name = "mmci", /* Fast device at 0x1000 offset */
>> - ? ? ? ? ? ? .platform_data = NULL, /* Added later */
>> + ? ? ? ? ? ? .platform_data = &mmcsd_platform_data,
>
> This will certainly conflict with the set of AMBA/Primecell patches
> I've just posted... the equivalent change is:
>
> ?static AMBA_APB_DEVICE(mmcsd, "mmci", 0, U300_MMCSD_BASE,
> - ? ? ? U300_MMCSD_IRQS, NULL);
> + ? ? ? U300_MMCSD_IRQS, &mmcsd_platform_data);

OK I will wait for your stuff to hit -next and then rebase it and
put it in the patch tracker for a conflict-free path to mainline.

Yours,
Linus Walleij
