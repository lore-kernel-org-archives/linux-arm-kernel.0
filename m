From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 28 Mar 2013 08:50:05 +0800
Subject: [PATCH V2 0/6] remove the clock name from pdata
In-Reply-To: <20130327131431.GE4626@arwen.pp.htv.fi>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
 <20130327131431.GE4626@arwen.pp.htv.fi>
Message-ID: <CADApbehQDD6avyeH8=i51Ngfia=c_+nP54ti3WJeUxdXjvc4=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 9:14 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Mar 25, 2013 at 03:06:51AM -0400, Chao Xie wrote:
>> The clock is defined by device, so the driver knows how many
>> clocks needed by the device.
>> The orignal way that passing the clock name by pdata is not correct.
>> The following patches fix it.
>>
>> V2->V1:
>>    typo fix
>>    rebased on latest usb-next
>>
>> Chao Xie (6):
>>   usb: gadget: mv_udc_core: remove unused clock
>>   usb: otg: mv_otg: remove unused clock
>>   usb: ehci: mv_ehci: remove unused clock
>>   arm: mmp: remove clock from usb pdata for aspenite
>>   arm: mmp: remove clock name from usb pdata for ttc
>>   usb: mv_usb: remove clock name from pdata
>
> how should this series be handled ?
>
> If you want me to carry all patches, I need Acks from other maintainers
> for ehci and arch/arm/ parts.
>
> Until then, I'm dropping this from my TODO list.
>
> --
> balbi

hi, Alan

Can you help me to review the EHCI parts?
It changes the way of getting clock. The orginal way uses the pdata to
get the clock name, and it is not correct, and the patch fix it.
Thanks.
