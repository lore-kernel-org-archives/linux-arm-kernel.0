From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 26 Aug 2016 08:25:08 +0100
Subject: [PATCH v2 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <CALw8SCWtTvWGmKru2MX7T7sFpoUpD-V400+w2nPkxaFB5WUKSA@mail.gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
 <1472045838-22628-4-git-send-email-mirza.krak@gmail.com>
 <de2fb909-829e-6c04-4f6a-442cbb9171c9@nvidia.com>
 <CALw8SCVcPymDZ8NyUbeanRF0TCT1TZzL6iRDticYA42FWrEWqw@mail.gmail.com>
 <CALw8SCWtTvWGmKru2MX7T7sFpoUpD-V400+w2nPkxaFB5WUKSA@mail.gmail.com>
Message-ID: <a7851104-1aa1-fd8d-a594-545a01046cdf@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 26/08/16 05:53, Mirza Krak wrote:

...

>> I have an idea which is following:
>>
>> gmi at 70090000 {
>>          status = "okay";
>>          #address-cells = <2>;
>>          #size-cells = <1>;
>>          ranges = <4 0 0x48000000 0x00040000>;
>>
>>          cs4 {
>>                  compatible = "simple-bus";
>>                  #address-cells = <2>;
>>                  #size-cells = <1>;
>>                  ranges;
>>
>>                  nvidia,snor-cs = <4>;
>>                  nvidia,snor-mux-mode;
>>                  nvidia,snor-adv-inv;
>>
>>                  can at 0 {
>>                          compatible = "nxp,sja1000";
>>                          reg = <4 0 0x100>;
>>                          ...
>>                  };
>>
>>
>>                  can at 40000 {
>>                          compatible = "nxp,sja1000";
>>                          reg = <4 0x40000 0x100>;
>>                          ...
>>                  };
>>          };
>> };
>>
>> Do not know if above will work at all (not able to test at current
>> location), anyway I will play around with it some more and get back to
>> you.
> 
> Gave above a test run and it works like a charm. Are we happy with that?

Does it not work with #address-cells = <1>? Seems odd to have the cs in
the reg for the device.

Cheers
Jon

-- 
nvpublic
