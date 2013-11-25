From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 25 Nov 2013 09:03:36 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87d2lp28pd.fsf@natisbad.org>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org>
Message-ID: <20131125120335.GD2408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Sun, Nov 24, 2013 at 03:08:46PM +0100, Arnaud Ebalard wrote:
> 
> As ReadyNAS 102, 104 and 2120 all depend on your driver, I decided to
> give v4 a change on a 102. As a side note, all those device have the
> same NAND chip, i.e. a 128 MB hynix H27U1G8F2BTR. Additionally, this is
> also the chip found on ReadyNAS Duo v2, which is perfectly handled by
> orion-nand driver.
> 
> With your 31 patches in my quilt set against current linus tree (w/
> 2 to 4 of 31 disabled as they are already in Linus tree), I modified
> my .dts in the following way:
> 
>  nand at d0000 {
>          status = "okay";
>          num-cs = <1>;
>          marvell,nand-keep-config;
>          marvell,nand-enable-arbiter;
>          nand-on-flash-bbt;
> 

Great! Thanks for giving NAND a chance :-)

Could you try using the devicetree snippet below?

nand at d0000 {
	/* HACK: Use legacy compatible to handle smaller pages */
	compatible = "marvell,pxa3xx-nand";
	status = "okay";
	num-cs = <1>;
	marvell,nand-keep-config;
	marvell,nand-enable-arbiter;
	nand-on-flash-bbt;

	/* partitions */
};

Please check if your device is detected and try to do some reading
first. If that works, you can try to mount the filesystem, or write
a new kernel.

If the above works, I'll prepare a proper patch.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
