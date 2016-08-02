From: qnguyen@apm.com (Quan Nguyen)
Date: Tue, 2 Aug 2016 13:03:01 +0700
Subject: [PATCH net-next 10/10] Documentation: dtb: xgene: Add rxlos GPIO
 mapping
In-Reply-To: <20160801163525.GA25767@rob-hp-laptop>
References: <1469838843-19943-1-git-send-email-isubramanian@apm.com>
 <1469838843-19943-11-git-send-email-isubramanian@apm.com>
 <20160801163525.GA25767@rob-hp-laptop>
Message-ID: <CAFopSPRePt_xnNK-fuesjX5AjCcK1rVbhdDYhFo7VVuX6PsRxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 1, 2016 at 11:35 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 29, 2016 at 05:34:03PM -0700, Iyappan Subramanian wrote:
>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
>> Tested-by: Fushen Chen <fchen@apm.com>
>> ---
>>  Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
>> index 05f705e3..b83ae67 100644
>> --- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
>> +++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
>> @@ -24,6 +24,7 @@ Required properties for all the ethernet interfaces:
>>  - clocks: Reference to the clock entry.
>>  - local-mac-address: MAC address assigned to this device
>>  - phy-connection-type: Interface type between ethernet device and PHY device
>> +- rxlos-gpios: rxlos GPIO mapping
>
> Needs a vendor prefix and some definition of what rxlos is. Direction
> and active state is needed as well.
>

Hi Rob,

This gpio signal is from SFP+ module which will tell whether incoming
fiber signal available. As this is gpio, it must have the form of
"xxxx-gpios" as stated in Documentation/gpio/board.txt. As per this
document, the active state is also included in this property.

About definition for "rxlos-gpios", I suggested as below :
"- rxlos-gpios: Optional, input gpio from SFP+ module to indicate
availability of incoming signal"

Thank you,
Quan
