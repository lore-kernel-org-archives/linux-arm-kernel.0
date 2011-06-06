From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Jun 2011 20:28:35 +0300
Subject: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
	to use REGULATOR_SUPPLY
In-Reply-To: <547324C9-4B76-410E-86E6-092D062C95AB@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-2-git-send-email-green@linuxhacker.ru>
	<20110606092126.GG18731@legolas.emea.dhcp.ti.com>
	<EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
	<20110606171326.GK12242@legolas.emea.dhcp.ti.com>
	<547324C9-4B76-410E-86E6-092D062C95AB@linuxhacker.ru>
Message-ID: <20110606172832.GM12242@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 01:18:41PM -0400, Oleg Drokin wrote:
> Hello!
> 
> On Jun 6, 2011, at 1:13 PM, Felipe Balbi wrote:
> > On Mon, Jun 06, 2011 at 11:45:29AM -0400, Oleg Drokin wrote:
> >>>> -static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
> >>>> -	{
> >>>> -		.supply = "vmmc",
> >>>> -		.dev_name = "omap_hsmmc.1",
> >>>> -	},
> >>>> -};
> >>>> +static struct regulator_consumer_supply sdp4430_vaux_supply =
> >>>> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
> >>> this should be an array, as it was before.
> >> 
> >> Only one is defined right now.
> >> Whoever needs a second element can convert it to array, I think?
> >> What;s the importance of having it as an array right now?
> > because later patches will be easier to review. Look below:
> ...
> > can you see now ?
> 
> Ok, I get the idea. Do you think it would be best to convert every supply
> definition to an array then just in case?

I think that while you're doing this big conversion, why not ?

> I wonder what are the chances of additional regulators to appear at all
> in many of these.
> What about supplies that are not going to have additional elements
> (like that cm-t35 board, because there simply are no more regulators in the twl)?

Still, It's the same thing I was discussing with Alan Stern on another
thread, it comes down to uniformity and you never know when someone
might decide to hook up and always on supply to any node :-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110606/a30dde24/attachment.sig>
