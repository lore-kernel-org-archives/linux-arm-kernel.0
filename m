From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 21 Jun 2018 14:44:54 -0700
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
Message-ID: <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 7:08 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Thu, Jun 21, 2018 at 9:47 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > I never assumed it was a regression and that USB worked on RDU1 board
> > before, so I never tried to see if this was a regression. I can only
> > tell you that it hangs as soon as any PORTSC registers are accessed.
>
> I think we need to investigate this portsc register hang further.
>

I just finished experimenting with it on RDU1 and Babbage boards and I
can't reproduce the hang that you describe against 4.18-rc1. At this
point I wonder if it's the bootloader that is a variable that plays
into this. I was booting both boards with 2018.06.0 version of barebox
+ the custom patches that can be found here
https://github.com/ndreys/barebox/commits/rdu1-netboot. Note that the
last patch in that branch/stack was added as a part of this
investigation, but even before it, I was able to boot Linux just fine,
albeit without working USB.

Any chance you can try it on your end and see if that makes a difference?

Thanks,
Andrey Smirnov
