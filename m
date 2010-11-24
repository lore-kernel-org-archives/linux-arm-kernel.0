From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Nov 2010 10:53:38 +0200
Subject: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
	<AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
	<20101124082245.GF2468@legolas.emea.dhcp.ti.com>
	<AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
Message-ID: <20101124085338.GH2468@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 02:20:40PM +0530, Varadarajan, Charulatha wrote:
>On Wed, Nov 24, 2010 at 13:52, Felipe Balbi <balbi@ti.com> wrote:
>> On Wed, Nov 24, 2010 at 10:46:04AM +0530, Varadarajan, Charulatha wrote:
>>>>
>>>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>>>> index 48e161c..a1c6bd9 100644
>>>> --- a/arch/arm/plat-omap/mailbox.c
>>>> +++ b/arch/arm/plat-omap/mailbox.c
>>>> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent, struct
>>>> omap_mbox **list)
>>>> ? ? ? ? ? ? ? ? ? ? ? ?ret = PTR_ERR(mbox->dev);
>>>> ? ? ? ? ? ? ? ? ? ? ? ?goto err_out;
>>>> ? ? ? ? ? ? ? ?}
>>>> + ? ? ? ? ? ? ? if (cpu_is_omap44xx())
>>>
>>> Do not use cpu_is* checks in plat-omap/*
>>
>> see the previous thread.
>
>Referring to [1], I do not find why cpu_is* checks is used in plat-omap and
>why it can't be avoided.
>
>In [1], it was suggested to create the pdata field that will be
>populated at init
>time using the cpu_is* check. But in this version, I am finding that
>this is done
>in plat-omap. This can be handled in mach-omap layer itself and can be passed
>as a pdata field which can be extracted during probe.
>
>[1] https://patchwork.kernel.org/patch/337131/

true, since I saw mbox->rev, I confused that with something that was
coming from pdata, sorry. You're right, this is not the right way to do
it.

-- 
balbi
