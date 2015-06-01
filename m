From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Jun 2015 11:53:20 +0100
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <CAMuHMdUQkm_9PhSdGS8j85Uodm-o0jiki=Xh4h59PBShB=rCXw@mail.gmail.com>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <CAMuHMdX=T3CsLTT95H_07Si6Kd8SRraBfxADpn+VtAF4GmZ=mw@mail.gmail.com>
 <CAMuHMdUQkm_9PhSdGS8j85Uodm-o0jiki=Xh4h59PBShB=rCXw@mail.gmail.com>
Message-ID: <20150601105319.GQ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 12:41:01PM +0200, Geert Uytterhoeven wrote:
> FWIW, I have the feeling this has a slight influence on boot reliability on
> two of my boards:
>   - r8a7740/armadillo, which is known to suffer from a cache-related bug in
>     its bootloader, seems to have a higher change of booting successfully on
>     cold boot,
>   - sh73a0/kzm9g, which has known cache-issues with secondary CPU boot up,
>     seems to have a lower chance of booting successfully.
> 
> No time to spend all week turning this into a statistical significant test
> project... The reset button is my friend...

Damn it, you sent this right after I merged and pushed out this change in
my for-arm-soc branch, and was just about to send it to the arm-soc people.
What excellent timing you have. :)

What happens on the kzm9g if you revert the mach-shmobile changes?

For armadillo, do you use the decompressor?  That should be doing all the
cache cleaning already, prior to the kernel being entered.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
