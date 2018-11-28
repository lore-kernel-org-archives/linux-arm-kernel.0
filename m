From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Wed, 28 Nov 2018 09:56:24 +0530
Subject: [PATCH v2] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
In-Reply-To: <20181128015754.GI1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
 <20181127232916.GG1824@MiWiFi-R3L-srv>
 <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
 <20181128015754.GI1824@MiWiFi-R3L-srv>
Message-ID: <CACi5LpM23rZQVe-bDirfNEODwe-zZDo0VyTFUG_969mgisL+gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 7:27 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/27/18 at 04:39pm, Kees Cook wrote:
> > >> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > >> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> > >> >> --- a/arch/x86/kernel/machine_kexec_64.c
> > >> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> > >> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> > >> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> > >> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> > >> >>                       pgtable_l5_enabled());
> > >> >> +#ifdef CONFIG_RANDOMIZE_BASE
> >
> > Okay, gotcha. In that case, shouldn't this be CONFIG_RANDOMIZE_MEMORY?
>
> And yes, if we only care about KASLR, it should be
> CONFIG_RANDOMIZE_MEMORY, but not CONFIG_RANDOMIZE_BASE.
>

Have you tried building the changes with 'make allmodconfig' with all
the different CONFIG options you have suggested so far?
