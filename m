From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 30 Aug 2016 20:25:08 -0300
Subject: [PATCH v2 0/2] extend kexec_file_load system call
In-Reply-To: <20160818102112.GB27045@leverpostej>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160818102112.GB27045@leverpostej>
Message-ID: <2408856.dZN5fLyePL@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Sorry for taking this long to respond. I've been focusing on getting my 
kexec_file_load and kexec buffer hand-over series in shape.

Am Donnerstag, 18 August 2016, 11:21:13 schrieb Mark Rutland:
> On Thu, Aug 11, 2016 at 08:03:56PM -0300, Thiago Jung Bauermann wrote:
> > Device tree blob must be passed to a second kernel on DTB-capable
> > archs, like powerpc and arm64, but the current kernel interface
> > lacks this support.
> > 
> > This patch extends kexec_file_load system call by adding an extra
> > argument to this syscall so that an arbitrary number of file descriptors
> > can be handed out from user space to the kernel.
> > 
> > See the background [1].
> > 
> > Please note that the new interface looks quite similar to the current
> > system call, but that it won't always mean that it provides the "binary
> > compatibility."
> > 
> > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
> 
> As with the original posting, I have a number of concerns, and I'm
> really not keen on this.

Thanks for laying out out the reasons for your objection. That's very 
helpful.

> * For typical usecases, I do not believe that this is necessary (at
>   least for arm64), and generally do not believe that it should be
>   necessary for a user to manipulate the DTB (much like the user need
>   not manipulate ACPI tables or other FW data structures).
> 
>   Other than (potentially) the case of Linux as a flashed-in bootloader,
>   I don't see a compelling case for modifying the DTB that could not be
>   accomplished in-kernel. For that case, if truly necessary, I think
>   that we can get away with something simpler.

Yes, this is the case I am aiming for. I'll experiment with a couple of 
different approaches and see how well they perform.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
