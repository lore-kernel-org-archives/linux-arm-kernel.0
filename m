From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 23:40:11 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <4D46ABA0.9010809@ru.mvista.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<4D46A44C.3030609@ru.mvista.com>
	<20110131122520.GA11694@n2100.arm.linux.org.uk>
	<4D46ABA0.9010809@ru.mvista.com>
Message-ID: <20110201234011.GA14889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 03:31:28PM +0300, Sergei Shtylyov wrote:
> Hello.
>
> On 31-01-2011 15:25, Russell King - ARM Linux wrote:
>> If you insist on putting parens around a&  b there, then for the sake of
>> consistency, you should be putting parens around every sub-expression
>> involving || and &&  - as if you think that a & b || c could be incorrectly
>> evaluated, a < b || c falls into exactly the same category, as does
>> a < b || c < d.
>
>    I mainly noted about those parens because gcc tends to give warnings 
> in such cases, if I remember right.

Not quite.  GCC warns for these:

	a || b && c
	a | b & c

as it seems much harder to remember the relative precedence of the OR
operators vs the AND operators in each class of logical vs bitwise
operators.
