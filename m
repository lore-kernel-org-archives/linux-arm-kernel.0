From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Jun 2013 18:09:54 +0200
Subject: [PATCH 02/10] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <51C2DF82.3030404@codethink.co.uk>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
 <1371645406-16873-3-git-send-email-ben.dooks@codethink.co.uk>
 <20130619193318.70a9988a@skate> <51C2DF82.3030404@codethink.co.uk>
Message-ID: <20130620180954.7448d824@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Thu, 20 Jun 2013 11:54:58 +0100, Ben Dooks wrote:

> > Also in
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/150784.html,
> > the same reviewer suggested to name the macro BE8() to make it fit like
> > ARM() and THUMB() in the margin left by the indentation of assembly
> > code. And also to add LE() to make the above code look like:
> >
> > BE8(	bic ip, ip, #0xff000000)
> > BE8(	orr ip, ip, r6, lsl#24)
> > LE(	bic ip, ip, #0x000000ff)
> > LE(	orr ip, ip, r6)
> 
> Actually, that doesn't work as LE is not the inverse of BE8 as
> it could also be when the kernel is being compiled in BE32.

Aah, correct. In BE32, data and instructions have the same endianness.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
