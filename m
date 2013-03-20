From: robherring2@gmail.com (Rob Herring)
Date: Wed, 20 Mar 2013 18:03:29 -0500
Subject: [PATCH 0/3] ARM sched_clock selection enhancements
In-Reply-To: <513F230E.1030307@gmail.com>
References: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
 <20130312092358.GP4977@n2100.arm.linux.org.uk> <513F230E.1030307@gmail.com>
Message-ID: <514A4041.9090406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 03/12/2013 07:43 AM, Rob Herring wrote:
> On 03/12/2013 04:23 AM, Russell King - ARM Linux wrote:
>> On Mon, Mar 11, 2013 at 09:26:34PM -0500, Rob Herring wrote:
>>> In preparation to move more timer initialization to use CLKSRC_OF and
>>> out of the platforms, a way to select the timer used for sched_clock is
>>> needed. This series makes the ARM sched_clock support code prefer 64-bit
>>> counters or higher frequency counters. This is sufficient at least on
>>> ARM Ltd boards to use the 24MHz counter rather than sp804 and to always
>>> use the 64-bit architected timer when present. This mechanism can be
>>> extended to DT properties if needed for any non-discoverable h/w feature.
>>
>> No - this stuff is designed specifically to cope with the dilemas of
>> less-than-64-bit sched_clock sources.  If you have 64-bit sources, then
>> that should be dealt with differently - this code will break with 64-bit
>> sources due to the multiplication and shift losing the high order bits.
> 
> It is dealt with differently. In the 64-bit case, there is only a
> multiply and all the code to deal with wrapping of 32-bit counters is
> skipped. It is exactly the same conversion as arm64.

Do you have any further comments?

Rob
