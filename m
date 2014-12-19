From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 19 Dec 2014 15:07:21 -0800
Subject: [PATCHv4] INPUT: Route keyboard LEDs through the generic LEDs
 layer.
In-Reply-To: <20141219230253.GA31928@amd>
References: <20141210010214.GZ3074@type.youpi.perso.aquilenet.fr>
 <20141219144641.3a549feb1ee5f2b9400f62cb@linux-foundation.org>
 <20141219225933.GD3049@type.youpi.perso.aquilenet.fr>
 <20141219230253.GA31928@amd>
Message-ID: <20141219230721.GA31631@dtor-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 20, 2014 at 12:02:53AM +0100, Pavel Machek wrote:
> On Fri 2014-12-19 23:59:33, Samuel Thibault wrote:
> > Andrew Morton, le Fri 19 Dec 2014 14:46:41 -0800, a ?crit :
> > > > Changed in this version:
> > > > - Use kcalloc instead of kzalloc
> > > > - to avoid any mutex order violation, defer LED update into a work callback.
> > > 
> > > Confused.  This patch is identical to the one that's presently in -mm.
> > 
> > Well, yes: I'm submitting the latest version of this patch to Dmitry,
> > i.e. including the fixes that happened in the -mm tree.
> 
> Andrew, do you think you could send the patch to Dmitry? He has been
> ignoring it for way too long... and it should be slightly harder for
> him to ignore patch from you...

I'll keep ignoring the patch until someone will figure out how to make new way
of handling LEDs play well with the current way (via writing to evdev). That
means not treating access to evdev as "raw" and ignoring LED trigger remapping
done in LED layer. So far I just heard that it is not a problem and nobody uses
evdev interface...

Thanks.

-- 
Dmitry
