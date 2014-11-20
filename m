From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 20 Nov 2014 14:05:15 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable cgroups
In-Reply-To: <201411201354.52679.arnd@arndb.de>
References: <1416254107-29326-1-git-send-email-soren.brinkmann@xilinx.com>
 <201411201354.52679.arnd@arndb.de>
Message-ID: <CABxcv=mTMi=yOD_ZmO73P7V9skhuedf8yfxbPbQuoreJMRdCoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 20, 2014 at 1:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 17 November 2014, Soren Brinkmann wrote:
>> This allows booting the kernel with systemd-based root file systems.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>> Hi,
>>
>> I don't know whether I'm the only one, but I use a initramfs with
>> systemd as init, which requires cgroup support in the kernel to fully
>> boot.
>>
>
> You probably are at this time, but I expect it to get more common
> in the future, I don't think enabling this is controversial at all.
>

Others are using it but with SoC specific defconfig and not multi_v7.

Newer version of systemd needs more config symbols to be enabled
besides cgroups, the full list is at
http://cgit.freedesktop.org/systemd/systemd/tree/README.

Tony recently added the recommended support to OMAP2+ defconfig so
something along these lines should be added to multi_v7 as a
follow-up:

673ce00c ("ARM: omap2plus_defconfig: Add support for distros with systemd")

Best regards,
Javier
