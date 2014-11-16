From: dalias@libc.org (Rich Felker)
Date: Sun, 16 Nov 2014 13:56:22 -0500
Subject: ARM atomics overhaul for musl
In-Reply-To: <CALCETrWiX-+tfucSd-ukS1ehUxT0Xx6N58DXHhpWuG+61=qMVg@mail.gmail.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <CALCETrWiX-+tfucSd-ukS1ehUxT0Xx6N58DXHhpWuG+61=qMVg@mail.gmail.com>
Message-ID: <20141116185622.GV22465@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 10:27:04AM -0800, Andy Lutomirski wrote:
> Would it make sense for arm and arm64 to add bits for these features
> to AT_HWCAP, along with an extra bit indicating that the kernel
> provides these bits?

Sadly since it wasn't available there from the beginning, I don't
think there would be a lot of benefit in adding it now, but it
wouldn't hurt.

It might be useful if there's a risk that the existing methods will
break in the future; adding it now would ensure that there are only a
known finite set of kernels for which the old hackish string methods
need to be used, so that there's no concern about their compatibility
with future kernels/models.

Rich
