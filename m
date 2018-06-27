From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 27 Jun 2018 19:59:22 +0300
Subject: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
In-Reply-To: <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
 <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
Message-ID: <72694ec0-45ee-6f57-ebbf-249d4a0b23bc@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> There are three boards that share that configuration almost to a T,
> with the only difference is the particular GPIOs used. Putting it into
> a common file avoids repeating the boilerplate and makes it explicit
> to the reader that those settings are shared.

I'd agree if that boilerplate was 100 lines.

But here it is small, and mostly containing lines that are required for
any i2c-gpio definition. It does not any value of itself.

Saving 5 lines at cost of loose of integrity is not something I agree with.

> There are at least two boards that use that UART2 as is. Same as above
> this was done to reduce boilerplate.

Here have choice between two logical blocks - definitions of uart2 in
two boards that use them, and two logical blocks - definition in dtsi
and undo in board that does not use it.

You trade a couple of saved dts lines against keeping things consistent.

Nikita

P.S.
In case of these zii boards I doubt that dtsi worths at all. Despite of
all being imx51 boards from ZII, these boards don't seem to have large
common logical blocks. Perhaos RDU1 and babbage have more in common - so
what, create a dtsi for them?
