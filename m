From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 21 Aug 2014 10:05:12 -0700
Subject: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
In-Reply-To: <1408636935-29515-3-git-send-email-nm@ti.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
 <1408636935-29515-1-git-send-email-nm@ti.com>
 <1408636935-29515-3-git-send-email-nm@ti.com>
Message-ID: <20140821170512.GA3796@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On Thu, Aug 21, 2014 at 11:02:15AM -0500, Nishanth Menon wrote:
> +
> +	ret = input_register_device(input_dev);
> +	if (ret) {
> +		free_irq(irq, pwron);

You can not use free_irq with devm-managed resources. As I mentioned, since you
need manual unwinding, I'd rather you not use managed resources in the driver
at all.

> +		cancel_delayed_work_sync(&pwron->input_work);
> +		dev_dbg(dev, "Can't register power button: %d\n", ret);
> +		return ret;

Thanks.

-- 
Dmitry
