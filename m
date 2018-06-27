From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Jun 2018 10:33:22 -0700
Subject: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
In-Reply-To: <72694ec0-45ee-6f57-ebbf-249d4a0b23bc@cogentembedded.com>
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
 <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
 <72694ec0-45ee-6f57-ebbf-249d4a0b23bc@cogentembedded.com>
Message-ID: <CAHQ1cqGxXg5QYMTxbSsNDDr=ot0h0XWW98hHNVnf+SQhrjoL=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 9:59 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
>
> > There are three boards that share that configuration almost to a T,
> > with the only difference is the particular GPIOs used. Putting it into
> > a common file avoids repeating the boilerplate and makes it explicit
> > to the reader that those settings are shared.
>
> I'd agree if that boilerplate was 100 lines.
>

OK, so your threshold is 100 lines, mine is 3. Agree to disagree?

> But here it is small, and mostly containing lines that are required for
> any i2c-gpio definition. It does not any value of itself.
>
> Saving 5 lines at cost of loose of integrity is not something I agree with.
>

Can we maybe tone it down and not make this sound like a struggle of
"good vs. evil"?

> > There are at least two boards that use that UART2 as is. Same as above
> > this was done to reduce boilerplate.
>
> Here have choice between two logical blocks - definitions of uart2 in
> two boards that use them, and two logical blocks - definition in dtsi
> and undo in board that does not use it.
>
> You trade a couple of saved dts lines against keeping things consistent.

That's your POV, mine is that I save a couple of lines and things are
still consistent.

>
> Nikita
>
> P.S.
> In case of these zii boards I doubt that dtsi worths at all. Despite of
> all being imx51 boards from ZII, these boards don't seem to have large
> common logical blocks. Perhaos RDU1 and babbage have more in common - so
> what, create a dtsi for them?

Nope, that slippery slope doesn't exist at all. We have a clear
boundary/decision criteria of common vendor.

As I said, let's leave this decision up to the maintainers and avoid
continuing having this argument where neither party convinces another.

Thanks,
Andrey Smirnov
