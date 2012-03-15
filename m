From: tpiepho@gmail.com (Trent Piepho)
Date: Thu, 15 Mar 2012 11:57:52 -0400
Subject: [alsa-devel] [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
In-Reply-To: <CA+7tXig6=gz8utcnV8qUs6=JnwEz8+tqc-57v-xNcYcK_AAHXw@mail.gmail.com>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
 <20120315142115.GB6065@S2101-09.ap.freescale.net>
 <CA+7tXig6=gz8utcnV8qUs6=JnwEz8+tqc-57v-xNcYcK_AAHXw@mail.gmail.com>
Message-ID: <CA+7tXiiJyLAm1ytyqQYgbJ_roUtXwxqhFWKEBk+4jY_HV5V8Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 11:39 AM, Trent Piepho <tpiepho@gmail.com> wrote:
> On Thu, Mar 15, 2012 at 10:21 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Thu, Mar 15, 2012 at 01:37:06PM +0000, Tabi Timur-B04825 wrote:
>> ...
>> > The PowerPC MPC8610 has two SSIs, and I have a hacked up board that has
>> > both connected to two CS4270s. ?This is how I tested multiple SSI support
>> > in my driver.
>> >
>> > Since my driver supports any number of SSIs, I expect any changes to it to
>> > continue that support.
>> >
>> I think it can still easily get supported with the binding like below.
>>
>> sound {
>> ? ? ?compatible = "fsl,imx51-babbage-sgtl5000",
>> ? ? ? ? ? ? ? ? ? "fsl,imx-audio-sgtl5000";
>> ? ? ?model = "imx51-babbage-sgtl5000";
>> ? ? ?ssi-controller = <&ssi1, &ssi2>;
>> ? ? ?audio-codec = <&sgtl5000_1, &sgtl5000_2>;
>> ? ? ?mux-int-port = <1>;
>> ? ? ?mux-ext-port = <3>;
>> };
>
> How would you support binding the imx51 ESAI controller?

Sorry about previous email, laptop touchpad emitted a spurious click,
which caused text window in gmail to become deselected, which caused a
subsequent enter to send the email rather than creating a new line.

For esai, would you add something like:
    esai-controller = <&esai1>;
    esai-audio-codec = <&sgtl5000_3>;

That seems rather ugly to me.

It seems to me in most device bindings where one piece of hardware is
attached to another, than the one upstream has in its binding a
phandle to the one downstream.  But here we have a third binding with
two lists of devices and an implied link between devices in
corresponding positions in the lists.  Does any other device binding
work like that?
