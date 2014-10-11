From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 10 Oct 2014 22:40:43 -0400
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <54388B81.5020306@mentor.com>
References: <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian>
 <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman>
 <20141010135743.GB31348@saruman>
 <20141010162531.GL12379@n2100.arm.linux.org.uk> <54388B81.5020306@mentor.com>
Message-ID: <543898AB.7060304@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2014 09:44 PM, Nathan Lynch wrote:
> On 10/10/2014 11:25 AM, Russell King - ARM Linux wrote:
>>
>> Right, so GCC 4.8.{1,2} are totally unsuitable for kernel building (and
>> it seems that this has been known about for some time.)
> 
> Looking at http://gcc.gnu.org/PR58854 it seems that all 4.8.x for x < 3
> are affected, as well as 4.9.0.
> 
>> We can blacklist these GCC versions quite easily.  We already have GCC
>> 3.3 blacklisted, and it's trivial to add others.  I would want to include
>> some proper details about the bug, just like the other existing entries
>> we already have in asm-offsets.c, where we name the functions that the
>> compiler is known to break where appropriate.
> 
> Before blacklisting anything, it's worth considering that simple version
> checks would break existing pre-4.8.3 compilers that have been patched
> for PR58854.  It looks like Yocto and Buildroot issued releases with
> patched 4.8.2 compilers well before the (fixed) 4.8.3 release.  I think
> the most we can reasonably do without breaking some correctly-behaving
> toolchains is to emit a warning.

Providing a manual switch to override blacklisting is way more sane
than a build warning that no one's looking at.
