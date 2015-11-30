From: mmarek@suse.com (Michal Marek)
Date: Mon, 30 Nov 2015 16:11:16 +0100
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <20151125234711.GT8644@n2100.arm.linux.org.uk>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk>
Message-ID: <565C6714.802@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-26 00:47, Russell King - ARM Linux wrote:
> On Wed, Nov 25, 2015 at 01:51:03PM -0800, Stephen Boyd wrote:
>> The ARM compiler inserts calls to __aeabi_uidiv() and
>> __aeabi_idiv() when it needs to perform division on signed and
>> unsigned integers. If a processor has support for the udiv and
>> sdiv division instructions the calls to these support routines
>> can be replaced with those instructions. Therefore, record the
>> location of calls to these library functions into two sections
>> (one for udiv and one for sdiv) similar to how we trace calls to
>> mcount. When the kernel boots up it will check to see if the
>> processor supports the instructions and then patch the call sites
>> with the instruction.
> 
> Do we have any resolution on these programs which modify the object
> files in-place, rather than breaking any hard-links which may be
> present (eg, as a result of using ccache in hard-link mode) ?

Good point, but I do not think anybody is using CCACHE_HARDLINK with the
kernel. As the manpage says, it is going to confuse make, so the time
saved by ccache would be offset by make trying to recompile all *.c
files each time.

Michal
