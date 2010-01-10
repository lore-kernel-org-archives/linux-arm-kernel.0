From: thommycheck@gmx.de (Thomas Kunze)
Date: Sun, 10 Jan 2010 15:31:46 +0100
Subject: [PATCH 3/7] [ARM] locomo: remove unused IRQs and avoid unnecessary
	cascade
In-Reply-To: <f17812d70912311859w597e4174s6c0101b670d758a@mail.gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
	<1261977488-18271-4-git-send-email-eric.y.miao@gmail.com>
	<4B3CAA54.1040301@gmx.de>
	<f17812d70912311859w597e4174s6c0101b670d758a@mail.gmail.com>
Message-ID: <4B49E4D2.8000801@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao schrieb:
> On Thu, Dec 31, 2009 at 9:42 PM, Thomas Kunze <thommycheck@gmx.de> wrote:
>   
>> Eric Miao wrote:
>>     
>>> IRQ_LOCOMO_* are never used elsewhere, remove these definitions. As well
>>> as the cascade of these IRQs. IRQ_LOCOMO_*_BASE changed to IRQ_LOCOMO_*.
>>>
>>> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>>>
>>>       
>> Unlike poodle which AFAIK only uses locomo for keyboard Collie needs most of
>> these irqs for various subdevices (for example SD-Card on SPI bus) . The
>> drivers for these devices
>> will find their way into mainline as time permits. So please don't remove
>> this functionality.
>>
>>     
>
> The LoCoMo driver is really weird, it has a second cascade of the IRQ
> which looks to me unnecessary.
>
> Could you look into the possibility that the subdevices driver on collie
> can make use only of the first level IRQ?
>
> The GPIO IRQs, which I'm seeking alternate solution with dynamic IRQ.
>   
I think all devices but GPIO can use these base irqs. Unfortunately I 
don't have a real network connection available until
end of january. I will test this then.

Regards,
Thomas
