From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jan 2013 14:25:31 +0000
Subject: Fwd: how to check the hardware support of XN/XI bit support on
 ARM/MIPS platform
In-Reply-To: <CALTRzTknSz4kNB6EE7-jb1NOj5OOc95ZqH9c=rwuN0DoROPvvw@mail.gmail.com>
References: <CALTRzTn_2eaE7vr-tXwGKmO3fGqmif0hdrFEinQjbf6Dx=yHCg@mail.gmail.com>
 <CALTRzTknSz4kNB6EE7-jb1NOj5OOc95ZqH9c=rwuN0DoROPvvw@mail.gmail.com>
Message-ID: <20130108142531.GA3931@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 11:32:03AM +0530, Girish garg wrote:
>         char buf[8192];
>         fptr func;
> 
>         /* Put a RETN instruction in the buffer */
>         buf[0] = '\xc3';

If you're going to be poking opcodes into the stack, you need to use
the correct opcodes for the CPU you're using.

You also need to use the correct opcodes (and alignment) for the
instruction set you're using - iow, if you're using ARM or Thumb.

0xc3 on its own is not a valid ARM or Thumb instruction.
