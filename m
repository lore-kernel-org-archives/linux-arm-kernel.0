From: james.morse@arm.com (James Morse)
Date: Mon, 07 Mar 2016 17:40:23 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <20160307172334.GJ19428@n2100.arm.linux.org.uk>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <56DDAFA7.4090207@arm.com> <20160307172334.GJ19428@n2100.arm.linux.org.uk>
Message-ID: <56DDBD07.2080200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/16 17:23, Russell King - ARM Linux wrote:
> On Mon, Mar 07, 2016 at 04:43:19PM +0000, James Morse wrote:
>> As far as I can see, this would only affect arm64. I can't find an equivalent
>> memset() for x86_64.
> 
> I don't think you've looked hard enough. :)

Heh, Thanks! I ignored the 32bit code and instead got lost in the maze of
underscores and alternative-strings for the 64 bit path.

Having seen that path, I've now found:
>	/* If the destination is a kernel buffer, we always clear the end */
>	if (!__addr_ok(to))
>		memset(to, 0, len);

in arch/x86/lib/usercopy_64.c:copy_user_handle_tail(), which may be the x86_64
equivalent, or I may be lost in the maze again.


Thanks!

James
