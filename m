From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 10 Jun 2016 20:27:03 +0200
Subject: [PATCH v4] USB: Fix of_usb_get_dr_mode_by_phy with a shared phy
 block
In-Reply-To: <20160610150014.GF2167@uda0271908>
References: <1465551985-3332-1-git-send-email-hdegoede@redhat.com>
 <20160610150014.GF2167@uda0271908>
Message-ID: <7c86faf8-85a9-fab5-d67d-672508b39a6f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10-06-16 17:00, Bin Liu wrote:
> Hi,
>
> On Fri, Jun 10, 2016 at 11:46:25AM +0200, Hans de Goede wrote:
>> Some SoCs have a single phy-hw-block with multiple phys, this is
>> modelled by a single phy dts node, so we end up with multiple
>> controller nodes with a phys property pointing to the phy-node
>> of the otg-phy.
>>
>> Only one of these controllers typically is an otg controller, yet we
>> were checking the first controller who uses a phy from the block and
>> then end up looking for a dr_mode property in e.g. the ehci controller.
>>
>> This commit fixes this by adding an arg0 parameter to
>> of_usb_get_dr_mode_by_phy and make of_usb_get_dr_mode_by_phy
>> check that this matches the phandle args[0] value when looking for
>> the otg controller.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Add a arg0 parameter instead of looking for nodes with a dr_mode property
>> Changes in v3:
>> -No changes
>> Changes in v4:
>> -When arg0 == -1, use of_parse_phandle instead of of_parse_phandle_with_args
>>  because using of_parse_phandle_with_args breaks phy's which use the usb-phy
>>  bindings instead of the generic phy bindings
>
> I would think you'd better send this patch with --in-reply-to to the
> patch in v3, so whoever picks it can easily pick the whole patch set,
> especially in this case the set touches multiple modules, and you don't
> want to resend the other patches.

Does that mean that you're happy with this patch now ? If so can I have
your Acked-by please ? Then I'll resend the entire set after that.

Regards,

Hans
