From: hotran@apm.com (Hoan Tran)
Date: Tue, 7 Jun 2016 11:05:01 -0700
Subject: [PATCH 1/3] Documentation: dtb: xgene: Add hwmon dts binding
 documentation
In-Reply-To: <CABb+yY3uFrknEU65aBCw7G+dfnDdqGTZ_sctktx03GM9b86xaA@mail.gmail.com>
References: <1463415447-29903-1-git-send-email-hotran@apm.com>
 <1463415447-29903-2-git-send-email-hotran@apm.com>
 <20160523203044.GA17450@rob-hp-laptop>
 <CAFHUOYyYt8pE6sggezCR=TFcsimcjakbYmcWFtpLyQ3Et_gZaA@mail.gmail.com>
 <CABb+yY3uFrknEU65aBCw7G+dfnDdqGTZ_sctktx03GM9b86xaA@mail.gmail.com>
Message-ID: <CAFHUOYwva_mry+gKKEsFaBw-L2ey-HHPetjDGqkr0hwcmw_zEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Thanks for your reply !

On Tue, Jun 7, 2016 at 10:20 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Tue, May 24, 2016 at 6:31 AM, Hoan Tran <hotran@apm.com> wrote:
>> Hi Rob,
>>
>> Thanks for your review !
>>
>> On Mon, May 23, 2016 at 1:30 PM, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Mon, May 16, 2016 at 09:17:25AM -0700, Hoan Tran wrote:
>>> > This patch adds the APM X-Gene hwmon device tree node documentation.
>>> >
>>> > Signed-off-by: Hoan Tran <hotran@apm.com>
>>> > ---
>>> >  .../devicetree/bindings/hwmon/apm-xgene-hwmon.txt          | 14 ++++++++++++++
>>> >  1 file changed, 14 insertions(+)
>>> >  create mode 100644 Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
>>> >
>>> > diff --git a/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt b/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
>>> > new file mode 100644
>>> > index 0000000..49a482e
>>> > --- /dev/null
>>> > +++ b/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
>>> > @@ -0,0 +1,14 @@
>>> > +APM X-Gene hwmon driver
>>> > +
>>> > +Hwmon driver accesses sensors over the "SLIMpro" mailbox.
>>>
>>> DT bindings describe h/w, not driver data.
>> How about this description: "APM X-Gene SOC sensors are accessed over
>> the "SLIMpro" mailbox" ?
>>> I'm not sure this belongs in
>>> DT and perhaps the devices for the mailbox should be created by the
>>> mailbox driver.
>> I don't think the current mailbox supports it.
>>>
>>> > +
>>> > +Required properties :
>>> > + - compatible : should be "apm,xgene-slimpro-hwmon"
>>> > + - mboxes : use the label reference for the mailbox as the first parameter.
>>> > +         The second parameter is the channel number.
>>>
>>> When do you expect this to be different mailbox numbers?
>> No, this number is not changed. This "mboxes" property is used and
>> required by mailbox.c when hwmon driver requests a mailbox channel
>>
> I think that's inaccurate.
>
> The h/w and the firmware combined is the "platform" from Linux POV.
> Channels are physical resources provided by a mailbox controller.
> Currently the firmware listens on Channel-7 but some future revision
> might switch to, say, Channel-9.  Or say the same firmware on next
> revision of h/w may have to switch to Channel-3 because it has only 4
> channels. So I see the mailbox channel number as a hardware property
> just like an IRQ (which very often change with SoC iterations).

Agree about that. I suppose this number is not changed. But as you
said, the mailbox channel number can be changed based on SoC or
Firmware. It would be better if this channel number is specified
inside a DT node.

Hi Rob, do you have any comments ?

Thanks
Hoan

>
> Cheers.
