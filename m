From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 04 Oct 2016 06:02:48 -0700
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <0125defa-5c34-85d0-f62a-133235c5094c@ti.com> (Peter Ujfalusi's
 message of "Mon, 3 Oct 2016 10:13:25 +0300")
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
 <CAMpxmJXafyT5G8ZyD8RBAtzD6R9HmvyS0NBpz5i2fJ0SwOhXBA@mail.gmail.com>
 <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
 <948c3f9e-f11b-092c-e002-e2ef4436197f@ti.com>
 <0125defa-5c34-85d0-f62a-133235c5094c@ti.com>
Message-ID: <7hvax8ferr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> On 10/01/16 12:24, Sekhar Nori wrote:

[...]

>> In any case, to configure the PBBR, you will have to introduce a driver
>> for it in drivers/memory. Then you can set it up per board using a DT
>> parameter.
>
> and we can reuse the introduced bindings for am335x and OMAP1/2 as well. On
> OMAP the legacy DMA API provided a call to raise the priority of the sDMA in
> EMIF :o That needs to be removed and replaced.

Can you point us to the bindings you're referring to?

Also, a new driver in drivers/memory is fine for setting the PBBR, but
what about the SYSCFG0 registers.  Are you OK with leaving those in the
init code as proposed in $SUBJECT patch?

Kevin
