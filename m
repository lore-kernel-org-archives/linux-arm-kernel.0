From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 24 Nov 2010 22:14:31 +0800
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <4CED1C95.8070300@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
Message-ID: <AANLkTimxjiYkbaHUzq_V-s9WWytgbpNSo8xe8V_Lm6uF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 10:09 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Haojian Zhuang wrote:
>>
>> Hi Sebastian,
>
> Hi Hoajian,
>
>> Actually it's added for cpufreq usage. We can check the commit in below.
>>
>> ? ?pxa2xx_spi: register earlier
>>
>> ? ?Register pxa2xx_spi earlier so it can be used with cpufreq
>>
>> So I think that this modifcation may cause others brokne.
>
> I've been pointed out to this commit but I don't understand _why_.
> The part I don't get is "so it can be used with cpufreq". Is it
> refered to a driver or the subsystem as it?
>

As we know, cpufreq is used to adjust frequency and voltage of CPU. We
need some interface to access PMIC hardware, such as I2C, SPI, .... So
I think that they need SPI to initialize first. Otherwise, they may
meet failure on accessing PMIC hardware.

Thanks
Haojian
