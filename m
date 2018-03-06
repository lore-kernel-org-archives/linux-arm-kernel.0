From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Mar 2018 14:09:17 +0000
Subject: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external vbus
 supply property
In-Reply-To: <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
 <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
 <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
Message-ID: <ae4c741e-d5aa-4a8c-4029-1dff6bef2cdd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/18 01:57, Rob Herring wrote:
> On Thu, Mar 01, 2018 at 10:51:38AM +0100, Amelie Delaunay wrote:
>> On some boards, especially when vbus supply requires large current,
>> and the charge pump on the PHY isn't enough, an external vbus power switch
>> per port may be used.
>> Add portN_vbus-supply property to usb-ehci bindings. As the number of ports
>> depends on the ehci controller, and the port on which an external vbus
>> supply depends on the platform, <portN> is used to make it generic.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   Documentation/devicetree/bindings/usb/usb-ehci.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index 3efde12..cd576db 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -19,6 +19,7 @@ Optional properties:
>>    - phys : phandle + phy specifier pair
>>    - phy-names : "usb"
>>    - resets : phandle + reset specifier pair
>> + - portN_vbus-supply : phandle of regulator supplying vbus for port N
> 
> Just make this an array with the index being the port (and drop
> "portN_").

Does that still work if there is an external supply for port 1 but none 
for port 0? I believe that was brought up as a possibility before.

Robin.
