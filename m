From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Nov 2012 16:57:58 +0530
Subject: [PATCH v3 2/6] ARM: davinci: Changed pr_warning() to pr_warn()
 (part 2)
In-Reply-To: <50A4B9E9.6000303@mvista.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-2-git-send-email-rtivy@ti.com>
 <50A36FA9.5050601@mvista.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F2D0E@DFLE08.ent.ti.com>
 <50A4B9E9.6000303@mvista.com>
Message-ID: <50AB693E.7090800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 3:16 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 15-11-2012 5:53, Tivy, Robert wrote:
> 
>>>> Also, while modifying those pr_warning() calls I changed hardcoded
>>>> function names to use '"%s:", __func__' instead
> 
>>>> Signed-off-by: Robert Tivy <rtivy@ti.com>
>>>> ---
>>>> Clean up files that will be otherwise modified in subsequent patch.
> 
>>>> Applies to v3.7-rc2 tag (commit
>>>> 6f0c0580b70c89094b3422ba81118c7b959c7556) of Linus' mainline kernel
>>> at git.kernel.org.
> 
>>>>    arch/arm/mach-davinci/board-omapl138-hawk.c |   30 ++++++++++------
>>> -----------
>>>>    1 file changed, 11 insertions(+), 19 deletions(-)
> 
>>>      Taksing of separation of board and SoC specific changes, this patch
> 
>    I meant "talking". :-/
> 
>>> shouldn't have been separated from patch 1 at all -- since it's two
>>> boards built around the same chip, OMAP-L138...
> 
>> The 4 patches that are of the same nature ("Changed pr_warning() to
>> pr_warn() (part #)") were split as 4 separate patches on request by
>> Sekhar, for the purpose of making it easier to merge later.
> 
>    To quote Sekhar: "My main motivation was to keep board and soc file
> changes from mixing together." You just went too far.

Since this has already gone back and forth a couple of times (probably
due to me not being entirely clear on what I want), lets proceed this way:

Merge patches 1/6 and 2/6 into a patch titled:

ARM: davinci: da850 board: change pr_warning() to pr_warn()

Re-headline 3/6 as:

ARM: davinci: devices-da8xx.c: change pr_warning() to pr_warn()

Re-headline 4/6 as:

ARM: davinci: psc.c: change pr_warning() to pr_warn()

I hope that's acceptable to everyone involved.

Thanks,
Sekhar
