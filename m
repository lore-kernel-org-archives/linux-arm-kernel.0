From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 22 Jun 2011 18:15:17 +0400
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <20110622140127.GB27654@legolas.emea.dhcp.ti.com>
References: <1308745217-10883-1-git-send-email-dbaryshkov@gmail.com>
	<20110622132314.GG23598@legolas.emea.dhcp.ti.com>
	<BANLkTimK0B-620-3DfRY4yGURGs=Y4uDQA@mail.gmail.com>
	<20110622140127.GB27654@legolas.emea.dhcp.ti.com>
Message-ID: <BANLkTikDiBbVLSnsTuciVK5G1yfhxTJo0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/22/11, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Jun 22, 2011 at 05:52:18PM +0400, Dmitry Eremin-Solenikov wrote:
>> On 6/22/11, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi,
>> >
>> > On Wed, Jun 22, 2011 at 04:20:16PM +0400, Dmitry Eremin-Solenikov wrote:
>> >> Some platforms would like to disable D+ pullup on suspend, to drain as
>> >> low power, as possible. E.g. this was requested by mioa701 board
>> >> maintainers.
>> >
>> > I think this makes sense to many platforms, but by doing so, you would
>> > loose connection to the Host PC, so you need to make sure your device
>> > isn't been used before you go down this road.
>>
>> I've thought about this. Should UDC driver should somehow call into OTG
>> layer on suspend? My understanding is that otg_set_suspend isn't the call
>> that should be done here, is it true?
>>
>> My idea was that board can ask for D+ disabling, knowing itself the
>> behaviour
>> of the platform driver on suspend (e.g. PXA27x does disable UDC on
>> suspend,
>> but I dunno what effect this will cause on Host PC).
>
> Host PC will only see the device disconnecting. So, what happens if the
> user has mounted file systems when you decide to go into suspend ?

What happens if user has mounted filesystems when I decide to pull out
the cable?
I agree with you generally, but I'd like to hear any suggestions.


-- 
With best wishes
Dmitry
