From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Mon, 16 Jan 2017 18:04:24 +0530
Subject: [PATCH RFC 2/2] ARM: nommu: remap exception base address to RAM
In-Reply-To: <83be771e-b432-0950-202b-afb09f125865@arm.com>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
 <20161213100226.GW14217@n2100.armlinux.org.uk>
 <20170107171339.GA5044@afzalpc> <20170115114750.GA5456@afzalpc>
 <83be771e-b432-0950-202b-afb09f125865@arm.com>
Message-ID: <20170116123424.GA6330@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 16, 2017 at 09:53:41AM +0000, Vladimir Murzin wrote:
> On 15/01/17 11:47, Afzal Mohammed wrote:

> > mpu_setup_region() in arch/arm/mm/nommu.c that takes care of
> > MPU_RAM_REGION only. And that seems to be a kind of redundant as it is
> > also done in asm at __setup_mpu(). Git blames asm & C to consecutive
> > commits, that makes me a little shaky about the conclusion on it being
> > redundant.
> 
> It is not redundant. MPU setup is done it two steps. The first step done in
> asm to enable caches, there only kernel image is covered; the second step takes
> care on the whole RAM given via dt or "mem=" parameter.

Okay, thanks for the details.

> > Thinking of invoking mpu_setup() from secondary_start_kernel() in
> > arch/arm/kernel/smp.c, with mpu_setup() being slightly modified to
> > avoid storing region details again when invoked by secondary cpu's.
> 
> I have wip patches on reworking MPU setup code. The idea is to start using
> mpu_rgn_info[] actively, so asm part for secondariness would just sync-up
> content of that array. Additionally, it seems that we can reuse free MPU slots
> to cover memory which is discarded due to MPU alignment restrictions... 
> 
> > Vladimir, once changes are done after a revisit, i would need your
> > help to test on Cortex-R.
> 
> I'm more than happy to help, but currently I have limited bandwidth, so if it
> can wait till the next dev cycle I'd try to make MPU rework finished by that
> time.

Okay, please feel free to do MPU rework the way you were planning, you
know more details & have the platform to achieve it with much higher
efficiency than me.

Regards
afzal
