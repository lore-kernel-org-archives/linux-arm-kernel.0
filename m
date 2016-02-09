From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 9 Feb 2016 14:28:51 -0500 (EST)
Subject: [PATCH v4 3/3] kallsyms: remove --page-offset command line option
In-Reply-To: <CAKv+Gu-rdP7-=Z2SO2jRS_dHzB8UDpZ7-RowN_400d32Qvxmqg@mail.gmail.com>
References: <1455030828-6416-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455030828-6416-4-git-send-email-ard.biesheuvel@linaro.org>
 <HKXPR06MB056549C714A864B2D4F37DCA8AD60@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu-rdP7-=Z2SO2jRS_dHzB8UDpZ7-RowN_400d32Qvxmqg@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1602091407380.17825@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Feb 2016, Ard Biesheuvel wrote:

> On 9 February 2016 at 17:09, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> > On 9 Feb 2016, Ard Biesheuvel wrote:
> >
> >>diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> >>index 02473b71643b..32c8d43590af 100644
> >>--- a/scripts/kallsyms.c
> >>+++ b/scripts/kallsyms.c
> >>@@ -63,7 +63,6 @@ static unsigned int table_size, table_cnt;
> >> static int all_symbols = 0;
> >> static int absolute_percpu = 0;
> >> static char symbol_prefix_char = '\0';
> >>-static unsigned long long kernel_start_addr = 0;
> >> static int base_relative = 0;
> >
> >
> >
> > You removed kernel_start_addr, but you didn't remove all the instances of it in the file (you did remove them all in V2 though).
> >
> > So, now I get:
> >
> >   CC      scripts/mod/devicetable-offsets.s
> > ../scripts/kallsyms.c: In function 'record_relative_base':
> > ../scripts/kallsyms.c:740:6: error: 'kernel_start_addr' undeclared (first use in this function)
> >   if (kernel_start_addr > 0) {
> >       ^
> > ../scripts/kallsyms.c:740:6: note: each undeclared identifier is reported only once for each function it appears in
> > make[2]: *** [scripts/kallsyms] Error 1
> >
> 
> That is because this patch
> 
> http://ozlabs.org/~akpm/mmots/broken-out/kallsyms-add-support-for-relative-offsets-in-kallsyms-address-table-v5.patch
> 
> is also in flight, via akpm's tree, and is expected to hit -next
> tomorrow. That patch removes this reference (or alternatively, will
> not introduce it anymore if akpm decides to fold it into
> http://ozlabs.org/~akpm/mmots/broken-out/kallsyms-add-support-for-relative-offsets-in-kallsyms-address-table.patch
> before submitting it)
> 
> Going forward, it probably makes sense to only submit #1 of this
> series for v4.6, and queue the remaining two after the merge window.

Well... If akpm agrees, you could get those patches back and create a 
tree of your own with all ACKs for this work to avoi all this patch 
ordering dependency nightmare (including the work that depends on this) 
and submit it upstream (to Linus maybe?) while having it merged in 
linux-next in the mean time.


Nicolas
