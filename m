From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 28 Apr 2011 09:10:58 +0200
Subject: [PATCH] pxa/mioa701: use gpio arrays for global and gsm gpio
	initialization
In-Reply-To: <BANLkTinE3Rubb4Kr-JqT_6ep-LNwLmTd5A@mail.gmail.com> (Eric Miao's
	message of "Mon\, 25 Apr 2011 11\:31\:12 +0800")
References: <1303329331.21545.7.camel@flow> <87tydre1c7.fsf@free.fr>
	<BANLkTimXsD6BYa2PPXmrY=aABLNFSRW4Sw@mail.gmail.com>
	<BANLkTinE3Rubb4Kr-JqT_6ep-LNwLmTd5A@mail.gmail.com>
Message-ID: <877haeetq5.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao <eric.y.miao@gmail.com> writes:

> On Fri, Apr 22, 2011 at 6:35 PM, pHilipp Zabel <philipp.zabel@gmail.com> wrote:
>> On Thu, Apr 21, 2011 at 11:33 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> Philipp Zabel <philipp.zabel@gmail.com> writes:
>>>
>>>> gpio_request_arrays() / gpio_free_arrays() are functional replacements for
>>>> mio_gpio_request() / mio_gpio_free(), which are now obsolete.
>>>>
>>>> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>>>
>>> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>
>> Dmitry Artamonow pointed out that contrary to
>> hx4700/mio_gpio_request(), gpio_request_array() is silent when a
>> request fails. Would you prefer something like
>>
>> int rc;
>> rc = gpio_request_array(ARRAY_AND_SIZE(global_gpios));
>> if (rc)
>> ? ?pr_err("MioA701: Failed to request GPIOs.\n");
>>
>> in there?
>>
>
> That will always be good.
Indeed.

pHilipp, keep the ack, the usage of gpio_request_array() is a very good
idea. Reporting the error is even better than saying nothing.

Cheers.

-- 
Robert
