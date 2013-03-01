From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Mar 2013 13:07:20 -0700
Subject: [PATCH v4 3/8] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to System Reset Controller (SRC)
In-Reply-To: <51310A12.1040209@wwwdotorg.org>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
 <1361878774-6382-4-git-send-email-p.zabel@pengutronix.de>
 <51310A12.1040209@wwwdotorg.org>
Message-ID: <51310A78.1020104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2013 01:05 PM, Stephen Warren wrote:
> On 02/26/2013 04:39 AM, Philipp Zabel wrote:
>> The SRC has auto-deasserting reset bits that control reset lines to
>> the GPU, VPU, IPU, and OpenVG IP modules. This patch adds a reset
>> controller that can be controlled by those devices using the
>> reset controller API.
> 
>> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
> 
>> +Specifying reset lines connected to IP modules
>> +==============================================
> ...
>> +example:
>> +
>> +        ipu1: ipu at 02400000 {
>> +                resets = <&src 2>;
>> +        };
>> +        ipu2: ipu at 02800000 {
>> +                resets = <&src 4>;
>> +        };
> 
> reset-names is mandatory in the documentation and implementation; you
> should probably add them to the example too.

Oh, looking at the code further, I see reset-names is optional if the
client node only has one reset defined. So ignore my comment above.
