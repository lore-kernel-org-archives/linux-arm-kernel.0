From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jun 2014 12:56:02 +0100
Subject: Build error - vmlinux.lds [Re: linux-next: Tree for Jun 18]
In-Reply-To: <CAK5sBcEpXboRVD-KzzjBJMi+LF-jhdt_HUYEz7wkJtFAv+BLcg@mail.gmail.com>
References: <CAK5sBcEpXboRVD-KzzjBJMi+LF-jhdt_HUYEz7wkJtFAv+BLcg@mail.gmail.com>
Message-ID: <20140618115602.GA32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 04:50:43PM +0530, Sachin Kamat wrote:
> Hi,
> 
> I observe the following build error while building uImage for ARM.
> 
>   Kernel: arch/arm/boot/Image is ready
> make[2]: *** No rule to make target
> `arch/arm/boot/compressed/vmlinux.lds', needed by
> `arch/arm/boot/compressed/vmlinux'.  Stop.
> make[1]: *** [arch/arm/boot/compressed/vmlinux] Error 2
> make: *** [uImage] Error 2

Works fine here against an empty object tree:

http://www.arm.linux.org.uk/developer/build/file.php?lid=9591

Are you building into an already-built object tree or rebuilding an
already built tree?

This is likely caused by make getting confused over the dependencies.
I suggest making clean to recover from this error.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
