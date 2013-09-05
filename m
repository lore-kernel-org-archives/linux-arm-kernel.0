From: robherring2@gmail.com (Rob Herring)
Date: Thu, 5 Sep 2013 08:29:24 -0500
Subject: [PATCH v2] ARM: highbank: fix debug uart virtual address for LPAE
In-Reply-To: <20130902124828.GT6617@n2100.arm.linux.org.uk>
References: <1376784748-31914-1-git-send-email-robherring2@gmail.com>
 <20130902124828.GT6617@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqKugHadYcE498n_OA_fpJxsvU4ME2uVBnRX5-hpitVJnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 2, 2013 at 7:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Aug 17, 2013 at 07:12:28PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Section entries are 2MB on LPAE, so the DEBUG_LL virtual address must
>> have the same offset in the 2MB section as the physical address. This
>> fixes async external aborts when DEBUG_LL is enabled on Midway.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>> v2: Rebase on Russell's DEBUG_LL clean-up
>
> Do you also want to do a patch for this for v3.11, because if it's wrong
> in my series, it's wrong in mainline at the moment:

That would be v1 of my patch. There are other fixes needed for LPAE on
Midway in 3.11, so this fix alone is not really needed.

Rob
