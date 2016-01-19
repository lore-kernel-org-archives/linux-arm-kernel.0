From: dhdang@apm.com (Duc Dang)
Date: Tue, 19 Jan 2016 15:53:24 -0800
Subject: [PATCH v4 2/3] Documentation: mailbox: Add APM X-Gene SLIMpro
 mailbox dts documentation
In-Reply-To: <20160117001321.GA7791@rob-hp-laptop>
References: <CABb+yY2zHycEmsVvp8OFwpJ1PZgrEPpV-oOe56wgFJ=EE0nTcg@mail.gmail.com>
 <cover.1452912126.git.dhdang@apm.com>
 <efac1dfff3e6893516f527f47b82f889635122a7.1452912126.git.dhdang@apm.com>
 <20160117001321.GA7791@rob-hp-laptop>
Message-ID: <CADaLNDmNzGa77DYbUN1Aabwy2y_d1mZW4kiNctxG_u9idCNaGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 16, 2016 at 4:13 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jan 15, 2016 at 06:57:18PM -0800, Duc Dang wrote:
>> This adds the APM X-Gene SLIMpro mailbox device tree
>> node documentation.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> ---
>> Changes since v3:
>>         - Rebase over v4.4
>>         - Change number of mailbox IRQs to 8
>>       - Fix white spaces, typos.
>>
>>  .../bindings/mailbox/xgene-slimpro-mailbox.txt     | 35 ++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
>> new file mode 100644
>> index 0000000..91774d7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
>> @@ -0,0 +1,35 @@
>> +The APM X-Gene SLIMpro mailbox is used to communicate messages between
>> +the ARM64 processors and the Cortex M3 (dubbed SLIMpro). It uses a simple
>> +interrupt based door bell mechanism and can exchange simple messages using the
>> +internal registers.
>> +
>> +There are total of 7 interrupts in this mailbox. Each used for an individual
>> +door bell (or mailbox channel).
>> +
>> +Required properties:
>> +- compatible:        Should be as "apm,xgene-slimpro-mbox".
>> +
>> +- reg:               Contains the mailbox register address range.
>> +
>> +- interrupts:        8 interrupts must be from 0 to 7, interrupt 0 define the
>> +             the interrupt for mailbox channel 0 and interrupt 1 for
>> +             mailbox channel 1 and so likewise for the reminder.
>> +
>> +- #mbox-cells:       only one to specify the mailbox channel number.
>> +
>> +Example:
>> +
>> +Mailbox Node:
>> +             slimpro-mbox: slimpro-mbox at 10540000 {
>
> Nit: just use mailbox@ or mbox@ (whatever others are using) for node
> name. Otherwise:
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, Rob.

I will change the node name to mailbox at 10540000 in the document and DT
as well in the next version.

Regards,
Duc Dang.
