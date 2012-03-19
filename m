From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 19 Mar 2012 16:34:37 +0000
Subject: [PATCH] ARM: lib: use LDRD/STRD for data copy
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <20120319085503.GL15988@n2100.arm.linux.org.uk>
 <4F674479.8090101@gmail.com>
 <20120319154123.GP15988@n2100.arm.linux.org.uk>
Message-ID: <yw1xehso1rdu.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Mar 19, 2012 at 09:36:41AM -0500, Rob Herring wrote:
>> On 03/19/2012 03:55 AM, Russell King - ARM Linux wrote:
>> > On Mon, Mar 19, 2012 at 04:02:48PM +0900, Boojin Kim wrote:
>> >> This patch uses LDRD/STRD that loads and stores data as DWORD unit
>> >> for the copy of 8-words data.
>> >> It brings better performance than LDRM/STRM that was used originally.
>> > 
>> > And what about CPUs that don't have ldrd/strd ?
>> > 
>> 
>> And what about CPUs that do have ldrd/strd but is slower than ldm/stm?
>> I'm pretty sure that is almost everything currently out there.

Care to give an example?  I can't find one.

> The double-word load/stores were introduced in ARMv6.

Not true.  LDRD/STRD were introduced in ARMv5TE.  ARMv6 relaxed the
alignment requirement of these instructions to 4 bytes from being
implementation defined 4 or 8 bytes in ARMv5TE.

-- 
M?ns Rullg?rd
mans at mansr.com
