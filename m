From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Jun 2015 15:01:49 -0300
Subject: Running kexec on mx6
In-Reply-To: <20150616161317.GS7557@n2100.arm.linux.org.uk>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
 <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
 <CAOMZO5DBoKXE9URxWvk+WkJEZ1RkC4S3hAyugTbd7b5Qu91QKA@mail.gmail.com>
 <CAOMZO5DOdrJdkvmtBV3Kegdxg=LVZB60qB_TvMJ-D45+1vDAHw@mail.gmail.com>
 <20150616094242.GR7557@n2100.arm.linux.org.uk>
 <CAOMZO5B9ysnLKpCrpyN3JBUrxVT7MOh7crY3nS8MDW2Hv4Xs+A@mail.gmail.com>
 <CAOMZO5BYCNuQ=5zHurf6Zqmpwcj1tiCZj7Nj4j6ygijbePNBFw@mail.gmail.com>
 <20150616161317.GS7557@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5A43JV9piTpkoQQdkYr2P-ysEZVaXLQWd4mNW7OTe_ANw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 1:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Well, the good news is I can reproduce it here... the bad news is that
> my attempt to debug it so far is causing extra problems - because the
> imx6 uart is having its clocks disabled, which kind'a makes it hard to
> get debug out... that's wasted half an hour working that out, and
> further debug is now going to have to wait until later this evening
> or tomorrow.

Thanks, Russell.

I am having different results from the initial post now.

I noticed that 4.1-rc works fine, but 4.0 does not.

If I apply commit fee3fd4fd2ad136b ("ARM: 8338/1: kexec: Relax SMP
validation to improve DT compatibility") against 4.0 then kexec works
fine here.
