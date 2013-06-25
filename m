From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Jun 2013 22:40:04 -0300
Subject: [patch 1/1] imx53-qsb: enable usb power
In-Reply-To: <CAOMZO5Bk6hBtK1G_jGejAg2+2L+cJqTw-NebKUpVn-6XwBUWxw@mail.gmail.com>
References: <20130620212939.018670789@rtp-net.org>
 <CAOMZO5Bk6hBtK1G_jGejAg2+2L+cJqTw-NebKUpVn-6XwBUWxw@mail.gmail.com>
Message-ID: <CAOMZO5DR6ChNwX8Kqb9mO66-M4xi1G3R8nQ=ENUwrp9k9S8vDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 8:52 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Jun 20, 2013 at 6:29 PM, Arnaud Patard
> <arnaud.patard@rtp-net.org> wrote:
>> Enable usb power pin by using a fixed regulator. With this and the usb clock
>> patch is making usb working on my loco.
>>
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>
> Could you please test this against linux-next?
>
> It does not work for me:
>
> usbcore: registered new interface driver usb-storage
> platform 53f80000.usb: Driver imx_usb requests probe deferral
> platform 53f80200.usb: Driver imx_usb requests probe deferral

Ok, got it working now, but had to do two changes:

- Add a vbus-supply node for usbh1 as suggested by Sascha

- Select CONFIG_NOP_USB_XCEIV. Will send a patch to select it by default.
