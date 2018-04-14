From: peda@axentia.se (Peter Rosin)
Date: Sat, 14 Apr 2018 15:54:24 +0200
Subject: [PATCH 2/5] dt-bindings: display: atmel: add optional output-mode
 property
In-Reply-To: <20180413174648.zxljbw634o2r4zty@rob-hp-laptop>
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409105918.20792-3-peda@axentia.se>
 <20180413174648.zxljbw634o2r4zty@rob-hp-laptop>
Message-ID: <3bf87960-06f8-3224-10d9-4ad76ff446a4@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-13 19:46, Rob Herring wrote:
> On Mon, Apr 09, 2018 at 12:59:15PM +0200, Peter Rosin wrote:
>> Useful for beating cases where an output mode selection heuristic
>> fails.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> index 82f2acb3d374..dc478455b883 100644
>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> @@ -10,6 +10,10 @@ Required properties:
>>   - #address-cells: should be set to 1.
>>   - #size-cells: should be set to 0.
>>  
>> +Optional properties:
>> + - output-mode: override any output mode selection hueristic and force a
>> +   particular output mode. One of "rgb444", "rgb565", "rgb666" and "rgb888".
>> +
> 
> This needs to be generic, not just added to some random display 
> controller binding.
> 
> It also belongs in the port or endpoint node as is done for camera 
> interfaces.

Hmm, should I extend media/video-interfaces.txt with more bus types (or since
I'm targeting parallel interfaces, perhaps the new bus types should be
autodetected from other props?) or should a write a new binding similar to
it?

One question regarding bus-width, should it include hsync/vsync/de/clk?
If yes, how to distinguish rgb565 with all those four from rgb666 with
only de/clk (some panels do not need hsync/vsync)? 20 lines in both
cases...

Or are rgb444/rgb565/rgb666/rgb888 already supported by the media video
interface binding? That's not at all obvious to me.

Cheers,
Peter
