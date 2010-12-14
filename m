From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Dec 2010 20:17:21 -0200
Subject: ulpi_check_integrity returning error
In-Reply-To: <877hfce2xd.fsf@lechat.rtp-net.org>
References: <AANLkTinxLr10X-EBGQHdhC5JyxbJOqcUz_+UMOCo+OFA@mail.gmail.com>
	<4D076E49.3020805@compulab.co.il>
	<AANLkTintiOa5mhcF_viNCzC5q1EEHjgTLHhYsJc5Un-5@mail.gmail.com>
	<87d3p4e6r1.fsf@lechat.rtp-net.org>
	<AANLkTimUSdV-0L+BSLumTJCDeFOgYNhw6azLjWuK4uX6@mail.gmail.com>
	<877hfce2xd.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTikjJ9y=t6=3RHtt+NF8SQbGdTkZfSfpi_L-61ex@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Tue, Dec 14, 2010 at 2:26 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
...
>
> Please, read again what I said. I'm not talking of .portsc but of
> .init. To reach the ulpi, the portsc register should be set to ulpi mode
> _before_ calling otg_init() in ehci_mxc_drv_probe() but the code is using
> .portsc/setting portsc in ehci_mxc_setup() which is afaik _after_
> ehci_mxc_drv_probe().

Ok, I understand what you mean now and I confirmed what you said:
current code is setting the portsc register after writing to the OTG
viewport.

The MX31 is by default configured for a USB serial phy, so like you
stated we need first to setup portsc to work in ULPI mode and after
that we can read/write the OTG viewport.

Thanks,

Fabio Estevam
