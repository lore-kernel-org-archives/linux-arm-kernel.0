From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 12 Jan 2011 10:05:19 -0600
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <4D2D1942.4050905@ahsoftware.de>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2D1942.4050905@ahsoftware.de>
Message-ID: <AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 9:00 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Hello,

[...]

> ? ? ? ? ? ? ? ?INIT_CALLS
> ? ? ? ? ? ? ? ?CON_INITCALL
> ? ? ? ? ? ? ? ?SECURITY_INITCALL
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* TODO: The size of INIT_RAM_FS could easily reach a
> + ? ? ? ? ? ? ? ?* point (~16MB) when loading modules will fail because
> + ? ? ? ? ? ? ? ?* relocations will be out of range. So this place here
> + ? ? ? ? ? ? ? ?* isn't the best one.
> + ? ? ? ? ? ? ? ?*/
> ? ? ? ? ? ? ? ?INIT_RAM_FS

In general, do we expect always to be able to avoid the situation
where branches in the kernel may need to cover too large a range ...
and is there any strategy for working aroung it?

If we have problems branching from the modules area into vmlinux, we
could possibly build modules with -fPIC : this would remove the
restriction on branch range, though there would also be some
performance impact for the modules...

Cheers
---Dave
