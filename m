From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 20 Jun 2018 00:36:46 +0300
Subject: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded name
In-Reply-To: <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 2:08 PM, Radhey Shyam Pandey
<radhey.shyam.pandey@xilinx.com> wrote:
> Switch hardcoded function name with a reference to __func__ making
> the code more maintainable. Address below checkpatch warning:
>
> WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
> this function's name, in a string
> +               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
>
> WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
> this function's name, in a string
> +               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
>

For dev_dbg() the __func__ should be completely dropped away.

-- 
With Best Regards,
Andy Shevchenko
