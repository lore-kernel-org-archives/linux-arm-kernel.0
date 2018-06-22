From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Jun 2018 13:27:20 -0300
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
Message-ID: <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Thu, Jun 21, 2018 at 6:44 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I just finished experimenting with it on RDU1 and Babbage boards and I
> can't reproduce the hang that you describe against 4.18-rc1. At this
> point I wonder if it's the bootloader that is a variable that plays
> into this. I was booting both boards with 2018.06.0 version of barebox
> + the custom patches that can be found here
> https://github.com/ndreys/barebox/commits/rdu1-netboot. Note that the
> last patch in that branch/stack was added as a part of this
> investigation, but even before it, I was able to boot Linux just fine,
> albeit without working USB.

Thanks for investigating this issue.

Yes, t is possible that the difference in behaviour that we see could
be related to the fact we use different bootloaders.

In order to make things easier, I am sharing a Buildroot image for
imx51-babbage that contains U-Boot 2018.05 + kernel 4.17.2:
https://www.dropbox.com/s/yevnu4y1zdchnbt/sdcard.img?dl=0

Please flash it directly to the SD card via dd and boot it.

You will notice that it will boot normally. Then please copy a
4.18-rc1 zImage into the first SD card partition and you will notice
the hang.

Thanks
