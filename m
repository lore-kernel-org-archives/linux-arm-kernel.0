From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 23 Sep 2015 17:43:25 -0500
Subject: [RESEND PATCHv3] arm64: dts: Add base stratix 10 dtsi
In-Reply-To: <20150923055450.GA4883@svinekod>
References: <1442353625-4552-1-git-send-email-dinguyen@opensource.altera.com>
 <20150923055450.GA4883@svinekod>
Message-ID: <CADhT+wccWpy9VhZv=yWRiA4tf1SO_1-EAu6_cc+UkPJOWX0Bpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 12:54 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> +/ {
>> +     compatible = "altr,socfpga-stratix10";
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>
> [...]
>
>> +     soc {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             compatible = "simple-bus";
>> +             device_type = "soc";
>> +             interrupt-parent = <&intc>;
>
> As far as I am aware, this requires a (non-empty) ranges property, given the
> parent node has {address,size}-cells = <2>.
>
> Does the kernel not complain currently?
>

I do not see any complaints without ranges here, but with ranges, I get:

DTC     arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb
Warning (ranges_format): /soc has empty "ranges" property but its
#address-cells (1) differs from / (2)
Warning (ranges_format): /soc has empty "ranges" property but its
#size-cells (1) differs from / (2)

Dinh
