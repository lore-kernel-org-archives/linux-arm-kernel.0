From: jason.wessel@windriver.com (Jason Wessel)
Date: Wed, 03 Mar 2010 17:36:18 -0600
Subject: [kGDB]Cannot compile KGDB on ARM SMP
In-Reply-To: <8cad0aa1003020107g3aae0875n1da8c442d9909f96@mail.gmail.com>
References: <8cad0aa1003020107g3aae0875n1da8c442d9909f96@mail.gmail.com>
Message-ID: <4B8EF272.1090007@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Jean-Michel Hautbois wrote:
> Hi there !
>
> I am  curently trying to compile kgdb on an ARM SMP core.
> I have the following error :
> kernel/kgdb.c:1481: undefined reference to `kgdb_roundup_cpus'
>
> When I am looking at the function 'kgdb_roundup_cpus', it is defined
> for x86, mips, blackfin, powerpc, but not for ARM.
> Is there any specific reason for that ?
> I can't see why...
>
>   

No one has yet to submit a patch which implements the proper way to
interrupt the slave CPUs and get them to call the kgdb_nmicallback(), as
well as to run the kgdb test suite on the SMP device.

I do not have any SMP ARM hw to test this, or I probably would have
implemented myself.

If you come up with any patches you can submit them here and please cc
kgdb-bugreport at lists.sourceforge.net.  If you have questions about the
kgdb test suite I am sure we can find some answers.

Thanks,
Jason.
