From: ccross@android.com (Colin Cross)
Date: Wed, 22 Feb 2012 11:19:53 -0800
Subject: [PATCH v3 02/10] ARM: tegra: export Tegra chipid
In-Reply-To: <CAOesGMi=nsKr91uu=QTpJ_vKKhc9GBRHPWd6XEB+rOqph_P+yA@mail.gmail.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
 <1328831277-21002-3-git-send-email-pdeschrijver@nvidia.com>
 <CAMbhsRT-ZTh7WQ1E0NUjX8FOMGAvx5zNnB-VYD=j8sWhM-9j+A@mail.gmail.com>
 <CAOesGMi=nsKr91uu=QTpJ_vKKhc9GBRHPWd6XEB+rOqph_P+yA@mail.gmail.com>
Message-ID: <CAMbhsRScEnZQrO3Ufrop+Me_ZKoZ=Cd7HqeAdDUOTe2dLPEjiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 3:30 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Mon, Feb 20, 2012 at 3:13 PM, Colin Cross <ccross@android.com> wrote:
>
>> Other platforms use accessors for this (cpu_is_xxx(), although
>> soc_is_xxx() is probably more appropriate).
>
> I have previously objected to additions of said functions on tegra,
> since they tend to start crawling into drivers as runtime tests
> instead of providing more appropriate detection at probe time.
>
> I can be persuaded differently but I haven't yet seen a strong case
> for changing my mind. :)

soc_is_xxx() is better than spreading tegra_chip_id == XXX all over
the place, but keeping them out of drivers completely is even better.
