From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 26 May 2016 10:11:01 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <CAMuHMdW7FacxRFf9VCiYPwR5kUEfBteT3+LBCrzof1cmpLjGDg@mail.gmail.com>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
 <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
 <b30c9c84-23b6-b088-4983-b2498317492b@de.bosch.com>
 <20160525004825.GC7292@verge.net.au>
 <c0fd13d5-c5c4-579b-6fad-c637bda92398@de.bosch.com>
 <edee7345-280a-0d7c-7e5a-798215fbd2b9@de.bosch.com>
 <CAMuHMdXnN-GTN4crXeWRvtWT4E2kYFvMdPPcH8z+gJb-B4PbYA@mail.gmail.com>
 <5a697ce7-c02a-707c-55b6-6cc209b63b32@de.bosch.com>
 <CAMuHMdW7FacxRFf9VCiYPwR5kUEfBteT3+LBCrzof1cmpLjGDg@mail.gmail.com>
Message-ID: <8c0ea32b-b722-62ac-6810-b1239d0de4eb@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 26.05.2016 10:05, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Thu, May 26, 2016 at 9:32 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> On 26.05.2016 09:03, Geert Uytterhoeven wrote:
>>> On Wed, May 25, 2016 at 9:32 AM, Dirk Behme <dirk.behme@de.bosch.com>
>>> wrote:
>>>> P.S.: This also results in the question why we need similar
>>>> r8a7795-cpg-mssr.h and r8a7796-cpg-mssr.h with just different "numbers"
>>>> for
>>>> the same clocks. Can't we use the same numbers on all SoCs, with just
>>>> having
>>>> wholes in the list where the clocks don't exist on a SoC? I haven't
>>>> looked
>>>
>>> The CPG and MSSR block are the IP blocks that differ most among SoCs of
>>> the
>>> same family. Some clocks are present on H3 only, others on M3-W only.
>>
>> Yes, this is my understanding as well. Is the H3 a superset? And the M3-W
>> drops some clocks? Or are there really clocks which are on M3-W only and not
>> on H3?
>
> H3 is not a superset.
> M3-W e.g. has more S0Dx clocks (for x = 2, 3, 6, 8, 12).


Ok, thanks!


>> this
>>
>> &scif2 {
>>         clocks = <&cpg CPG_MOD 310>,
>>                  <&cpg CPG_CORE R8A7795_CLK_S3D1>,
>>                  <&scif_clk>;
>> };
>>
>> &scif2 {
>>         clocks = <&cpg CPG_MOD 310>,
>>                  <&cpg CPG_CORE R8A7796_CLK_S3D1>,
>>                  <&scif_clk>;
>> };
>>
>> should be done better.
>
> That's a bad example, as both SoCs use S3D1 ;-)


Then, I'd propose to find a clever way to put the common parts into a 
rcar-gen3.dtsi and ...


> Now look at e.g. i2c:
>   - On H3, the parent of the i2c module clock is S3D2,
>   - On M3-W, the parent of the i2c module clock is S3D2 for i2c0/1/2,
>     and S0D6 for i2c3/4/5/6.


... to keep the differences in the r8a7795.dtsi, r8a7796.dtsi etc.


Best regards

Dirk
