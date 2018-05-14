From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 14 May 2018 12:12:19 +0200
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <091ccf85-ae4c-f6fd-0455-1a70e973c85c@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
 <1937901.oyadCYFYNo@aspire.rjw.lan>
 <a431b0e1-f4f4-1439-f0bf-736018c6ab0c@pengutronix.de>
 <091ccf85-ae4c-f6fd-0455-1a70e973c85c@pengutronix.de>
Message-ID: <12a60556-deaf-1b2a-e073-ba2a70389141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14.05.2018 07:10, Oleksij Rempel wrote:
> 
> 
> On 14.05.2018 06:33, Oleksij Rempel wrote:
>>
>>
>> On 12.05.2018 13:13, Rafael J. Wysocki wrote:
>>> On Friday, May 4, 2018 8:50:52 PM CEST Oleksij Rempel wrote:
>>>> Hallo Andrew,
>>>> I need your ACK or NACK for this patch.
>>>>
>>>> This function is used to configure external PMIC to interpret
>>>> signal which will be triggered by pm_power_off as power off.
>>>> Since same signal can be used for stand by, I linked PMIC configuration
>>>> with pm_power_off_prepare to avoid possible conflicts.
>>>>
>>>> On Mon, Mar 05, 2018 at 11:25:20AM +0100, Oleksij Rempel wrote:
>>>>> Export pm_power_off_prepare. It is needed to implement power off on
>>>>> Freescale/NXP iMX6 based boards with external power management
>>>>> integrated circuit (PMIC).
>>>>>
>>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>>> ---
>>>>>  kernel/reboot.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>>>>> index e4ced883d8de..350be6baa60d 100644
>>>>> --- a/kernel/reboot.c
>>>>> +++ b/kernel/reboot.c
>>>>> @@ -49,6 +49,7 @@ int reboot_force;
>>>>>   */
>>>>>  
>>>>>  void (*pm_power_off_prepare)(void);
>>>>> +EXPORT_SYMBOL(pm_power_off_prepare);
>>>
>>> Why not EXPORT_SYMBOL_GPL() ?
>>
>> No special reason. Fixed.
>> Any other comments?
>>
> 
> Or with other words, will it be enough to get your Signed-of-by for this
> patch?

Hi again,

i was punished by my colleagues and actually by Russel for asking
"Signed-of-by". So, I correct my self, is it enough for a Reviewed-by?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180514/61f11d48/attachment.sig>
