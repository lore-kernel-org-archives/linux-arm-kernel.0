From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 4 Jul 2018 22:22:07 +0200
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180628090655.GL112168@atomide.com>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com> <20180627205834.GB29478@amd>
 <20180628090655.GL112168@atomide.com>
Message-ID: <20180704202207.GA15246@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> OK. I checked and duovero runs only at 600MHz. I can only
> get down to 19 seconds with omap2plus_defconfig if I disable
> CONFIG_CPU_FREQ so the max speed is maintained from bootloader.
> Otherwise it runs at most at 1GHz, I think any higher speeds
> need smartreflex and voltage scaling working which we don't
> have in the mainline kernel. Not sure what happens with higher
> speeds with mainline kernel or if they are unsafe in the long
> run.
> 
> Anyways, care to post your .config somewhere so I can see what
> the numbers are for me with it?

After reboot (same config as in previous mail), before x / ofono /
unicsy_demo /... were started:

user at devuan:~$ uname -a
Linux devuan 4.18.0-rc3-88788-g528947b #758 SMP Wed Jul 4 10:05:21
CEST 2018 armv7l GNU/Linux
user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
| wc -c
10044041
11.50user 0.37system 11.57 (0m11.570s) elapsed 102.63%CPU
user at devuan:~$

droid 4.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/b53d01f6/attachment.sig>
