From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 12 Aug 2010 01:15:12 +0300
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get board
	data
In-Reply-To: <20100811212513.GC827@n2100.arm.linux.org.uk>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
	<20100811185724.GD21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com>
	<20100811212513.GC827@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=y9ZEVTnTORhTj4gncLGcTjPxi_Ttja5POiT_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 12:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Aug 12, 2010 at 12:57:18AM +0530, DebBarma, Tarun Kanti wrote:
>>
>> > -----Original Message-----
>> > From: Felipe Balbi [mailto:felipe.balbi at nokia.com]
>> > Sent: Thursday, August 12, 2010 12:27 AM
>> > To: DebBarma, Tarun Kanti
>> > Cc: Balbi Felipe (Nokia-MS/Helsinki); Ohad Ben-Cohen; linux-
>> > wireless at vger.kernel.org; linux-mmc at vger.kernel.org; linux-
>> > omap at vger.kernel.org; Ido Yariv; Mark Brown; linux-arm-
>> > kernel at lists.infradead.org; Chikkature Rajashekar, Madhusudhan; Coelho
>> > Luciano (Nokia-MS/Helsinki); akpm at linux-foundation.org; San Mehat; Quadros
>> > Roger (Nokia-MS/Helsinki); Tony Lindgren; Nicolas Pitre; Pandita, Vikram;
>> > Kalle Valo
>> > Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
>> > board data
>> >
>> > Hi,
>> >
>> > On Wed, Aug 11, 2010 at 08:52:54PM +0200, ext DebBarma, Tarun Kanti wrote:
>> > >True; however if we go by that argument than we can also assume pdata
>> > >is valid, so that we would not need the below check.
>> >
>> > of course not. You can have devices that just play well with default
>> > values or devices where you don't need the flexibility of platform data.
>> > That's why we check.
>> >
>> > platform_device pointers on the other hand, are guaranteed to be always
>> > true, if it isn't then you should oops, you deserve to oops because
>> > something is really really wrong.
>> >
>> Sounds perfect!
>> What that means is _probe() function makes sense only for cases where we
>> have valid platform data because we are returning right at the top if
>> pdata is not valid. If this is the case I was curious to know why not
>> framework make another check for valid pdata before calling _probe()
>> instead of coming all the way to _probe() and then returning!
>
> Platform devices are not for passing platform data around - they're for
> declaring platform hardware devices that we want drivers to handle -
> and it depends on the driver whether having platform data is appropriate
> or not.
>
> This proposal is, IMHO, abusing the platform device/driver support to
> achieve its own goals. ?I've outlined a far simpler and easiler solution
> which avoids this kind of abuse, and given suggestions on how to extend
> it to support multiple instances.

Thanks, Russell.

I'll give your suggestion a spin when I get back (I'm going to be away
for some time now with no devices with me).
