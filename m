From: kvalo@codeaurora.org (Kalle Valo)
Date: Wed, 05 Apr 2017 13:33:12 +0300
Subject: [PATCH 16/16] drivers, net,
 intersil: convert request_context.refcount from atomic_t to refcount_t
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C8741B@IRSMSX102.ger.corp.intel.com>
 (Elena Reshetova's message of "Tue, 4 Apr 2017 10:07:55 +0000")
References: <1490691403-4016-1-git-send-email-elena.reshetova@intel.com>
 <1490691403-4016-17-git-send-email-elena.reshetova@intel.com>
 <87zifxn2gb.fsf@kamboji.qca.qualcomm.com>
 <2236FBA76BA1254E88B949DDB74E612B41C8741B@IRSMSX102.ger.corp.intel.com>
Message-ID: <87k26zi1p3.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Reshetova, Elena" <elena.reshetova@intel.com> writes:

>> Elena Reshetova <elena.reshetova@intel.com> writes:
>> 
>> > refcount_t type and corresponding API should be
>> > used instead of atomic_t when the variable is used as
>> > a reference counter. This allows to avoid accidental
>> > refcounter overflows that might lead to use-after-free
>> > situations.
>> >
>> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> > Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > Signed-off-by: David Windsor <dwindsor@gmail.com>
>> > ---
>> >  drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 15 ++++++++-------
>> >  1 file changed, 8 insertions(+), 7 deletions(-)
>> 
>> The prefix should be "orinoco_usb:", I'll fix that.
>
> Thanks for both! Will you take the patches in?

You mean patches 15 and 16? I didn't even look rest of the patches.

But not sure yet because Dave doesn't seem to like the interface and I
want to follow the discussion first.

-- 
Kalle Valo
