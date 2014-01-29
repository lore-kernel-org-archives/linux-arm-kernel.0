From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 29 Jan 2014 13:54:22 +0900
Subject: [PATCH 2/2] arm64: kernel: use seq_puts() instead of seq_printf()
In-Reply-To: <20140128155156.GC24617@arm.com>
References: <001d01cf1bc9$452569d0$cf703d70$%han@samsung.com>
 <001f01cf1bc9$57767070$06635150$%han@samsung.com>
 <20140128155156.GC24617@arm.com>
Message-ID: <001201cf1cae$2d60ce80$88226b80$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 29, 2014 12:52 AM, Catalin Marinas wrote:
> On Tue, Jan 28, 2014 at 01:36:18AM +0000, Jingoo Han wrote:
> > For a constant format without additional arguments, use seq_puts()
> > instead of seq_printf(). Also, it fixes the following checkpatch
> > warning.
> >
> >   WARNING: Prefer seq_puts to seq_printf
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  arch/arm64/kernel/setup.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index c8e9eff..4507691 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -416,7 +416,7 @@ static int c_show(struct seq_file *m, void *v)
> >  			seq_printf(m, "%s ", hwcap_str[i]);
> >
> >  	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
> > -	seq_printf(m, "CPU architecture: AArch64\n");
> > +	seq_puts(m, "CPU architecture: AArch64\n");
> >  	seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
> >  	seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
> >  	seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
> 
> Just ignore the checkpatch warning. I prefer the consistency of
> seq_printf() in this function.

(+cc Joe Perches, Dan Carpenter)

Personally, I don't like the checkpatch warning.
However, I respect your opinion on the consistency.
Thank you for your comment.

Best regards,
Jingoo Han
