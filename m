From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 22 Mar 2011 13:19:14 -0000
Subject: Updated mach-types update
In-Reply-To: <20110320110322.GC16646@n2100.arm.linux.org.uk>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=C3TGRvN+eWLc+C2JHf_XRmc_s8Dp+pnGkO+j2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sun, Mar 20, 2011 at 12:03 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

>
> What this means is that any platform in the machine database which has not
> been submitted to mainline for 12 months since it was registered will be
> automatically dropped from the file, and the platform maintainer will need
> to either talk to me to get it reinstated before submission, or update the
> entry in some way to 'freshen' it.
>

I think this statement matches the needs of those, like me, are trying to
add a new board.
My patch [0] applies but does not build any more. How does it work in this
case?

I may include a new bit which adds the right entry in mach-types (so that my
patch is actually
buildable and testable before inclusion), in taking my patch set then you
should drop the
mach-types bit because it will be updated by you script later.


> This does have the potential to go wrong if people start randomly changing
> the format of how they write the MACHINE_START() macro.  If it's not found
> by:
>
> grep -rh --exclude=include --include='*.c' MACHINE_START arch/arm |
>  grep -v '^#' | sed "s@[^(]*(\([^,]*\).*@ ('\1')@;2,\$s@^@,@"
>

maybe it could be useful to add this regex in the top of mach-types or put
it in scripts/ so that everybody can validate his/her changes.

anyway I would add some comment in mach-types that explains how the files is
managed.

thanks,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110322/3a89c019/attachment-0001.html>
