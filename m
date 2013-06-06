From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 6 Jun 2013 04:34:47 +0000 (UTC)
Subject: Tegra baseline test results for v3.10-rc1
In-Reply-To: <51AF5698.5050106@wwwdotorg.org>
References: <alpine.DEB.2.02.1306050558430.13098@utopia.booyaka.com>
 <51AF5698.5050106@wwwdotorg.org>
Message-ID: <alpine.DEB.2.02.1306060421250.15042@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

thanks very much for the review -

On Wed, 5 Jun 2013, Stephen Warren wrote:

> On 06/04/2013 11:59 PM, Paul Walmsley wrote:
> > 
> > Here are some basic Tegra test results for Linux v3.10-rc1.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/tegra/testlogs/test_v3.10-rc1/20130518212204/
>
> That URL is 404, although going up one directory manually lets me find
> the logs.

Indeed - this is now fixed in the copy of the README.txt that's on the 
server.  The correct URL should be:

http://www.pwsan.com/tegra/testlogs/test_v3.10-rc1/20130519152115/

Looks like the -rc2 through -rc4 URLs are correct.

> I can access all the log files there, but can't download the zImage; I
> get permission denied. I can download the .dtb file. Is this deliberate?

For the moment, yes.  I haven't gotten comfortable with distributing 
executable code yet.  

> I'm curious what the difference is between the "t33beaver" and
> "tegra30-beaver" path entries is, in the following URL:
> 
> http://www.pwsan.com/tegra/testlogs/test_v3.10-rc1/20130519152115/boot/t33beaver/tegra30-beaver/
> 
> It might be better to call this board just "tegra30-beaver" for
> consistency with other upstream tools like cbootimage-configs and the
> DTB filename.

In the boot test environment here, "t33beaver" uniquely identifies the 
board, while "tegra30-beaver" identifies the DTB used to boot it.  
So if an alternate DTB were used, the boot test path would be:

../boot/t33beaver/tegra30-beaver-alternate/

If it's important to you, I'll change it.  Otherwise, I'd prefer not to 
call the board 'tegra30-beaver' -- mostly to avoid confusing myself 
between the board name and the DTB name :-)

> In the boot logs, I see:
> 
> Tegra30 (Beaver) # setenv bootargs 'console=ttyS0,230400n8
> lp0_vec=0x00002000 at 0x9C406000 video=tegrafb mem=1023M at 2048M vmalloc=128M
> noinitrd usbcore.old_scheme_first=1 core_edp_mv=1300 panel=lvds
> tegraid=30.1.2.0.0 debug_uartport=lsport tegra_fbmem=4104K at 0xFF900000
> max_cpu_cur_ma=10000 root=/dev/mmcblk0p1 rw rootwait gpt'
> 
> Most of those options aren't necessary for the upstream kernel.
> Unfortunately, our downstream kernel requires a bunch of crufty options,
> but upstream doesn't. It might be worth minimizing the set of options
> passed to upstream, so there's no possibility that those options ever do
> anything; most won't since they're custom options no supported upstream,
> but I wonder if e.g. mem, vmalloc, gpt might have negative effects even now.

Certainly - will figure out which of these are actually needed for the 
mainline kernel, and will update the kernel command line.


- Paul
