From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jun 2015 17:13:17 +0100
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5BYCNuQ=5zHurf6Zqmpwcj1tiCZj7Nj4j6ygijbePNBFw@mail.gmail.com>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
 <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
 <CAOMZO5DBoKXE9URxWvk+WkJEZ1RkC4S3hAyugTbd7b5Qu91QKA@mail.gmail.com>
 <CAOMZO5DOdrJdkvmtBV3Kegdxg=LVZB60qB_TvMJ-D45+1vDAHw@mail.gmail.com>
 <20150616094242.GR7557@n2100.arm.linux.org.uk>
 <CAOMZO5B9ysnLKpCrpyN3JBUrxVT7MOh7crY3nS8MDW2Hv4Xs+A@mail.gmail.com>
 <CAOMZO5BYCNuQ=5zHurf6Zqmpwcj1tiCZj7Nj4j6ygijbePNBFw@mail.gmail.com>
Message-ID: <20150616161317.GS7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 09:46:46AM -0300, Fabio Estevam wrote:
> On Tue, Jun 16, 2015 at 8:15 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> >> Which kernel - the one which is doing the kexec, or the one being kexec'd
> >> into?
> >
> > In my tests the kernel which is doing the kexec needs to have
> > CONFIG_SMP=n, so that kexec works on mx6solo.
> 
> Other combination that works is to have CONFIG_SMP=y and then pass
> 'nosmp' in the kernel command line, or also by removing cpu1 from the
> imx6dl.dtsi.

Well, the good news is I can reproduce it here... the bad news is that
my attempt to debug it so far is causing extra problems - because the
imx6 uart is having its clocks disabled, which kind'a makes it hard to
get debug out... that's wasted half an hour working that out, and
further debug is now going to have to wait until later this evening
or tomorrow.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
