From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Fri, 3 Nov 2017 15:14:13 +0100
Subject: [PATCH v2] arm64: support __int128 on gcc 5+
In-Reply-To: <20171103134223.GD13499@arm.com>
References: <20171102134720.GA17333@arm.com>
 <20171102174322.21853-1-Jason@zx2c4.com>
 <20171103134223.GD13499@arm.com>
Message-ID: <CAHmME9oXG1AgkJM-Ya6Jns+Y6HadwGxQ+NqmF0ed=p8Zg8fiVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 2:42 PM, Will Deacon <will.deacon@arm.com> wrote:
> We used to link against libgcc way back when, but that dependency was
> removed in commit d67703a8a69e ("arm64: kill off the libgcc dependency")
> and I'm really not keen to add it back. I also think that there might
> be licensing concerns if you link against it and make use of GCC plugins,
> but IANAL.

Considering many other architectures link to it, that seems strange to me...

>
> Shouldn't we just provide our own implementations of __ashlti3 and
> __ashrti3 instead?

I just coded up an implementation. I'm testing it now and I'll have v3
for you shortly.

Jason
