From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Feb 2011 08:47:36 +0000
Subject: [PATCH 2/4] msm: scm: Fix improper register assignment
In-Reply-To: <4D688AF1.1090607@codeaurora.org>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-3-git-send-email-sboyd@codeaurora.org>
	<1298640219.958.74.camel@e102144-lin.cambridge.arm.com>
	<4D688AF1.1090607@codeaurora.org>
Message-ID: <20110226084736.GB3640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 25, 2011 at 09:09:05PM -0800, Saravana Kannan wrote:
> Yeah, Stephen and I spent quite a bit of time discussing this and  
> experimenting to figure out what the heck GCC was doing. But it kept  
> optimizing the fake code we put in trying to force GCC to use a specific  
> register.

One way to look at it is that if you specify a value for r0, assign it,
and then call a function, how do you expect the r0 value to be preserved?
r0 will be corrupted by the called function as its used to pass arg0 and
the return value.

I'm surprised the compiler didn't spit out an error.
