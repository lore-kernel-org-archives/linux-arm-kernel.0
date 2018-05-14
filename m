From: bp@alien8.de (Borislav Petkov)
Date: Mon, 14 May 2018 18:47:20 +0200
Subject: [PATCH] ghes_edac: enable HIP08 platform edac driver
In-Reply-To: <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
Message-ID: <20180514164720.GH23049@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 04:12:08PM +0100, James Morse wrote:
> I'm afraid I'd like to keep both doors open. Kernel-first handling will require
> some ACPI-table/DT property as some aspects of the CPU extensions aren't
> discover-able. Can't we use this to pick up whether the platform supports
> firmware-first (HEST and GHES entries) or kernel-first via some as-yet-undefined
> HEST bits?

So how you detect those platforms is largely undefined as we're walking
new grounds here with the FF crap on the one hand and platform-specific
drivers on the other. So whatever works for you and as long as the
ugliness is nicely hidden. :-)

> Without GHES entries this code would never be run. So we 'just' need to catch
> systems that are describing both. (which can be the platform specific kernel
> first bits problem to do)

So the reason why we're doing this on x86 is that the majority of
GHES-advertizing platforms out there are a serious turd when it comes
to functioning fw.

So we've opted for known-good platforms list where there's backing from
the vendor to have firmware which is getting fixes and is being tested
properly.

And everything else we assume is crap. Thus we use the platform-specific
EDAC driver which we know it works and we can fix if there's an issue.
VS firmware which we can't. (I doubt anyone can, for that matter. :)...)

Anyway, this is the story in x86 land. JFYI guys in case it helps making
some decisions.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
