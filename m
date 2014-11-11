From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Nov 2014 19:35:48 +0100
Subject: [PATCH] ARM: dts: sunxi: Banana Pi: increase startup-delay for
 the GMAC PHY regulator
In-Reply-To: <20141111173435.GJ14919@lukather>
References: <1415539714-7652-1-git-send-email-merker@debian.org>
 <1415539714-7652-2-git-send-email-merker@debian.org>
 <545FD716.5060305@redhat.com> <20141111173435.GJ14919@lukather>
Message-ID: <54625704.7030100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/11/2014 06:34 PM, Maxime Ripard wrote:
> On Sun, Nov 09, 2014 at 10:05:26PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/09/2014 02:28 PM, Karsten Merker wrote:
>>> On the LeMaker Banana Pi, probing the external ethernet PHY connected
>>> to the SoC's internal GMAC module sometimes fails.  The PHY power
>>> supply is handled via a GPIO-controlled regulator, and the existing
>>> regulator startup-delay of 50000us is too short to make sure that the
>>> PHY is always fully powered up when it is queried by phylib.  To
>>> guarantee a reliable PHY detection, the startup-delay has to be
>>> increased to 60000us.
>>
>> We should probably just increase it to 100000us to be safe, otherwise:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Soooo, should I merge it or will there be a v2?

It might be easiest if you merge it with the delay increased to 100000 us,
assuming you agree that it is a good idea to add some extra safety margin.

Regards,

Hans
