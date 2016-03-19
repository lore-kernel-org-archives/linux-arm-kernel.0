From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 19 Mar 2016 10:13:47 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun6i: Add serial0 alias and
 stdout-path to a31s-primo81.dts
In-Reply-To: <20160318174839.GQ30977@lukather>
References: <1458137962-27714-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v67+V1JdaG2ypgj5sXyzxiwZhYC_z_1sye5HpnMvcE_QfA@mail.gmail.com>
 <20160318174839.GQ30977@lukather>
Message-ID: <56ED184B.9000609@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18-03-16 18:48, Maxime Ripard wrote:
> On Thu, Mar 17, 2016 at 02:28:03PM +0800, Chen-Yu Tsai wrote:
>> On Wed, Mar 16, 2016 at 10:19 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> u-boot uses the kernel as the canonical source for its sunxi dts files
>>> and u-boot needs these.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
> Queued, thanks!

I just got an of-list mail from Karsten Merker that you nacked the addition
if this during the initial submission, because there are no accessible uart
test pads on this tablet.

In that case the proper fix would be to change the u-boot defconfig to have:

# CONFIG_REQUIRE_SERIAL_CONSOLE is not set

Which will stop u-boot from panicking (with nowhere to print the panic msg)
when it has no stdout-path.

Can you unqueue this one until we've figured out what the best fix is ?

Thanks & Regards,

Hans
