From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 06:36:45 +0100
Subject: [PATCH] serial: SAMSUNG: Fix dev_name and driver_name
In-Reply-To: <4BF20EED.5040306@samsung.com>
References: <4BF13ABA.3090504@samsung.com>
	<20100518024820.GK27571@trinity.fluff.org>
	<4BF20EED.5040306@samsung.com>
Message-ID: <20100518053645.GN27571@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 12:52:13PM +0900, Joonyoung Shim wrote:
> On 5/18/2010 11:48 AM, Ben Dooks wrote:
> > On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
> >> Thd dev_name and driver_name should be switched each other.
> > 
> > Hmm, this doesn't seem to have appeard on the linux-arm-kernel list yet.
> >  
> > Please provide some information about what problem that this is fixing
> > and the impact on any existing systems.
> > 
> 
> The serial device nodes are created to s3c2410_serial* on android 
> platform instead of ttySAC*.

This has been how they've been for ages, surely the android device node
creation sytstem supports symlinking /dev/SACx -> /dev/s3c2410_serialx,
like many other operating sysyerms that can already do this.

Changing this just because android (something as-yet unmerged into mainline)
does not like it. I'm not even happy with an #ifdef around this.

If you really feel this is a problem that you absolutely must fix in kernel
then please provide a kernel commandline option to change the serial driver
name and use that on any platform that needs it. Another way would be to
update the serial platform data to have a field for which name to choose.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
