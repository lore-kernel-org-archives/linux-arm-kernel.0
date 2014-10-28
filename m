From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 21:13:20 +0100
Subject: [PATCH v8 8/8] ARM: multi_v7_defconfig: Enable Broadcom Cygnus
In-Reply-To: <544FF744.5020707@broadcom.com>
References: <1414525992-3678-9-git-send-email-sbranden@broadcom.com>
 <5089697.D8odgNlVtY@wuerfel> <544FF744.5020707@broadcom.com>
Message-ID: <1982026.E1VTksgscj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 13:06:28 Scott Branden wrote:
> On 14-10-28 01:01 PM, Arnd Bergmann wrote:
> > On Tuesday 28 October 2014 12:53:12 Scott Branden wrote:
> >> From: Ray Jui <rjui@broadcom.com>
> >>
> >> Enable Broadcom Cygnus platform support in multi_v7_defconfig
> >>
> >> Signed-off-by: Ray Jui <rjui@broadcom.com>
> >> Signed-off-by: Scott Branden <sbranden@broadcom.com>
> >>
> >
> > Just to be sure: did you check that multi_v7_defconfig contains
> > all the drivers you need that you enable in your other defconfig?
> No - the other defconfig has more that have not been tested on the 
> device.  The defconfig builds, but the other drivers haven't been 
> tested.  I guess we can try adding them to the multi_defconfig right now 
> as well or wait until we have tested them?  There will need to be 
> addition dts changes in the future after we have tested the other drivers.
> 
> Can we wait to add them to multi_v7_defconfig or do you want them in 
> this patchset?

The important part is that you don't break other platforms, and that
is independent of whether the code actually does the right thing.

If you know that you will need certain drivers to make use of
the platform, just enable them now.

	Arnd
