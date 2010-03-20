From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 20 Mar 2010 10:44:25 +0100
Subject: Using of cached values
In-Reply-To: <2703439e1003200222y16147d81x27b0a8bcc804c338@mail.gmail.com>
References: <2703439e1003200222y16147d81x27b0a8bcc804c338@mail.gmail.com>
Message-ID: <20100320094425.GB30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 06:22:43PM +0900, Mogambo Park wrote:
>   I wants to know - How safe to read register values one time in a structure
> and use value from there, assume no write is performed on the
> register? I see many
> files in sound/soc/codec/ do that.

Why shouldn't that be safe? Do you expect your cache to get lost?

> is it becos sometime the register may return not accurate value on
> busy bus by h/w mistake?
> OR I should always read from register even if his value is not
> expected to change?

If the register content does not change, you can use a cached value.
That can be a lot faster and less power-consuming than going over the
bus and reading from the device. Depending on the bus in use and how
often you do that of course.

Daniel
