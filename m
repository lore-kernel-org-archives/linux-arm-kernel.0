From: nm@ti.com (Nishanth Menon)
Date: Mon, 31 Oct 2016 15:34:04 -0500
Subject: [PATCH 1/3] Documentation: dt: Add TI SCI clock driver
In-Reply-To: <41c58712-bc00-ed05-9d1d-42e31397a70c@ti.com>
References: <1477053961-27128-1-git-send-email-t-kristo@ti.com>
 <1477053961-27128-2-git-send-email-t-kristo@ti.com>
 <20161030204121.qvb5d33dh65awwzx@rob-hp-laptop>
 <41c58712-bc00-ed05-9d1d-42e31397a70c@ti.com>
Message-ID: <bce2ef84-491b-070a-dda4-77729567341c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2016 07:50 AM, Tero Kristo wrote:
[...]

>>> +pmmc: pmmc {
>>> +	compatible = "ti,k2g-sci";
>>> +
>>> +	k2g_clks: k2g_clks {
>>
>> Use "clocks" for node name instead.
>>
>>> +		compatible = "ti,k2g-sci-clk";
>>
>> I'm starting to think all these child nodes for SCI are pointless. Is
>> there any reason why the parent node can't be the clock provider (along
>> with all the other providers it acks as)?
>
> I believe the only reason to keep them separate is to have kernel side
> of things modular. If we have separate nodes, the drivers can be probed
> separately.
>
> If not, we need to build one huge blob with all the features in it, so
> the main driver can probe everything in one go, with annoying
> back-and-forth callbacks in place (assuming we still want to keep stuff
> somehow modular.)

Documentation/devicetree/bindings/arm/arm,scpi.txt follows the same 
solution as well, right? There is indeed additional nodes coming in - 
such as reset, pd etc.. I cant see why it is different for sci clk.. 
not to mention the driver mess it results in.


-- 
Regards,
Nishanth Menon
