From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 05 Mar 2014 21:02:39 +0100
Subject: [linux-sunxi] Re: [PATCH 0/7] mfd: AXP20x: Add support for AXP202
 and AXP209
In-Reply-To: <53123507.6020607@redhat.com>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>	<53121151.9050804@redhat.com>
 <CAOQ7t2ae35E-eiQW4DFspdTe3H7AWGzRpw4B_1t27p0OSkX_Uw@mail.gmail.com>
 <53123507.6020607@redhat.com>
Message-ID: <531782DF.6090209@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/01/2014 08:29 PM, Hans de Goede wrote:
> Hi,
> 
> On 03/01/2014 06:17 PM, Carlo Caione wrote:
>> On Sat, Mar 1, 2014 at 5:56 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi Carlo,
>>>
>>> Great work, thanks for all the time you're putting into this!
>>
>> Hi Hans :)
>>
>>> I've 2 questions:
>>>
>>> 1) What dependencies does this patch-set have? Obviously it needs the NMI irq
>>> patches for A20, anything else ?  I no longer see any use of a special flag
>>> for ack on unmask, is that no longer needed ?
>>
>> Yes, the only dependency is on the NMI controller patch.
>> After a discussion with Maxime and Thomas I decided to not push for
>> including the special flag for ack on unmask in the irqchip core but
>> to use the unmask callback as in the v3 version of the NMI controller
>> driver (so no flag needed)
>>
>>> 2) No poweroff functionality ? That would be really great to have.
>>
>> Actually in [PATCH 1/7] I support the poweroff using the pm_power_off hook.
> 
> Ah I missed that, cool.
> 
> I'm doing with sunxi hacking for today, but I'll add these to sunxi-devel
> and them give them a test run tomorrow.

So I've added your patches to my sunxi-devel tree and they work as advertised :)

I've also added dt support for the axp209 to the cubietruck dts file, to avoid
things becoming a copy and paste fest I've introduced a new axp209.dtsi file,
as well as did some fixes to the existing sun?i-a*.dtsi files, see my tree here:
https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-devel

If you agree this is a good idea feel free to steal it all for the next
revision of your patch-set :)

Note that I've still left some copy-paste parts inside the per board dts files,
specifically things which may differ per board, ie we know already that A10
boards will have a different interrupt parent for the interrupt.

Thanks for your work on this!

Regards,

Hans
