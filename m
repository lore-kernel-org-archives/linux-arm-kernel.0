From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 07 Oct 2013 10:18:14 +0200
Subject: [PATCH|RFC] of: let of_match_device() always return best match
In-Reply-To: <21074.28159.130293.169699@ipc1.ka-ro>
References: <1380826284-18381-1-git-send-email-mkl@pengutronix.de>
 <CAOMZO5BekS_BvJzrt8vM1=7LjsiO=3hKL=mMfTjxkO3aZ4qwRQ@mail.gmail.com>
 <525052F5.5080204@pengutronix.de> <21074.28159.130293.169699@ipc1.ka-ro>
Message-ID: <52526E46.4030205@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 10:17 AM, Lothar Wa?mann wrote:
> Hi,
> 
> Marc Kleine-Budde writes:
>> On 10/05/2013 07:46 PM, Fabio Estevam wrote:
>>> Hi Marc,
>>>
>>> On Thu, Oct 3, 2013 at 3:51 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>>> For example:
>>>>
>>>> The imx28.dtsi gives this compatible string for its CAN core:
>>>>
>>>>>       compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
>>>>
>>>> The flexcan driver defines:
>>>>
>>>>> static const struct of_device_id flexcan_of_match[] = {
>>>>>       { .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
>>>>>       { .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
>>>>>       { .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
>>>>>       { /* sentinel */ },
>>>>> };
>>>>
>>>> The "p1010" was the first Freescale SoC with the flexcan core. But this SoC has
>>>> a bug, so a workaround has to be enabled in the driver. The mx28 has this bug
>>>> fixed, so we don't need this quite costly workaround.
>>>
>>> What about defining in imx28.dtsi:
>>> compatible = "fsl,imx28-flexcan".
>>
>> It already works with changing only the driver.
>>
> IMO the change proposed by Fabio is much more sensible. If the imx28
> implementation of the CAN controller is not compatible to p1010 (which
> is obviously true) there is no point in having the "fsl,p1010-flexcan"
> in the DT for imx28.

But it is compatible with the "fsl,p1010-flexcan".

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/218b740d/attachment.sig>
