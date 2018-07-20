From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 20 Jul 2018 17:57:02 +0300
Subject: [PATCH v6 7/8] dt-bindings: Introduce interconnect consumers
 bindings
In-Reply-To: <CAE=gft7tDYB172LTMuS4JPPaTFasT22zLBx4XjpYne2PNNz+kQ@mail.gmail.com>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-8-georgi.djakov@linaro.org>
 <CAE=gft7tDYB172LTMuS4JPPaTFasT22zLBx4XjpYne2PNNz+kQ@mail.gmail.com>
Message-ID: <5081de57-e6f2-1201-a1f3-15e05ea3800b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/11/2018 01:34 AM, Evan Green wrote:
> On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Add documentation for the interconnect consumer bindings, that will allow
>> to link a device node (consumer) to its interconnect controller hardware.
>>
>> Tha aim is to enable drivers to request a framework API to configure an
>> interconnect path by providing their struct device pointer and a name.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/interconnect.txt    | 27 +++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> index 6e2b2971b094..0ad65dccbe8b 100644
>> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> @@ -31,3 +31,30 @@ Example:
>>                         clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>>                                  <&rpmcc RPM_SMD_SNOC_A_CLK>;
>>                 };
>> +
>> +
>> += interconnect consumers =
>> +
>> +The interconnect consumers are device nodes which consume the interconnect
>> +path(s) provided by the interconnect provider. There can be multiple
> 
> I wonder if this sentence could be more descriptive. Maybe something like:
> 
> The interconnect consumers are device nodes which dynamically express
> their bandwidth requirements along interconnect paths they are
> connected to.
> 
> ...or choose a better one if this one's a mouthful.
> 

This sounds much better. Thank you!

Georgi
