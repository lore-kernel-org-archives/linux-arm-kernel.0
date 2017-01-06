From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 6 Jan 2017 10:46:21 +0100
Subject: [PATCHv2 0/2] Memblock cleanup plus memory removal fix
In-Reply-To: <1483657274-11346-1-git-send-email-labbott@redhat.com>
References: <1483657274-11346-1-git-send-email-labbott@redhat.com>
Message-ID: <CAM=E1R7CfCUw25+ONSx1Vz29dxEQgjM0M7OddY_kihpRTnWLeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 6 January 2017 at 00:01, Laura Abbott <labbott@redhat.com> wrote:
> Hi,
>
> This is v2 of the series to make sanity_check_meminfo (renamed in this series)
> more readable and less error prone and fix an existing bug. v1 failed in that it
> re-introduced a previously fixed bug. Hopefully this version does better.
>
> As a reminder, During the course of
> https://marc.info/?l=linux-arm-kernel&m=148145259511248, Grygorii Strashko
> reminded me of another issue where I proposed a patch but never followed up on
> it. The patch in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296978.html
> did some cleanup and renaming of sanity_check_meminfo. I think this makes the
> code more readable so I'd like to resurect it and rebase my fix
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474060.html
> on top of it.
>

Tested the series on i.MX31 PDK board.

Tested-by: Magnus Lilja <lilja.magnus@gmail.com>

/Magnus


> Laura Abbott (2):
>   arm: Cleanup sanity_check_meminfo
>   arm: Adjust memory boundaries after reservations
>
>  arch/arm/kernel/setup.c | 12 ++++++++--
>  arch/arm/mm/mmu.c       | 62 +++++++++++++++++--------------------------------
>  arch/arm/mm/nommu.c     |  8 +++----
>  3 files changed, 35 insertions(+), 47 deletions(-)
>
> --
> 2.7.4
>
