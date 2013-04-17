From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Apr 2013 12:46:43 -0500
Subject: [PATCH v5 5/6] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <1829212.6niSeTsyIU@amdc1227>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-6-git-send-email-tomasz.figa@gmail.com>
 <516D4D76.2010409@gmail.com> <1829212.6niSeTsyIU@amdc1227>
Message-ID: <CAL_JsqL_i-5SDCsGZCrsxMehLVMGoLO1s_V3R-H6Oa5ff16dEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 8:19 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> On Tuesday 16 of April 2013 08:09:10 Rob Herring wrote:
>> On 04/15/2013 04:14 PM, Tomasz Figa wrote:
>> > This patch adds basic device tree definitions for Samsung S3C64xx SoCs.
>> >
>> > Since all the SoCs in the series are very similar, the files are created
>> > hierarchically - one file for the whole series and then separate files
>> > for particular SoCs including the common one.
>> >
>> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>> > ---
>> >
>> >  arch/arm/boot/dts/s3c6400.dtsi         |  33 ++
>> >  arch/arm/boot/dts/s3c6410.dtsi         |  33 ++
>> >  arch/arm/boot/dts/s3c64xx-pinctrl.dtsi | 683
>> >  +++++++++++++++++++++++++++++++++ arch/arm/boot/dts/s3c64xx.dtsi
>> >  | 136 +++++++
>> >  4 files changed, 885 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
>> >  create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
>> >  create mode 100644 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
>> >  create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
>>
>> [...]
>>
>> > +
>> > +   vic0: interrupt-controller at 71200000 {
>>
>> These nodes should be off a "simple-bus" node.
>
> Hmm, is there any reason behind it?
>
> I thought simple bus was just a convenient helper to represent hierarchical
> bus structures if one has a need to do so.

No. The DT should reflect the bus structure of the chip. How
accurately it is done is up to you and the information available, but
you have to have a bus of some sort.

There's obvious examples that don't follow this, but I'd like to not have more.

Rob
