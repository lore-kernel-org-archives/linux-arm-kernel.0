From: hebert.marcandre@gmail.com (=?ISO-8859-1?Q?Marc=2DAndr=E9_H=E9bert?=)
Date: Wed, 4 Jan 2012 07:54:06 -0500
Subject: GPIO matrix and button with single edge IRQ
Message-ID: <CAHEb4-8Xo=w5GuYQzP8X3h_HW8yHG89T+oGRfZJNa652St=YnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

We are developing an i.MX283 custom board. We have a small keypad
matrix and some gpio buttons. After setting up the necessary platform
data, I realized when debugging that it couldn't work because the GPIO
controller does not support dual edge triggers like requested in both
the matrix_keypad and gpio_keys drivers. For gpio_keys there's always
gpio_keys_polled that could be used quickly but that's not quite what
I would need (more like a mix of the 2). For matrix_keypad I don't see
anything that can be used quickly.

Before starting to customize each driver to support single edge IRQs,
I was wondering if this had been encountered on other platforms and if
someone was aware of patches for this.

Thanks
Marc-Andre Hebert
