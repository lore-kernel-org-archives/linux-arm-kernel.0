From: mingo@kernel.org (Ingo Molnar)
Date: Mon, 11 Dec 2017 15:42:18 +0100
Subject: [PATCH 0/2] acpi, x86: Add SPCR table support
In-Reply-To: <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171208062925.64ov23u7oxmdfzyk@gmail.com>
 <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
Message-ID: <20171211144218.fcycoxibyln5f44x@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Prarit Bhargava <prarit@redhat.com> wrote:

> If I disable "Serial Port Console Debug" in my BIOS I still see the SPCR configured:
> 
> [root at prarit-lab ~]# dmesg | grep SPCR
> [    0.000000] ACPI: SPCR 0x0000000069031000 000050 (v01
> 00000000      00000000)
> 
> AFAICT the SPCR is always enabled on some systems.

Fair enough.

> > If so then we should pick up that serial console configuration and activate it, 
> > regardless of any kernel boot options!
> 
> I'm worried about someone who doesn't want a console on ttyS0 suddenly ending up
> with one.  The SPCR could contain incorrect data, etc.

Yeah, that's not good.

Thanks,

	Ingo
