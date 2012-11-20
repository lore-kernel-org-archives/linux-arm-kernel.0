From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Nov 2012 16:02:19 +0000
Subject: KEXEC on ARM cortex-a15
In-Reply-To: <CAJXQGf+wfXGZ=PWN585dJDMX1nH+sRexf6UZujyjKM6rJeDiXQ@mail.gmail.com>
References: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
 <20121119144417.GH3290@n2100.arm.linux.org.uk>
 <20121119151327.GG3205@mudshark.cambridge.arm.com>
 <CAJXQGf+BQ18GhR3emhK-ejTivqx_o=gtaO3-FjTiE3BMGydgsw@mail.gmail.com>
 <CAJXQGf+wfXGZ=PWN585dJDMX1nH+sRexf6UZujyjKM6rJeDiXQ@mail.gmail.com>
Message-ID: <20121120160219.GF26475@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 03:02:17PM +0000, Naresh Bhat wrote:
> Hi All,
> 
> I downloaded, compiled and installed bleeding edge GIT repository
> http://horms.net/projects/kexec/ on my Cortex-a15 target.
> After execution of below command the target hangs.
> 
> bash-4.2# kexec -f uImage --dtb=vexpress.dtb
> --command-line="root=/dev/nfs rw ip=dhcp -serial stdio
> console=ttyAMA0"
> Starting new kernel
> Bye!
> Uncompressing Linux...
> 
> Any idea why it is happening ?
> 
> i appreciate your help/any comments.
> 
> My kernel version is v3.4 from kernel.org
> vexpress.dtb - Is generated from vexpress-v2p-ca15_a7.dts

Your platform probably doesn't park the secondary CPUs correctly. Try
booting the kexec host kernel with 'nosmp' on the command line.

Will
