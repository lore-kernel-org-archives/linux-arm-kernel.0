From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 15 Oct 2015 16:55:47 +0200
Subject: [linux-sunxi] Re: [PATCH 1/3] ARM: dts: sunxi: Fix
 interrupt-cells for [r]pio on A23/A31/A33/A80
In-Reply-To: <5423411.WHZ4SNGvxb@wuerfel>
References: <1444919327-23747-1-git-send-email-hdegoede@redhat.com>
 <5423411.WHZ4SNGvxb@wuerfel>
Message-ID: <561FBE73.7070606@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-10-15 16:38, Arnd Bergmann wrote:
> On Thursday 15 October 2015 16:28:45 Hans de Goede wrote:
>> When the gpio interrupt bindings where changed to add a bank to the
>> specifier list, the r_pio nodes of A23/A31/A33 where not updated to
>> match and neither was the pio node of the A80, this fixes this.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>
> Is this safe to apply by itself? I don't see any interrupts references
> to these nodes, so I assume it's fine, but if there are any cross-dependencies
> we need more careful planning.

Should be safe to apply by itself, later patches in this series introduce
the first interrupt users of these nodes, which is what made me notice
the mistake in them.

Regards,

Hans
