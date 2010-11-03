From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 3 Nov 2010 17:24:09 +0100
Subject: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <129498.93810.qm@web180302.mail.gq1.yahoo.com>
References: <AANLkTin=3K0H+YdNM2Nhz63c3+Upp+rwApo-Ww4p5qH6@mail.gmail.com>
	<129498.93810.qm@web180302.mail.gq1.yahoo.com>
Message-ID: <AANLkTikZNMRLiWnDuY9oahwoJ+Zxsrvz=JO0C10CbZvx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/3 David Brownell <david-b@pacbell.net>:
> --- On Wed, 11/3/10, Linus Walleij <linus.ml.walleij@gmail.com> wrote:
>>
>> Incidentally the ARM PrimeCell PL022 is called SSP,
>> "Synchronous Serial Port" and is not multifunction at all.
>
> ISTR coming across that IP module; are you sure
> that it only supports a single serial protocol,
> instead of just a "small" variety" (multi)?
> Unless the hardware only supports one protocol,
> my point holds.

Yeah well:

/**
 * enum ssp_interface - interfaces allowed for this SSP Controller
 * @SSP_INTERFACE_MOTOROLA_SPI: Motorola Interface
 * @SSP_INTERFACE_TI_SYNC_SERIAL: Texas Instrument Synchronous Serial
 * interface
 * @SSP_INTERFACE_NATIONAL_MICROWIRE: National Semiconductor Microwire
 * interface
 * @SSP_INTERFACE_UNIDIRECTIONAL: Unidirectional interface (STn8810
 * &STn8815 only)
 */
enum ssp_interface {
        SSP_INTERFACE_MOTOROLA_SPI,
        SSP_INTERFACE_TI_SYNC_SERIAL,
        SSP_INTERFACE_NATIONAL_MICROWIRE,
        SSP_INTERFACE_UNIDIRECTIONAL
};

If that is what you mean then yes. All of the protols are
"SPI type" though.

Yours,
Linus Walleij
