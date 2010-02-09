From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Feb 2010 18:01:09 +0000
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100209143055.GA6015@bnru01.bnr.st.com>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
	<20100209143055.GA6015@bnru01.bnr.st.com>
Message-ID: <20100209180109.GB20924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2010 at 08:00:56PM +0530, Rabin VINCENT wrote:
> On Mon, Feb 08, 2010 at 02:51:24PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Feb 08, 2010 at 07:11:50PM +0530, Rabin Vincent wrote:
> > > Enable/disable hardware flow control as requested by the termios.
> > 
> > From what I remember, I didn't implement this because there were
> > corner cases to be dealt with.  I don't remember what they were
> > off hand though.
> 
> We haven't seen any problems with it thus far.  Nothing obvious strikes
> me on rechecking the pl011 spec; it would be helpful if you could
> elaborate.

Can't elaborate at the moment without re-reading the specs.

> Either way, this patch should be safe to apply since existing users of
> the driver shouldn't be affected.

Err, that really doesn't follow.  There are existing users, and existing
users will have CRTSCTS set by default.  Therefore, existing users are
going from having hardware flow control on the UART disabled to having
it enabled.

That's not "shouldn't be affected", that's a "this patch does change
the hardware behaviour for these users".
