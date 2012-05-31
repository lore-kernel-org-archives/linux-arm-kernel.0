From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 31 May 2012 09:37:51 +0100
Subject: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
In-Reply-To: <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
References: <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
 <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
Message-ID: <4FC72DDF.7080209@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/12 02:51, Linus Walleij wrote:
> On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini<rubini@gnudd.com>  wrote:
>
>> The i2c-nomadik gateware is really a PrimeCell APB device. By hosting
>> the driver under the amba bus we can access it more easily, for
>> example using the generic pci-amba driver. The patch also fixes the
>> mach-ux500 users to register an AMBA device, not a platform device.
>>
>> Signed-off-by: Alessandro Rubini<rubini@gnudd.com>
>> Acked-by: Giancarlo Asnaghi<giancarlo.asnaghi@st.com>
>> Cc: Srinidhi Kasagar<srinidhi.kasagar@stericsson.com>
>> Cc: STEricsson_nomadik_linux at list.st.com
>> Cc: Linus Walleij<linus.walleij@stericsson.com>
>
> This will affect Lee Jones' device tree bindings for the same device.
>
> You will need some add-on patch to the db8500 device tree moving this
> over to the AMBA (PrimeCell) bus abstraction.

What does AMBA win us over the platform device here?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
