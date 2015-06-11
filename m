From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 15:58:15 -0700
Subject: [PATCH 0/2] ARM: socfpga: Add CPU_METHOD_OF_DECLARE for SoCFPGA
In-Reply-To: <1433297642-3818-1-git-send-email-dinh.linux@gmail.com>
References: <1433297642-3818-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <CAMAWPa-y-7N4GMhigvFMdk3BAU=3Nd2vEYVAQ+mBgd3-xK1aJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Tue, Jun 2, 2015 at 7:14 PM,  <dinh.linux@gmail.com> wrote:
> From: Dinh Nguyen <dinh.linux@gmail.com>
>
> Hi Arnd, Kevin, Olof:
>
> Please apply these 2 patches for v4.2. I could not do a pull request for
> these as they will cause a merge conflict for arm-soc/next.
>
> Thanks,
>
> Dinh Nguyen (2):
>   ARM: socfpga: use CPU_METHOD_OF_DECLARE for socfpga_cyclone5
>   ARM: socfpga: add CPU_METHOD_OF_DECLARE for Arria 10

This one caused a build failure after merging the L1 invalidate patch
from Russell[1] since it removed the SoC specific secondary startup.
I've fixed this up in our next/soc branch by using the generic
secondary_startup[2].  Please let me know if you see any issues with
this.

Kevin

[1] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=next/cleanup&id=02b4e2756e01c623cc4dbceae4b07be75252db5b

[2] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=socfpga/soc&id=89b8da06ba302dd130df60df7964ccd3ab151cd6
