From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 9 Jun 2016 12:47:36 +0200
Subject: [PATCH 0/1] ARM: dts: sunxi: Fix simplefb not working in 4.7-rc1
In-Reply-To: <20160609074643.GA5242@lukather>
References: <1465063524-4925-1-git-send-email-hdegoede@redhat.com>
 <20160609074643.GA5242@lukather>
Message-ID: <21258fc0-0250-951b-2ee7-d022fb3c09ac@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-06-16 09:46, Maxime Ripard wrote:
> Hi Hans,
>
> On Sat, Jun 04, 2016 at 08:05:23PM +0200, Hans de Goede wrote:
>> Hi Maxime,
>>
>> While testing 4.7-rc1 / linux-sunxi/sunxi-next on a A10s I noticed that
>> hdmi out is no longer working (screen goes black when the kernel turns
>> of unused clocks).
>>
>> This is caused by the dtsi for sun4i / sun5i / sun7i based boards now
>> listing pll3, without pll3 being added to the clocks list for the
>> simplefb nodes.
>
> Why not do just that then? It's more appropriate for a fix imho.

You mean just for sun5i-a10s, or for all of sun4i / sun5i-a10s and
sun7i ?

For sun4i and sun7i things are already fixed in next:

https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=5a7f2310cc847a73852e70bc720a61ca9bf986a6
https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=c79255ca4d7b67cce4eac4dd532e097ce49f3679

It seems best to use those fixes, rather then come up with a separate
fix for 4.7.

My patch for fixing sun5i-a10s is inline with the 2 above patches,
which seems best, rather then doing something special for just sun5i-a10s.

I'll send a v2 of this patch with the spelling mistakes pointed out
by Peter Korsgaard fixed.

Regards,

Hans
