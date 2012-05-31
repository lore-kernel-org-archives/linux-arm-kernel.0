From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:51:14 +0800
Subject: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
In-Reply-To: <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
References: <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
Message-ID: <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini <rubini@gnudd.com> wrote:

> The i2c-nomadik gateware is really a PrimeCell APB device. By hosting
> the driver under the amba bus we can access it more easily, for
> example using the generic pci-amba driver. The patch also fixes the
> mach-ux500 users to register an AMBA device, not a platform device.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: STEricsson_nomadik_linux at list.st.com
> Cc: Linus Walleij <linus.walleij@stericsson.com>

This will affect Lee Jones' device tree bindings for the same device.

You will need some add-on patch to the db8500 device tree moving this
over to the AMBA (PrimeCell) bus abstraction.

Lee can you test this and help Alessandro add the proper chunks to
the device tree as well?

Apart from that this looks good to me, I'll test it on the MOP500
as soon as I can.

Yours,
Linus Walleij
