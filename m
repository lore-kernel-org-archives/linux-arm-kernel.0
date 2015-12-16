From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Dec 2015 14:15:54 +0100
Subject: arm-soc boot: 320 boots: 12 failed,
 308 passed (v4.4-rc3-483-gb48b5ceb7227)
In-Reply-To: <1746045.ErmxH37Pke@wuerfel>
References: <567128b4.46b71c0a.17f65.7531@mx.google.com>
 <1746045.ErmxH37Pke@wuerfel>
Message-ID: <4264525.bKhfcYWiXW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. Dezember 2015, 11:17:30 schrieb Arnd Bergmann:
> On Wednesday 16 December 2015 01:02:44 kernelci. org bot wrote:
> > arm-soc boot: 320 boots: 12 failed, 308 passed
> > (v4.4-rc3-483-gb48b5ceb7227)
> > 
> > Full Boot Summary:
> > https://kernelci.org/boot/all/job/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb72
> > 27/ Full Build Summary:
> > https://kernelci.org/build/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb7227/
> > 
> > Tree: arm-soc
> > Branch: local/for-next
> > Git Describe: v4.4-rc3-483-gb48b5ceb7227
> > Git Commit: b48b5ceb7227a8e6e548dae7a44c80ad85719808
> > Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> > Tested: 67 unique boards, 18 SoC families, 22 builds out of 135
> > 
> > Boot Failures Detected:
> > https://kernelci.org/boot/?v4.4-rc3-483-gb48b5ceb7227&fail
> We got three regressions in the arm-soc for-next branch today, compared to
> yesterday:
> 
> * I did not merge any rockchip changes, but it looks like multi_v7_defconfig
> is now broken on rk3288-rock2-square and rk3288-veyron-jerry (not in the
> list below, but in the web interface). I put a diff of the defconfig file
> on http://pastebin.com/DHgzz1jr, but I don't anything that may have cause
> the regression.

I would also think more of a hickup of the kernelci systems. When looking at 
veyron-jerry it shows the tftp kernel transfer not completing
(line "Waiting for the transfer"...) and then the board getting reset and 
booting the original chromeos after that.

On the rock2 there is also nothing standing out in terms of errors or so.
So I guess it might be best to simply check if that is still present tomorrow.


Heiko
