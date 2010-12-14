From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 14 Dec 2010 17:26:22 +0100
Subject: ulpi_check_integrity returning error
In-Reply-To: <AANLkTimUSdV-0L+BSLumTJCDeFOgYNhw6azLjWuK4uX6@mail.gmail.com>
	(Fabio Estevam's message of "Tue, 14 Dec 2010 14:16:32 -0200")
References: <AANLkTinxLr10X-EBGQHdhC5JyxbJOqcUz_+UMOCo+OFA@mail.gmail.com>
	<4D076E49.3020805@compulab.co.il>
	<AANLkTintiOa5mhcF_viNCzC5q1EEHjgTLHhYsJc5Un-5@mail.gmail.com>
	<87d3p4e6r1.fsf@lechat.rtp-net.org>
	<AANLkTimUSdV-0L+BSLumTJCDeFOgYNhw6azLjWuK4uX6@mail.gmail.com>
Message-ID: <877hfce2xd.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:

> On Tue, Dec 14, 2010 at 1:03 PM, Arnaud Patard
> <arnaud.patard@rtp-net.org> wrote:
> ...
>>> I am curious to know if any of this boards can work in host mode OTG
>>> with current mainline kernel.
>>
>> I guess you need to configure portsc register into ulpi mode in the
>> .init function of the mxc_usbh_platform_data otherwise, you won't be
>> able to reach the ulpi.
>
> Yes, I am configuring the portsc register into ULPI mode:
>
> .portsc	= MXC_EHCI_MODE_ULPI,
>
> Code does reach ulpi read/write functions in arch/arm/plat-mxc/ulpi.c,
> but always return 0 in the reads.

Please, read again what I said. I'm not talking of .portsc but of
.init. To reach the ulpi, the portsc register should be set to ulpi mode
_before_ calling otg_init() in ehci_mxc_drv_probe() but the code is using
.portsc/setting portsc in ehci_mxc_setup() which is afaik _after_
ehci_mxc_drv_probe().


Arnaud
