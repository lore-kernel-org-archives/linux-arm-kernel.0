From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 10 Jan 2013 09:36:47 +0100
Subject: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <20130109111055.GG3931@n2100.arm.linux.org.uk>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
 <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
 <201301091035.23206.arnd@arndb.de>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
Message-ID: <20130110083647.GA26256@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 11:10:55AM +0000, Russell King - ARM Linux wrote:
[...]
>         err = gpio_request(en_vdd_1v05, "EN_VDD_1V05");
>         if (err) {
>                 pr_err("%s: gpio_request failed: %d\n", __func__, err);
>                 return err;
>         }
> 
>         gpio_direction_output(en_vdd_1v05, 1);
> 
>         regulator = regulator_get(NULL, "vdd_ldo0,vddio_pex_clk");
>         if (IS_ERR_OR_NULL(regulator)) {
>                 pr_err("%s: regulator_get failed: %d\n", __func__,
>                        (int)PTR_ERR(regulator));
>                 goto err_reg;
>         }
> ...
> err_reg:
>         gpio_free(en_vdd_1v05);
> 
>         return err;
> }
> 
> So 'err' here is never set.  when IS_ERR_OR_NULL evaluates true.
> Setting 'err' to PTR_ERR(regulator) is not correct because a NULL return
> sets 'err' to zero.

FWIW, this one is fixed in the Tegra PCIe series I posted yesterday.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/a9b222d3/attachment.sig>
