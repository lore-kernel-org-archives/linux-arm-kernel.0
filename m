From: balbi@ti.com (Felipe Balbi)
Date: Tue, 20 Aug 2013 07:26:32 -0500
Subject: [PATCH 01/15] drivers: phy: add generic PHY framework
In-Reply-To: <5211ACE9.3040302@ti.com>
References: <20130720220006.GA7977@kroah.com> <520A2100.6000709@ti.com>
 <520AB0F0.8010106@gmail.com> <2128883.KpgODjXPJQ@flatron>
 <520B9C9E.8010002@ti.com> <5211ACE9.3040302@ti.com>
Message-ID: <20130820122632.GS26587@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 19, 2013 at 10:58:09AM +0530, Kishon Vijay Abraham I wrote:
> >> So maybe let's stop solving an already solved problem and just state that 
> >> you need to explicitly assign device ID to use this framework?
> > 
> > Felipe,
> > Can we have it the way I had in my v10 patch series till we find a better way?
> > I think this *non-dt* stuff shouldn't be blocking as most of the users are dt only?

I don't have a lot of things against it, but preventing driver authors
to use PLATFORM_DEVID_AUTO just to use the framework is likely going to
piss some people off.

Perhaps we can start with this approach and fix things later ? At least
it ungates all the PHY drivers which are depending on this framework
(quite a few already). If everybody agrees with this approach, I'd be ok
with it too.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/3d97825d/attachment.sig>
