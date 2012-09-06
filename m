From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 06 Sep 2012 10:27:30 +0200
Subject: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA27D69@DBDE01.ent.ti.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <50473D92.9000500@pengutronix.de> <504759B4.6060203@pengutronix.de>
 <20120905232609.GL1303@atomide.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA27D69@DBDE01.ent.ti.com>
Message-ID: <50485E72.7010900@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 08:09 AM, AnilKumar, Chimata wrote:
> On Thu, Sep 06, 2012 at 04:56:10, Tony Lindgren wrote:
>> * Marc Kleine-Budde <mkl@pengutronix.de> [120905 06:55]:
>>> On 09/05/2012 01:54 PM, Marc Kleine-Budde wrote:
>>>> On 09/05/2012 01:12 PM, AnilKumar Ch wrote:
>>>>> Adds suspend/resume functionality of d_can driver along with d_can
>>>>> raminit support which is required to initialize RAM while data
>>>>> transmission.
>>>>>
>>>>> This patch series also adds pinctrl support to c_can driver. These
>>>>> patches were tested on AM335x-EVM.
>>>>>
>>>>> This patch-series is based ontop of runtimePM patch submitted
>>>>> earlier - https://patchwork.kernel.org/patch/1348081/
>>>>
>>>> Looks good, I'll apply the series after Tony acks the patch 3
>>>> ([PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
>>>> pass d_can raminit).
>>>
>>> I've pushed all patches to can-next/master [1]. When Tony gives his Ack,
>>> I'll send David a pull request (of a tree including that Ack).
>>
>> To me it looks like we can avoid the platform callbacks and the ram
>> init changes to the driver by implementing right runtime PM calls
>> for omap/am33xx. So NAK on few patches, and ACK on one :)
>>
> 
> Marc,
> 
> Can you please queue ACK patch for 3.7, I will submit v3 for rest of
> the patches, once we found the clear way of doing RAMINIT.

Done. I've updated the master branch on my repo[1]. I'll send a pull
request to David soon.

Marc

[1] https://gitorious.org/linux-can/linux-can-next
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/54e1b78d/attachment.sig>
