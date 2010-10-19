From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 19 Oct 2010 23:02:37 +0200
Subject: [PATCH 3/3] omap: add hwspinlock device
In-Reply-To: <87r5fmxghm.fsf@deeprootsystems.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-4-git-send-email-ohad@wizery.com>
	<87r5fmxghm.fsf@deeprootsystems.com>
Message-ID: <AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 7:03 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> +postcore_initcall(hwspinlocks_init);
>
> Any reason this needs to be a postcore_initcall? ?Are there users of
> hwspinlocks this early in boot?

i2c-omap, which is subsys_initcall (the I2C bus is shared between the
A9 and the M3 on some OMAP4 boards).

And to allow early board code to reserve specific hwspinlock numbers
for predefined use-cases, we probably want to be before arch_initcall.

> The I2C  ?Probaly subsys or even device_initcall
> is more appropriate here.
>
> I would've suspected that any users of hwspinlocks will be dependent on
> drivers for the other cores (e.g. syslink) which would likely be
> initialized much later.
>
> Kevin
>
