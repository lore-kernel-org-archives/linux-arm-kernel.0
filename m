From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Thu, 28 Apr 2011 22:16:43 +0200
Subject: [PATCH v2] pxa/hx4700: use gpio arrays for global gpio
	initialization
In-Reply-To: <20110428090528.GN17290@n2100.arm.linux.org.uk>
References: <1303329317.21545.5.camel@flow> <20110421150226.GA10052@rainbow>
	<1303930220.14964.8.camel@flow>
	<20110428090528.GN17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTim-9PpQCc3oy05-pc5SCyc=nNuw+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 11:05 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 27, 2011 at 08:50:19PM +0200, Philipp Zabel wrote:
>> - ? ? hx4700_gpio_request(ARRAY_AND_SIZE(global_gpios));
>> + ? ? ret = gpio_request_array(ARRAY_AND_SIZE(global_gpios));
>> + ? ? if (ret)
>> + ? ? ? ? ? ? pr_err ("hx4700: Failed to request GPIOs.\n");
>
> No space between pr_err and (.

checkpatch issue. Sorry about that.

> Does the return code convey useful information as to _why_ it failed? ?If
> yes, you really should print its value. ?Knowing whether it's -EBUSY
> (eg, already in use) instead of -EINVAL (eg, invalid GPIO number) really
> helps to debug problems.

Yes, it does. It is certainly better to include the error code.
Recompiling with DEBUG_GPIO enabled might still be necessary to get
information about which GPIO failed, and whether -EINVAL was returned
by gpio_request() or gpio_direction_input/output().

regards
Philipp
