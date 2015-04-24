From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Fri, 24 Apr 2015 14:50:04 +0800
Subject: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <20150423125620.GB29702@leverpostej>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150423125620.GB29702@leverpostej>
Message-ID: <CALx668W_rj8_UBory5fVa4_i3vLCjgApYCwHoSthXNmx79yH1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 8:56 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> +/*
>> + * This is a temporary solution until we have new OPPv2 bindings. Therefore we
>> + * could describe the OPPs with (freq, volt, volt) tuple properly in device
>> + * tree.
>> + */
>> +
>> +/* OPP table for LITTLE cores of MT8173 */
>> +struct mtk_cpu_opp mt8173_l_opp[] = {
>> +       OPP(507000000, 859000, 0),
>> +       OPP(702000000, 908000, 0),
>> +       OPP(1001000000, 983000, 0),
>> +       OPP(1105000000, 1009000, 0),
>> +       OPP(1183000000, 1028000, 0),
>> +       OPP(1404000000, 1083000, 0),
>> +       OPP(1508000000, 1109000, 0),
>> +       OPP(1573000000, 1125000, 0),
>> +};
>> +
>> +/* OPP table for big cores of MT8173 */
>> +struct mtk_cpu_opp mt8173_b_opp[] = {
>> +       OPP(507000000, 828000, 928000),
>> +       OPP(702000000, 867000, 967000),
>> +       OPP(1001000000, 927000, 1027000),
>> +       OPP(1209000000, 968000, 1068000),
>> +       OPP(1404000000, 1007000, 1107000),
>> +       OPP(1612000000, 1049000, 1149000),
>> +       OPP(1807000000, 1089000, 1150000),
>> +       OPP(1989000000, 1125000, 1150000),
>> +};
>
> We should sort out the OPP bindings if we need to sort out the OPP
> bindings. We can't remove these once they're in without causing pain for
> everyone with an old DTB.

So even we have a new OPP binding to describe the OPP, we have to
leave these table as they are for backward compatibility?

Best Regards,
Pi-Cheng

>
> Mark.
