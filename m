From: nm@ti.com (Nishanth Menon)
Date: Thu, 1 Aug 2013 10:10:48 -0500
Subject: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
In-Reply-To: <51FA1C7D.5060403@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-4-git-send-email-t-kristo@ti.com> <51FA1C7D.5060403@ti.com>
Message-ID: <51FA7A78.20702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2013 03:29 AM, Rajendra Nayak wrote:
> Tero,
>
> On Tuesday 23 July 2013 12:49 PM, Tero Kristo wrote:
>> +	dd->control_reg = of_iomap(node, 0);
>> +	dd->idlest_reg = of_iomap(node, 1);
>> +	dd->autoidle_reg = of_iomap(node, 2);
>> +	dd->mult_div1_reg = of_iomap(node, 3);
>> +
> []...
>> +	reg = of_iomap(node, 0);
>
> Doing an of_iomap() for every single clock register seems like an overkill
> and might have performance penalties at boot.

the other option might be to use offset and a single allocation - but I 
think Tero should comment if this is possible or if registers on some 
SoCs are strewn all over the place

-- 
Regards,
Nishanth Menon
