From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Nov 2017 11:47:44 +0000
Subject: [PATCH] arm64: fix missing 'const' qualifiers
In-Reply-To: <20171129093225.tq2cbg6l6yupkeit@yury-thinkpad>
References: <20171125094127.7536-1-ynorov@caviumnetworks.com>
 <20171128183355.GO9266@arm.com>
 <20171129093225.tq2cbg6l6yupkeit@yury-thinkpad>
Message-ID: <20171129114744.GB10650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 12:32:25PM +0300, Yury Norov wrote:
> On Tue, Nov 28, 2017 at 06:33:55PM +0000, Will Deacon wrote:
> > On Sat, Nov 25, 2017 at 12:41:27PM +0300, Yury Norov wrote:
> > > It was discovered during LTO-enabled compilation with gcc/ld.bfd.
> > 
> > What was discovered? Could you provide a bit more information in the
> > changelog, please? I'm happy to take this as a fix if it's actually fixing
> > something.
> 
> Yes it does. There's inconsistency in variable declaration and
> section type. GCC doesn't throw error for usual build, but if LTO
> enabled, build becomes broken, like this:
> 
> mm/percpu.c:2168:20: error: pcpu_fc_names causes a section type conflict
> with dt_supported_cpu_ops
> const char * const pcpu_fc_names[PCPU_FC_NR] __initconst = {
>         ^
> arch/arm64/kernel/cpu_ops.c:34:37: note: ?dt_supported_cpu_ops? was declared here
> static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
> 
> And so on. Let me know if you need full error log, then I'll resend the
> patch with it.

I think it would be helpful to include one of the errors in the commit
message.

Please send a v2 with that.

Will
