From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jul 2011 13:50:36 +0100
Subject: [PATCH v2] ARM: support XZ compressed kernels
In-Reply-To: <20110722095738.GE21416@n2100.arm.linux.org.uk>
References: <1310475369-3000-1-git-send-email-kaloz@openwrt.org>
	<20110715162519.GC24628@n2100.arm.linux.org.uk>
	<op.vyptiwow2s3iss@ecaz>
	<20110719110235.GH26574@n2100.arm.linux.org.uk>
	<20110719110717.GI26574@n2100.arm.linux.org.uk>
	<20110722091604.GC21416@n2100.arm.linux.org.uk>
	<op.vy0lphg52s3iss@ecaz>
	<20110722095738.GE21416@n2100.arm.linux.org.uk>
Message-ID: <20110722125036.GG21416@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 10:57:38AM +0100, Russell King - ARM Linux wrote:
> What I'm concerned about is the apparant lack of exposure of the patch
> to people outside of ARM, especially as it touches lib/xz/xz_dec_stream.c.
> 
> I have no idea whether that breaks some architecture or not.
> 
> Is Lasse Collin (the original contributer of that file) aware of this
> change?

I forwarded it to Lasse, and got some comments back... essentially
putting includes in xz_dec_stream.c could be problematical.  Lasse
would - as I did - like to have the full information on why the
include was necessary.

Lasse is - again like me - concerned about dragging stuff into the
pre-boot environment which can cause it to fail unexpectedly,
especially as linux/kernel.h includes a whole raft of other includes.

What I don't understand is if this code requires min_t, where does it
get this for everyone else - that's something to be discussed in the
wider discussion over this.  Does it build outside of the decompressor
on ARM already?

So... given the increasing number of questions over this, I think you
need to put something together which describes the problem, how its
caused, why it seems to only exhibit on ARM, and discuss solutions
with all those involved.  I know Lasse is very interested to find out
more information about your patch...

But in the mean time, this isn't a patch for 3.1.
