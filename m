From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Oct 2014 12:19:34 +0100
Subject: [PATCH v6 4/7] ARM: l2c: Add support for overriding prefetch
 settings
In-Reply-To: <20141027111404.GW12379@n2100.arm.linux.org.uk>
References: <1414407950-3029-1-git-send-email-m.szyprowski@samsung.com>
 <1414407950-3029-5-git-send-email-m.szyprowski@samsung.com>
 <20141027111404.GW12379@n2100.arm.linux.org.uk>
Message-ID: <544E2A46.7070106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-10-27 12:14, Russell King - ARM Linux wrote:
> On Mon, Oct 27, 2014 at 12:05:47PM +0100, Marek Szyprowski wrote:
>> From: Tomasz Figa <t.figa@samsung.com>
>>
>> Firmware on certain boards (e.g. ODROID-U3) can leave incorrect L2C prefetch
>> settings configured in registers leading to crashes if L2C is enabled
>> without overriding them. This patch introduces bindings to enable
>> prefetch settings to be specified from DT and necessary support in the
>> driver.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> [mszyprow: rebased onto v3.18-rc1, added error messages when property value
>>   is missing]
> Why?  What if the boot loader has already set these up appropriately?  Why
> should we force people to list these in the DT?

The error message is displayed only when user provided prefetch related
properties without any value (empty properties). Something that Mark Rutland
requested here: https://lkml.org/lkml/2014/9/24/426 I'm sorry if I didn't
describe it clearly enough.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
