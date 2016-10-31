From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 15:46:22 +0000
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <1913139.FJW82OAuEF@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <4818149.nzRaU7vJQE@amdc1976> <4264651.gPKphdYuCx@wuerfel>
 <1913139.FJW82OAuEF@amdc3058>
Message-ID: <20161031154622.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 07:01:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, July 13, 2016 04:37:31 PM Arnd Bergmann wrote:
> > On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> > > > On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > > This patch disables deprecated IDE subsystem in assabet_defconfig
> > > > > (no IDE host drivers are selected in this config so there is no
> > > > > valid reason to enable IDE subsystem itself).
> > > > > 
> > > > > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > > > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > 
> > > > I think the series makes a lot of sense. I have checked your assertions
> > > > in the changelogs and found no flaws in your logic, so I think we should
> > > > take them all through arm-soc unless there are other concerns.
> > > 
> > > Thank you.
> > > 
> > > Should I resend everything or just patches that were not reposted yet
> > > (the ones that were marked as RFT initially and got no feedback)?
> > 
> > I'd be fine with just getting a pull request with all the patches that
> > had no negative feedback and that were not already applied (if any).
> 
> Here it is (sorry for taking so long).

I've just been digging in the dmesg logs from when I was using the
Assabet+Neponset as my firewall, and it was having to use the IDE
ide-cs driver rather than the pata pcmcia driver.

I don't recall whether the pata pcmcia driver was a problem or not,
as the PCMCIA interface can't cope with _any_ 32-bit accesses.  I
think PATA tries to use the "highest" possible access size by
default...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
