From: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 02 Jul 2012 11:07:57 -0700
Subject: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <20120702180518.GA25995@sirena.org.uk>
References: <4FECB95D.7010200@zytor.com> <20120701104401.GA4352@mail.gnudd.com>
 <2b797c83-6a3c-4051-841a-a4cfa9d1cae1@email.android.com>
 <201207021658.27755.arnd@arndb.de> <20120702180518.GA25995@sirena.org.uk>
Message-ID: <4FF1E37D.7050103@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2012 11:05 AM, Mark Brown wrote:
> On Mon, Jul 02, 2012 at 04:58:27PM +0000, Arnd Bergmann wrote:
> 
>> Also, in many cases it's possible to say specifically what some code depends
>> on. E.g. if a driver uses clk_get/clk_put, it should depend on CLKDEV_LOOKUP,
>> not on !X86.
> 
> Or we could get the stubs merged, or x86 could enable the clock API...
> 

If there is a dependency there it should be registered, regardless if
x86 enables the clock API.

Last I saw I saw a patch to that effect, asked what the benefit was, and
got no answer.

	-hpa
