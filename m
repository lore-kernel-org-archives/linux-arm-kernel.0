From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 15 Oct 2014 07:16:33 +0000
Subject: [PATCHv4] serial: of-serial: fix up PM ops on no_console_suspend
 and port type
In-Reply-To: <543E19C5.3040200@nvidia.com>
References: <1413276146-20388-1-git-send-email-jingchang.lu@freescale.com>
 <543DC753.4070304@nvidia.com>
 <67564f37252242079bcd4c65827b8352@BL2PR03MB467.namprd03.prod.outlook.com>
 <543E1730.2040108@nvidia.com> <543E19C5.3040200@nvidia.com>
Message-ID: <b7caa34e784a47dfa585cea66ebfbb69@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Joseph Lo [mailto:josephl at nvidia.com]
>Sent: Wednesday, October 15, 2014 2:53 PM
>To: Lu Jingchang-B35083; gregkh at linuxfoundation.org
>Cc: linux-arm-kernel at lists.infradead.org; linux-serial at vger.kernel.org;
>peter at hurleysoftware.com; arnd at arndb.de; linux-kernel at vger.kernel.org
>Subject: Re: [PATCHv4] serial: of-serial: fix up PM ops on
>no_console_suspend and port type
>
>On 10/15/2014 02:41 PM, Joseph Lo wrote:
>> On 10/15/2014 02:32 PM, Jingchang Lu wrote:
>>>> -----Original Message-----
>>>> From: Joseph Lo [mailto:josephl at nvidia.com]
>>>> Sent: Wednesday, October 15, 2014 9:01 AM
>>>> To: Lu Jingchang-B35083; gregkh at linuxfoundation.org
>>>> Cc: peter at hurleysoftware.com; arnd at arndb.de;
>>>> linux-kernel at vger.kernel.org; linux-serial at vger.kernel.org;
>>>> linux-arm-kernel at lists.infradead.org
>>>> Subject: Re: [PATCHv4] serial: of-serial: fix up PM ops on
>>>> no_console_suspend and port type
>>>>
>>>> On 10/14/2014 04:42 PM, Jingchang Lu wrote:
>>>>> This patch fixes commit 2dea53bf57783f243c892e99c10c6921e956aa7e,
>>>>> "serial: of-serial: add PM suspend/resume support", which disables
>>>>> the uart clock on suspend, but also causes a hardware hang on
>>>>> register access if no_console_suspend command line option is used.
>>>>>
>>>>> Also, not every of_serial device is an 8250 port, so the serial8250
>>>>> suspend/resume functions should only be applied to a real 8250 port.
>>>>>
>>>>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>>>>
>>>> If you can make sure this patch can build without include
>>>> <linux/console.h>, then this patch
>>> The build passes on my cloned linux-next tree, include next-20141014,
>>> but is required on my another kernel-3.12+ based tree, then I didn't
>>> add this header file when upstream.
>>> Is the build broken on your source tree, and is the tree latest?
>>> If the header is needed, I will add it.
>> I tested it on next-20141013 and k3.14, both of them need the fix. I
>> can check it again against the latest linux-next tree later. Thanks.
>>
>OK, I confirmed it. You should add the header file. It also doesn't build
>for me with the latest linux-next tree. Maybe you missed to enable
>CONFIG_PM_SLEEP or CONFIG_SERIAL_8250 when doing the build test in linux-
>next tree.
I have sent out the v5 patch with last git-send-email command line,
didn't realized the missing of your email address in the cc list when sending.
Please help review the v5 patch. Thanks.

Best Regards,
Jingchang
>
>-Joseph
