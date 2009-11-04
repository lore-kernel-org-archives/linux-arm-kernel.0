From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 4 Nov 2009 14:15:01 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
References: <OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
Message-ID: <20091104131500.GZ14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2009 at 01:09:32PM +0530, Vadivelan M wrote:
>      I am porting Linux-2.6.28 Kernel on IMX27based board.
>      Filesystem is mounted and after that we are getting message Freeing init
>      memory and some junk characters are coming. Keyboards are responding.
>      Can anybody help us in this regard.
> 
>      Thanks,
> 
>      Please see the following logs ..
> 
>      Launch LinuxUncompressing
>      Linux......................................................................
>      done, booting the kernel.
>      Linux version 2.6.28-arm2 (root at localhost.localdomain) (gcc version
>      4.1.1) #75 Wed Oct 28 13:12:53 IST 2009
>      CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00053177
>      CPU: VIVT data cache, VIVT instruction cache
>      Machine: Freescale i.MX27ADS
>      Kernel command line: root=/dev/ram rw mem=64M console=ttymxc0,115200

Your kernel uses 115200 baud to output these messages ...

[...]

>      EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
>      VFS: Mounted root (ext2 filesystem).
>      Freeing init memory: 92K
> 
>      After this some junk characters are coming like ....
> 
>      &#65533;&#65533;&#1421;&#65533;&#531488;0^&#1949;&#65533;&#65533;r&#65533;'&#65533;&#65533;&#65533;j&#65533;&#65533;r:&#65533;&#65533;&#65533;&#65533;&#65533;&#65533;&#65533;:&#65533;&#65533;M&#65533;.&#65533;&#65533;D&#65533;d&#65533;z.?&#65533;&#65533;.T&#65533;&#65533;8V&#65533;`&#65533;T&#65533;&#65533;&#65533;V&#51082;]nn]^&#65400;&#65533;m8m&#65533;&#65533;^&#65533;.&#65533;m&#65533;.E&#65533;&#65533;N&#65533;&#65533;8&#65533;&#65533;6&#65533;&#65533;&#65533;:]&#65533;&#65533;&#65533;

... and in your inittab, there seems to be a getty registered which
operates at a different speed. Change either of the two and you should
be fine.

Daniel
