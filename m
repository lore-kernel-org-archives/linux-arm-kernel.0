From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Nov 2014 15:30:52 +0100
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <20141107131129.GF18916@arm.com>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <353850534.aGkkrtTogX@wuerfel> <20141107131129.GF18916@arm.com>
Message-ID: <6654405.Rf26mgoaDJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 November 2014 13:11:30 Will Deacon wrote:
> 
> > It's not that I care strongly about the interface, my main point is
> > that the changelog doesn't describe why one interface was used instead
> > the other.
> 
> I suspect the current approach was taken because it follows the same scheme
> as 32-bit ARM. If both methods are sufficient (Kees would have a better idea
> than me on that), then I don't have a strong preference.

Using the regset would probably address Oleg's comment, and would keep the
implementation architecture specific. You could even share the NT_S390_SYSTEM_CALL
number, but I don't know if there any downsides to doing that.

	Arnd
