From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Oct 2011 09:37:38 +0100
Subject: [PATCH v2 2/8] ARM: smp: populate logical CPU mapping during boot
In-Reply-To: <CADrkgWK=Or3=js81b2kRb1drwUsuSyxWFv2LkcKC673VgODK0A@mail.gmail.com>
References: <CADrkgWK=Or3=js81b2kRb1drwUsuSyxWFv2LkcKC673VgODK0A@mail.gmail.com>
Message-ID: <20111025083738.GB6184@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 06:30:31PM +0100, IL HAN wrote:
> Hello,
>  
> Thanks for your patch.
>  
> But, actually, Linux Kernel could be booted on a CPU with physical ID != 0 ?
> or it is just in case ?

Well it seems daft to restrict ourself to booting on CPU 0 across the whole
of arch/arm/ despite there being platform issues in most cases. One place
where this might be used is making a kexec system call from a CPU other than
CPU 0, in which case the calling CPU will be the boot CPU for the new
kernel.

The mapping may also have useful implications when considering multi-cluster
support, but I've not thought about that in any detail.

Will
