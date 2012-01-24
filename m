From: rabin@rab.in (Rabin Vincent)
Date: Tue, 24 Jan 2012 22:27:36 +0530
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <20120124160516.GC12326@n2100.arm.linux.org.uk>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
 <20111122194213.GC9581@n2100.arm.linux.org.uk>
 <20120124154353.GA4304@debian>
 <20120124160516.GC12326@n2100.arm.linux.org.uk>
Message-ID: <20120124165736.GA5923@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 04:05:16PM +0000, Russell King - ARM Linux wrote:
> Let me repeat: the difference is power.  Nothing more nothing less.
> 'nop' was invented to allow some vendors to 'optimize' nop from
> a power management point of view.  Nothing more, nothing less.
> 
> 'nop' will be executed as a true 'no operation' where as 'mov r0, r0'
> will tell the CPU to load the value of r0 and store it back into the
> register - which involves doing an operation.
> 
> There's no difference between "nop" vs "mov r0, r0" in terms of
> performance.  It's purely a power thing.
> 
> If you have tracepoints enabled, then you're taking a performance
> hit anyway by having all those sites inserted.  So, the only time
> you'd sanely enable them is if you're doing development work.
> You wouldn't enable them for production, unless you had some
> desire to waste CPU cycles needlessly in your end users products
> (maybe you're trying to go for the worlds slowest device?)

I was thinking not of end user products but of distro kernels.  For
example Debian does have tracepoints built in into the standard kernels
(at least on x86). 

I will drop the "real nop" usage from v2 of this patchset as you
suggested since the power impact of these few nops is vanishingly
negligible.
