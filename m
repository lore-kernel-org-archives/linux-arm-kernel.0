From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Tue, 18 Aug 2015 10:03:33 -0700
Subject: [PATCH v3 0/3] qcom: Add SMEM MTD parser
In-Reply-To: <CAOiHx=nPDBPsj_Kg_7AkFeieedwGbcJmvALDp2eK+6aKi0wOJA@mail.gmail.com>
References: <1439855266-26242-1-git-send-email-mathieu@codeaurora.org>
 <CAOiHx=nPDBPsj_Kg_7AkFeieedwGbcJmvALDp2eK+6aKi0wOJA@mail.gmail.com>
Message-ID: <20150818170333.GA1581@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 02:30:14PM +0200, Jonas Gorski wrote:
> Hi,
> 
> On Tue, Aug 18, 2015 at 1:47 AM, Mathieu Olivari <mathieu@codeaurora.org> wrote:
> > QCOM platforms such as IPQ806x are using SMEM to store their flash
> > layout. This patch set adds the DT nodes required to instanciate SMEM
> > on IPQ806x and add an MTD parser using it.
> >
> > This change is based on the SMEM driver posted here:
> > *https://lkml.org/lkml/2015/7/27/1125
> 
> Nice work. After testing it on AP148 I see this:
> 
> [    2.481507] 12 qcom-smem partitions found on MTD device qcom-nandc
> [    2.481540] Creating 12 MTD partitions on "qcom-nandc":
> [    2.486690] 0x000000000000-0x000000040000 : "0:SBL1"
> [    2.492842] 0x000000040000-0x000000180000 : "0:MIBIB"
> [    2.497857] 0x000000180000-0x0000002c0000 : "0:SBL2"
> [    2.502895] 0x0000002c0000-0x000000540000 : "0:SBL3"
> [    2.507828] 0x000000540000-0x000000660000 : "0:DDRCONFIG"
> [    2.512857] 0x000000660000-0x000000780000 : "0:SSD"
> [    2.518074] 0x000000780000-0x000000a00000 : "0:TZ"
> [    2.522834] 0x000000a00000-0x000000c80000 : "0:RPM"
> [    2.527607] 0x000000c80000-0x000001180000 : "0:APPSBL"
> [    2.532472] 0x000001180000-0x000001200000 : "0:APPSBLENV"
> [    2.537586] 0x000001200000-0x000001340000 : "0:ART"
> [    2.543140] 0x000001340000-0x000005340000 : "rootfs"
> 
> Are all these partition names supposed to be prefixed with "0:"? This
> is using the OpenWrt applied version.

Yes. These are the names as they are listed in SMEM. If you run the
"smem" command from the U-boot prompt, you will see the same information.
I'm not sure what the 0: prefix means, and where it comes from to be
honest.

> 
> 
> Jonas
