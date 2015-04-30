From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 30 Apr 2015 07:03:31 -0600
Subject: [PATCH 2/2] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <1430385874.2400.13.camel@linaro.org>
References: <1430310000-10867-1-git-send-email-ivan.ivanov@linaro.org>
 <1430310000-10867-3-git-send-email-ivan.ivanov@linaro.org>
 <CANLsYkxE9xieUW+OMgb4LbnJHRdCtTM=uzcwPzC6bs4x4pP3MA@mail.gmail.com>
 <1430385874.2400.13.camel@linaro.org>
Message-ID: <CANLsYkwaOe2b+Hytfkd18YbOXQcG7cdEi-HgZS1g_ZFpFDyMNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 April 2015 at 03:24, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
>
> On Wed, 2015-04-29 at 10:49 -0600, Mathieu Poirier wrote:
>> On 29 April 2015 at 06:20, Ivan T. Ivanov ivanov at linaro.org> wrote:
>
>
>> > +
>> > +       funnel at 821000 {
>> > +               compatible = "arm,coresight-funnel", "arm,primecell";
>> > +               reg = <0x821000 0x1000>;
>> > +
>> > +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> > +               clock-names = "apb_pclk", "atclk";
>> > +
>> > +               ports {
>> > +                       #address-cells = <1>;
>> > +                       #size-cells = <0>;
>> > +
>> > +                       port at 4 {
>> > +                               reg = <4>;
>> > +                               funnel0_in4: endpoint {
>> > +                                       slave-mode;
>> > +                                       remote-endpoint = <&funnel1_out>;
>> > +                               };
>> > +                       };
>> > +                       port at 8 {
>> > +                               reg = <0>;
>> > +                               funnel0_out: endpoint {
>> > +                                       remote-endpoint = <&etf_in>;
>> > +                               };
>> > +                       };
>>
>> Please add a comment indicating what the other ports are connected to.
>>
>> > +               };
>> > +       };
>> > +
>> > +       replicator at 824000 {
>> > +               compatible = "qcom,coresight-replicator", "arm,primecell";
>> > +               reg = <0x824000 0x1000>;
>> > +
>> > +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> > +               clock-names = "apb_pclk", "atclk";
>> > +
>> > +               ports {
>> > +                       #address-cells = <1>;
>> > +                       #size-cells = <0>;
>> > +
>> > +                       port at 0 {
>> > +                               reg = <0>;
>> > +                               replicator_out0: endpoint {
>> > +                                       remote-endpoint = <&etr_in>;
>> > +                               };
>> > +                       };
>> > +                       port at 1 {
>> > +                               reg = <1>;
>> > +                               replicator_out1: endpoint {
>> > +                                       remote-endpoint = <&tpiu_in>;
>> > +                               };
>> > +                       };
>> > +                       port at 2 {
>> > +                               reg = <0>;
>> > +                               replicator_in: endpoint {
>> > +                                       slave-mode;
>> > +                                       remote-endpoint = <&etf_out>;
>> > +                               };
>> > +                       };
>>
>> Same comment as with the funnel component.
>
> Sorry, but what do you mean here?

My bad - replicators have only one input port and two output ones.
Forget about this comments.

>
> Regards,
> Ivan
