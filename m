From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 9 Mar 2018 15:02:41 -0300
Subject: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
In-Reply-To: <20180309180040.GI8347@kernel.org>
References: <20180307143832.GJ3701@kernel.org>
 <CAKTKpr4zMcRLykw8xwWJKf2eiuCrf2RuJ7kexGRQNN7_OdJ=uQ@mail.gmail.com>
 <52328144-3a2a-af03-273b-3a2f3bdadda6@redhat.com>
 <CAKTKpr7HgsdZ90k0_evSq_aZW-uGSKwLndHOQ2Jahajj3Gkc0Q@mail.gmail.com>
 <CAKTKpr5=Doy2bQz8yYcoRNUGQ1HEgLcqk7U+4m-=1T_TZWa4HA@mail.gmail.com>
 <20180309143415.GB4194@kernel.org> <20180309155808.GP15537@arm.com>
 <20180309173316.GF8347@kernel.org>
 <CAKTKpr7AQQVQKpQyeDObXvgq1Cps7K7STW2TngjFmOjmCRXQWQ@mail.gmail.com>
 <20180309180040.GI8347@kernel.org>
Message-ID: <20180309180241.GJ8347@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Mar 09, 2018 at 03:00:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 09, 2018 at 11:15:16PM +0530, Ganapatrao Kulkarni escreveu:
> > On Fri, Mar 9, 2018 at 11:03 PM, Arnaldo Carvalho de Melo
> > > +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > > @@ -13,5 +13,5 @@
> > >  #
> > >  #Family-model,Version,Filename,EventType
> > >  0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
> > > -0x00000000420f5160,v1,cavium/thunderx2,core
> > > +0x00000000430f0af0,v1,cavium/thunderx2,core
> > >  0x00000000480fd010,v1,hisilicon/hip08,core

> > please do not delete existing entry,  add additional entry.
> > > +0x00000000430f0af0,v1,cavium/thunderx2,core
 
> Ok, my bad, I think my eyes are failing me, I swear I saw them in the
> original patch, which is not the case...
 
> Ok, will add, together with Will's Acked-by

So this is how it ended up:


commit 9245299469de2e02d9c3cb167c0e52f75f1cc180
Author: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Date:   Wed Mar 7 16:38:03 2018 +0530

    perf vendor events arm64: Enable JSON events for ThunderX2 B0
    
    There is MIDR change on ThunderX2 B0, adding an entry to mapfile to
    enable JSON events for B0.
    
    Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ganapatrao Kulkarni <gpkulkarni@gklkml16.com>
    Cc: Jayachandran C <jnair@caviumnetworks.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: John Garry <john.garry@huawei.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Robert Richter <robert.richter@cavium.com>
    Cc: William Cohen <wcohen@redhat.com>
    Cc: linux-arm-kernel at lists.infradead.org
    Link: http://lkml.kernel.org/r/20180307110803.32418-1-ganapatrao.kulkarni at cavium.com
    [ Fixup wrt recent patchset by John Garry ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 8f11aeb003a9..f03e26ecb658 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -14,4 +14,5 @@
 #Family-model,Version,Filename,EventType
 0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
+0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
